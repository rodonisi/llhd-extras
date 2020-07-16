// Copyright (c) 2019 Fabian Schuiki
#![allow(
    unused_imports,
    unreachable_code,
    dead_code,
    unused_mut,
    unused_variables
)]

#[macro_use]
extern crate clap;
#[allow(unused_imports)]
#[macro_use]
extern crate log;
extern crate llvm_sys as llvm;

use anyhow::{anyhow, Result};
use clap::{Arg, ArgMatches};
use codespan::{FileId, Files, Location, Span};
use hibitset::{BitSet, BitSetLike};
use llhd::{
    assembly::parse_module,
    ir::{prelude::*, DataFlowGraph},
    opt::{Pass, PassContext},
    verifier::Verifier,
};
use llvm::{
    analysis::*,
    bit_writer::LLVMWriteBitcodeToFile,
    core::*,
    debuginfo::*,
    execution_engine::*,
    initialization::*,
    prelude::*,
    support::LLVMAddSymbol,
    target::*,
    transforms::{ipo::*, pass_manager_builder::*},
    LLVMIntPredicate, LLVMTypeKind,
};
use num::{traits::Pow, BigInt, BigRational, FromPrimitive, One, ToPrimitive};
use std::{
    cell::{Cell, RefCell},
    collections::{BTreeMap, HashMap},
    ffi::CString,
    fs::File,
    io::{Read, Write},
    mem,
    path::Path,
    ptr::{null, null_mut},
};

fn main() -> Result<()> {
    // Parse the command line arguments.
    let matches = app_from_crate!()
        .about("Simulates LLHD assembly using LLVM .")
        .arg(
            Arg::with_name("verbosity")
                .short("v")
                .multiple(true)
                .help("Increase message verbosity"),
        )
        .arg(
            Arg::with_name("input")
                .help("LLHD file to simulate")
                .required(true),
        )
        .arg(
            Arg::with_name("emit-llvm")
                .short("S")
                .takes_value(true)
                .help("Emit LLVM assembly"),
        )
        .arg(
            Arg::with_name("emit-bitcode")
                .short("c")
                .takes_value(true)
                .help("Emit LLVM bitcode"),
        )
        .arg(
            Arg::with_name("emit-trace")
                .short("t")
                .takes_value(true)
                .help("Emit a human-readable change trace"),
        )
        .arg(
            Arg::with_name("dump")
                .short("d")
                .long("dump")
                .help("Dump LLVM module"),
        )
        .arg(
            Arg::with_name("optlevel")
                .short("O")
                .takes_value(true)
                .help("Optimization level"),
        )
        .arg(
            Arg::with_name("dry-run")
                .short("n")
                .long("dry-run")
                .help("Only map the design, don't simulate"),
        )
        .arg(
            Arg::with_name("num-steps")
                .short("N")
                .takes_value(true)
                .help("Terminate after a fixed number of steps"),
        )
        .get_matches();

    // Configure the logger.
    let verbose = std::cmp::max(1, matches.occurrences_of("verbosity") as usize) - 1;
    let quiet = !matches.is_present("verbosity");
    stderrlog::new()
        .module("llhd_blaze")
        .quiet(quiet)
        .verbosity(verbose)
        .init()
        .unwrap();

    // Read the input.
    let path = matches.value_of("input").unwrap();
    let mut files = Files::new();
    let (module, file_id) = {
        let mut input = File::open(path)?;
        let mut contents = String::new();
        input.read_to_string(&mut contents)?;
        let module = parse_module(&contents).map_err(|e| anyhow!("Parsing failed: {}", e))?;
        let file_id = files.add(path, contents);
        let mut verifier = Verifier::new();
        verifier.verify_module(&module);
        verifier
            .finish()
            .map_err(|errs| anyhow!("Verification failed: {}", errs))?;
        (module, file_id)
    };

    // // Apply basic optimizations.
    // info!("Optimizing input");
    // let ctx = PassContext;
    // llhd::pass::ConstFolding::run_on_module(&ctx, &mut module);
    // llhd::pass::GlobalCommonSubexprElim::run_on_module(&ctx, &mut module);
    // llhd::pass::DeadCodeElim::run_on_module(&ctx, &mut module);
    // llhd::pass::LoopIndepCodeMotion::run_on_module(&ctx, &mut module);
    // llhd::pass::DeadCodeElim::run_on_module(&ctx, &mut module);
    // llhd::pass::ControlFlowSimplification::run_on_module(&ctx, &mut module);
    // llhd::pass::DeadCodeElim::run_on_module(&ctx, &mut module);

    // // Verify modified module.
    // info!("Verifying optimization result");
    // let mut verifier = Verifier::new();
    // verifier.verify_module(&module);
    // verifier
    //     .finish()
    //     .map_err(|errs| anyhow!("Verification failed after optimization:\n{}", errs))?;

    // Find the last process or entity in the module, which we will use as the
    // simulation's root unit.
    let root = match module
        .units()
        .filter(|&unit| module.is_process(unit) || module.is_entity(unit))
        .last()
    {
        Some(r) => r,
        None => Err(anyhow!("no process or entity found that can be simulated"))?,
    };
    info!("Found simulation root: {}", module.unit_name(root));

    // Simulate the module.
    unsafe { simulate(&module, root, &matches, &files, file_id) };

    Ok(())
}

unsafe fn simulate(
    llhd_module: &Module,
    root: ModUnit,
    matches: &ArgMatches,
    files: &Files<String>,
    file_id: FileId,
) {
    let pass_reg = LLVMGetGlobalPassRegistry();
    LLVMInitializeCore(pass_reg);

    let context = LLVMGetGlobalContext();
    let optlevel = matches
        .value_of("optlevel")
        .and_then(|v| v.parse().ok())
        .unwrap_or(4);
    let mut map = Mapping::new(llhd_module, root, context, optlevel, files, file_id);
    trace!("Design fully mapped");

    // Optimize IR.
    if optlevel > 0 {
        info!("Optimizing IR");
        let mpm = LLVMCreatePassManager();
        let fpm = LLVMCreateFunctionPassManagerForModule(map.llvm_module);

        debug!("Populating pass managers");
        let pmb = LLVMPassManagerBuilderCreate();
        LLVMPassManagerBuilderSetOptLevel(pmb, optlevel as u32 - 1);
        LLVMPassManagerBuilderPopulateFunctionPassManager(pmb, fpm);
        LLVMPassManagerBuilderPopulateModulePassManager(pmb, mpm);
        LLVMPassManagerBuilderDispose(pmb);

        LLVMInitializeFunctionPassManager(fpm);
        let mut f = LLVMGetFirstFunction(map.llvm_module);
        #[allow(deprecated)]
        while !f.is_null() {
            debug!(
                "Optimizing \"{}\"",
                std::ffi::CStr::from_ptr(LLVMGetValueName(f))
                    .to_str()
                    .unwrap()
            );
            LLVMRunFunctionPassManager(fpm, f);
            f = LLVMGetNextFunction(f);
        }
        LLVMFinalizeFunctionPassManager(fpm);

        debug!("Optimizing entire module");
        LLVMRunPassManager(mpm, map.llvm_module);

        LLVMDisposePassManager(mpm);
        LLVMDisposePassManager(fpm);
    }

    // Dump the module if requested.
    if matches.is_present("dump") {
        LLVMDumpModule(map.llvm_module);
    }

    // Write the module to disk if requested.
    if let Some(path) = matches.value_of("emit-llvm") {
        LLVMPrintModuleToFile(
            map.llvm_module,
            format!("{}\0", path).as_ptr() as *const _,
            null_mut(),
        );
    }
    if let Some(path) = matches.value_of("emit-bitcode") {
        LLVMWriteBitcodeToFile(map.llvm_module, format!("{}\0", path).as_ptr() as *const _);
    }
    if matches.is_present("dry-run") {
        return;
    }

    // Open the trace file if requested.
    let mut trace = matches
        .value_of("emit-trace")
        .map(|p| File::create(p).unwrap());

    // Create the execution engine.
    LLVMLinkInMCJIT();
    LLVM_InitializeNativeTarget();
    LLVM_InitializeNativeAsmPrinter();
    LLVMAddSymbol(b"blaze_drive\0".as_ptr() as *const _, blaze_drive as *mut _);
    LLVMAddSymbol(b"blaze_wake\0".as_ptr() as *const _, blaze_wake as *mut _);

    let mut ee = mem::uninitialized();
    let mut out = mem::zeroed();
    LLVMCreateJITCompilerForModule(
        &mut ee,
        map.llvm_module,
        if optlevel > 0 { 3 } else { 0 },
        &mut out,
    ); // consumes the module

    // Find the relevant function addresses.
    let addr = LLVMGetFunctionAddress(ee, b"blaze_create\0".as_ptr() as *const _);
    let blaze_create: extern "C" fn(&mut BlazeContext) = mem::transmute(addr);
    let addr = LLVMGetFunctionAddress(ee, b"blaze_dump\0".as_ptr() as *const _);
    let blaze_dump: extern "C" fn(&BlazeContext, u32, fn(&mut String, char), &mut String) =
        mem::transmute(addr);

    // Initialize the context.
    info!("Starting simulation");
    let mut ctx = BlazeContext::new(&map);
    // trace!("SigMem before: {:?}", ctx.sigmem);
    // trace!("InsTbl before: {:?}", ctx.insts);
    blaze_create(&mut ctx);
    debug!("SigMem: {:?}", ctx.sigmem);
    debug!("InsTbl: {:?}", ctx.insts);

    // Try to trigger the first instance.
    // let inst_id = map.unit_lookup[&root];
    // trace!("Root instance is {}", inst_id);
    // let inst = &*ctx.insts.offset(inst_id as isize);
    // trace!("Current func: {:?}", inst.func as *const u8);
    let step_limit = matches
        .value_of("num-steps")
        .map(|s| s.parse::<usize>().unwrap());
    let mut s = 0;
    for _ in 0.. {
        if let Some(sl) = step_limit {
            if s >= sl {
                break;
            }
        }
        if let Some(trace) = &mut trace {
            write!(trace, "{}ps {}d {}e\n", ctx.time.0, ctx.time.1, ctx.time.2).unwrap();
            // let mut changed: Vec<_> = if s == 0 {
            //     (0..map.signals.len()).map(|i| i as u32).collect()
            // } else {
            //     (&ctx.sig_changed).iter().collect()
            // };
            let mut changed: Vec<_> = (&ctx.sig_changed).iter().collect();
            changed.sort_by_key(|&s| &map.signals[s as usize].name);
            for signal in changed {
                let name = match map.signals[signal as usize].name {
                    Some(ref n) => n,
                    None => continue,
                };
                let mut v = String::new();
                blaze_dump(&ctx, signal, String::push, &mut v);
                write!(trace, "  {} = {}\n", name, v).unwrap();
            }
        }
        // let ret = (inst.func)(&mut ctx, inst.state);
        // trace!("{:#?}", ctx);
        // trace!("Next func: {:?}", ret);
        // let (time, slot) = match ctx.pop_slot() {
        //     Some(x) => x,
        //     None => break,
        // };
        // trace!("Advancing to {:?}", time);
        // ctx.time = time;
        s += 1;
        if !ctx.step(&map) {
            break;
        }
    }
    info!(
        "Simulation stopped at {}ps {}d {}e (after {} steps)",
        ctx.time.0, ctx.time.1, ctx.time.2, s
    );

    // Clean up.
    // LLVMDisposeExecutionEngine(ee);
    // LLVMContextDispose(context);
}

pub struct Mapping<'a> {
    module: &'a Module,
    root: ModUnit,
    context: LLVMContextRef,
    optlevel: usize,
    files: &'a Files<String>,
    file_id: FileId,

    insts: Vec<InstanceMapping>,
    signals: Vec<SignalMapping>,
    units: Vec<UnitMapping<'a>>,
    unit_lookup: HashMap<ModUnit, usize>,

    llvm_module: LLVMModuleRef,
    type_cache: RefCell<HashMap<llhd::Type, LLVMTypeRef>>,
    ctxptr_type: LLVMTypeRef,
    voidptr_type: LLVMTypeRef,
    seconds_type: LLVMTypeRef,
    delta_type: LLVMTypeRef,
    epsilon_type: LLVMTypeRef,
    time_type: LLVMTypeRef,
    time_prec: BigRational,
    resume_type: LLVMTypeRef,
    sigmem_type: LLVMTypeRef,
    instbl_type: LLVMTypeRef,
    drive_func: LLVMValueRef,
    wake_func: LLVMValueRef,
    di_builder: LLVMDIBuilderRef,
    di_file: LLVMMetadataRef,
    di_cu: LLVMMetadataRef,
}

