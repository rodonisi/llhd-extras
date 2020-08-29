llhd.proc @delta_counter.param3.always_comb.421.3(%clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %delta_i: !llhd.sig<i4>, %d_i: !llhd.sig<i4>, %counter_q: !llhd.sig<i5>) -> (%counter_d: !llhd.sig<i5> ) {
    br ^0
^0:
    br ^body
^body:
    %counter_q1 = llhd.prb %counter_q : !llhd.sig<i5>
    %1 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %counter_q1 after %1 : !llhd.sig<i5>
    %clear_i1 = llhd.prb %clear_i : !llhd.sig<i1>
    cond_br %clear_i1, ^if_true, ^if_false
^if_false:
    %load_i1 = llhd.prb %load_i : !llhd.sig<i1>
    cond_br %load_i1, ^if_true1, ^if_false1
^if_true:
    %2 = llhd.const 0 : i5
    %3 = llhd.const 0 : i1
    %4 = llhd.insert_slice %2, %3, 0 : i5, i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %4 after %5 : !llhd.sig<i5>
    br ^if_exit
^check:
    llhd.wait (%clear_i, %en_i, %load_i, %down_i, %delta_i, %d_i, %counter_q : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>), ^body
^if_exit:
    br ^check
^if_false1:
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    cond_br %en_i1, ^if_true2, ^if_false2
^if_true1:
    %6 = llhd.const 0 : i5
    %d_i1 = llhd.prb %d_i : !llhd.sig<i4>
    %7 = llhd.insert_slice %6, %d_i1, 0 : i5, i4
    %8 = llhd.const 0 : i1
    %9 = llhd.insert_slice %7, %8, 4 : i5, i1
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %9 after %10 : !llhd.sig<i5>
    br ^if_exit1
^if_exit1:
    br ^if_exit
^if_false2:
    br ^if_exit2
^if_true2:
    %down_i1 = llhd.prb %down_i : !llhd.sig<i1>
    cond_br %down_i1, ^if_true3, ^if_false3
^if_false3:
    %counter_q3 = llhd.prb %counter_q : !llhd.sig<i5>
    %11 = llhd.const 0 : i5
    %delta_i2 = llhd.prb %delta_i : !llhd.sig<i4>
    %12 = llhd.insert_slice %11, %delta_i2, 0 : i5, i4
    %13 = addi %counter_q3, %12 : i5
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %13 after %14 : !llhd.sig<i5>
    br ^if_exit3
^if_true3:
    %counter_q2 = llhd.prb %counter_q : !llhd.sig<i5>
    %15 = llhd.const 0 : i5
    %delta_i1 = llhd.prb %delta_i : !llhd.sig<i4>
    %16 = llhd.insert_slice %15, %delta_i1, 0 : i5, i4
    %17 = subi %counter_q2, %16 : i5
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %17 after %18 : !llhd.sig<i5>
    br ^if_exit3
^if_exit2:
    br ^if_exit1
^if_exit3:
    br ^if_exit2
}

