llhd.proc @proc (%a : !llhd.sig<i1>) -> () {
    br ^entry
^entry:
    %c = constant 0 : i1
    br ^args(%c: i1)
^args(%i : i1):
    %0 = llhd.const 1 : i1
    %1 = llhd.var %0 : i1
    %l = llhd.load %1 : !llhd.ptr<i1>
    %t = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait for %t, ^end
    // br ^end
^end:
    %b = addi %i, %i : i1
    %d = addi %b, %i : i1
    llhd.wait for %t, ^next
// ^end2:
//     llhd.wait for %t, ^end3
// ^end3:
//     llhd.wait for %t, ^next
^next:
    llhd.halt
}

// llhd.proc @graycode_tb.initial.232.0 (%b : !llhd.sig<i20>) -> (%a : !llhd.sig<i20>, %bp : !llhd.sig<i20>) {
//     br ^0
// ^0:
//     %1 = llhd.const 0 : i21
//     %i = llhd.var %1 : i21
//     %2 = llhd.const 0 : i20
//     %3 = llhd.const 0 : i1
//     %4 = llhd.inss %2, %3, 0 : i20, i1
//     %5 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
//     llhd.drv %bp, %4 after %5 : !llhd.sig<i20>
//     %6 = llhd.const 2 : i32
//     %loop_count = llhd.var %6 : i32
//     br ^loop_body
// ^loop_body:
//     %7 = llhd.load %loop_count : !llhd.ptr<i32>
//     %8 = llhd.const 0 : i32
//     %9 = cmpi "ne", %7, %8 : i32
//     llhd.halt
// }

// llhd.entity @root () -> () {
//     %0 = llhd.const 0 : i1
//     %1 = llhd.sig "sig" %0 : i1
//     llhd.inst "proc" @proc (%1) -> () : (!llhd.sig<i1>) -> ()
// }

// llhd.proc @graycode2 (%b : !llhd.sig<i20>) -> (%a : !llhd.sig<i20>, %bp : !llhd.sig<i20>) {
//     br ^b0
// ^b0:
//     %1 = llhd.const 0 : i21
//     %i = llhd.var %1 : i21
//     %2 = llhd.const 0 : i20
//     %3 = llhd.const 0 : i1
//     %4 = llhd.inss %2, %3, 0 : i20, i1
//     %5 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
//     llhd.drv %bp, %4 after %5 : !llhd.sig<i20>
//     %6 = llhd.const 2 : i32
//     %loop_count = llhd.var %6 : i32
//     br ^loop_body
// ^loop_body:
//     %7 = llhd.load %loop_count : !llhd.ptr<i32>
//     %8 = llhd.const 0 : i32
//     %9 = cmpi "ne", %7, %8 : i32
//     cond_br %9, ^loop_exit, ^loop_continue
// ^loop_exit:
//     %10 = llhd.const 0 : i32
//     %11 = llhd.exts %10, 0 : i32 -> i21
//     llhd.store %i, %11 : !llhd.ptr<i21>
//     br ^loop_body1
//     // llhd.halt
// ^loop_continue:
//     %12 = llhd.const 0 : i32
//     %13 = llhd.exts %12, 0 : i32 -> i21
//     llhd.store %i, %13 : !llhd.ptr<i21>
//     br ^loop_body2
//     // llhd.halt
// ^loop_body2:
//     %14 = llhd.const 0 : i32
//     %i1 = llhd.load %i : !llhd.ptr<i21>
//     %15 = llhd.inss %14, %i1, 0 : i32, i21
//     %16 = llhd.const 1 : i32
//     %17 = llhd.const 20 : i32
//     %18 = llhd.const 0 : i32
//     %19 = llhd.shl %16, %18, %17 : (i32, i32, i32) -> i32
//     %20 = cmpi "ult", %15, %19 : i32
//     cond_br %20, ^loop_exit1, ^loop_continue1
//     // llhd.halt
// ^loop_exit1:
//     %21 = llhd.load %loop_count : !llhd.ptr<i32>
//     %22 = llhd.const 1 : i32
//     %23 = subi %21, %22 : i32
//     llhd.store %loop_count, %23 : !llhd.ptr<i32>
//     br ^loop_body
// ^loop_continue1:
//     %i2 = llhd.load %i : !llhd.ptr<i21>
//     %24 = llhd.exts %i2, 0 : i21 -> i20
//     %25 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
//     llhd.drv %a, %24 after %25 : !llhd.sig<i20>
//     %26 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
//     // llhd.wait for %26, ^27
//     br ^27
//     // llhd.halt
// ^27:
//     %b1 = llhd.prb %b : !llhd.sig<i20>
//     %28 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
//     llhd.drv %bp, %b1 after %28 : !llhd.sig<i20>
//     %i3 = llhd.load %i : !llhd.ptr<i21>
//     %29 = llhd.const 1 : i21
//     %30 = addi %i3, %29 : i21
//     llhd.store %i, %30 : !llhd.ptr<i21>
//     %i4 = llhd.load %i : !llhd.ptr<i21>
//     %31 = llhd.const 0 : i21
//     %32 = cmpi "ne", %i4, %31 : i21
//     br ^loop_body2
// ^loop_body1:
//     %33 = llhd.const 0 : i32
//     %i5 = llhd.load %i : !llhd.ptr<i21>
//     %34 = llhd.inss %33, %i5, 0 : i32, i21
//     %35 = llhd.const 1 : i32
//     %36 = llhd.const 20 : i32
//     %37 = llhd.const 0 : i32
//     %38 = llhd.shl %35, %37, %36 : (i32, i32, i32) -> i32
//     %39 = cmpi "ult", %34, %38 : i32
//     cond_br %39, ^loop_exit2, ^loop_continue2
//     // llhd.halt
// ^loop_exit2:
//     llhd.halt
// ^loop_continue2:
//     %40 = llhd.const 1 : i32
//     %41 = llhd.const 20 : i32
//     %42 = llhd.const 0 : i32
//     %43 = llhd.shl %40, %42, %41 : (i32, i32, i32) -> i32
//     %44 = llhd.const 0 : i32
//     %i6 = llhd.load %i : !llhd.ptr<i21>
//     %45 = llhd.inss %44, %i6, 0 : i32, i21
//     %46 = subi %43, %45 : i32
//     %47 = llhd.const 1 : i32
//     %48 = subi %46, %47 : i32
//     %49 = llhd.exts %48, 0 : i32 -> i20
//     %50 = llhd.const #llhd.time<0ns, 0d, 0e> : !llhd.time
//     llhd.drv %a, %49 after %50 : !llhd.sig<i20>
//     %51 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
//     // llhd.wait for %51, ^52
//     llhd.halt
// ^52:
//     %b2 = llhd.prb %b : !llhd.sig<i20>
//     %53 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
//     llhd.drv %bp, %b2 after %53 : !llhd.sig<i20>
//     %i7 = llhd.load %i : !llhd.ptr<i21>
//     %54 = llhd.const 1 : i21
//     %55 = addi %i7, %54 : i21
//     llhd.store %i, %55 : !llhd.ptr<i21>
//     %i8 = llhd.load %i : !llhd.ptr<i21>
//     %56 = llhd.const 0 : i21
//     %57 = cmpi "ne", %i8, %56 : i21
//     br ^loop_body1
// }