impl<'a> Mapping<'a> {
    pub fn new(
        module: &'a Module,
        root: ModUnit,
        context: LLVMContextRef,
        optlevel: usize,
        files: &'a Files<String>,
        file_id: FileId,
    ) -> Self {
        unsafe {
            // Create a new LLVM module.
            let llvm_module =
                LLVMModuleCreateWithNameInContext(b"llhd_blaze\0".as_ptr() as *const _, context);
            LLVMSetDataLayout(
                llvm_module,
                b"i8:8-i16:16-i32:32-i64:64\0".as_ptr() as *const _,
            );

            // Gather some of the frequently used types.
            let voidptr_type = LLVMPointerType(LLVMInt8Type(), 0);
            let ctx_type = LLVMStructCreateNamed(context, b"ctx_ty\0".as_ptr() as *const _);
            LLVMStructSetBody(ctx_type, [voidptr_type, voidptr_type].as_mut_ptr(), 2, 0);
            let ctxptr_type = LLVMPointerType(ctx_type, 0);
            let seconds_type = LLVMInt64Type();
            let delta_type = LLVMInt32Type();
            let epsilon_type = LLVMInt32Type();
            let time_type =
                LLVMStructType([seconds_type, delta_type, epsilon_type].as_mut_ptr(), 3, 0);
            let time_prec: BigRational = BigInt::from_usize(10).unwrap().pow(12usize).into();
            let resume_type = LLVMInt16Type();
            let sigset_type = LLVMInt16Type();
            let action_type = LLVMStructTypeInContext(
                context,
                [resume_type, sigset_type, time_type].as_mut_ptr(),
                3,
                0,
            );
            let zero_time = LLVMConstNull(time_type);
            // let unit_func_type = LLVMFunctionType(
            //     LLVMVoidType(),
            //     [ctxptr_type, voidptr_type].as_mut_ptr(),
            //     2,
            //     0,
            // );
            let instbl_type = LLVMStructType([voidptr_type, voidptr_type].as_mut_ptr(), 2, 0);

            // Create the drive function prototype.
            let mut drive_func_args = [
                ctxptr_type,     // context
                LLVMInt32Type(), // signal index
                voidptr_type,    // signal pointer
                voidptr_type,    // data
                LLVMInt32Type(), // size
                time_type,       // time
                LLVMInt32Type(), // offset
                LLVMInt32Type(), // length
            ];
            let drive_func_type = LLVMFunctionType(
                LLVMVoidType(),
                drive_func_args.as_mut_ptr(),
                drive_func_args.len() as u32,
                0,
            );
            let drive_func = LLVMAddFunction(
                llvm_module,
                b"blaze_drive\0".as_ptr() as *const _,
                drive_func_type,
            );

            // Create the wake function prototype.
            let mut wake_func_args = [
                ctxptr_type,     // context
                LLVMInt32Type(), // instance index
                time_type,       // time
            ];
            let wake_func_type = LLVMFunctionType(
                LLVMVoidType(),
                wake_func_args.as_mut_ptr(),
                wake_func_args.len() as u32,
                0,
            );
            let wake_func = LLVMAddFunction(
                llvm_module,
                b"blaze_wake\0".as_ptr() as *const _,
                wake_func_type,
            );

            // Create the root debugging information.
            let di_builder = LLVMCreateDIBuilder(llvm_module);
            let di_file = {
                let p = Path::new(files.name(file_id));
                let dir_name = p.parent().unwrap().to_str().unwrap();
                let file_name = p.file_name().unwrap().to_str().unwrap();
                LLVMDIBuilderCreateFile(
                    di_builder,
                    file_name.as_ptr() as *const _,
                    file_name.len(),
                    dir_name.as_ptr() as *const _,
                    dir_name.len(),
                )
            };
            let di_cu = {
                let producer = "llhd-blaze";
                LLVMDIBuilderCreateCompileUnit(
                    di_builder,
                    LLVMDWARFSourceLanguage::LLVMDWARFSourceLanguageC,
                    di_file,
                    producer.as_ptr() as *const _,
                    producer.len(),
                    0,
                    std::ptr::null(),
                    0,
                    0,
                    std::ptr::null(),
                    0,
                    LLVMDWARFEmissionKind::LLVMDWARFEmissionKindFull,
                    0,
                    0,
                    0,
                )
            };

            // Create the mapping struct and run the individual steps.
            let mut n = Self {
                module,
                root,
                context,
                optlevel,
                files,
                file_id,
                insts: Default::default(),
                signals: Default::default(),
                units: Default::default(),
                unit_lookup: Default::default(),

                llvm_module,
                type_cache: Default::default(),
                ctxptr_type,
                voidptr_type,
                seconds_type,
                delta_type,
                epsilon_type,
                time_type,
                time_prec,
                resume_type,
                sigmem_type: null_mut(),
                instbl_type,
                drive_func,
                wake_func,
                di_builder,
                di_file,
                di_cu,
            };
            n.collect();
            n.compute_signal_layout();
            n.map_units();
            n.populate_units();
            n.populate_senses();
            n.emit_create_func();
            n.emit_dump_func();

            // Optimize the shit out of the module.
            // let pm = LLVMCreatePassManager();
            // let pmb = LLVMPassManagerBuilderCreate();
            // LLVMPassManagerBuilderSetOptLevel(pmb, 1);
            // LLVMPassManagerBuilderPopulateModulePassManager(pmb, pm);
            // LLVMPassManagerBuilderDispose(pmb);
            // LLVMRunPassManager(pm, n.llvm_module);
            // LLVMDisposePassManager(pm);

            // Dispose of the metadata.
            LLVMDisposeDIBuilder(n.di_builder);
            n.di_builder = std::ptr::null_mut();

            // info!("Module Dump:");
            // LLVMDumpModule(n.llvm_module);
            n
        }
    }

    /// Collect all signals and instances in the design.
    fn collect(&mut self) {
        self.collect_instance(self.root, None, "");
        trace!(
            "Collected {} signals, {} instances",
            self.signals.len(),
            self.insts.len()
        );
    }

    fn collect_instance(
        &mut self,
        unit: ModUnit,
        bindings: impl IntoIterator<Item = (Value, usize)>,
        prefix: &str,
    ) -> usize {
        let mut instance = InstanceMapping {
            unit,
            signals: Default::default(),
            insts: Default::default(),
            senses: Default::default(),
        };
        let prefix = format!(
            "{}{}/",
            prefix,
            self.module.unit_name(unit).get_name().unwrap()
        );
        instance.signals.extend(bindings);
        if let Some(entity) = self.module.get_entity(unit) {
            self.collect_instance_mapping(
                &mut instance,
                entity.dfg(),
                entity.inst_layout().insts().collect(),
                &prefix,
            );
        } else if let Some(prok) = self.module.get_process(unit) {
            self.collect_instance_mapping(
                &mut instance,
                prok.dfg(),
                prok.func_layout()
                    .blocks()
                    .flat_map(|bb| prok.func_layout().insts(bb))
                    .collect(),
                &prefix,
            );
        }
        let id = self.insts.len();
        trace!(
            "Instance {} has {} bound signals, {} instances",
            id,
            instance.signals.len(),
            instance.insts.len()
        );
        self.insts.push(instance);
        id
    }

    fn collect_instance_mapping(
        &mut self,
        instance: &mut InstanceMapping,
        dfg: &DataFlowGraph,
        insts: Vec<Inst>,
        prefix: &str,
    ) {
        for (&value, &sigidx) in &instance.signals {
            if self.signals[sigidx as usize].name.is_none() {
                self.signals[sigidx as usize].name =
                    dfg.get_name(value).map(|n| format!("{}{}", prefix, n));
            }
        }
        for inst in insts {
            let data = &dfg[inst];
            match data.opcode() {
                Opcode::Inst => {
                    let module = self.module;
                    let ext_unit = data.get_ext_unit().unwrap();
                    let unit = self
                        .module
                        .lookup_ext_unit(ext_unit, instance.unit)
                        .unwrap();
                    let bindings = data
                        .input_args()
                        .iter()
                        .zip(self.module[unit].sig().inputs())
                        .chain(
                            data.output_args()
                                .iter()
                                .zip(self.module[unit].sig().outputs()),
                        )
                        .map(|(sig, arg)| {
                            (
                                module[unit].get_dfg().unwrap().arg_value(arg),
                                instance.signals[sig],
                            )
                        });
                    let id = self.collect_instance(unit, bindings, prefix);
                    instance.insts.push(id);
                }
                Opcode::Sig => {
                    let id = self.signals.len();
                    let value = dfg.inst_result(inst);
                    let name = dfg.get_name(value).map(|n| format!("{}{}", prefix, n));
                    self.signals.push(SignalMapping {
                        unit: instance.unit,
                        value,
                        name,
                        ty: dfg.value_type(value).unwrap_signal().clone(),
                        llty: Cell::new(null_mut()),
                    });
                    instance.signals.insert(value, id);
                }
                _ => (),
            }
        }
    }

    /// Compute the layout of the signal memory.
    fn compute_signal_layout(&mut self) {
        let mut tys = vec![];
        for sig in &self.signals {
            let ty = self.map_type(&sig.ty);
            sig.llty.set(ty);
            tys.push(ty);
        }
        unsafe {
            self.sigmem_type =
                LLVMStructCreateNamed(self.context, b"sigmem\0".as_ptr() as *const _);
            LLVMStructSetBody(self.sigmem_type, tys.as_mut_ptr(), tys.len() as u32, 0);
        }
    }

    fn map_type(&self, ty: &llhd::Type) -> LLVMTypeRef {
        let existing: Option<LLVMTypeRef> = self.type_cache.borrow().get(ty).cloned();
        if let Some(ty) = existing {
            ty
        } else {
            let llty = unsafe {
                match *ty.as_ref() {
                    llhd::VoidType => LLVMVoidType(),
                    llhd::TimeType => self.time_type,
                    llhd::IntType(w) => LLVMIntType(w as u32),
                    llhd::ArrayType(w, ref ty) => LLVMArrayType(self.map_type(ty), w as u32),
                    llhd::StructType(ref tys) => {
                        let mut ltys: Vec<_> = tys.iter().map(|ty| self.map_type(ty)).collect();
                        LLVMStructType(ltys.as_mut_ptr(), ltys.len() as u32, 0)
                    }
                    _ => unimplemented!("type {} not implemented in llvm", ty),
                }
            };
            self.type_cache.borrow_mut().insert(ty.clone(), llty);
            llty
        }
    }

    /// Map all LLHD units to LLVM equivalents.
    fn map_units(&mut self) {
        for unit in self.module.units() {
            match self.module[unit] {
                llhd::ir::ModUnitData::Entity(ref e) => unsafe { self.map_unit(unit, e) },
                llhd::ir::ModUnitData::Process(ref p) => unsafe { self.map_unit(unit, p) },
                _ => unimplemented!("unit {} not supported", unit),
            }
        }
    }

    /// Map a unit to LLVM.
    unsafe fn map_unit(&mut self, mod_unit: ModUnit, unit: &'a dyn Unit) {
        let dfg = unit.dfg();
        let name = unit.name().get_name().unwrap();
        info!("Mapping {}", name);

        // Compute the signal table.
        let mut signals = vec![];
        signals.extend(unit.sig().args().map(|a| dfg.arg_value(a)));
        if unit.is_entity() {
            for inst in unit.inst_layout().insts() {
                if dfg[inst].opcode() == Opcode::Sig {
                    signals.push(dfg.inst_result(inst));
                }
            }
        } else {
            for block in unit.func_layout().blocks() {
                for inst in unit.func_layout().insts(block) {
                    if dfg[inst].opcode() == Opcode::Sig {
                        signals.push(dfg.inst_result(inst));
                    }
                }
            }
        }
        let mut signal_types: Vec<_> = signals
            .iter()
            .map(|&v| {
                LLVMStructType(
                    [
                        LLVMInt32Type(),
                        LLVMPointerType(self.map_type(dfg.value_type(v).unwrap_signal()), 0),
                    ]
                    .as_mut_ptr(),
                    2,
                    0,
                )
            })
            .collect();
        let signal_table_type = LLVMStructCreateNamed(
            self.context,
            format!("{}.sigtbl\0", name).as_bytes().as_ptr() as *const _,
        );
        LLVMStructSetBody(
            signal_table_type,
            signal_types.as_mut_ptr(),
            signal_types.len() as u32,
            0,
        );
        let signal_table_mapping: HashMap<Value, usize> =
            signals.iter().enumerate().map(|(i, &v)| (v, i)).collect();
        let sigtbl = SignalTable {
            signals,
            mapping: signal_table_mapping,
            llty: signal_table_type,
        };

        // Compute the state table.
        let mut state = vec![
            LLVMInt64Type(),   // Sense
            signal_table_type, // Signal Table
            LLVMInt32Type(),   // Instance ID
        ];
        let mut spilled_values = HashMap::new();
        let mut spilled_vars = HashMap::new();
        let mut buffered_drvs = HashMap::new();

        // Gather the values that must be preserved across process suspension.
        if unit.is_process() {
            let layout = unit.func_layout();
            let dfg = unit.dfg();
            let cfg = unit.cfg();
            let trg = llhd::pass::tcm::TemporalRegionGraph::new(dfg, layout);
            let tpt = llhd::pass::gcse::PredecessorTable::new_temporal(dfg, layout);
            let tdt = llhd::pass::gcse::DominatorTree::new(layout, &tpt);

            // Add the resume point to the state.
            state.push(self.resume_type);

            for block in layout.blocks() {
                for inst in layout.insts(block) {
                    if !dfg.has_result(inst) {
                        continue;
                    }
                    let value = dfg.inst_result(inst);
                    let value_tr = trg[block];

                    // Check whether the value needs to be preserved across temporal
                    // regions.
                    let mut escapes_tr = false;
                    for (user, _) in dfg.uses(value) {
                        let user_block = layout.inst_block(user).unwrap();
                        let user_tr = trg[user_block];
                        if dfg[inst].opcode() == Opcode::Var {
                            debug!(
                                "{} ({:?}) used in {} ({:?})",
                                value.dump(dfg),
                                value_tr,
                                user.dump(dfg, Some(cfg)),
                                user_tr
                            );
                        }
                        if user_tr != value_tr || !tdt.dominates(block, user_block) {
                            escapes_tr = true;
                            debug!(
                                "{} escapes at least to {}",
                                value.dump(dfg),
                                user.dump(dfg, Some(cfg))
                            );
                            break;
                        }
                    }
                    if !escapes_tr {
                        continue;
                    }

                    if dfg[inst].opcode() == Opcode::Var {
                        spilled_vars.insert(value, state.len());
                        state.push(self.map_type(&dfg.value_type(value).unwrap_pointer()));
                    } else if dfg[inst].opcode() != Opcode::Sig {
                        spilled_values.insert(value, state.len());
                        state.push(self.map_type(&dfg.value_type(value)));
                    }
                }
            }
        } else {
            let layout = unit.inst_layout();
            let dfg = unit.dfg();
            for inst in layout.insts() {
                if dfg[inst].opcode() == Opcode::Drv {
                    buffered_drvs.insert(inst, state.len());
                    state.push(self.map_type(&dfg.value_type(dfg[inst].args()[0]).unwrap_signal()));
                }
            }
        }
        trace!(
            "Unit {} spills {} values, {} vars; buffers {} drvs; uses {} state fields",
            name,
            spilled_values.len(),
            spilled_vars.len(),
            buffered_drvs.len(),
            state.len()
        );

        // Assemble the state structure.
        let state_type = LLVMStructCreateNamed(
            self.context,
            format!("{}.state\0", name).as_bytes().as_ptr() as *const _,
        );
        LLVMStructSetBody(state_type, state.as_mut_ptr(), state.len() as u32, 0);

        // Create the simulation function declaration.
        let func_name = format!("unit.{}\0", name);
        let func_type = LLVMFunctionType(
            self.voidptr_type,
            [self.ctxptr_type, LLVMPointerType(state_type, 0u32)].as_mut_ptr(),
            2,
            0,
        );
        let func = LLVMAddFunction(
            self.llvm_module,
            func_name.as_bytes().as_ptr() as *const _,
            func_type,
        );

        // Create the trivial sensitivity set which covers all signals.
        // Populating the unit will add further.
        let senses = vec![sigtbl.signals.clone(), Vec::new()];

        self.unit_lookup.insert(mod_unit, self.units.len());
        self.units.push(UnitMapping {
            mod_unit,
            unit,
            sigtbl,
            senses: RefCell::new(senses),
            state_type,
            func_name,
            func_type,
            func,
            spilled_values,
            spilled_vars,
            buffered_drvs,
            ctx_arg: LLVMGetParam(func, 0),
            state_arg: LLVMGetParam(func, 1),
        });
    }