llhd.proc @delta_counter.param3.always_ff.422.3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %counter_d: !llhd.sig<i5>) -> (%counter_q: !llhd.sig<i5> ) {
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
    %counter_d1 = llhd.prb %counter_d : !llhd.sig<i5>
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %counter_q, %counter_d1 after %8 : !llhd.sig<i5>
    br ^if_exit
^if_true:
    %9 = llhd.const 0 : i5
    %10 = llhd.const 0 : i1
    %11 = llhd.insert_slice %9, %10, 0 : i5, i1
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %counter_q, %11 after %12 : !llhd.sig<i5>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.entity @delta_counter.param3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %delta_i: !llhd.sig<i4>, %d_i: !llhd.sig<i4>) -> (%q_o: !llhd.sig<i4> , %overflow_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i5
    %counter_q = llhd.sig "counter_q" %0 : i5
    %1 = llhd.const 0 : i5
    %counter_d = llhd.sig "counter_d" %1 : i5
    %counter_q1 = llhd.prb %counter_q : !llhd.sig<i5>
    %2 = llhd.const 0 : i1
    %3 = llhd.const 0 : i5
    %4 = llhd.shr %counter_q1, %3, %2 : (i5, i5, i1) -> i5
    %5 = llhd.extract_slice %4, 0 : i5 -> i4
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %q_o, %5 after %6 : !llhd.sig<i4>
    %counter_q2 = llhd.prb %counter_q : !llhd.sig<i5>
    %7 = llhd.const 4 : i32
    %8 = llhd.const 0 : i5
    %9 = llhd.shr %counter_q2, %8, %7 : (i5, i5, i32) -> i5
    %10 = llhd.extract_slice %9, 0 : i5 -> i1
    %11 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %overflow_o, %10 after %11 : !llhd.sig<i1>
    llhd.inst "inst" @delta_counter.param3.always_comb.421.3(%clear_i, %en_i, %load_i, %down_i, %delta_i, %d_i, %counter_q) -> (%counter_d) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>) -> (!llhd.sig<i5>)
    llhd.inst "inst1" @delta_counter.param3.always_ff.422.3(%clk_i, %rst_ni, %counter_d) -> (%counter_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i5>) -> (!llhd.sig<i5>)
}

