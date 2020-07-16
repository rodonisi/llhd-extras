// RUN: circt-opt %s --convert-llhd-to-llvm | FileCheck %s

// llhd.entity @root () -> (%s : !llhd.sig<i32>) {
//   %0 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
//   %1 = llhd.const 0 : i1
//   %2 = llhd.const 0 : i32
//   llhd.reg %s, (%2, "low" %1 after %0 : i32), (%2, "high" %1 after %0 : i32), (%2, "both" %1 after %0 : i32), (%2, "rise" %1 after %0 : i32), (%2, "fall" %1 after %0 : i32) : !llhd.sig<i32>
// }

  llvm.func @convert_reg_modes(%arg0: !llvm<"i8*">, %arg1: !llvm<"i32*">, %arg2: !llvm<"i32*">) {
    %0 = llvm.mlir.constant(0 : i32) : !llvm.i32
    %1 = llvm.getelementptr %arg2[%0] : (!llvm<"i32*">, !llvm.i32) -> !llvm<"i32*">
    %2 = llvm.load %1 : !llvm<"i32*">
    %3 = llvm.mlir.constant(1 : i32) : !llvm.i32
    %4 = llvm.mlir.constant(0 : i32) : !llvm.i32
    %5 = llvm.mlir.constant(0 : i32) : !llvm.i32
    %6 = llvm.mlir.undef : !llvm<"[3 x i32]">
    %7 = llvm.insertvalue %3, %6[0 : i32] : !llvm<"[3 x i32]">
    %8 = llvm.insertvalue %4, %7[1 : i32] : !llvm<"[3 x i32]">
    %9 = llvm.insertvalue %5, %8[2 : i32] : !llvm<"[3 x i32]">
    %10 = llvm.mlir.constant(false) : !llvm.i1
    %11 = llvm.mlir.constant(0 : i32) : !llvm.i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %12 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %13 = llvm.mlir.constant(0 : i16) : !llvm.i1
    %14 = llvm.icmp "eq" %10, %13 : !llvm.i1
    llvm.cond_br %14, ^bb6(%11, %9, %12 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1), ^bb2
  ^bb2:  // pred: ^bb1
    %15 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %16 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %17 = llvm.icmp "eq" %10, %16 : !llvm.i1
    llvm.cond_br %17, ^bb6(%11, %9, %15 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1), ^bb3
  ^bb3:  // pred: ^bb2
    %18 = llvm.mlir.constant(1 : i16) : !llvm.i1
    llvm.br ^bb6(%11, %9, %18 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1)
  ^bb4:  // no predecessors
    %19 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %20 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %21 = llvm.icmp "eq" %10, %20 : !llvm.i1
    llvm.cond_br %21, ^bb6(%11, %9, %19 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1), ^bb5
  ^bb5:  // pred: ^bb4
    %22 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %23 = llvm.mlir.constant(0 : i16) : !llvm.i1
    %24 = llvm.icmp "eq" %10, %23 : !llvm.i1
    llvm.cond_br %24, ^bb6(%11, %9, %22 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1), ^bb9
  ^bb6(%25: !llvm.i32, %26: !llvm<"[3 x i32]">, %27: !llvm.i1):  // 5 preds: ^bb1, ^bb2, ^bb3, ^bb4, ^bb5
    %28 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %29 = llvm.icmp "eq" %27, %28 : !llvm.i1
    llvm.cond_br %29, ^bb7, ^bb8
  ^bb7:  // pred: ^bb6
    %30 = llvm.mlir.constant(32 : i64) : !llvm.i64
    %31 = llvm.mlir.constant(1 : i32) : !llvm.i32
    %32 = llvm.alloca %31 x !llvm.i32 {alignment = 4 : i64} : (!llvm.i32) -> !llvm<"i32*">
    llvm.store %25, %32 : !llvm<"i32*">
    %33 = llvm.bitcast %32 : !llvm<"i32*"> to !llvm<"i8*">
    %34 = llvm.extractvalue %26[0 : i32] : !llvm<"[3 x i32]">
    %35 = llvm.extractvalue %26[1 : i32] : !llvm<"[3 x i32]">
    %36 = llvm.extractvalue %26[2 : i32] : !llvm<"[3 x i32]">
    %37 = llvm.call @drive_signal(%arg0, %2, %33, %30, %34, %35, %36) : (!llvm<"i8*">, !llvm.i32, !llvm<"i8*">, !llvm.i64, !llvm.i32, !llvm.i32, !llvm.i32) -> !llvm.void
    llvm.br ^bb8
  ^bb8:  // 2 preds: ^bb6, ^bb7
    llvm.br ^bb9
  ^bb9:  // 2 preds: ^bb5, ^bb8
    llvm.return
  }
  llvm.func @convert_reg_gates(%arg0: !llvm<"i8*">, %arg1: !llvm<"i32*">, %arg2: !llvm<"i32*">) {
    %0 = llvm.mlir.constant(0 : i32) : !llvm.i32
    %1 = llvm.getelementptr %arg2[%0] : (!llvm<"i32*">, !llvm.i32) -> !llvm<"i32*">
    %2 = llvm.load %1 : !llvm<"i32*">
    %3 = llvm.mlir.constant(1 : i32) : !llvm.i32
    %4 = llvm.mlir.constant(0 : i32) : !llvm.i32
    %5 = llvm.mlir.constant(0 : i32) : !llvm.i32
    %6 = llvm.mlir.undef : !llvm<"[3 x i32]">
    %7 = llvm.insertvalue %3, %6[0 : i32] : !llvm<"[3 x i32]">
    %8 = llvm.insertvalue %4, %7[1 : i32] : !llvm<"[3 x i32]">
    %9 = llvm.insertvalue %5, %8[2 : i32] : !llvm<"[3 x i32]">
    %10 = llvm.mlir.constant(false) : !llvm.i1
    %11 = llvm.mlir.constant(0 : i32) : !llvm.i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %12 = llvm.mlir.constant(0 : i16) : !llvm.i1
    %13 = llvm.icmp "eq" %10, %12 : !llvm.i1
    llvm.cond_br %13, ^bb3(%11, %9, %10 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%11, %9, %10 : !llvm.i32, !llvm<"[3 x i32]">, !llvm.i1)
  ^bb3(%14: !llvm.i32, %15: !llvm<"[3 x i32]">, %16: !llvm.i1):  // 2 preds: ^bb1, ^bb2
    %17 = llvm.mlir.constant(1 : i16) : !llvm.i1
    %18 = llvm.icmp "eq" %16, %17 : !llvm.i1
    llvm.cond_br %18, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %19 = llvm.mlir.constant(32 : i64) : !llvm.i64
    %20 = llvm.mlir.constant(1 : i32) : !llvm.i32
    %21 = llvm.alloca %20 x !llvm.i32 {alignment = 4 : i64} : (!llvm.i32) -> !llvm<"i32*">
    llvm.store %14, %21 : !llvm<"i32*">
    %22 = llvm.bitcast %21 : !llvm<"i32*"> to !llvm<"i8*">
    %23 = llvm.extractvalue %15[0 : i32] : !llvm<"[3 x i32]">
    %24 = llvm.extractvalue %15[1 : i32] : !llvm<"[3 x i32]">
    %25 = llvm.extractvalue %15[2 : i32] : !llvm<"[3 x i32]">
    %26 = llvm.call @drive_signal(%arg0, %2, %22, %19, %23, %24, %25) : (!llvm<"i8*">, !llvm.i32, !llvm<"i8*">, !llvm.i64, !llvm.i32, !llvm.i32, !llvm.i32) -> !llvm.void
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb6
  ^bb6:  // pred: ^bb5
    llvm.return
  }