    /// Populate the LLVM units with instructions.
    unsafe fn populate_units(&self) {
        for unit in &self.units {
            self.populate_unit(unit);
        }
        #[cfg(debug_assertions)]
        LLVMVerifyModule(
            self.llvm_module,
            LLVMVerifierFailureAction::LLVMPrintMessageAction,
            null_mut(),
        );
    }

    /// Populate an LLVM unit with instructions.
    unsafe fn populate_unit(&self, um: &UnitMapping) {
        let noname = b"\0".as_ptr() as *const _;
        let builder = LLVMCreateBuilderInContext(self.context);

        // Setup a debugging scope.
        let name = um.unit.name().to_string();
        let mut fname_len = 0;
        let fname = LLVMGetValueName2(um.func, &mut fname_len as *mut _);
        let line = self
            .module
            .location_hint(um.mod_unit)
            .and_then(|loc| self.files.location(self.file_id, loc as u32).ok())
            .map(|loc| loc.line.to_usize() + 1)
            .unwrap_or(0);
        ;
        let di_scope = LLVMDIBuilderCreateFunction(
            self.di_builder,           // Builder
            self.di_file,              // Scope
            fname,                     // Name
            fname_len,                 // NameLen
            name.as_ptr() as *const _, // LinkageName
            name.len(),                // LinkageNameLen
            self.di_file,              // File
            line as u32,               // LineNo
            LLVMDIBuilderCreateSubroutineType(
                self.di_builder,
                self.di_file,
                [std::ptr::null_mut()].as_mut_ptr(),
                1,
                LLVMDIFlags::LLVMDIFlagZero,
            ), // Ty
            1,                         // IsLocalToUnit
            1,                         // IsDefinition
            line as u32,               // ScopeLine
            LLVMDIFlags::LLVMDIFlagPrototyped, // Flags
            1,                         // IsOptimized
        );
        LLVMSetSubprogram(um.func, di_scope);
        let di_loc = LLVMDIBuilderCreateDebugLocation(
            self.context,
            line as u32,
            1,
            di_scope,
            std::ptr::null_mut(),
        );
        LLVMSetCurrentDebugLocation(builder, LLVMMetadataAsValue(self.context, di_loc));

        trace!("Mapping unit {}", um.unit.name());
        let pop = UnitPopulator {
            parent: self,
            um,
            unit: um.unit,
            builder,
            di_scope,
            line,
            di_loc,
            values: Default::default(),
            resume_points: Default::default(),
            blocks: Default::default(),
            resume_ptr: Cell::new(null_mut()),
            sense_ptr: Cell::new(null_mut()),
            inst_ptr: Cell::new(null_mut()),
        };
        if um.unit.is_entity() {
            let bb = LLVMAppendBasicBlockInContext(
                self.context,
                um.func,
                b"entry\0".as_ptr() as *const _,
            );
            LLVMPositionBuilderAtEnd(builder, bb);
            pop.emit_debug();
            for inst in um.unit.inst_layout().insts() {
                pop.emit_inst(inst);
            }

            // Return a pointer to the entity function itself.
            let slf = LLVMBuildBitCast(
                builder,
                um.func,
                self.voidptr_type,
                b"self\0".as_ptr() as *const _,
            );
            LLVMBuildRet(builder, slf);
        } else {
            pop.emit_process();
        }
        // LLVMVerifyFunction(um.func, LLVMVerifierFailureAction::LLVMPrintMessageAction);
        LLVMDisposeBuilder(pop.builder);

        // // Optimize the generated function.
        // let fpm = LLVMCreateFunctionPassManagerForModule(self.llvm_module);
        // let pmb = LLVMPassManagerBuilderCreate();
        // LLVMPassManagerBuilderSetOptLevel(pmb, self.optlevel as u32);
        // LLVMPassManagerBuilderPopulateFunctionPassManager(pmb, fpm);
        // LLVMInitializeFunctionPassManager(fpm);
        // LLVMRunFunctionPassManager(fpm, um.func);
        // LLVMFinalizeFunctionPassManager(fpm);
        // LLVMPassManagerBuilderDispose(pmb);
        // LLVMDisposePassManager(fpm);
    }

    /// Populate the sensitivity lists.
    unsafe fn populate_senses(&self) {
        for inst in &self.insts {
            let unit = &self.units[self.unit_lookup[&inst.unit]];
            for sense in unit.senses.borrow().iter() {
                let mut s = BitSet::new();
                for sig in sense {
                    s.add(inst.signals[&sig] as u32);
                }
                inst.senses.borrow_mut().push(s);
            }
        }
    }