llhd.entity @counter.param2(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %d_i: !llhd.sig<i4>) -> (%q_o: !llhd.sig<i4> , %overflow_o: !llhd.sig<i1> ) {
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.sig "1" %0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1, %clk_i1 after %2 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.sig "4" %3 : i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %rst_ni1 after %5 : !llhd.sig<i1>
    %clear_i1 = llhd.prb %clear_i : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.sig "7" %6 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %7, %clear_i1 after %8 : !llhd.sig<i1>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %9 = llhd.const 0 : i1
    %10 = llhd.sig "10" %9 : i1
    %11 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %10, %en_i1 after %11 : !llhd.sig<i1>
    %load_i1 = llhd.prb %load_i : !llhd.sig<i1>
    %12 = llhd.const 0 : i1
    %13 = llhd.sig "13" %12 : i1
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %13, %load_i1 after %14 : !llhd.sig<i1>
    %down_i1 = llhd.prb %down_i : !llhd.sig<i1>
    %15 = llhd.const 0 : i1
    %16 = llhd.sig "16" %15 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %16, %down_i1 after %17 : !llhd.sig<i1>
    %18 = llhd.const 0 : i4
    %19 = llhd.const 1 : i1
    %20 = llhd.insert_slice %18, %19, 0 : i4, i1
    %21 = llhd.const 0 : i1
    %22 = llhd.const 0 : i1
    %23 = llhd.insert_slice %21, %22, 0 : i1, i1
    %24 = llhd.const 0 : i3
    %25 = llhd.insert_slice %24, %23, 0 : i3, i1
    %26 = llhd.insert_slice %25, %23, 1 : i3, i1
    %27 = llhd.insert_slice %26, %23, 2 : i3, i1
    %28 = llhd.insert_slice %20, %27, 1 : i4, i3
    %29 = llhd.const 0 : i4
    %30 = llhd.sig "30" %29 : i4
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %30, %28 after %31 : !llhd.sig<i4>
    %d_i1 = llhd.prb %d_i : !llhd.sig<i4>
    %32 = llhd.const 0 : i4
    %33 = llhd.sig "33" %32 : i4
    %34 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %33, %d_i1 after %34 : !llhd.sig<i4>
    llhd.inst "inst" @delta_counter.param3(%1, %4, %7, %10, %13, %16, %30, %33) -> (%q_o, %overflow_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
}

llhd.proc @lfsr_16bit.param4.always_comb.610.4(%en_i: !llhd.sig<i1>, %shift_q: !llhd.sig<i16>) -> (%out_o: !llhd.sig<i16> , %shift_d: !llhd.sig<i16> ) {
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

llhd.proc @lfsr_16bit.param4.always_ff.611.4(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %shift_d: !llhd.sig<i16>) -> (%shift_q: !llhd.sig<i16> ) {
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
    %9 = llhd.const 0 : i16
    %10 = llhd.const 0 : i8
    %11 = llhd.insert_slice %9, %10, 0 : i16, i8
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %shift_q, %11 after %12 : !llhd.sig<i16>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.proc @lfsr_16bit.param4.initial.612.4() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param4(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %shift_d = llhd.sig "shift_d" %0 : i16
    %1 = llhd.const 0 : i16
    %shift_q = llhd.sig "shift_q" %1 : i16
    llhd.inst "inst" @lfsr_16bit.param4.always_comb.610.4(%en_i, %shift_q) -> (%out_o, %shift_d) : (!llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param4.always_ff.611.4(%clk_i, %rst_ni, %shift_d) -> (%shift_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param4.initial.612.4() -> () : () -> ()
}

llhd.proc @stream_delay.param1.always_comb.320.1(%valid_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>, %state_q: !llhd.sig<i2>, %count_out: !llhd.sig<i4>, %counter_load: !llhd.sig<i4>) -> (%ready_o: !llhd.sig<i1> , %valid_o: !llhd.sig<i1> , %state_d: !llhd.sig<i2> , %load: !llhd.sig<i1> , %en: !llhd.sig<i1> ) {
    br ^0
^0:
    br ^body
^body:
    %state_q1 = llhd.prb %state_q : !llhd.sig<i2>
    %1 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %state_q1 after %1 : !llhd.sig<i2>
    %2 = llhd.const 0 : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_o, %2 after %3 : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_o, %4 after %5 : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %load, %6 after %7 : !llhd.sig<i1>
    %8 = llhd.const 0 : i1
    %9 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %en, %8 after %9 : !llhd.sig<i1>
    %state_q2 = llhd.prb %state_q : !llhd.sig<i2>
    %10 = llhd.const 0 : i1
    %11 = llhd.const 0 : i2
    %12 = llhd.eq %state_q2, %11 : i2
    %13 = llhd.or %10, %12 : i1
    cond_br %13, ^case_body, ^14
^14:
    %15 = llhd.const 0 : i1
    %16 = llhd.const 1 : i2
    %17 = llhd.eq %state_q2, %16 : i2
    %18 = llhd.or %15, %17 : i1
    cond_br %18, ^case_body1, ^19
^case_body:
    %valid_i1 = llhd.prb %valid_i : !llhd.sig<i1>
    cond_br %valid_i1, ^if_true, ^if_false
^check:
    llhd.wait (%valid_i, %ready_i, %state_q, %count_out, %counter_load : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>), ^body
^case_exit:
    br ^check
^if_false:
    br ^if_exit
^if_true:
    %20 = llhd.const 1 : i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %load, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const 1 : i2
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %22 after %23 : !llhd.sig<i2>
    %24 = llhd.const 0 : i32
    %25 = llhd.const 1 : i32
    %26 = llhd.eq %24, %25 : i32
    %27 = llhd.const 1 : i32
    %28 = llhd.const 0 : i32
    %29 = llhd.neq %27, %28 : i32
    %30 = llhd.const 0 : i32
    %counter_load1 = llhd.prb %counter_load : !llhd.sig<i4>
    %31 = llhd.insert_slice %30, %counter_load1, 0 : i32, i4
    %32 = llhd.const 1 : i32
    %33 = llhd.eq %31, %32 : i32
    %34 = llhd.and %29, %33 : i1
    %35 = llhd.or %26, %34 : i1
    cond_br %35, ^if_true1, ^if_false1
^19:
    %36 = llhd.const 0 : i1
    %37 = llhd.const 2 : i2
    %38 = llhd.eq %state_q2, %37 : i2
    %39 = llhd.or %36, %38 : i1
    cond_br %39, ^case_body2, ^40
^case_body1:
    %41 = llhd.const 1 : i1
    %42 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %en, %41 after %42 : !llhd.sig<i1>
    %43 = llhd.const 0 : i32
    %count_out1 = llhd.prb %count_out : !llhd.sig<i4>
    %44 = llhd.insert_slice %43, %count_out1, 0 : i32, i4
    %45 = llhd.const 0 : i32
    %46 = llhd.eq %44, %45 : i32
    cond_br %46, ^if_true4, ^if_false4
^if_false1:
    br ^if_exit1
^if_true1:
    %47 = llhd.const 2 : i2
    %48 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %47 after %48 : !llhd.sig<i2>
    br ^if_exit1
^if_exit:
    br ^case_exit
^if_exit1:
    %49 = llhd.const 1 : i32
    %50 = llhd.const 0 : i32
    %51 = llhd.neq %49, %50 : i32
    %52 = llhd.const 0 : i32
    %counter_load2 = llhd.prb %counter_load : !llhd.sig<i4>
    %53 = llhd.insert_slice %52, %counter_load2, 0 : i32, i4
    %54 = llhd.const 0 : i32
    %55 = llhd.eq %53, %54 : i32
    %56 = llhd.and %51, %55 : i1
    cond_br %56, ^if_true2, ^if_false2
^if_false2:
    br ^if_exit2
^if_true2:
    %57 = llhd.const 1 : i1
    %58 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_o, %57 after %58 : !llhd.sig<i1>
    %ready_i1 = llhd.prb %ready_i : !llhd.sig<i1>
    %59 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_o, %ready_i1 after %59 : !llhd.sig<i1>
    %ready_i2 = llhd.prb %ready_i : !llhd.sig<i1>
    cond_br %ready_i2, ^if_true3, ^if_false3
^if_false3:
    %60 = llhd.const 2 : i2
    %61 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %60 after %61 : !llhd.sig<i2>
    br ^if_exit3
^if_true3:
    %62 = llhd.const 0 : i2
    %63 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %62 after %63 : !llhd.sig<i2>
    br ^if_exit3
^if_exit2:
    br ^if_exit
^if_exit3:
    br ^if_exit2
^if_false4:
    br ^if_exit4
^if_true4:
    %64 = llhd.const 2 : i2
    %65 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %64 after %65 : !llhd.sig<i2>
    br ^if_exit4
^40:
    br ^case_exit
^case_body2:
    %66 = llhd.const 1 : i1
    %67 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_o, %66 after %67 : !llhd.sig<i1>
    %ready_i3 = llhd.prb %ready_i : !llhd.sig<i1>
    %68 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_o, %ready_i3 after %68 : !llhd.sig<i1>
    %ready_i4 = llhd.prb %ready_i : !llhd.sig<i1>
    cond_br %ready_i4, ^if_true5, ^if_false5
^if_exit4:
    br ^case_exit
^if_false5:
    br ^if_exit5
^if_true5:
    %69 = llhd.const 0 : i2
    %70 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %69 after %70 : !llhd.sig<i2>
    br ^if_exit5
^if_exit5:
    br ^case_exit
}

llhd.proc @stream_delay.param1.always_ff.324.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %state_d: !llhd.sig<i2>) -> (%state_q: !llhd.sig<i2> ) {
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
    %state_d1 = llhd.prb %state_d : !llhd.sig<i2>
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %state_q, %state_d1 after %8 : !llhd.sig<i2>
    br ^if_exit
^if_true:
    %9 = llhd.const 0 : i2
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %state_q, %9 after %10 : !llhd.sig<i2>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.entity @stream_delay.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %payload_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>) -> (%ready_o: !llhd.sig<i1> , %payload_o: !llhd.sig<i32> , %valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i2
    %state_d = llhd.sig "state_d" %0 : i2
    %1 = llhd.const 0 : i2
    %state_q = llhd.sig "state_q" %1 : i2
    %2 = llhd.const 0 : i1
    %load = llhd.sig "load" %2 : i1
    %3 = llhd.const 0 : i4
    %count_out = llhd.sig "count_out" %3 : i4
    %4 = llhd.const 0 : i1
    %en = llhd.sig "en" %4 : i1
    %5 = llhd.const 0 : i4
    %counter_load = llhd.sig "counter_load" %5 : i4
    %payload_i1 = llhd.prb %payload_i : !llhd.sig<i32>
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %payload_o, %payload_i1 after %6 : !llhd.sig<i32>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %7 = llhd.const 0 : i1
    %8 = llhd.sig "8" %7 : i1
    %9 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %8, %clk_i1 after %9 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %10 = llhd.const 0 : i1
    %11 = llhd.sig "11" %10 : i1
    %12 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %11, %rst_ni1 after %12 : !llhd.sig<i1>
    %13 = llhd.const 0 : i1
    %14 = llhd.const 0 : i1
    %15 = llhd.sig "15" %14 : i1
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %15, %13 after %16 : !llhd.sig<i1>
    %en1 = llhd.prb %en : !llhd.sig<i1>
    %17 = llhd.const 0 : i1
    %18 = llhd.sig "18" %17 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %18, %en1 after %19 : !llhd.sig<i1>
    %load1 = llhd.prb %load : !llhd.sig<i1>
    %20 = llhd.const 0 : i1
    %21 = llhd.sig "21" %20 : i1
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %21, %load1 after %22 : !llhd.sig<i1>
    %23 = llhd.const 1 : i1
    %24 = llhd.const 0 : i1
    %25 = llhd.sig "25" %24 : i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %25, %23 after %26 : !llhd.sig<i1>
    %counter_load1 = llhd.prb %counter_load : !llhd.sig<i4>
    %27 = llhd.const 0 : i4
    %28 = llhd.sig "28" %27 : i4
    %29 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %28, %counter_load1 after %29 : !llhd.sig<i4>
    %30 = llhd.const 0 : i1
    %31 = llhd.sig "31" %30 : i1
    llhd.inst "inst" @counter.param2(%8, %11, %15, %18, %21, %25, %28) -> (%count_out, %31) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
    %32 = llhd.const 0 : i16
    %lfsr_out = llhd.sig "lfsr_out" %32 : i16
    %lfsr_out1 = llhd.prb %lfsr_out : !llhd.sig<i16>
    %33 = llhd.extract_slice %lfsr_out1, 0 : i16 -> i4
    %34 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_load, %33 after %34 : !llhd.sig<i4>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %35 = llhd.const 0 : i1
    %36 = llhd.sig "36" %35 : i1
    %37 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %36, %clk_i2 after %37 : !llhd.sig<i1>
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %38 = llhd.const 0 : i1
    %39 = llhd.sig "39" %38 : i1
    %40 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %39, %rst_ni2 after %40 : !llhd.sig<i1>
    %load2 = llhd.prb %load : !llhd.sig<i1>
    %41 = llhd.const 0 : i1
    %42 = llhd.sig "42" %41 : i1
    %43 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %42, %load2 after %43 : !llhd.sig<i1>
    llhd.inst "inst1" @lfsr_16bit.param4(%36, %39, %42) -> (%lfsr_out) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @stream_delay.param1.always_comb.320.1(%valid_i, %ready_i, %state_q, %count_out, %counter_load) -> (%ready_o, %valid_o, %state_d, %load, %en) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst3" @stream_delay.param1.always_ff.324.1(%clk_i, %rst_ni, %state_d) -> (%state_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>) -> (!llhd.sig<i2>)
}

llhd.proc @stream_delay_tb.initial.243.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %9 = llhd.const 600000 : i32
    %loop_count = llhd.var %9 : i32
    br ^loop_body
^loop_body:
    %10 = llhd.load %loop_count : !llhd.ptr<i32>
    %11 = llhd.const 0 : i32
    %12 = llhd.neq %10, %11 : i32
    cond_br %12, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    %13 = llhd.const 1 : i32
    %14 = llhd.extract_slice %13, 0 : i32 -> i1
    %15 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %14 after %15 : !llhd.sig<i1>
    %16 = llhd.const 0 : i32
    %17 = llhd.extract_slice %16, 0 : i32 -> i1
    %18 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %17 after %18 : !llhd.sig<i1>
    %19 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.wait  for %19, ^20
^20:
    %21 = llhd.load %loop_count : !llhd.ptr<i32>
    %22 = llhd.const 1 : i32
    %23 = subi %21, %22 : i32
    llhd.store %loop_count, %23 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.proc @stream_delay_tb.always.245.0(%clk_i: !llhd.sig<i1>, %payload_i: !llhd.sig<i32>, %ready_o: !llhd.sig<i1>) -> (%payload_i1: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = llhd.prb %payload_i1 : !llhd.sig<i32>
    %payload_i.shadow = llhd.var %1 : i32
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %payload_i1 : !llhd.sig<i32>
    llhd.store %payload_i.shadow, %2 : !llhd.ptr<i32>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i1, %3 : i1
    %5 = llhd.neq %clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %ready_o1 = llhd.prb %ready_o : !llhd.sig<i1>
    %iff = llhd.and %posedge, %ready_o1 : i1
    cond_br %iff, ^event, ^init
^event:
    %payload_i2 = llhd.load %payload_i.shadow : !llhd.ptr<i32>
    %6 = llhd.const 1 : i32
    %7 = addi %payload_i2, %6 : i32
    %8 = llhd.const #llhd.time<500ps, 0d, 0e> : !llhd.time
    llhd.drv %payload_i1, %7 after %8 : !llhd.sig<i32>
    br ^0
}

llhd.entity @stream_delay_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %2 = llhd.const 0 : i32
    %payload_i = llhd.sig "payload_i" %2 : i32
    %3 = llhd.const 0 : i1
    %ready_o = llhd.sig "ready_o" %3 : i1
    %4 = llhd.const 0 : i1
    %valid_i = llhd.sig "valid_i" %4 : i1
    %5 = llhd.const 0 : i32
    %payload_o = llhd.sig "payload_o" %5 : i32
    %6 = llhd.const 0 : i1
    %ready_i = llhd.sig "ready_i" %6 : i1
    %7 = llhd.const 0 : i1
    %valid_o = llhd.sig "valid_o" %7 : i1
    %8 = llhd.const 1 : i32
    %9 = llhd.extract_slice %8, 0 : i32 -> i1
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_i, %9 after %10 : !llhd.sig<i1>
    %valid_o1 = llhd.prb %valid_o : !llhd.sig<i1>
    %11 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_i, %valid_o1 after %11 : !llhd.sig<i1>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %12 = llhd.const 0 : i1
    %13 = llhd.sig "13" %12 : i1
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %13, %clk_i1 after %14 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %15 = llhd.const 0 : i1
    %16 = llhd.sig "16" %15 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %16, %rst_ni1 after %17 : !llhd.sig<i1>
    %payload_i1 = llhd.prb %payload_i : !llhd.sig<i32>
    %18 = llhd.const 0 : i32
    %19 = llhd.sig "19" %18 : i32
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %19, %payload_i1 after %20 : !llhd.sig<i32>
    %valid_i1 = llhd.prb %valid_i : !llhd.sig<i1>
    %21 = llhd.const 0 : i1
    %22 = llhd.sig "22" %21 : i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %22, %valid_i1 after %23 : !llhd.sig<i1>
    %ready_i1 = llhd.prb %ready_i : !llhd.sig<i1>
    %24 = llhd.const 0 : i1
    %25 = llhd.sig "25" %24 : i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %25, %ready_i1 after %26 : !llhd.sig<i1>
    llhd.inst "inst" @stream_delay.param1(%13, %16, %19, %22, %25) -> (%ready_o, %payload_o, %valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @stream_delay_tb.initial.243.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst2" @stream_delay_tb.always.245.0(%clk_i, %payload_i, %ready_o) -> (%payload_i) : (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
}
