llhd.entity @binary_to_gray_param3 (%arg0 : !llhd.sig<i20>) -> (%arg1 : !llhd.sig<i20>) {
  %c0_i20 = constant 0 : i20
  %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
  %1 = llhd.prb %arg0 : !llhd.sig<i20>
  %2 = llhd.exts %1, 1 : i20 -> i19
  %3 = llhd.inss %c0_i20, %2, 0 : i20, i19
  %4 = llhd.xor %1, %3 : i20
  llhd.drv %arg1, %4 after %0 : !llhd.sig<i20>
}
llhd.entity @gray_to_binary_param5 (%arg0 : !llhd.sig<i20>) -> (%arg1 : !llhd.sig<i20>) {
  %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
  %c0_i20 = constant 0 : i20
  %1 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
  %2 = llhd.exts %arg1, 0 : !llhd.sig<i20> -> !llhd.sig<i1>
  %3 = llhd.prb %arg0 : !llhd.sig<i20>
  %4 = llhd.exts %3, 0 : i20 -> i1
  %5 = llhd.exts %3, 1 : i20 -> i1
  %6 = llhd.exts %3, 2 : i20 -> i1
  %7 = llhd.exts %3, 3 : i20 -> i1
  %8 = llhd.exts %3, 4 : i20 -> i1
  %9 = llhd.exts %3, 5 : i20 -> i1
  %10 = llhd.exts %3, 6 : i20 -> i1
  %11 = llhd.exts %3, 7 : i20 -> i1
  %12 = llhd.exts %3, 8 : i20 -> i1
  %13 = llhd.exts %3, 9 : i20 -> i1
  %14 = llhd.exts %3, 10 : i20 -> i1
  %15 = llhd.exts %3, 11 : i20 -> i1
  %16 = llhd.exts %3, 12 : i20 -> i1
  %17 = llhd.exts %3, 13 : i20 -> i1
  %18 = llhd.exts %3, 14 : i20 -> i1
  %19 = llhd.exts %3, 15 : i20 -> i1
  %20 = llhd.exts %3, 16 : i20 -> i1
  %21 = llhd.exts %3, 17 : i20 -> i1
  %22 = llhd.exts %3, 18 : i20 -> i1
  %23 = llhd.exts %3, 19 : i20 -> i1
  %24 = llhd.xor %22, %23 : i1
  %25 = llhd.xor %21, %24 : i1
  %26 = llhd.xor %20, %25 : i1
  %27 = llhd.xor %19, %26 : i1
  %28 = llhd.xor %18, %27 : i1
  %29 = llhd.xor %17, %28 : i1
  %30 = llhd.xor %16, %29 : i1
  %31 = llhd.xor %15, %30 : i1
  %32 = llhd.xor %14, %31 : i1
  %33 = llhd.xor %13, %32 : i1
  %34 = llhd.xor %12, %33 : i1
  %35 = llhd.xor %11, %34 : i1
  %36 = llhd.xor %10, %35 : i1
  %37 = llhd.xor %9, %36 : i1
  %38 = llhd.xor %8, %37 : i1
  %39 = llhd.xor %7, %38 : i1
  %40 = llhd.xor %6, %39 : i1
  %41 = llhd.xor %5, %40 : i1
  %42 = llhd.xor %4, %41 : i1
  llhd.drv %2, %42 after %0 : !llhd.sig<i1>
  %43 = llhd.exts %arg1, 1 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %43, %41 after %0 : !llhd.sig<i1>
  %44 = llhd.exts %arg1, 2 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %44, %40 after %0 : !llhd.sig<i1>
  %45 = llhd.exts %arg1, 3 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %45, %39 after %0 : !llhd.sig<i1>
  %46 = llhd.exts %arg1, 4 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %46, %38 after %0 : !llhd.sig<i1>
  %47 = llhd.exts %arg1, 5 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %47, %37 after %0 : !llhd.sig<i1>
  %48 = llhd.exts %arg1, 6 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %48, %36 after %0 : !llhd.sig<i1>
  %49 = llhd.exts %arg1, 7 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %49, %35 after %0 : !llhd.sig<i1>
  %50 = llhd.exts %arg1, 8 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %50, %34 after %0 : !llhd.sig<i1>
  %51 = llhd.exts %arg1, 9 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %51, %33 after %0 : !llhd.sig<i1>
  %52 = llhd.exts %arg1, 10 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %52, %32 after %0 : !llhd.sig<i1>
  %53 = llhd.exts %arg1, 11 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %53, %31 after %0 : !llhd.sig<i1>
  %54 = llhd.exts %arg1, 12 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %54, %30 after %0 : !llhd.sig<i1>
  %55 = llhd.exts %arg1, 13 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %55, %29 after %0 : !llhd.sig<i1>
  %56 = llhd.exts %arg1, 14 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %56, %28 after %0 : !llhd.sig<i1>
  %57 = llhd.exts %arg1, 15 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %57, %27 after %0 : !llhd.sig<i1>
  %58 = llhd.exts %arg1, 16 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %58, %26 after %0 : !llhd.sig<i1>
  %59 = llhd.exts %arg1, 17 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %59, %25 after %0 : !llhd.sig<i1>
  %60 = llhd.exts %arg1, 18 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %60, %24 after %0 : !llhd.sig<i1>
  %61 = llhd.exts %arg1, 19 : !llhd.sig<i20> -> !llhd.sig<i1>
  llhd.drv %61, %23 after %0 : !llhd.sig<i1>
  llhd.drv %arg1, %c0_i20 after %1 : !llhd.sig<i20>
}
llhd.entity @graycode_param1 (%arg0 : !llhd.sig<i20>) -> (%arg1 : !llhd.sig<i20>, %arg2 : !llhd.sig<i20>) {
  %c0_i20 = constant 0 : i20
  %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
  %1 = llhd.prb %arg0 : !llhd.sig<i20>
  %2 = llhd.sig "sig" %c0_i20 : i20
  llhd.drv %2, %1 after %0 : !llhd.sig<i20>
  llhd.inst "inst" @binary_to_gray_param3(%2) -> (%arg1) : (!llhd.sig<i20>) -> !llhd.sig<i20>
  %3 = llhd.prb %arg1 : !llhd.sig<i20>
  %4 = llhd.sig "sig1" %c0_i20 : i20
  llhd.drv %4, %3 after %0 : !llhd.sig<i20>
  llhd.inst "inst1" @gray_to_binary_param5(%4) -> (%arg2) : (!llhd.sig<i20>) -> !llhd.sig<i20>
}
llhd.proc @graycode_tb_initial_5049_0(%b: !llhd.sig<i20>) -> (%a: !llhd.sig<i20> , %bp: !llhd.sig<i20> ) {
    br ^0
^0:
    %1 = constant 0 : i21
    %i = llhd.var %1 : i21
    %2 = constant 0 : i20
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %bp, %2 after %3 : !llhd.sig<i20>
    %4 = constant 2 : i32
    %loop_count = llhd.var %4 : i32
    br ^loop_body
^loop_body:
    %5 = llhd.load %loop_count : !llhd.ptr<i32>
    %6 = constant 0 : i32
    %7 = cmpi "ne", %5, %6 : i32
    cond_br %7, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.store %i, %1 : !llhd.ptr<i21>
    br ^loop_body1
^loop_continue:
    llhd.store %i, %1 : !llhd.ptr<i21>
    br ^loop_body2
^loop_body1:
    %8 = constant 0 : i32
    %i_ld3 = llhd.load %i : !llhd.ptr<i21>
    %zext1 = llhd.inss %8, %i_ld3, 0 : i32, i21
    %9 = constant 1048576 : i32
    %10 = cmpi "ult", %zext1, %9 : i32
    cond_br %10, ^loop_continue2, ^loop_exit2
^loop_body2:
    %11 = constant 0 : i32
    %i_ld = llhd.load %i : !llhd.ptr<i21>
    %zext = llhd.inss %11, %i_ld, 0 : i32, i21
    %12 = constant 1048576 : i32
    %13 = cmpi "ult", %zext, %12 : i32
    cond_br %13, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %14 = llhd.load %loop_count : !llhd.ptr<i32>
    llhd.store %loop_count, %14 : !llhd.ptr<i32>
    br ^loop_body
^loop_continue1:
    %i_ld1 = llhd.load %i : !llhd.ptr<i21>
    %15 = llhd.exts %i_ld1, 0 : i21 -> i20
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %a, %15 after %16 : !llhd.sig<i20>
    %17 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %17, ^18
^18:
    %b_prb = llhd.prb %b : !llhd.sig<i20>
    llhd.drv %bp, %b_prb after %16 : !llhd.sig<i20>
    %i_ld2 = llhd.load %i : !llhd.ptr<i21>
    %19 = constant 1 : i21
    %20 = addi %i_ld2, %19 : i21
    llhd.store %i, %20 : !llhd.ptr<i21>
    br ^loop_body2
^loop_exit2:
    llhd.halt
^loop_continue2:
    %i_ld4 = llhd.load %i : !llhd.ptr<i21>
    %zext2 = llhd.inss %8, %i_ld4, 0 : i32, i21
    %21 = subi %9, %zext2 : i32
    %22 = constant 1 : i32
    %23 = subi %21, %22 : i32
    %24 = llhd.exts %23, 0 : i32 -> i20
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %a, %24 after %25 : !llhd.sig<i20>
    %26 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %26, ^27
^27:
    %b_prb1 = llhd.prb %b : !llhd.sig<i20>
    llhd.drv %bp, %b_prb1 after %25 : !llhd.sig<i20>
    %i_ld5 = llhd.load %i : !llhd.ptr<i21>
    %28 = constant 1 : i21
    %29 = addi %i_ld5, %28 : i21
    llhd.store %i, %29 : !llhd.ptr<i21>
    br ^loop_body1
}
llhd.entity @root () -> () {
  %c0_i20 = constant 0 : i20
  %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
  %1 = llhd.sig "sig" %c0_i20 : i20
  %2 = llhd.sig "sig1" %c0_i20 : i20
  %3 = llhd.sig "sig2" %c0_i20 : i20
  %4 = llhd.prb %1 : !llhd.sig<i20>
  %5 = llhd.sig "sig4" %c0_i20 : i20
  %6 = llhd.sig "sig3" %c0_i20 : i20
  llhd.drv %5, %4 after %0 : !llhd.sig<i20>
  llhd.inst "inst" @graycode_param1(%5) -> (%2, %3) : (!llhd.sig<i20>) -> (!llhd.sig<i20>, !llhd.sig<i20>)
  llhd.inst "inst1" @graycode_tb_initial_5049_0(%2) -> (%1, %6) : (!llhd.sig<i20>) -> (!llhd.sig<i20>, !llhd.sig<i20>)
}