    /// Emit the `blaze_create` function.
    unsafe fn emit_create_func(&self) {
        let noname = b"\0".as_ptr() as *const _;

        // Create the function prototype.
        let func_type = LLVMFunctionType(LLVMVoidType(), [self.ctxptr_type].as_mut_ptr(), 1, 0);
        let func = LLVMAddFunction(
            self.llvm_module,
            b"blaze_create\0".as_ptr() as *const _,
            func_type,
        );

        // Create the entry block.
        let builder = LLVMCreateBuilderInContext(self.context);
        let bb = LLVMAppendBasicBlockInContext(self.context, func, b"entry\0".as_ptr() as *const _);
        LLVMPositionBuilderAtEnd(builder, bb);

        // Initialize the global signal memory.
        let sigmem = LLVMBuildMalloc(builder, self.sigmem_type, b"sigmem\0".as_ptr() as *const _);
        for (i, sig) in self.signals.iter().enumerate() {
            let dfg = self.module[sig.unit].get_dfg().unwrap();
            let inst = dfg.value_inst(sig.value);
            let init = dfg[inst].args()[0];
            let init_inst = dfg.value_inst(init);
            let um = &self.units[self.unit_lookup[&sig.unit]];
            let pop = UnitPopulator {
                parent: self,
                um,
                unit: um.unit,
                builder,
                di_scope: std::ptr::null_mut(),
                line: 0,
                di_loc: std::ptr::null_mut(),
                values: Default::default(),
                resume_points: Default::default(),
                blocks: Default::default(),
                resume_ptr: Cell::new(null_mut()),
                sense_ptr: Cell::new(null_mut()),
                inst_ptr: Cell::new(null_mut()),
            };
            // pop.emit_inst(init_inst);
            pop.emit_insts_for_value(init);
            let sigptr = LLVMBuildGEP(
                builder,
                sigmem,
                [
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                    LLVMConstInt(LLVMInt32Type(), i as u64, 0),
                ]
                .as_mut_ptr(),
                2 as u32,
                b"sigptr\0".as_ptr() as *const _,
            );
            LLVMBuildStore(builder, pop.values.borrow()[&init], sigptr);
        }

        // Initialize the instance table.
        let instbl = LLVMBuildArrayMalloc(
            builder,
            self.instbl_type,
            LLVMConstInt(LLVMInt32Type(), self.insts.len() as u64, 0),
            b"instbl\0".as_ptr() as *const _,
        );

        // Initialize the individual instance states and initialize their
        // individual signal table.
        for (i, inst) in self.insts.iter().enumerate() {
            let unit_id = self.unit_lookup[&inst.unit];
            let unit = &self.units[unit_id];
            trace!("Initializing instance {} of unit {}", i, unit_id);

            // Decorative block.
            let bb = LLVMAppendBasicBlockInContext(
                self.context,
                func,
                format!("inst_{}\0", i).as_ptr() as *const _,
            );
            LLVMBuildBr(builder, bb);
            LLVMPositionBuilderAtEnd(builder, bb);

            // Allocate the state.
            let state_ptr =
                LLVMBuildMalloc(builder, unit.state_type, b"state\0".as_ptr() as *const _);
            LLVMBuildMemSet(
                builder,
                state_ptr,
                LLVMConstNull(LLVMInt8Type()),
                LLVMSizeOf(unit.state_type),
                0,
            );

            // Store the initial sensitivity setting.
            let sense_ptr = LLVMBuildGEP(
                builder,
                state_ptr,
                [
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                ]
                .as_mut_ptr(),
                2 as u32,
                b"sense\0".as_ptr() as *const _,
            );
            LLVMBuildStore(builder, LLVMConstNull(LLVMInt64Type()), sense_ptr);

            // Store the instance ID.
            let inst_ptr = LLVMBuildGEP(
                builder,
                state_ptr,
                [
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                    LLVMConstInt(LLVMInt32Type(), 2, 0),
                ]
                .as_mut_ptr(),
                2 as u32,
                b"inst\0".as_ptr() as *const _,
            );
            LLVMBuildStore(
                builder,
                LLVMConstInt(LLVMInt32Type(), i as u64, 0),
                inst_ptr,
            );

            // Populate the signal table.
            let sigtbl_ptr = LLVMBuildGEP(
                builder,
                state_ptr,
                [
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                    LLVMConstInt(LLVMInt32Type(), 1, 0),
                ]
                .as_mut_ptr(),
                2 as u32,
                b"sigtbl\0".as_ptr() as *const _,
            );
            let mut sigtbl = LLVMConstNull(unit.sigtbl.llty);
            for (i, sig) in unit.sigtbl.signals.iter().enumerate() {
                let glob = inst.signals[&sig];
                trace!(
                    "  Assigning signal {} {} to global signal {}",
                    i,
                    sig.dump(unit.unit.dfg()),
                    glob
                );
                let sigidx = LLVMConstInt(LLVMInt32Type(), glob as u64, 0);
                let sigptr = LLVMBuildGEP(
                    builder,
                    sigmem,
                    [LLVMConstInt(LLVMInt32Type(), 0, 0), sigidx].as_mut_ptr(),
                    2 as u32,
                    format!("global_{}\0", glob).as_ptr() as *const _,
                );
                let sigty =
                    LLVMStructType([LLVMInt32Type(), LLVMTypeOf(sigptr)].as_mut_ptr(), 2, 0);
                let sig = LLVMConstNull(sigty);
                let sig = LLVMBuildInsertValue(builder, sig, sigidx, 0, noname);
                let sig = LLVMBuildInsertValue(builder, sig, sigptr, 1, noname);
                sigtbl = LLVMBuildInsertValue(builder, sigtbl, sig, i as u32, noname);
            }
            LLVMBuildStore(builder, sigtbl, sigtbl_ptr);

            // Assemble the instance entry and store.
            let func_ptr = LLVMBuildBitCast(
                builder,
                unit.func,
                self.voidptr_type,
                b"func_ptr\0".as_ptr() as *const _,
            );
            let state_ptr = LLVMBuildBitCast(
                builder,
                state_ptr,
                self.voidptr_type,
                b"state_ptr\0".as_ptr() as *const _,
            );
            let entry = LLVMConstNull(self.instbl_type);
            let entry = LLVMBuildInsertValue(builder, entry, func_ptr, 0, noname);
            let entry = LLVMBuildInsertValue(builder, entry, state_ptr, 1, noname);
            let entry_ptr = LLVMBuildGEP(
                builder,
                instbl,
                [LLVMConstInt(LLVMInt32Type(), i as u64, 0)].as_mut_ptr(),
                1 as u32,
                b"entry_ptr\0".as_ptr() as *const _,
            );
            LLVMBuildStore(builder, entry, entry_ptr);
        }

        // Decorative block.
        let bb = LLVMAppendBasicBlockInContext(self.context, func, b"store\0".as_ptr() as *const _);
        LLVMBuildBr(builder, bb);
        LLVMPositionBuilderAtEnd(builder, bb);

        // Store the global signal memory in the context.
        let sigmem = LLVMBuildBitCast(builder, sigmem, self.voidptr_type, noname);
        let ctx_sigmem = LLVMBuildGEP(
            builder,
            LLVMGetParam(func, 0),
            [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), 0, 0),
            ]
            .as_mut_ptr(),
            2 as u32,
            noname,
        );
        LLVMBuildStore(builder, sigmem, ctx_sigmem);

        // Store the instance table in the context.
        let instbl = LLVMBuildBitCast(builder, instbl, self.voidptr_type, noname);
        let ctx_instbl = LLVMBuildGEP(
            builder,
            LLVMGetParam(func, 0),
            [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), 1, 0),
            ]
            .as_mut_ptr(),
            2 as u32,
            noname,
        );
        LLVMBuildStore(builder, instbl, ctx_instbl);

        // Clean up.
        LLVMBuildRetVoid(builder);
        LLVMDisposeBuilder(builder);
    }

    /// Emit the `blaze_dump` function.
    unsafe fn emit_dump_func(&self) {
        let noname = b"\0".as_ptr() as *const _;

        // Create the function prototype.
        let callback_type = LLVMFunctionType(
            LLVMVoidType(),
            [LLVMPointerType(LLVMInt8Type(), 0), LLVMInt8Type()].as_mut_ptr(),
            2,
            0,
        );
        let func_type = LLVMFunctionType(
            LLVMVoidType(),
            [
                self.ctxptr_type,
                LLVMInt32Type(),
                LLVMPointerType(callback_type, 0),
                LLVMPointerType(LLVMInt8Type(), 0),
            ]
            .as_mut_ptr(),
            4,
            0,
        );
        let func = LLVMAddFunction(
            self.llvm_module,
            b"blaze_dump\0".as_ptr() as *const _,
            func_type,
        );
        LLVMSetValueName2(LLVMGetParam(func, 0), "ctx".as_ptr() as *const _, 3);
        LLVMSetValueName2(LLVMGetParam(func, 1), "sigidx".as_ptr() as *const _, 6);
        LLVMSetValueName2(LLVMGetParam(func, 2), "putc".as_ptr() as *const _, 4);
        LLVMSetValueName2(LLVMGetParam(func, 3), "putc_ctx".as_ptr() as *const _, 8);

        // Create the entry block.
        let builder = LLVMCreateBuilderInContext(self.context);
        let bb = LLVMAppendBasicBlockInContext(self.context, func, b"entry\0".as_ptr() as *const _);

        // Create the global character map.
        let charmap = LLVMAddGlobal(
            self.llvm_module,
            LLVMArrayType(LLVMInt8Type(), 16),
            "blaze_charmap\0".as_ptr() as *const _,
        );
        LLVMSetInitializer(
            charmap,
            LLVMConstString("0123456789abcdef".as_ptr() as *const _, 16, 1),
        );

        // Create the switch statement to dump the corresponding signal.
        let bail_bb =
            LLVMAppendBasicBlockInContext(self.context, func, b"bail\0".as_ptr() as *const _);
        LLVMPositionBuilderAtEnd(builder, bail_bb);
        LLVMBuildRetVoid(builder);
        LLVMPositionBuilderAtEnd(builder, bb);

        let ctx_sigmem = LLVMBuildGEP(
            builder,
            LLVMGetParam(func, 0),
            [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), 0, 0),
            ]
            .as_mut_ptr(),
            2 as u32,
            noname,
        );
        let ctx_sigmem = LLVMBuildLoad(builder, ctx_sigmem, noname);
        let ctx_sigmem = LLVMBuildBitCast(
            builder,
            ctx_sigmem,
            LLVMPointerType(self.sigmem_type, 0),
            b"sigmem\0".as_ptr() as *const _,
        );

        let switch = LLVMBuildSwitch(
            builder,
            LLVMGetParam(func, 1),
            bail_bb,
            self.signals.len() as u32,
        );

        // Create the dump code for each signal.
        for (idx, signal) in self.signals.iter().enumerate() {
            trace!(
                "Create signal {} dump {:?} {:?}",
                idx,
                signal.ty,
                signal.name
            );
            let name = format!("signal_{}\0", idx);
            let bb = LLVMAppendBasicBlockInContext(self.context, func, name.as_ptr() as *const _);
            LLVMPositionBuilderAtEnd(builder, bb);
            let sigptr = LLVMBuildGEP(
                builder,
                ctx_sigmem,
                [
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                    LLVMConstInt(LLVMInt32Type(), idx as u64, 0),
                ]
                .as_mut_ptr(),
                2,
                b"sigptr\0".as_ptr() as *const _,
            );

            // let sigptr_rawvar = LLVMBuildAlloca(builder, LLVMInt64Type(), noname);
            // let sigptr_raw = LLVMBuildPtrToInt(builder, sigptr, LLVMInt64Type(), noname);
            // LLVMBuildStore(builder, sigptr_raw, sigptr_rawvar);
            // self.emit_signal_dump(
            //     builder,
            //     sigptr_rawvar,
            //     LLVMGetParam(func, 2),
            //     LLVMGetParam(func, 3),
            //     charmap,
            // );
            // for c in ": ".bytes() {
            //     LLVMBuildCall(
            //         builder,
            //         LLVMGetParam(func, 2),
            //         [
            //             LLVMGetParam(func, 3),
            //             LLVMConstInt(LLVMInt8Type(), c as u64, 0),
            //         ]
            //         .as_mut_ptr(),
            //         2,
            //         noname,
            //     );
            // }

            self.emit_signal_dump(
                builder,
                sigptr,
                LLVMGetParam(func, 2),
                LLVMGetParam(func, 3),
                charmap,
            );
            LLVMBuildRetVoid(builder);
            LLVMAddCase(switch, LLVMConstInt(LLVMInt32Type(), idx as u64, 0), bb);
        }

        // Clean up.
        LLVMDisposeBuilder(builder);
    }

    /// Emit the code to dump a signal.
    unsafe fn emit_signal_dump(
        &self,
        builder: LLVMBuilderRef,
        value: LLVMValueRef,
        callback: LLVMValueRef,
        callback_ctx: LLVMValueRef,
        charmap: LLVMValueRef,
    ) {
        let noname = b"\0".as_ptr() as *const _;
        let ty = LLVMGetElementType(LLVMTypeOf(value));

        match LLVMGetTypeKind(ty) {
            LLVMTypeKind::LLVMIntegerTypeKind => {
                let value = LLVMBuildLoad(builder, value, noname);
                let width = LLVMGetIntTypeWidth(ty);
                for c in "0x".bytes() {
                    LLVMBuildCall(
                        builder,
                        callback,
                        [callback_ctx, LLVMConstInt(LLVMInt8Type(), c as u64, 0)].as_mut_ptr(),
                        2,
                        noname,
                    );
                }
                for i in (0..(width + 3) / 4).rev() {
                    let digit =
                        LLVMBuildLShr(builder, value, LLVMConstInt(ty, (i * 4) as u64, 0), noname);
                    let digit = LLVMBuildAnd(builder, digit, LLVMConstInt(ty, 0xf, 0), noname);
                    let digit = if width < 8 {
                        LLVMBuildZExt(builder, digit, LLVMInt8Type(), noname)
                    } else if width > 8 {
                        LLVMBuildTrunc(builder, digit, LLVMInt8Type(), noname)
                    } else {
                        digit
                    };
                    let digit = LLVMBuildGEP(
                        builder,
                        charmap,
                        [LLVMConstInt(LLVMInt32Type(), 0, 0), digit].as_mut_ptr(),
                        2,
                        noname,
                    );
                    let digit = LLVMBuildLoad(builder, digit, noname);
                    LLVMBuildCall(
                        builder,
                        callback,
                        [callback_ctx, digit].as_mut_ptr(),
                        2,
                        noname,
                    );
                }
            }
            LLVMTypeKind::LLVMArrayTypeKind => {
                let len = LLVMGetArrayLength(ty) as usize;
                LLVMBuildCall(
                    builder,
                    callback,
                    [callback_ctx, LLVMConstInt(LLVMInt8Type(), '[' as u64, 0)].as_mut_ptr(),
                    2,
                    noname,
                );
                for i in 0..len {
                    if i > 0 {
                        for c in ", ".bytes() {
                            LLVMBuildCall(
                                builder,
                                callback,
                                [callback_ctx, LLVMConstInt(LLVMInt8Type(), c as u64, 0)]
                                    .as_mut_ptr(),
                                2,
                                noname,
                            );
                        }
                    }
                    let value = LLVMBuildGEP(
                        builder,
                        value,
                        [
                            LLVMConstInt(LLVMInt32Type(), 0, 0),
                            LLVMConstInt(LLVMInt32Type(), i as u64, 0),
                        ]
                        .as_mut_ptr(),
                        2,
                        noname,
                    );
                    self.emit_signal_dump(builder, value, callback, callback_ctx, charmap);
                }
                LLVMBuildCall(
                    builder,
                    callback,
                    [callback_ctx, LLVMConstInt(LLVMInt8Type(), ']' as u64, 0)].as_mut_ptr(),
                    2,
                    noname,
                );
            }
            LLVMTypeKind::LLVMStructTypeKind => {
                let len = LLVMGetNumContainedTypes(ty) as usize;
                LLVMBuildCall(
                    builder,
                    callback,
                    [callback_ctx, LLVMConstInt(LLVMInt8Type(), '{' as u64, 0)].as_mut_ptr(),
                    2,
                    noname,
                );
                for i in 0..len {
                    if i > 0 {
                        for c in ", ".bytes() {
                            LLVMBuildCall(
                                builder,
                                callback,
                                [callback_ctx, LLVMConstInt(LLVMInt8Type(), c as u64, 0)]
                                    .as_mut_ptr(),
                                2,
                                noname,
                            );
                        }
                    }
                    let value = LLVMBuildGEP(
                        builder,
                        value,
                        [
                            LLVMConstInt(LLVMInt32Type(), 0, 0),
                            LLVMConstInt(LLVMInt32Type(), i as u64, 0),
                        ]
                        .as_mut_ptr(),
                        2,
                        noname,
                    );
                    self.emit_signal_dump(builder, value, callback, callback_ctx, charmap);
                }
                LLVMBuildCall(
                    builder,
                    callback,
                    [callback_ctx, LLVMConstInt(LLVMInt8Type(), '}' as u64, 0)].as_mut_ptr(),
                    2,
                    noname,
                );
            }
            _ => {
                LLVMBuildCall(
                    builder,
                    callback,
                    [callback_ctx, LLVMConstInt(LLVMInt8Type(), '?' as u64, 0)].as_mut_ptr(),
                    2,
                    noname,
                );
            }
        }
    }
}

pub struct InstanceMapping {
    unit: ModUnit,
    signals: HashMap<Value, usize>,
    insts: Vec<usize>,
    senses: RefCell<Vec<BitSet>>,
}

pub struct SignalMapping {
    unit: ModUnit,
    value: Value,
    name: Option<String>,
    ty: llhd::Type,
    llty: Cell<LLVMTypeRef>,
}

pub struct UnitMapping<'a> {
    unit: &'a dyn Unit,
    mod_unit: ModUnit,
    sigtbl: SignalTable,
    senses: RefCell<Vec<Vec<Value>>>,
    state_type: LLVMTypeRef,
    func_name: String,
    func_type: LLVMTypeRef,
    func: LLVMValueRef,
    spilled_values: HashMap<Value, usize>,
    spilled_vars: HashMap<Value, usize>,
    buffered_drvs: HashMap<Inst, usize>,
    ctx_arg: LLVMValueRef,
    state_arg: LLVMValueRef,
}

pub struct SignalTable {
    signals: Vec<Value>,
    mapping: HashMap<Value, usize>,
    llty: LLVMTypeRef,
}

pub struct UnitPopulator<'a> {
    parent: &'a Mapping<'a>,
    um: &'a UnitMapping<'a>,
    unit: &'a dyn Unit,
    builder: LLVMBuilderRef,
    di_scope: LLVMMetadataRef,
    line: usize,
    di_loc: LLVMMetadataRef,
    values: RefCell<HashMap<Value, LLVMValueRef>>,
    resume_points: RefCell<HashMap<usize, Block>>,
    blocks: RefCell<HashMap<Block, LLVMBasicBlockRef>>,
    sense_ptr: Cell<LLVMValueRef>,
    resume_ptr: Cell<LLVMValueRef>,
    inst_ptr: Cell<LLVMValueRef>,
}

