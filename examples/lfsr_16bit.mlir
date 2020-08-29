llhd.proc @lfsr_16bit.param1.always_comb.251.1(%en_i: !llhd.sig<i1>, %shift_q: !llhd.sig<i16>) -> (%out_o: !llhd.sig<i16> , %shift_d: !llhd.sig<i16> ) {
    br ^0
^0:
    br ^body
^body:
    %1 = llhd.const 0 : i1
    %shift_in = llhd.var %1 : i1
    %shift_q1 = llhd.prb %shift_q : !llhd.sig<i16>
    %2 = llhd.const 15 : i32
    %3 = llhd.const 0 : i16
    %4 = llhd.shr %shift_q1, %3, %2 : (i16, i16, i32) -> i16
    %5 = llhd.extract_slice %4, 0 : i16 -> i1
    %shift_q2 = llhd.prb %shift_q : !llhd.sig<i16>
    %6 = llhd.const 12 : i32
    %7 = llhd.const 0 : i16
    %8 = llhd.shr %shift_q2, %7, %6 : (i16, i16, i32) -> i16
    %9 = llhd.extract_slice %8, 0 : i16 -> i1
    %10 = llhd.xor %5, %9 : i1
    %shift_q3 = llhd.prb %shift_q : !llhd.sig<i16>
    %11 = llhd.const 5 : i32
    %12 = llhd.const 0 : i16
    %13 = llhd.shr %shift_q3, %12, %11 : (i16, i16, i32) -> i16
    %14 = llhd.extract_slice %13, 0 : i16 -> i1
    %15 = llhd.xor %10, %14 : i1
    %shift_q4 = llhd.prb %shift_q : !llhd.sig<i16>
    %16 = llhd.const 1 : i32
    %17 = llhd.const 0 : i16
    %18 = llhd.shr %shift_q4, %17, %16 : (i16, i16, i32) -> i16
    %19 = llhd.extract_slice %18, 0 : i16 -> i1
    %20 = llhd.xor %15, %19 : i1
    %21 = llhd.not %20 : i1
    llhd.store %shift_in, %21 : !llhd.ptr<i1>
    %shift_q5 = llhd.prb %shift_q : !llhd.sig<i16>
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %shift_q5 after %22 : !llhd.sig<i16>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    cond_br %en_i1, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %23 = llhd.const 0 : i16
    %shift_in1 = llhd.load %shift_in : !llhd.ptr<i1>
    %24 = llhd.insert_slice %23, %shift_in1, 0 : i16, i1
    %shift_q6 = llhd.prb %shift_q : !llhd.sig<i16>
    %25 = llhd.const 0 : i1
    %26 = llhd.const 0 : i16
    %27 = llhd.shr %shift_q6, %26, %25 : (i16, i16, i1) -> i16
    %28 = llhd.extract_slice %27, 0 : i16 -> i15
    %29 = llhd.insert_slice %24, %28, 1 : i16, i15
    %30 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %29 after %30 : !llhd.sig<i16>
    br ^if_exit
^check:
    llhd.wait (%en_i, %shift_q : !llhd.sig<i1>, !llhd.sig<i16>), ^body
^if_exit:
    %shift_q7 = llhd.prb %shift_q : !llhd.sig<i16>
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %out_o, %shift_q7 after %31 : !llhd.sig<i16>
    br ^check
}

llhd.proc @lfsr_16bit.param1.always_ff.252.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %shift_d: !llhd.sig<i16>) -> (%shift_q: !llhd.sig<i16> ) {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %rst_ni1, %4 : i1
    %6 = llhd.eq %rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %rst_ni3 = llhd.prb %rst_ni : !llhd.sig<i1>
    %7 = llhd.not %rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %shift_d1 = llhd.prb %shift_d : !llhd.sig<i16>
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %shift_q, %shift_d1 after %8 : !llhd.sig<i16>
    br ^if_exit
^if_true:
    %9 = llhd.const 1 : i32
    %10 = llhd.extract_slice %9, 0 : i32 -> i16
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %shift_q, %10 after %11 : !llhd.sig<i16>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.proc @lfsr_16bit.param1.initial.253.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %shift_d = llhd.sig "shift_d" %0 : i16
    %1 = llhd.const 0 : i16
    %shift_q = llhd.sig "shift_q" %1 : i16
    llhd.inst "inst" @lfsr_16bit.param1.always_comb.251.1(%en_i, %shift_q) -> (%out_o, %shift_d) : (!llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param1.always_ff.252.1(%clk_i, %rst_ni, %shift_d) -> (%shift_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param1.initial.253.1() -> () : () -> ()
}

llhd.proc @lfsr_16bit_tb.initial.232.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> , %en_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i32
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %2 after %3 : !llhd.sig<i1>
    %4 = llhd.const 1 : i32
    %5 = llhd.extract_slice %4, 0 : i32 -> i1
    %6 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const #llhd.time<4ns, 0d, 0e> : !llhd.time
    llhd.wait  for %7, ^8
^8:
    %9 = llhd.const 1 : i32
    %10 = llhd.extract_slice %9, 0 : i32 -> i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %en_i, %10 after %11 : !llhd.sig<i1>
    %12 = llhd.const 10000000 : i32
    %loop_count = llhd.var %12 : i32
    br ^loop_body
^loop_body:
    %13 = llhd.load %loop_count : !llhd.ptr<i32>
    %14 = llhd.const 0 : i32
    %15 = llhd.neq %13, %14 : i32
    cond_br %15, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    %16 = llhd.const 1 : i32
    %17 = llhd.extract_slice %16, 0 : i32 -> i1
    %18 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %17 after %18 : !llhd.sig<i1>
    %19 = llhd.const 0 : i32
    %20 = llhd.extract_slice %19, 0 : i32 -> i1
    %21 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.wait  for %22, ^23
^23:
    %24 = llhd.load %loop_count : !llhd.ptr<i32>
    %25 = llhd.const 1 : i32
    %26 = subi %24, %25 : i32
    llhd.store %loop_count, %26 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.entity @lfsr_16bit_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %2 = llhd.const 0 : i1
    %en_i = llhd.sig "en_i" %2 : i1
    %3 = llhd.const 0 : i16
    %out_o = llhd.sig "out_o" %3 : i16
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.sig "5" %4 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %5, %clk_i1 after %6 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %7 = llhd.const 0 : i1
    %8 = llhd.sig "8" %7 : i1
    %9 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %8, %rst_ni1 after %9 : !llhd.sig<i1>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %10 = llhd.const 0 : i1
    %11 = llhd.sig "11" %10 : i1
    %12 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %11, %en_i1 after %12 : !llhd.sig<i1>
    llhd.inst "inst" @lfsr_16bit.param1(%5, %8, %11) -> (%out_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit_tb.initial.232.0() -> (%clk_i, %rst_ni, %en_i) : () -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
