llhd.proc @lfsr_16bit.param1.always_comb.273.1(%shift_q: !llhd.sig<i16>, %en_i: !llhd.sig<i1>) -> (%shift_d: !llhd.sig<i16> , %out_o: !llhd.sig<i16> ) {
    br ^body
^body:
    %shift_q1 = llhd.prb %shift_q : !llhd.sig<i16>
    %0 = llhd.exts %shift_q1, 15 : i16 -> i1
    %1 = constant 0 : i16
    %2 = llhd.inss %1, %0, 0 : i16, i1
    %3 = llhd.exts %2, 0 : i16 -> i1
    %4 = llhd.exts %shift_q1, 12 : i16 -> i4
    %5 = llhd.inss %1, %4, 0 : i16, i4
    %6 = llhd.exts %5, 0 : i16 -> i1
    %7 = llhd.xor %3, %6 : i1
    %8 = llhd.exts %shift_q1, 5 : i16 -> i11
    %9 = llhd.inss %1, %8, 0 : i16, i11
    %10 = llhd.exts %9, 0 : i16 -> i1
    %11 = llhd.xor %7, %10 : i1
    %12 = llhd.exts %shift_q1, 1 : i16 -> i15
    %13 = llhd.inss %1, %12, 0 : i16, i15
    %14 = llhd.exts %13, 0 : i16 -> i1
    %15 = llhd.xor %11, %14 : i1
    %16 = constant 0 : i1
    %17 = cmpi "ne", %15, %16 : i1
    %18 = llhd.not %17 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %shift_q1 after %19 : !llhd.sig<i16>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %20 = cmpi "ne", %en_i1, %16 : i1
    cond_br %20, ^if_true, ^if_exit
^if_exit:
    llhd.drv %out_o, %shift_q1 after %19 : !llhd.sig<i16>
    llhd.wait (%shift_q, %en_i : !llhd.sig<i16>, !llhd.sig<i1>), ^body
^if_true:
    %21 = llhd.inss %1, %18, 0 : i16, i1
    %22 = llhd.exts %shift_q1, 0 : i16 -> i15
    %23 = llhd.inss %21, %22, 1 : i16, i15
    llhd.drv %shift_d, %23 after %19 : !llhd.sig<i16>
    br ^if_exit
}

llhd.proc @lfsr_16bit.param1.always_ff.314.1(%shift_d: !llhd.sig<i16>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>) -> (%shift_q: !llhd.sig<i16> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %clk_i1, %0 : i1
    %2 = cmpi "ne", %clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %rst_ni1, %0 : i1
    %4 = cmpi "eq", %rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.not %rst_ni2 : i1
    %6 = cmpi "ne", %5, %0 : i1
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %6, ^if_true, ^if_false
^if_false:
    %shift_d1 = llhd.prb %shift_d : !llhd.sig<i16>
    llhd.drv %shift_q, %shift_d1 after %7 : !llhd.sig<i16>
    br ^init
^if_true:
    %8 = constant 1 : i16
    llhd.drv %shift_q, %8 after %7 : !llhd.sig<i16>
    br ^init
}

llhd.proc @lfsr_16bit.param1.initial.332.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = constant 0 : i16
    %shift_d = llhd.sig "sig" %0 : i16
    %shift_q = llhd.sig "sig1" %0 : i16
    llhd.inst "inst" @lfsr_16bit.param1.always_comb.273.1(%shift_q, %en_i) -> (%shift_d, %out_o) : (!llhd.sig<i16>, !llhd.sig<i1>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param1.always_ff.314.1(%shift_d, %clk_i, %rst_ni) -> (%shift_q) : (!llhd.sig<i16>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param1.initial.332.1() -> () : () -> ()
}

llhd.proc @lfsr_16bit_tb.initial.113.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> , %en_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = constant 0 : i1
    %2 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = constant 1 : i1
    %4 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %3 after %4 : !llhd.sig<i1>
    %5 = llhd.const #llhd.time<4ns, 0d, 0e> : !llhd.time
    llhd.wait  for %5, ^6
^6:
    %7 = constant 1 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %en_i, %7 after %8 : !llhd.sig<i1>
    %9 = constant 10000000 : i32
    br ^loop_body(%9: i32)
^loop_body(%10: i32):
    %11 = constant 0 : i32
    %12 = cmpi "ne", %10, %11 : i32
    cond_br %12, ^loop_continue, ^loop_exit
^13:
    %14 = constant 1 : i32
    %15 = subi %10, %14 : i32
    br ^loop_body(%15: i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %16 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %7 after %16 : !llhd.sig<i1>
    %17 = constant 0 : i1
    %18 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %17 after %18 : !llhd.sig<i1>
    llhd.wait  for %18, ^13
}

llhd.entity @lfsr_16bit_tb() -> () {
    %0 = constant 0 : i1
    %clk_i = llhd.sig "sig" %0 : i1
    %1 = constant 1 : i1
    %rst_ni = llhd.sig "sig1" %1 : i1
    %en_i = llhd.sig "sig2" %0 : i1
    %2 = constant 0 : i16
    %out_o = llhd.sig "sig3" %2 : i16
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.sig "sig4" %0 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %clk_i1 after %4 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %5 = llhd.sig "sig5" %0 : i1
    llhd.drv %5, %rst_ni1 after %4 : !llhd.sig<i1>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %6 = llhd.sig "sig6" %0 : i1
    llhd.drv %6, %en_i1 after %4 : !llhd.sig<i1>
    llhd.inst "inst" @lfsr_16bit.param1(%3, %5, %6) -> (%out_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit_tb.initial.113.0() -> (%clk_i, %rst_ni, %en_i) : () -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