impl<'a> UnitPopulator<'a> {
    /// Emit debug information.
    unsafe fn emit_debug(&self) {
        let noname = b"\0".as_ptr() as *const _;
        let dfg = self.unit.dfg();

        // // Make the input and output signals of the unit debuggable.
        // for (&value, &idx) in &self.um.sigtbl.mapping {
        //     let ptr = LLVMBuildGEP(
        //         self.builder,
        //         self.um.state_arg,
        //         [
        //             LLVMConstInt(LLVMInt32Type(), 0, 0),
        //             LLVMConstInt(LLVMInt32Type(), 1, 0),
        //             LLVMConstInt(LLVMInt32Type(), idx as u64, 0),
        //         ]
        //         .as_mut_ptr(),
        //         3 as u32,
        //         noname,
        //     );
        //     let sig = LLVMBuildLoad(self.builder, ptr, noname);
        //     let sig_idx = LLVMBuildExtractValue(self.builder, sig, 0, noname);
        //     let sig_ptr = LLVMBuildExtractValue(self.builder, sig, 1, noname);
        //     let ty = dfg.value_type(value);
        //     let ty_name = ty.to_string();
        //     let di_ty = match *ty {
        //         llhd::IntType(w) => {
        //             let bits = (w + 7) / 8 * 8;
        //             LLVMDIBuilderCreateBasicType(
        //                 self.parent.di_builder,       // Builder
        //                 ty_name.as_ptr() as *const _, // Name
        //                 ty_name.len(),                // NameLen
        //                 bits as u64,                  // SizeInBits
        //                 7,                            // Encoding (DW_ATE_unsigned)
        //                 LLVMDIFlags::LLVMDIFlagZero,  // Flags
        //             )
        //         }
        //         _ => LLVMDIBuilderCreateBasicType(
        //             self.parent.di_builder,       // Builder
        //             ty_name.as_ptr() as *const _, // Name
        //             ty_name.len(),                // NameLen
        //             0,                            // SizeInBits
        //             0,                            // Encoding
        //             LLVMDIFlags::LLVMDIFlagZero,  // Flags
        //         ),
        //     };
        //     let name = value.dump(dfg).to_string();
        //     let di_var = LLVMDIBuilderCreateAutoVariable(
        //         self.parent.di_builder,      // Builder
        //         self.di_scope,               // Scope
        //         name.as_ptr() as *const _,   // Name
        //         name.len(),                  // NameLen
        //         self.parent.di_file,         // File
        //         self.line as u32,            // LineNo
        //         di_ty,                       // Ty
        //         1,                           // AlwaysPreserve
        //         LLVMDIFlags::LLVMDIFlagZero, // Flags
        //         0,                           // AlignInBits
        //     );
        //     LLVMDIBuilderInsertDeclareAtEnd(
        //         self.parent.di_builder, // Builder
        //         sig_ptr,                // Storage
        //         di_var,                 // VarInfo
        //         LLVMDIBuilderCreateExpression(self.parent.di_builder, std::ptr::null_mut(), 0), // Expr
        //         self.di_loc,                      // DebugLoc
        //         LLVMGetInsertBlock(self.builder), // Instr
        //     );
        // }
    }

