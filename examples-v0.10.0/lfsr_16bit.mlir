llhd.proc @lfsr_16bit.param1.always_comb.155.1(%en_i: !llhd.sig<i1>, %shift_q: !llhd.sig<i16>) -> (%out_o: !llhd.sig<i16> , %shift_d: !llhd.sig<i16> ) {
    br ^body
^body:
    %shift_q.prb = llhd.prb %shift_q : !llhd.sig<i16>
    %0 = llhd.extract_slice %shift_q.prb, 15 : i16 -> i1
    %1 = llhd.const 0 : i16
    %2 = llhd.insert_slice %1, %0, 0 : i16, i1
    %3 = llhd.extract_slice %2, 0 : i16 -> i1
    %4 = llhd.extract_slice %shift_q.prb, 12 : i16 -> i4
    %5 = llhd.insert_slice %1, %4, 0 : i16, i4
    %6 = llhd.extract_slice %5, 0 : i16 -> i1
    %7 = llhd.xor %3, %6 : i1
    %8 = llhd.extract_slice %shift_q.prb, 5 : i16 -> i11
    %9 = llhd.insert_slice %1, %8, 0 : i16, i11
    %10 = llhd.extract_slice %9, 0 : i16 -> i1
    %11 = llhd.xor %7, %10 : i1
    %12 = llhd.extract_slice %shift_q.prb, 1 : i16 -> i15
    %13 = llhd.insert_slice %1, %12, 0 : i16, i15
    %14 = llhd.extract_slice %13, 0 : i16 -> i1
    %15 = llhd.xor %11, %14 : i1
    %16 = llhd.const 0 : i1
    %17 = llhd.neq %15, %16 : i1
    %18 = llhd.not %17 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %shift_q.prb after %19 : !llhd.sig<i16>
    %en_i.prb = llhd.prb %en_i : !llhd.sig<i1>
    %20 = llhd.neq %en_i.prb, %16 : i1
    cond_br %20, ^if_true, ^if_exit
^if_exit:
    llhd.drv %out_o, %shift_q.prb after %19 : !llhd.sig<i16>
    llhd.wait (%en_i, %shift_q : !llhd.sig<i1>, !llhd.sig<i16>), ^body
^if_true:
    %21 = llhd.insert_slice %1, %18, 0 : i16, i1
    %22 = llhd.extract_slice %shift_q.prb, 0 : i16 -> i15
    %concat = llhd.insert_slice %21, %22, 1 : i16, i15
    llhd.drv %shift_d, %concat after %19 : !llhd.sig<i16>
    br ^if_exit
}

llhd.proc @lfsr_16bit.param1.always_ff.196.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %shift_d: !llhd.sig<i16>) -> (%shift_q: !llhd.sig<i16> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %rst_ni.prb1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %rst_ni.prb, %0 : i1
    %4 = llhd.eq %rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.not %rst_ni.prb1 : i1
    %6 = llhd.neq %5, %0 : i1
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %6, ^if_true, ^if_false
^if_false:
    %shift_d.prb = llhd.prb %shift_d : !llhd.sig<i16>
    llhd.drv %shift_q, %shift_d.prb after %7 : !llhd.sig<i16>
    br ^init
^if_true:
    %8 = llhd.const 1 : i16
    llhd.drv %shift_q, %8 after %7 : !llhd.sig<i16>
    br ^init
}

llhd.proc @lfsr_16bit.param1.initial.214.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %shift_d = llhd.sig "shift_d" %0 : i16
    %shift_q = llhd.sig "shift_q" %0 : i16
    llhd.inst "inst" @lfsr_16bit.param1.always_comb.155.1(%en_i, %shift_q) -> (%out_o, %shift_d) : (!llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param1.always_ff.196.1(%clk_i, %rst_ni, %shift_d) -> (%shift_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param1.initial.214.1() -> () : () -> ()
}

llhd.proc @lfsr_16bit_tb.initial.332.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> , %en_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i1
    %2 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.const 1 : i1
    %4 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %3 after %4 : !llhd.sig<i1>
    %5 = llhd.const #llhd.time<4ns, 0d, 0e> : !llhd.time
    llhd.wait  for %5, ^6
^6:
    %7 = llhd.const 1 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %en_i, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const 10000000 : i32
    br ^loop_body(%9 : i32)
^loop_body(%10: i32):
    %11 = llhd.const 0 : i32
    %12 = llhd.neq %10, %11 : i32
    cond_br %12, ^loop_continue, ^loop_exit
^13:
    br ^loop_body(%10 : i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %14 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %7 after %14 : !llhd.sig<i1>
    %15 = llhd.const 0 : i1
    %16 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %15 after %16 : !llhd.sig<i1>
    llhd.wait  for %16, ^13
}

llhd.entity @lfsr_16bit_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %en_i = llhd.sig "en_i" %0 : i1
    %2 = llhd.const 0 : i16
    %out_o = llhd.sig "out_o" %2 : i16
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.sig "3" %0 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %clk_i.prb after %4 : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    %5 = llhd.sig "5" %0 : i1
    llhd.drv %5, %rst_ni.prb after %4 : !llhd.sig<i1>
    %en_i.prb = llhd.prb %en_i : !llhd.sig<i1>
    %6 = llhd.sig "6" %0 : i1
    llhd.drv %6, %en_i.prb after %4 : !llhd.sig<i1>
    llhd.inst "inst" @lfsr_16bit.param1(%3, %5, %6) -> (%out_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit_tb.initial.332.0() -> (%clk_i, %rst_ni, %en_i) : () -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
