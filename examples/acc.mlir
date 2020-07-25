llhd.proc @acc.param1.always_ff.139.1 (%d : !llhd.sig<i32>, %clk : !llhd.sig<i1>) -> (%q : !llhd.sig<i32>) {
    br ^init
^init:
    %clk1 = llhd.prb %clk : !llhd.sig<i1>
    llhd.wait (%clk : !llhd.sig<i1>), ^check 
^check:
    %clk2 = llhd.prb %clk : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = cmpi "eq", %clk1, %0 : i1
    %2 = cmpi "ne", %clk2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %d1 = llhd.prb %d : !llhd.sig<i32>
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %q, %d1 after %3 : !llhd.sig<i32>
    br ^init
}

llhd.proc @acc.param1.always_comb.176.1 (%x : !llhd.sig<i32>, %en : !llhd.sig<i32>, %q : !llhd.sig<i32>) -> (%d : !llhd.sig<i32>) {
    br ^body
^body:
    %q1 = llhd.prb %q : !llhd.sig<i32>
    %0 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %d, %q1 after %0 : !llhd.sig<i32>
    %en1 = llhd.prb %en : !llhd.sig<i32>
    %1 = llhd.const 0 : i32
    %2 = cmpi "ne", %en1, %1 : i32
    cond_br %2, ^if_true, ^check
^check:
    llhd.wait (%x, %en, %q : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>), ^body
^if_true:
    %x1 = llhd.prb %x : !llhd.sig<i32>
    %3 = addi %q1, %x1 : i32
    llhd.drv %d, %3 after %0 : !llhd.sig<i32>
    br ^check
}

llhd.entity @acc.param1 (%clk : !llhd.sig<i1>, %x : !llhd.sig<i32>, %en : !llhd.sig<i32>) -> (%q : !llhd.sig<i32>) {
    %0 = llhd.const 0 : i32
    %d = llhd.sig "d" %0 : i32
    llhd.inst "acc.param1.always_ff" @acc.param1.always_ff.139.1 (%d, %clk) -> (%q) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "acc.param1.always_comb" @acc.param1.always_comb.176.1 (%x, %en, %q) -> (%d) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
}

llhd.proc @acc_tb.initial.90.0 () -> (%clk : !llhd.sig<i1>, %en : !llhd.sig<i1>, %x : !llhd.sig<i32>) {
    br ^0
^0:
    %1 = llhd.const 0 : i32 
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %en, %2 after %3 : !llhd.sig<i1>
    br ^loop_body(%1 : i32)
^loop_body(%i : i32):
    // %i = phi i32 [%4, %5], [%1, %0]
    llhd.drv %x, %i after %3 : !llhd.sig<i32>
    %6 = llhd.const 1 : i1 
    %7 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk, %6 after %7 : !llhd.sig<i1>
    %8 = llhd.const 0 : i1
    llhd.drv %clk, %8 after %3 : !llhd.sig<i1>
    llhd.wait for %3, ^5
^loop_exit:
    llhd.halt
^5:
    %9 = llhd.const 1 : i32
    %4 = addi %i, %9 : i32
    %10 = llhd.const 1337 : i32
    %11 = cmpi "ult", %4, %10 : i32
    %12 = llhd.const 0 : i1
    %13 = cmpi "ne", %11, %12 : i1
    cond_br %13, ^loop_body(%4 : i32), ^loop_exit
}

llhd.entity @root () -> () {
    %0 = llhd.const 0 : i1
    %clk = llhd.sig "clk" %0 : i1 
    %en = llhd.sig "en" %0 : i1 
    %1 = llhd.const 0 : i32 
    %x = llhd.sig "x" %1 : i32 
    %i_dut.clk.default = llhd.sig "i_dut.clk.default" %0 : i1 
    %i_dut.x.default = llhd.sig "i_dut.x.default" %1 : i32 
    %i_dut.en.default = llhd.sig "i_dut.en.default" %1 : i32 
    %i_dut.q.default = llhd.sig "i_dut.q.default" %1 : i32 
    llhd.inst "acc" @acc.param1 (%i_dut.clk.default, %i_dut.x.default, %i_dut.en.default) -> (%i_dut.q.default) : (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "acc_tb" @acc_tb.initial.90.0 () -> (%clk, %en, %x) : () -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>)
}
