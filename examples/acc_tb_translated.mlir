llhd.entity @acc_param1_always_ff_139_1 (%arg0 : !llhd.sig<i32>, %arg1 : !llhd.sig<i1>) -> (%arg2 : !llhd.sig<i32>) {
  %0 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
  %1 = llhd.prb %arg1 : !llhd.sig<i1>
  %2 = llhd.prb %arg0 : !llhd.sig<i32>
  llhd.reg %arg2, (%2, "rise" %1 after %0 : i32) : !llhd.sig<i32>
}

llhd.entity @acc_param1_always_comb_176_1 (%arg0 : !llhd.sig<i32>, %arg1 : !llhd.sig<i32>, %arg2 : !llhd.sig<i32>) -> (%arg3 : !llhd.sig<i32>) {
  %0 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
  %c0_i32 = constant 0 : i32
  %1 = llhd.prb %arg2 : !llhd.sig<i32>
  %2 = llhd.prb %arg1 : !llhd.sig<i32>
  %3 = cmpi "ne", %2, %c0_i32 : i32
  %4 = llhd.prb %arg0 : !llhd.sig<i32>
  %5 = addi %1, %4 : i32
  %6 = select %3, %5, %1 : i32
  llhd.drv %arg3, %6 after %0 : !llhd.sig<i32>
}

llhd.entity @acc_param1(%clk: !llhd.sig<i1>, %x: !llhd.sig<i32>, %en: !llhd.sig<i32>) -> (%q: !llhd.sig<i32> ) {
    %0 = constant 0 : i32
    %d = llhd.sig "sig" %0 : i32
    llhd.inst "inst" @acc_param1_always_ff_139_1(%d, %clk) -> (%q) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst1" @acc_param1_always_comb_176_1(%x, %en, %q) -> (%d) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
}

llhd.proc @acc_tb_initial_90_0() -> (%clk: !llhd.sig<i1> , %en: !llhd.sig<i1> , %x: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = constant 0 : i32
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %en, %2 after %3 : !llhd.sig<i1>
    br ^loop_body(%1: i32)
^loop_body(%i: i32):
    llhd.drv %x, %i after %3 : !llhd.sig<i32>
    %4 = constant 1 : i1
    %5 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk, %4 after %5 : !llhd.sig<i1>
    %6 = constant 0 : i1
    llhd.drv %clk, %6 after %3 : !llhd.sig<i1>
    llhd.wait  for %3, ^7
^7:
    %8 = constant 1 : i32
    %9 = addi %i, %8 : i32
    %10 = constant 1337 : i32
    %11 = cmpi "ult", %9, %10 : i32
    %12 = constant 0 : i1
    %13 = cmpi "ne", %11, %12 : i1
    cond_br %13, ^loop_body(%9: i32), ^loop_exit
^loop_exit:
    llhd.halt
}

llhd.entity @acc_tb() -> () {
    %0 = constant 0 : i1
    %clk = llhd.sig "sig" %0 : i1
    %en = llhd.sig "sig1" %0 : i1
    %1 = constant 0 : i32
    %x = llhd.sig "sig2" %1 : i32
    %i_dut_clk_default = llhd.sig "sig3" %0 : i1
    %i_dut_x_default = llhd.sig "sig4" %1 : i32
    %i_dut_en_default = llhd.sig "sig5" %1 : i32
    %i_dut_q_default = llhd.sig "sig6" %1 : i32
    llhd.inst "inst" @acc_param1(%i_dut_clk_default, %i_dut_x_default, %i_dut_en_default) -> (%i_dut_q_default) : (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst1" @acc_tb_initial_90_0() -> (%clk, %en, %x) : () -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>)
}