    /// Emit a process.
    unsafe fn emit_process(&self) {
        let layout = self.unit.func_layout();
        let dfg = self.unit.dfg();
        let cfg = self.unit.cfg();
        let builder = self.builder;
        let context = self.parent.context;
        let noname = b"\0".as_ptr() as *const _;

        // Prepare the dispatch and bailout basic blocks.
        let dispatch_bb = LLVMAppendBasicBlockInContext(
            context,
            self.um.func,
            b"dispatch\0".as_ptr() as *const _,
        );
        let bail_bb =
            LLVMAppendBasicBlockInContext(context, self.um.func, b"bail\0".as_ptr() as *const _);

        // Prepare a pointer to the resume point and sensitivity state variable.
        LLVMPositionBuilderAtEnd(builder, dispatch_bb);
        self.emit_debug();
        self.resume_ptr.set(LLVMBuildGEP(
            self.builder,
            self.um.state_arg,
            [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), 3, 0),
            ]
            .as_mut_ptr(),
            2 as u32,
            b"resume_ptr\0".as_ptr() as *const _,
        ));
        self.sense_ptr.set(LLVMBuildGEP(
            self.builder,
            self.um.state_arg,
            [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), 0, 0),
            ]
            .as_mut_ptr(),
            2 as u32,
            b"sense_ptr\0".as_ptr() as *const _,
        ));
        self.inst_ptr.set(LLVMBuildGEP(
            self.builder,
            self.um.state_arg,
            [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), 2, 0),
            ]
            .as_mut_ptr(),
            2 as u32,
            b"inst_ptr\0".as_ptr() as *const _,
        ));

        // Create the basic blocks.
        for block in layout.blocks() {
            let bb_name = cfg
                .get_name(block)
                .map(|n| format!(".{}\0", n))
                .unwrap_or(format!("\0"));
            let bb =
                LLVMAppendBasicBlockInContext(context, self.um.func, bb_name.as_ptr() as *const _);
            self.blocks.borrow_mut().insert(block, bb);
        }

        // Emit the instructions.
        // let mut signal_sets = HashMap::new();
        self.resume_points.borrow_mut().insert(0, layout.entry());
        for block in layout.blocks() {
            LLVMPositionBuilderAtEnd(builder, self.blocks.borrow()[&block]);
            for inst in layout.insts(block) {
                self.emit_inst(inst);
            }
        }

        // Build the dispatch table.
        LLVMPositionBuilderAtEnd(builder, dispatch_bb);
        let resume = LLVMBuildLoad(builder, self.resume_ptr.get(), noname);
        let sw = LLVMBuildSwitch(
            builder,
            resume,
            bail_bb,
            self.resume_points.borrow().len() as u32,
        );
        for (&id, &block) in self.resume_points.borrow().iter() {
            LLVMAddCase(
                sw,
                LLVMConstInt(self.parent.resume_type, id as u64, 0),
                self.blocks.borrow()[&block],
            );
        }

        // Fill in the bailout block.
        LLVMPositionBuilderAtEnd(builder, bail_bb);
        let this = LLVMBuildBitCast(builder, self.um.func, self.parent.voidptr_type, noname);
        LLVMBuildRet(builder, this);
    }

    /// Register a value write.
    unsafe fn set_value(&self, value: Value, to: LLVMValueRef) {
        let noname = b"\0".as_ptr() as *const _;
        if let Some(&state_slot) = self.um.spilled_values.get(&value) {
            let mut ind = [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), state_slot as u64, 0),
            ];
            let ptr = LLVMBuildGEP(
                self.builder,
                self.um.state_arg,
                ind.as_mut_ptr(),
                ind.len() as u32,
                noname,
            );
            LLVMBuildStore(self.builder, to, ptr);
        } else {
            self.values.borrow_mut().insert(value, to);
        }
    }

    /// Use a value.
    unsafe fn use_value(&self, value: Value) -> LLVMValueRef {
        let noname = b"\0".as_ptr() as *const _;

        // Resolve as a signal.
        if let Some(&idx) = self.um.sigtbl.mapping.get(&value) {
            let ptr = LLVMBuildGEP(
                self.builder,
                self.um.state_arg,
                [
                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                    LLVMConstInt(LLVMInt32Type(), 1, 0),
                    LLVMConstInt(LLVMInt32Type(), idx as u64, 0),
                ]
                .as_mut_ptr(),
                3 as u32,
                noname,
            );
            let sig = LLVMBuildLoad(self.builder, ptr, noname);
            let sig_idx = LLVMBuildExtractValue(self.builder, sig, 0, noname);
            let sig_ptr = LLVMBuildExtractValue(self.builder, sig, 1, noname);
            let ty = LLVMStructType(
                [
                    LLVMInt32Type(),
                    LLVMTypeOf(sig_ptr),
                    LLVMInt32Type(),
                    LLVMInt32Type(),
                ]
                .as_mut_ptr(),
                4,
                0,
            );
            let sig = LLVMConstNull(ty);
            let sig = LLVMBuildInsertValue(self.builder, sig, sig_idx, 0, noname);
            let sig = LLVMBuildInsertValue(self.builder, sig, sig_ptr, 1, noname);
            return sig;
        }

        // Resolve as a variable.
        let var_slot = self.um.spilled_vars.get(&value);
        let value_slot = self.um.spilled_values.get(&value);
        if let Some(&state_slot) = var_slot.or(value_slot) {
            let mut ind = [
                LLVMConstInt(LLVMInt32Type(), 0, 0),
                LLVMConstInt(LLVMInt32Type(), state_slot as u64, 0),
            ];
            let ptr = LLVMBuildGEP(
                self.builder,
                self.um.state_arg,
                ind.as_mut_ptr(),
                ind.len() as u32,
                noname,
            );
            return if value_slot.is_some() {
                LLVMBuildLoad(self.builder, ptr, noname)
            } else {
                ptr
            };
        }

        // Otherwise fall back to regular value.
        match self.values.borrow().get(&value) {
            Some(&v) => v,
            None => panic!("{} not emitted", value.dump(self.unit.dfg())),
        }
    }

    /// Emit an instruction into a unit being populated.
    unsafe fn emit_inst(&self, inst: Inst) {
        let m = self.parent;
        let dfg = self.unit.dfg();
        let cfg = self.unit.try_cfg();
        let data = &dfg[inst];
        let builder = self.builder;
        let state_ptr = self.um.state_arg;
        let noname = b"\0".as_ptr() as *const _;

        let di_loc = if !self.di_scope.is_null() {
            let loc = dfg
                .location_hint(inst)
                .and_then(|loc| {
                    self.parent
                        .files
                        .location(self.parent.file_id, loc as u32)
                        .ok()
                })
                .unwrap_or(Location::new(0, 0));
            let di_loc = LLVMDIBuilderCreateDebugLocation(
                self.parent.context,
                loc.line.to_usize() as u32 + 1,
                loc.column.to_usize() as u32 + 1,
                self.di_scope,
                std::ptr::null_mut(),
            );
            LLVMSetCurrentDebugLocation(builder, LLVMMetadataAsValue(self.parent.context, di_loc));
            Some((loc, di_loc))
        } else {
            None
        };

        // Handle void instructions.
        match data.opcode() {
            Opcode::Inst => return,

            // Signals.
            Opcode::Drv => {
                // Prepare the data for the drive.
                let ctx = self.um.ctx_arg;
                let sigptr = self.use_value(data.args()[0]);
                let driven = self.use_value(data.args()[1]);

                let sig = LLVMBuildExtractValue(self.builder, sigptr, 0, noname);
                let offset = LLVMBuildExtractValue(self.builder, sigptr, 2, noname);
                let length = LLVMBuildExtractValue(self.builder, sigptr, 3, noname);
                let sigptr = LLVMBuildExtractValue(self.builder, sigptr, 1, noname);
                let name = format!("_$.{}\0", data.args()[0].dump(dfg));
                let sigptr = LLVMBuildBitCast(
                    builder,
                    sigptr,
                    self.parent.voidptr_type,
                    name.as_ptr() as *const _,
                );

                let dataptr = LLVMBuildAlloca(builder, LLVMTypeOf(driven), noname);
                LLVMBuildStore(builder, driven, dataptr);
                let dataptr = LLVMBuildBitCast(builder, dataptr, self.parent.voidptr_type, noname);
                let size = LLVMSizeOf(LLVMTypeOf(driven));
                let size = LLVMBuildTrunc(builder, size, LLVMInt32Type(), noname);
                let time = self.use_value(data.args()[2]);

                // Check if we are buffering the drive. If yes, we only apply it
                // if the value actually changes.
                let out = if let Some(&buffer_slot) = self.um.buffered_drvs.get(&inst) {
                    let mut ind = [
                        LLVMConstInt(LLVMInt32Type(), 0, 0),
                        LLVMConstInt(LLVMInt32Type(), buffer_slot as u64, 0),
                    ];
                    let ptr = LLVMBuildGEP(
                        self.builder,
                        self.um.state_arg,
                        ind.as_mut_ptr(),
                        ind.len() as u32,
                        noname,
                    );
                    let buffered =
                        LLVMBuildLoad(self.builder, ptr, b"buffered\0".as_ptr() as *const _);
                    let eq = self.emit_aggregate_eq(driven, buffered);
                    let take = LLVMAppendBasicBlockInContext(
                        self.parent.context,
                        self.um.func,
                        "drv.take\0".as_ptr() as *const _,
                    );
                    let skip = LLVMAppendBasicBlockInContext(
                        self.parent.context,
                        self.um.func,
                        "drv.skip\0".as_ptr() as *const _,
                    );
                    LLVMBuildCondBr(builder, eq, skip, take);
                    LLVMPositionBuilderAtEnd(builder, take);
                    Some((skip, ptr))
                } else {
                    None
                };

                // Actually perform the drive.
                let mut call_args = [ctx, sig, sigptr, dataptr, size, time, offset, length];
                LLVMBuildCall(
                    builder,
                    self.parent.drive_func,
                    call_args.as_mut_ptr(),
                    call_args.len() as u32,
                    noname,
                );

                // Store the driven value to the buffer if needed.
                if let Some((skip, ptr)) = out {
                    // Store.
                    LLVMBuildStore(self.builder, driven, ptr);

                    // Go back to business as usual.
                    LLVMBuildBr(builder, skip);
                    LLVMPositionBuilderAtEnd(builder, skip);
                }
                return;
            }

            // Memory.
            Opcode::St => {
                LLVMBuildStore(
                    builder,
                    self.use_value(data.args()[1]),
                    self.use_value(data.args()[0]),
                );
                return;
            }

            // Control flow.
            Opcode::Br => {
                LLVMBuildBr(builder, self.blocks.borrow()[&data.blocks()[0]]);
                return;
            }

            Opcode::BrCond => {
                LLVMBuildCondBr(
                    builder,
                    self.use_value(data.args()[0]),
                    self.blocks.borrow()[&data.blocks()[1]],
                    self.blocks.borrow()[&data.blocks()[0]],
                );
                return;
            }

            // Execution suspension.
            Opcode::Wait | Opcode::WaitTime => {
                let (time, args) = match data.opcode() {
                    Opcode::Wait => (None, data.args()),
                    Opcode::WaitTime => (Some(self.use_value(data.args()[0])), &data.args()[1..]),
                    _ => unreachable!(),
                };
                let id = self.resume_points.borrow().len();
                let ssid = self.um.senses.borrow().len();
                self.resume_points.borrow_mut().insert(id, data.blocks()[0]);
                self.um.senses.borrow_mut().insert(ssid, args.to_vec());
                LLVMBuildStore(
                    builder,
                    LLVMConstInt(self.parent.resume_type, id as u64, 0),
                    self.resume_ptr.get(),
                );
                LLVMBuildStore(
                    builder,
                    LLVMConstInt(LLVMInt64Type(), ssid as u64, 0),
                    self.sense_ptr.get(),
                );
                if let Some(time) = time {
                    let inst =
                        LLVMBuildLoad(builder, self.inst_ptr.get(), b"inst\0".as_ptr() as *const _);
                    let mut call_args = [self.um.ctx_arg, inst, time];
                    LLVMBuildCall(
                        builder,
                        self.parent.wake_func,
                        call_args.as_mut_ptr(),
                        call_args.len() as u32,
                        noname,
                    );
                }
                let this =
                    LLVMBuildBitCast(builder, self.um.func, self.parent.voidptr_type, noname);
                LLVMBuildRet(builder, this);
                return;
            }

            Opcode::Halt => {
                LLVMBuildStore(
                    builder,
                    LLVMConstInt(self.parent.resume_type, -1i64 as u64, 0),
                    self.resume_ptr.get(),
                );
                LLVMBuildStore(
                    builder,
                    LLVMConstInt(LLVMInt64Type(), 1, 0), // insensitive
                    self.sense_ptr.get(),
                );
                let this =
                    LLVMBuildBitCast(builder, self.um.func, self.parent.voidptr_type, noname);
                LLVMBuildRet(builder, this);
                return;
            }

            _ => (),
        }
        if !dfg.has_result(inst) {
            return;
        }

        // Handle non-void instructions.
        let result = dfg.inst_result(inst);
        let ty = dfg.value_type(result);

        match data.opcode() {
            // Constants.
            Opcode::ConstInt => {
                let i = data.get_const_int().unwrap();
                let t = LLVMIntType(i.width as u32);
                let v = LLVMConstIntOfString(
                    t,
                    format!("{}\0", i.value).as_bytes().as_ptr() as *const _,
                    10,
                );
                self.set_value(result, v);
            }

            Opcode::ConstTime => {
                let t = data.get_const_time().unwrap();
                let s = (&t.time * &m.time_prec)
                    .trunc()
                    .to_integer()
                    .to_usize()
                    .unwrap();
                let v = LLVMConstStruct(
                    [
                        LLVMConstInt(m.seconds_type, s as u64, 0),
                        LLVMConstInt(m.delta_type, t.delta as u64, 0),
                        LLVMConstInt(m.epsilon_type, t.epsilon as u64, 0),
                    ]
                    .as_mut_ptr(),
                    3,
                    0,
                );
                self.set_value(result, v);
            }

            // Aggregates.
            Opcode::Array | Opcode::Struct => {
                let mut v = LLVMConstNull(self.parent.map_type(&ty));
                for (i, &arg) in data.args().iter().enumerate() {
                    v = LLVMBuildInsertValue(builder, v, self.use_value(arg), i as u32, noname);
                }
                self.set_value(result, v);
            }

            Opcode::ArrayUniform => {
                let arg = self.use_value(data.args()[0]);
                let mut v = LLVMConstNull(self.parent.map_type(&ty));
                for i in 0..data.imms()[0] {
                    v = LLVMBuildInsertValue(builder, v, arg, i as u32, noname);
                }
                self.set_value(result, v);
            }

            // Signals.
            Opcode::Sig => (),

            Opcode::Prb => {
                let sig = self.use_value(data.args()[0]);
                let sig = LLVMBuildExtractValue(self.builder, sig, 1, noname);
                let ld = LLVMBuildLoad(builder, sig, noname);
                self.set_value(result, ld);
                // self.set_value(result, LLVMConstNull(self.parent.map_type(&ty)));
            }

            // Memory.
            Opcode::Var => {
                let dst = if let Some(&state_slot) = self.um.spilled_vars.get(&result) {
                    let mut ind = [
                        LLVMConstInt(LLVMInt32Type(), 0, 0),
                        LLVMConstInt(LLVMInt32Type(), state_slot as u64, 0),
                    ];
                    LLVMBuildGEP(
                        builder,
                        state_ptr,
                        ind.as_mut_ptr(),
                        ind.len() as u32,
                        noname,
                    )
                } else {
                    let a = LLVMBuildAlloca(
                        builder,
                        self.parent
                            .map_type(&dfg.value_type(result).unwrap_pointer()),
                        noname,
                    );
                    self.set_value(result, a);
                    a
                };
                LLVMBuildStore(builder, self.use_value(data.args()[0]), dst);
            }

            Opcode::Ld => {
                let v = LLVMBuildLoad(builder, self.use_value(data.args()[0]), noname);
                self.set_value(result, v);
            }

            // Comparisons.
            Opcode::Eq
            | Opcode::Neq
            | Opcode::Ugt
            | Opcode::Uge
            | Opcode::Ult
            | Opcode::Ule
            | Opcode::Sgt
            | Opcode::Sge
            | Opcode::Slt
            | Opcode::Sle => {
                let op = match data.opcode() {
                    Opcode::Eq => LLVMIntPredicate::LLVMIntEQ,
                    Opcode::Neq => LLVMIntPredicate::LLVMIntNE,
                    Opcode::Ugt => LLVMIntPredicate::LLVMIntUGT,
                    Opcode::Uge => LLVMIntPredicate::LLVMIntUGE,
                    Opcode::Ult => LLVMIntPredicate::LLVMIntULT,
                    Opcode::Ule => LLVMIntPredicate::LLVMIntULE,
                    Opcode::Sgt => LLVMIntPredicate::LLVMIntSGT,
                    Opcode::Sge => LLVMIntPredicate::LLVMIntSGE,
                    Opcode::Slt => LLVMIntPredicate::LLVMIntSLT,
                    Opcode::Sle => LLVMIntPredicate::LLVMIntSLE,
                    _ => unreachable!(),
                };
                let v = LLVMBuildICmp(
                    builder,
                    op,
                    self.use_value(data.args()[0]),
                    self.use_value(data.args()[1]),
                    noname,
                );
                self.set_value(result, v);
            }

            // Arithmetic.
            Opcode::Add
            | Opcode::Sub
            | Opcode::Umul
            | Opcode::Smul
            | Opcode::Udiv
            | Opcode::Sdiv
            | Opcode::Umod
            | Opcode::Smod
            | Opcode::Urem
            | Opcode::Srem
            | Opcode::And
            | Opcode::Or
            | Opcode::Xor => {
                let lhs = self.use_value(data.args()[0]);
                let rhs = self.use_value(data.args()[1]);
                let v = match data.opcode() {
                    Opcode::Add => LLVMBuildAdd(builder, lhs, rhs, noname),
                    Opcode::Sub => LLVMBuildSub(builder, lhs, rhs, noname),
                    Opcode::Umul => LLVMBuildMul(builder, lhs, rhs, noname),
                    Opcode::Smul => LLVMBuildMul(builder, lhs, rhs, noname),
                    Opcode::Udiv => LLVMBuildUDiv(builder, lhs, rhs, noname),
                    Opcode::Sdiv => LLVMBuildSDiv(builder, lhs, rhs, noname),
                    Opcode::Umod => LLVMBuildURem(builder, lhs, rhs, noname), // fix
                    Opcode::Smod => LLVMBuildSRem(builder, lhs, rhs, noname), // fix
                    Opcode::Urem => LLVMBuildURem(builder, lhs, rhs, noname), // fix
                    Opcode::Srem => LLVMBuildSRem(builder, lhs, rhs, noname), // fix
                    Opcode::And => LLVMBuildAnd(builder, lhs, rhs, noname),
                    Opcode::Or => LLVMBuildOr(builder, lhs, rhs, noname),
                    Opcode::Xor => LLVMBuildXor(builder, lhs, rhs, noname),
                    _ => unreachable!(),
                };
                self.set_value(result, v);
            }
            Opcode::Not | Opcode::Neg => {
                let arg = self.use_value(data.args()[0]);
                let v = match data.opcode() {
                    Opcode::Not => LLVMBuildNot(builder, arg, noname),
                    Opcode::Neg => LLVMBuildNeg(builder, arg, noname),
                    _ => unreachable!(),
                };
                self.set_value(result, v);
            }

            // Multiplexing.
            Opcode::Mux => {
                let ways = self.use_value(data.args()[0]);
                let select = self.use_value(data.args()[1]);
                let alloca = LLVMBuildAlloca(builder, LLVMTypeOf(ways), noname);
                LLVMBuildStore(builder, ways, alloca);
                let select = LLVMBuildZExt(builder, select, LLVMInt32Type(), noname);
                let ptr = LLVMBuildGEP(
                    builder,
                    alloca,
                    [LLVMConstInt(LLVMInt32Type(), 0, 0), select].as_mut_ptr(),
                    2,
                    noname,
                );
                let v = LLVMBuildLoad(builder, ptr, noname);
                self.set_value(result, v);
            }

            // Insertion and extraction.
            Opcode::InsSlice => {
                let offset = data.imms()[0];
                let length = data.imms()[1];
                if ty.is_int() {
                    let target = self.use_value(data.args()[0]);
                    let arg = self.use_value(data.args()[1]);
                    let mask = ((BigInt::one() << length) - 1) << offset;
                    let mask = LLVMConstIntOfString(
                        LLVMTypeOf(target),
                        format!("{}\0", mask).as_bytes().as_ptr() as *const _,
                        10,
                    );
                    // let not_mask = LLVMBuildNot(builder, mask, noname);
                    let arg = LLVMBuildZExt(builder, arg, LLVMTypeOf(target), noname);
                    let arg = LLVMBuildShl(
                        builder,
                        arg,
                        LLVMConstInt(LLVMTypeOf(arg), offset as u64, 0),
                        noname,
                    );
                    let target = LLVMBuildOr(builder, target, mask, noname);
                    let target = LLVMBuildAnd(builder, target, arg, noname);
                    self.set_value(result, target);
                } else {
                    unimplemented!("inss on {}", ty);
                }
            }

            Opcode::InsField => {
                let field = data.imms()[0];
                let target = self.use_value(data.args()[0]);
                let arg = self.use_value(data.args()[1]);

                // Handle array/struct insertion.
                if ty.is_array() || ty.is_struct() {
                    let v = LLVMBuildInsertValue(builder, target, arg, field as u32, noname);
                    self.set_value(result, v);
                } else {
                    unimplemented!("insf on {}", ty);
                }
            }

            Opcode::ExtSlice => {
                let target_ty = dfg.value_type(data.args()[0]);
                let offset = data.imms()[0];
                let length = data.imms()[1];

                // Handle integer extraction.
                if target_ty.is_int() {
                    let llty = LLVMIntType(length as u32);
                    let v = self.use_value(data.args()[0]);
                    let v = LLVMBuildLShr(
                        builder,
                        v,
                        LLVMConstInt(LLVMTypeOf(v), offset as u64, 0),
                        noname,
                    );
                    let v = LLVMBuildTrunc(builder, v, llty, noname);
                    self.set_value(result, v);
                }
                // Handle integer projections.
                else if target_ty.is_signal() && target_ty.unwrap_signal().is_int() {
                    // Determine the signal memory and signal type.
                    let sigptr_ty =
                        LLVMPointerType(self.parent.map_type(target_ty.unwrap_signal()), 0);
                    let sig_ty = LLVMStructType(
                        [LLVMInt32Type(), sigptr_ty, LLVMInt32Type(), LLVMInt32Type()].as_mut_ptr(),
                        4,
                        0,
                    );

                    // Extract the fields from the input signal.
                    let sig = self.use_value(data.args()[0]);
                    let sig_idx = LLVMBuildExtractValue(builder, sig, 0, noname);
                    let sig_ptr = LLVMBuildExtractValue(builder, sig, 1, noname);
                    let sig_off = LLVMBuildExtractValue(builder, sig, 2, noname);

                    // Shift the pointer and adjust the offset.
                    let k8u64 = LLVMConstInt(LLVMInt32Type(), 8, 0);
                    let sig_off = LLVMBuildAdd(
                        builder,
                        sig_off,
                        LLVMConstInt(LLVMInt32Type(), offset as u64, 0),
                        noname,
                    );
                    let sig_ptr = LLVMBuildPtrToInt(builder, sig_ptr, LLVMInt64Type(), noname);
                    let sig_ptr = LLVMBuildAdd(
                        builder,
                        sig_ptr,
                        LLVMBuildZExt(
                            builder,
                            LLVMBuildUDiv(builder, sig_off, k8u64, noname),
                            LLVMInt64Type(),
                            noname,
                        ),
                        noname,
                    );
                    let sig_ptr = LLVMBuildIntToPtr(builder, sig_ptr, sigptr_ty, noname);
                    let sig_off = LLVMBuildURem(builder, sig_off, k8u64, noname);
                    let sig_len = LLVMConstInt(LLVMInt32Type(), length as u64, 0);

                    // Construct the new signal.
                    let sig = LLVMConstNull(sig_ty);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_idx, 0, noname);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_ptr, 1, noname);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_off, 2, noname);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_len, 3, noname);
                    self.set_value(result, sig);
                }
                // Handle projections.
                else if target_ty.is_signal() {
                    error!("Signal exts not supported: {}", inst.dump(dfg, cfg));
                    // TODO: Add projection metadata.
                    self.set_value(result, self.use_value(data.args()[0]));
                } else {
                    unimplemented!("exts on {}", target_ty);
                }
            }

            Opcode::ExtField => {
                let field = data.imms()[0];
                let target_ty = dfg.value_type(data.args()[0]);

                // Handle array extraction.
                if target_ty.is_array() {
                    let v = LLVMBuildExtractValue(
                        builder,
                        self.use_value(data.args()[0]),
                        field as u32,
                        noname,
                    );
                    self.set_value(result, v);
                }
                // Handle struct extraction.
                else if target_ty.is_struct() {
                    let v = LLVMBuildExtractValue(
                        builder,
                        self.use_value(data.args()[0]),
                        field as u32,
                        noname,
                    );
                    self.set_value(result, v);
                }
                // Handle projections.
                else if target_ty.is_signal() {
                    let sig = self.use_value(data.args()[0]);
                    let sigptr = LLVMBuildExtractValue(builder, sig, 1, noname);

                    let offset_ptr = LLVMBuildGEP(
                        builder,
                        sigptr,
                        [
                            LLVMConstInt(LLVMInt32Type(), 0, 0),
                            LLVMConstInt(LLVMInt32Type(), field as u64, 0),
                        ]
                        .as_mut_ptr(),
                        2,
                        noname,
                    );
                    let offset_ptr =
                        LLVMBuildBitCast(builder, offset_ptr, LLVMTypeOf(sigptr), noname);

                    let sig = LLVMBuildInsertValue(builder, sig, offset_ptr, 1, noname);
                    self.set_value(result, sig);
                } else {
                    unimplemented!("extf on {}", target_ty);
                }
            }

            // Shifts.
            Opcode::Shl | Opcode::Shr => {
                let base = data.args()[0];
                let hidden = data.args()[1];
                let amount = data.args()[2];

                // Handle integer shifts.
                if ty.is_int() {
                    let w = ty.unwrap_int();
                    let base_w = dfg.value_type(base).unwrap_int();
                    let hidden_w = dfg.value_type(hidden).unwrap_int();
                    let amount_w = dfg.value_type(amount).unwrap_int();
                    let unified_ty = LLVMIntType(std::cmp::max(base_w + hidden_w, amount_w) as u32);

                    let mut base_ext =
                        LLVMBuildZExt(builder, self.use_value(base), unified_ty, noname);
                    let mut hidden_ext =
                        LLVMBuildZExt(builder, self.use_value(hidden), unified_ty, noname);

                    match data.opcode() {
                        Opcode::Shl => {
                            base_ext = LLVMBuildShl(
                                builder,
                                base_ext,
                                LLVMConstInt(LLVMInt32Type(), hidden_w as u64, 0),
                                noname,
                            );
                        }
                        Opcode::Shr => {
                            hidden_ext = LLVMBuildShl(
                                builder,
                                hidden_ext,
                                LLVMConstInt(LLVMInt32Type(), base_w as u64, 0),
                                noname,
                            );
                        }
                        _ => unreachable!(),
                    }
                    let unified = LLVMBuildOr(builder, base_ext, hidden_ext, noname);
                    let amount = self.use_value(amount);
                    let amount = LLVMBuildZExt(builder, amount, unified_ty, noname);

                    let shifted = match data.opcode() {
                        // LShr is correct!
                        Opcode::Shl => LLVMBuildLShr(
                            builder,
                            unified,
                            LLVMBuildSub(
                                builder,
                                LLVMConstInt(LLVMTypeOf(amount), hidden_w as u64, 0),
                                amount,
                                noname,
                            ),
                            noname,
                        ),
                        Opcode::Shr => LLVMBuildLShr(builder, unified, amount, noname),
                        _ => unreachable!(),
                    };
                    let shifted = LLVMBuildTrunc(builder, shifted, LLVMIntType(w as u32), noname);
                    self.set_value(result, shifted);
                }
                // Handle array shifts.
                else if ty.is_array() {
                    let (w, elty) = ty.unwrap_array();
                    let (base_w, _) = dfg.value_type(base).unwrap_array();
                    let (hidden_w, _) = dfg.value_type(hidden).unwrap_array();
                    let unified_ty =
                        LLVMArrayType(self.parent.map_type(elty), (base_w + hidden_w) as u32);

                    let unified = LLVMBuildAlloca(builder, unified_ty, noname);
                    let mut base_ptr = unified;
                    let mut hidden_ptr = unified;

                    match data.opcode() {
                        Opcode::Shl => {
                            base_ptr = LLVMBuildGEP(
                                builder,
                                base_ptr,
                                [
                                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                                    LLVMConstInt(LLVMInt32Type(), hidden_w as u64, 0),
                                ]
                                .as_mut_ptr(),
                                2,
                                noname,
                            );
                        }
                        Opcode::Shr => {
                            hidden_ptr = LLVMBuildGEP(
                                builder,
                                hidden_ptr,
                                [
                                    LLVMConstInt(LLVMInt32Type(), 0, 0),
                                    LLVMConstInt(LLVMInt32Type(), base_w as u64, 0),
                                ]
                                .as_mut_ptr(),
                                2,
                                noname,
                            );
                        }
                        _ => unreachable!(),
                    }
                    let base = self.use_value(base);
                    let hidden = self.use_value(hidden);
                    let base_ptr = LLVMBuildBitCast(
                        builder,
                        base_ptr,
                        LLVMPointerType(LLVMTypeOf(base), 0),
                        noname,
                    );
                    let hidden_ptr = LLVMBuildBitCast(
                        builder,
                        hidden_ptr,
                        LLVMPointerType(LLVMTypeOf(hidden), 0),
                        noname,
                    );
                    LLVMBuildStore(builder, base, base_ptr);
                    LLVMBuildStore(builder, hidden, hidden_ptr);

                    // Clamp the amount.
                    let amount = self.use_value(amount);
                    let amount = self.emit_clamp_amount(amount, hidden_w as u64);

                    let offset = match data.opcode() {
                        Opcode::Shl => LLVMBuildSub(
                            builder,
                            LLVMConstInt(LLVMTypeOf(amount), hidden_w as u64, 0),
                            amount,
                            noname,
                        ),
                        Opcode::Shr => amount,
                        _ => unreachable!(),
                    };
                    let offset_ptr = LLVMBuildGEP(
                        builder,
                        unified,
                        [LLVMConstInt(LLVMInt32Type(), 0, 0), offset].as_mut_ptr(),
                        2,
                        noname,
                    );
                    let offset_ptr = LLVMBuildBitCast(
                        builder,
                        offset_ptr,
                        LLVMPointerType(LLVMTypeOf(base), 0),
                        noname,
                    );
                    let v = LLVMBuildLoad(builder, offset_ptr, noname);
                    self.set_value(result, v);
                }
                // Handle integer projection shifts.
                else if ty.is_signal() && ty.unwrap_signal().is_int() {
                    let base_ty = dfg.value_type(base).unwrap_signal().clone();
                    let hidden_ty = dfg.value_type(hidden).unwrap_signal().clone();
                    let base_w = base_ty.unwrap_int();
                    let hidden_w = hidden_ty.unwrap_int();

                    // Clamp the amount.
                    let amount = self.use_value(amount);
                    let amount = self.emit_clamp_amount(amount, hidden_w as u64);

                    // Determine the signal memory and signal type.
                    let sigptr_ty = LLVMPointerType(self.parent.map_type(&base_ty), 0);
                    let sig_ty = LLVMStructType(
                        [LLVMInt32Type(), sigptr_ty, LLVMInt32Type(), LLVMInt32Type()].as_mut_ptr(),
                        4,
                        0,
                    );

                    // Extract the fields from the input signal.
                    let sig = self.use_value(base);
                    let sig_idx = LLVMBuildExtractValue(builder, sig, 0, noname);
                    let sig_ptr = LLVMBuildExtractValue(builder, sig, 1, noname);
                    let sig_off = LLVMBuildExtractValue(builder, sig, 2, noname);

                    // Shift the pointer and adjust the offset.
                    let k8u64 = LLVMConstInt(LLVMInt32Type(), 8, 0);
                    let sig_off = LLVMBuildAdd(builder, sig_off, amount, noname);
                    let sig_ptr = LLVMBuildPtrToInt(builder, sig_ptr, LLVMInt64Type(), noname);
                    let sig_ptr = LLVMBuildAdd(
                        builder,
                        sig_ptr,
                        LLVMBuildZExt(
                            builder,
                            LLVMBuildUDiv(builder, sig_off, k8u64, noname),
                            LLVMInt64Type(),
                            noname,
                        ),
                        noname,
                    );
                    let sig_ptr = LLVMBuildIntToPtr(builder, sig_ptr, sigptr_ty, noname);
                    let sig_off = LLVMBuildURem(builder, sig_off, k8u64, noname);
                    let sig_len = LLVMConstInt(LLVMInt32Type(), base_w as u64, 0);

                    // Construct the new signal.
                    let sig = LLVMConstNull(sig_ty);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_idx, 0, noname);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_ptr, 1, noname);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_off, 2, noname);
                    let sig = LLVMBuildInsertValue(builder, sig, sig_len, 3, noname);
                    self.set_value(result, sig);
                }
                // Handle projection shifts.
                else if ty.is_signal() {
                    let sig = self.use_value(data.args()[0]);
                    let sigptr = LLVMBuildExtractValue(builder, sig, 1, noname);

                    let amount = self.use_value(amount);
                    let amount = self.emit_clamp_amount(
                        amount,
                        dfg.value_type(data.args()[0]).unwrap_signal().len() as u64,
                    );
                    let offset = match data.opcode() {
                        Opcode::Shl => LLVMBuildNeg(builder, amount, noname),
                        Opcode::Shr => amount,
                        _ => unreachable!(),
                    };
                    let offset_ptr = LLVMBuildGEP(
                        builder,
                        sigptr,
                        [LLVMConstInt(LLVMInt32Type(), 0, 0), offset].as_mut_ptr(),
                        2,
                        noname,
                    );
                    let offset_ptr =
                        LLVMBuildBitCast(builder, offset_ptr, LLVMTypeOf(sigptr), noname);

                    let sig = LLVMBuildInsertValue(builder, sig, offset_ptr, 1, noname);
                    self.set_value(result, sig);
                } else {
                    unimplemented!("shift on {}", ty);
                }
            }

            _ => {
                error!("Instruction not supported: {}", inst.dump(dfg, cfg));
            }
        }

        if let Some(&value) = self.values.borrow().get(&result) {
            let name = format!("_{}", result.dump(dfg));
            LLVMSetValueName2(value, name.as_ptr() as *const _, name.len());
        }

        if let (Some((loc, di_loc)), Some(&value)) = (di_loc, self.values.borrow().get(&result)) {
            let ty_name = ty.to_string();
            let di_ty = match *ty {
                llhd::IntType(w) => {
                    let bits = (w + 7) / 8 * 8;
                    LLVMDIBuilderCreateBasicType(
                        self.parent.di_builder,       // Builder
                        ty_name.as_ptr() as *const _, // Name
                        ty_name.len(),                // NameLen
                        bits as u64,                  // SizeInBits
                        7,                            // Encoding (DW_ATE_unsigned)
                        LLVMDIFlags::LLVMDIFlagZero,  // Flags
                    )
                }
                _ => LLVMDIBuilderCreateBasicType(
                    self.parent.di_builder,       // Builder
                    ty_name.as_ptr() as *const _, // Name
                    ty_name.len(),                // NameLen
                    0,                            // SizeInBits
                    0,                            // Encoding
                    LLVMDIFlags::LLVMDIFlagZero,  // Flags
                ),
            };
            let name = result.dump(dfg).to_string();
            let di_var = LLVMDIBuilderCreateAutoVariable(
                self.parent.di_builder,         // Builder
                self.di_scope,                  // Scope
                name.as_ptr() as *const _,      // Name
                name.len(),                     // NameLen
                self.parent.di_file,            // File
                loc.line.to_usize() as u32 + 1, // LineNo
                di_ty,                          // Ty
                1,                              // AlwaysPreserve
                LLVMDIFlags::LLVMDIFlagZero,    // Flags
                0,                              // AlignInBits
            );
            LLVMDIBuilderInsertDbgValueAtEnd(
                self.parent.di_builder, // Builder
                value,                  // Storage
                di_var,                 // VarInfo
                LLVMDIBuilderCreateExpression(self.parent.di_builder, std::ptr::null_mut(), 0), // Expr
                di_loc,                      // DebugLoc
                LLVMGetInsertBlock(builder), // Instr
            );
        }
    }

    /// Emit the code necessary to clamp a shift amount to a given width.
    pub unsafe fn emit_clamp_amount(&self, amount: LLVMValueRef, max: u64) -> LLVMValueRef {
        let builder = self.builder;
        let noname = b"\0".as_ptr() as *const _;

        let amount_max = max;
        let amount_bits = std::cmp::max(
            64 - amount_max.leading_zeros() + 1,
            LLVMGetIntTypeWidth(LLVMTypeOf(amount)),
        );
        let amount = LLVMBuildZExt(builder, amount, LLVMIntType(amount_bits), noname);
        let amount_min = LLVMConstInt(LLVMTypeOf(amount), 0, 0);
        let amount_max = LLVMConstInt(LLVMTypeOf(amount), max, 0);
        let amount_below = LLVMBuildICmp(
            builder,
            LLVMIntPredicate::LLVMIntULT,
            amount,
            amount_min,
            noname,
        );
        let amount_above = LLVMBuildICmp(
            builder,
            LLVMIntPredicate::LLVMIntUGT,
            amount,
            amount_max,
            noname,
        );
        let amount = LLVMBuildSelect(builder, amount_below, amount_min, amount, noname);
        let amount = LLVMBuildSelect(builder, amount_above, amount_max, amount, noname);
        amount
    }

    /// Ensure that all instructions have been emitted that are needed to
    /// materialize a value.
    pub unsafe fn emit_insts_for_value(&self, value: Value) -> LLVMValueRef {
        if let Some(&v) = self.values.borrow().get(&value) {
            return v;
        }
        let dfg = self.unit.dfg();
        let cfg = self.unit.try_cfg();
        let inst = dfg.value_inst(value);

        // Ensure uses have been materialized.
        for &arg in dfg[inst].args() {
            self.emit_insts_for_value(arg);
        }

        // Materialize the value.
        trace!("Materialize {}", inst.dump(dfg, cfg));
        self.emit_inst(inst);
        self.values.borrow()[&value]
    }

    /// Emit the code to compare two (potentially aggregate) values.
    pub unsafe fn emit_aggregate_eq(&self, lhs: LLVMValueRef, rhs: LLVMValueRef) -> LLVMValueRef {
        let builder = self.builder;
        let noname = b"\0".as_ptr() as *const _;
        let ty = LLVMTypeOf(lhs);
        match LLVMGetTypeKind(ty) {
            LLVMTypeKind::LLVMIntegerTypeKind => {
                LLVMBuildICmp(builder, LLVMIntPredicate::LLVMIntEQ, lhs, rhs, noname)
            }
            LLVMTypeKind::LLVMArrayTypeKind => {
                let len = LLVMGetArrayLength(ty);
                let mut r = LLVMConstInt(LLVMInt1Type(), 1, 0);
                for i in 0..len {
                    let lhs = LLVMBuildExtractValue(builder, lhs, i as u32, noname);
                    let rhs = LLVMBuildExtractValue(builder, rhs, i as u32, noname);
                    let c = self.emit_aggregate_eq(lhs, rhs);
                    r = LLVMBuildAnd(builder, r, c, noname);
                }
                r
            }
            LLVMTypeKind::LLVMStructTypeKind => {
                let len = LLVMCountStructElementTypes(ty);
                let mut r = LLVMConstInt(LLVMInt1Type(), 1, 0);
                for i in 0..len {
                    let lhs = LLVMBuildExtractValue(builder, lhs, i as u32, noname);
                    let rhs = LLVMBuildExtractValue(builder, rhs, i as u32, noname);
                    let c = self.emit_aggregate_eq(lhs, rhs);
                    r = LLVMBuildAnd(builder, r, c, noname);
                }
                r
            }
            x => {
                error!("aggregate comparison of {:?} not supported", x);
                LLVMConstNull(LLVMInt1Type())
            }
        }
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct BlazeContext {
    sigmem: *const u8,
    insts: *mut BlazeUnit,
    time: BlazeTime,
    queue_len: usize,
    queue_time: Vec<BlazeTime>,
    queue_slot: Vec<BlazeQueue>,
    inst_len: usize,
    inst_senses: Vec<Vec<BitSet>>,
    inst_enable: BitSet,
    sig_changed: BitSet,
}

impl BlazeContext {
    pub fn new(map: &Mapping) -> Self {
        // Collect the sensitivities of the instances.
        let mut inst_senses = vec![];
        for inst in &map.insts {
            inst_senses.push(inst.senses.borrow().clone());
        }

        let mut s = Self {
            sigmem: null(),
            insts: null_mut(),
            time: Default::default(),
            queue_len: 0,
            queue_time: Vec::with_capacity(16),
            queue_slot: Vec::with_capacity(16),
            inst_len: map.insts.len(),
            inst_senses,
            inst_enable: BitSet::with_capacity(map.insts.len() as u32),
            sig_changed: BitSet::with_capacity(map.signals.len() as u32),
        };
        for i in 0..s.inst_len {
            s.inst_enable.add(i as u32);
        }
        s
    }

    pub fn slot(&mut self, time: BlazeTime) -> &mut BlazeQueue {
        for i in 0..self.queue_len {
            if self.queue_time[i] == time {
                return &mut self.queue_slot[i];
            }
        }
        self.queue_len += 1;
        if self.queue_len > self.queue_time.len() {
            trace!("Alloc new queue slot");
            self.queue_time.push(time);
            self.queue_slot.push(BlazeQueue {
                insts: BitSet::with_capacity(self.inst_len as u32),
                changes: Vec::with_capacity(32),
                data: Vec::with_capacity(128),
            });
        } else {
            self.queue_time[self.queue_len - 1] = time;
            self.queue_slot[self.queue_len - 1].insts.clear();
            self.queue_slot[self.queue_len - 1].changes.clear();
            self.queue_slot[self.queue_len - 1].data.clear();
        }
        &mut self.queue_slot[self.queue_len - 1]
    }

    pub fn delta_slot(&mut self, mut time: BlazeTime) -> &mut BlazeQueue {
        if time.0 == 0 {
            if time.1 == 0 {
                time.2 += self.time.2;
            }
            time.1 += self.time.1;
        }
        time.0 += self.time.0;
        self.slot(time)
    }

    pub fn pop_slot(&mut self) -> Option<(BlazeTime, &mut BlazeQueue)> {
        let (i, &t) = self.queue_time[0..self.queue_len]
            .iter()
            .enumerate()
            .min_by_key(|(_, &t)| t)?;
        self.queue_len -= 1;
        unsafe {
            std::ptr::swap(
                &mut self.queue_time[i] as *mut _,
                &mut self.queue_time[self.queue_len] as *mut _,
            );
            std::ptr::swap(
                &mut self.queue_slot[i] as *mut _,
                &mut self.queue_slot[self.queue_len] as *mut _,
            );
        }
        Some((t, &mut self.queue_slot[self.queue_len]))
    }

    /// Advance the simulation state to the next step.
    pub unsafe fn step(&mut self, map: &Mapping) -> bool {
        // Execute the enabled instances.
        for i in (&self.inst_enable).iter() {
            trace!("Executing inst {}", i);
            let inst = &mut *self.insts.offset(i as isize);
            let next = (inst.func)(self, inst.state);
            inst.func = mem::transmute(next);
        }

        // Advance to the next time slot.
        let (time, slot) = match self.pop_slot() {
            Some(x) => x,
            None => return false,
        };
        let slot: &mut BlazeQueue = &mut *(slot as *mut _);
        self.time = time;

        // Apply the signal changes. There might me multiple changes per signal,
        // and only the last change wins. We want to avoid toggling these
        // signals back and forth, since that will count as a change. To prevent
        // this, execute the changes backwards and keep track of which signals
        // have already been assigned.
        self.sig_changed.clear();
        let mut data_ptr = slot.data.as_mut_ptr().offset(slot.data.len() as isize);
        let mut already_changed = BitSet::new();
        for change in slot.changes.iter().rev() {
            data_ptr = data_ptr.offset(-(change.size as isize));
            if already_changed.contains(change.sig) {
                continue;
            }
            already_changed.add(change.sig);
            let mut any_change = false;
            trace!(
                "Apply {} {}: {:?} -> {:?} (size {}, offset {}, length {})",
                change.sig,
                map.signals[change.sig as usize]
                    .name
                    .as_ref()
                    .map(String::as_str)
                    .unwrap_or(""),
                std::slice::from_raw_parts(change.sigptr, change.size as usize),
                std::slice::from_raw_parts(data_ptr, change.size as usize),
                change.size,
                change.offset,
                change.length,
            );
            if change.offset == 0 {
                for i in 0..change.size {
                    let src = data_ptr.offset(i as isize);
                    let dst = change.sigptr.offset(i as isize);
                    any_change |= *src != *dst;
                    *dst = *src;
                }
            } else if change.offset + change.length <= 8 {
                let mask = (((1 << change.length) - 1) << change.offset) as u8;
                let new_val = (*change.sigptr & !mask) | (*data_ptr & mask);
                any_change |= *change.sigptr != new_val;
                *change.sigptr = new_val;
            } else {
                let src = data_ptr.offset(0 as isize);
                let dst = change.sigptr.offset(0 as isize);
                let mask = ((0x100 << change.offset) - 1) as u8;
                let new_val = (*dst & !mask) | (*src & mask);
                any_change |= *dst != new_val;
                for i in 1..change.size - 1 {
                    let src = data_ptr.offset(i as isize);
                    let dst = change.sigptr.offset(i as isize);
                    any_change |= *src != *dst;
                    *dst = *src;
                }
                let shift = (change.offset + change.length) % 8;
                let mask = ((1 << shift) - 1) as u8;
                let src = data_ptr.offset((change.size - 1) as isize);
                let dst = change.sigptr.offset((change.size - 1) as isize);
                let new_val = (*dst & !mask) | (*src & mask);
            }
            if any_change {
                self.sig_changed.add(change.sig);
                trace!(" -> Changed!");
            }
        }
        trace!("Changed signals: {:?}", self.sig_changed);

        // Wake up instances sensitive to the changed signals.
        self.inst_enable.clear();
        for i in 0..self.inst_len {
            let sense = (*self.insts.offset(i as isize)).state as *const u64;
            let sense = &self.inst_senses[i][*sense as usize];
            if !(&self.sig_changed & sense).is_empty() {
                trace!("Triggering inst {}", i);
                self.inst_enable.add(i as u32);
            }
        }

        // TODO: Clear the woken insts in future slots.

        // Wake up instances sensitive to time.
        self.inst_enable.extend((&slot.insts).iter());

        // And step.
        debug!("Advancing to {:?}: {} changes", time, slot.changes.len());
        true
    }
}

type BlazeFunc = extern "C" fn(*const BlazeContext, *const u8) -> *const u8;

#[repr(C)]
pub struct BlazeUnit {
    func: BlazeFunc,
    state: *const u8,
}

#[derive(Debug)]
pub struct BlazeQueue {
    insts: BitSet,
    changes: Vec<BlazeChange>,
    data: Vec<u8>, // change data
}

#[derive(Debug)]
pub struct BlazeChange {
    sig: u32,
    sigptr: *mut u8,
    size: u32,
    offset: u32,
    length: u32,
}

#[derive(Clone, Copy, Default, PartialEq, Eq, PartialOrd, Ord, Hash, Debug)]
pub struct BlazeTime(u64, u32, u32);

unsafe extern "C" fn blaze_drive(
    ctx: &mut BlazeContext,
    sig: u32,
    sigptr: *mut u8,
    data: *const u8,
    size: u32,
    mut time_s: u64,
    mut time_d: u32,
    mut time_e: u32,
    offset: u32,
    length: u32,
) {
    trace!(
        "Drive {}, ptr {:?}, data {:?}, size {}, time {}ps {}d {}e, offset {}, length {}",
        sig,
        sigptr,
        std::slice::from_raw_parts(data, size as usize),
        size,
        time_s,
        time_d,
        time_e,
        offset,
        length,
    );

    // Allocate a new queue slot.
    let slot = ctx.delta_slot(BlazeTime(time_s, time_d, time_e));

    // Store the change data.
    let (size_dst, size_src) = if offset != 0 {
        (
            ((length + offset + 7) / 8) as usize,
            ((length + 7) / 8) as usize,
        )
    } else {
        (size as usize, size as usize)
    };
    let data_offset = slot.data.len();
    slot.data.reserve(size_dst);
    slot.data.resize(data_offset + size_dst, 0);
    let data_ptr = slot.data.as_mut_ptr().offset(data_offset as isize);
    if offset == 0 {
        std::ptr::copy_nonoverlapping(data, data_ptr, size_dst);
    } else {
        let src = std::slice::from_raw_parts(data, size_src);
        let mut dst = std::slice::from_raw_parts_mut(data_ptr, size_dst);
        dst[0] = src[0] << offset;
        for i in 1..size_src {
            dst[i] = src[i - 1] >> (8 - offset) | src[i] << offset;
        }
        if size_dst > size_src {
            dst[size_src] = src[size_src - 1] >> (8 - offset);
        }
    }

    // Populate the entry.
    slot.changes.push(BlazeChange {
        sig,
        sigptr,
        size: size_dst as u32,
        offset,
        length,
    });
}

unsafe extern "C" fn blaze_wake(
    ctx: &mut BlazeContext,
    inst: u32,
    mut time_s: u64,
    mut time_d: u32,
    mut time_e: u32,
) {
    trace!("Wake {}, time {}ps {}d {}e", inst, time_s, time_d, time_e,);
    assert!(inst < ctx.inst_len as u32);

    // Allocate a new queue slot.
    let slot = ctx.delta_slot(BlazeTime(time_s, time_d, time_e));

    // Mark the instance as to be woken up.
    slot.insts.add(inst);
}
