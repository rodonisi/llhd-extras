llhd.proc @delta_counter.param3.always_comb.1234.3(%clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %delta_i: !llhd.sig<i4>, %d_i: !llhd.sig<i4>, %counter_q: !llhd.sig<i5>) -> (%counter_d: !llhd.sig<i5> ) {
    br ^body
^body:
    %counter_q.prb = llhd.prb %counter_q : !llhd.sig<i5>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %counter_q.prb after %0 : !llhd.sig<i5>
    %clear_i.prb = llhd.prb %clear_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.neq %clear_i.prb, %1 : i1
    %3 = llhd.const 0 : i5
    cond_br %2, ^if_true, ^if_false
^if_false:
    %load_i.prb = llhd.prb %load_i : !llhd.sig<i1>
    %4 = llhd.neq %load_i.prb, %1 : i1
    cond_br %4, ^if_true1, ^if_false1
^if_true:
    llhd.drv %counter_d, %3 after %0 : !llhd.sig<i5>
    br ^check
^check:
    llhd.wait (%clear_i, %en_i, %load_i, %down_i, %delta_i, %d_i, %counter_q : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>), ^body
^if_false1:
    %en_i.prb = llhd.prb %en_i : !llhd.sig<i1>
    %5 = llhd.neq %en_i.prb, %1 : i1
    cond_br %5, ^if_true2, ^check
^if_true1:
    %d_i.prb = llhd.prb %d_i : !llhd.sig<i4>
    %6 = llhd.insert_slice %3, %d_i.prb, 0 : i5, i4
    %concat = llhd.insert_slice %6, %1, 4 : i5, i1
    llhd.drv %counter_d, %concat after %0 : !llhd.sig<i5>
    br ^check
^if_true2:
    %down_i.prb = llhd.prb %down_i : !llhd.sig<i1>
    %7 = llhd.neq %down_i.prb, %1 : i1
    %delta_i.prb = llhd.prb %delta_i : !llhd.sig<i4>
    cond_br %7, ^if_true3, ^if_false2
^if_false2:
    %zext1 = llhd.insert_slice %3, %delta_i.prb, 0 : i5, i4
    %8 = addi %counter_q.prb, %zext1 : i5
    llhd.drv %counter_d, %8 after %0 : !llhd.sig<i5>
    br ^check
^if_true3:
    %zext = llhd.insert_slice %3, %delta_i.prb, 0 : i5, i4
    %9 = subi %counter_q.prb, %zext : i5
    llhd.drv %counter_d, %9 after %0 : !llhd.sig<i5>
    br ^check
}

llhd.proc @delta_counter.param3.always_ff.1273.3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %counter_d: !llhd.sig<i5>) -> (%counter_q: !llhd.sig<i5> ) {
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
    %5 = llhd.neq %rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %counter_d.prb = llhd.prb %counter_d : !llhd.sig<i5>
    llhd.drv %counter_q, %counter_d.prb after %8 : !llhd.sig<i5>
    br ^init
^if_true:
    %9 = llhd.const 0 : i5
    llhd.drv %counter_q, %9 after %8 : !llhd.sig<i5>
    br ^init
}

llhd.entity @delta_counter.param3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %delta_i: !llhd.sig<i4>, %d_i: !llhd.sig<i4>) -> (%q_o: !llhd.sig<i4> , %overflow_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i5
    %counter_q = llhd.sig "counter_q" %0 : i5
    %counter_d = llhd.sig "counter_d" %0 : i5
    %counter_q.prb = llhd.prb %counter_q : !llhd.sig<i5>
    %1 = llhd.extract_slice %counter_q.prb, 0 : i5 -> i4
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %q_o, %1 after %2 : !llhd.sig<i4>
    %3 = llhd.extract_slice %counter_q.prb, 4 : i5 -> i1
    %4 = llhd.insert_slice %0, %3, 0 : i5, i1
    %5 = llhd.extract_slice %4, 0 : i5 -> i1
    llhd.drv %overflow_o, %5 after %2 : !llhd.sig<i1>
    llhd.inst "inst" @delta_counter.param3.always_comb.1234.3(%clear_i, %en_i, %load_i, %down_i, %delta_i, %d_i, %counter_q) -> (%counter_d) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>) -> (!llhd.sig<i5>)
    llhd.inst "inst1" @delta_counter.param3.always_ff.1273.3(%clk_i, %rst_ni, %counter_d) -> (%counter_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i5>) -> (!llhd.sig<i5>)
}

llhd.entity @counter.param2(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %d_i: !llhd.sig<i4>) -> (%q_o: !llhd.sig<i4> , %overflow_o: !llhd.sig<i1> ) {
    %0 = llhd.const 1 : i4
    %1 = llhd.const 0 : i4
    %2 = llhd.sig "2" %1 : i4
    %3 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %2, %0 after %3 : !llhd.sig<i4>
    llhd.inst "inst" @delta_counter.param3(%clk_i, %rst_ni, %clear_i, %en_i, %load_i, %down_i, %2, %d_i) -> (%q_o, %overflow_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
}

llhd.proc @lfsr_16bit.param4.always_comb.1433.4(%en_i: !llhd.sig<i1>, %shift_q: !llhd.sig<i16>) -> (%out_o: !llhd.sig<i16> , %shift_d: !llhd.sig<i16> ) {
    br ^body
^body:
    %0 = llhd.const 0 : i1
    %shift_in = llhd.var %0 : i1
    %shift_q.prb = llhd.prb %shift_q : !llhd.sig<i16>
    %1 = llhd.extract_slice %shift_q.prb, 15 : i16 -> i1
    %2 = llhd.const 0 : i16
    %3 = llhd.insert_slice %2, %1, 0 : i16, i1
    %4 = llhd.extract_slice %3, 0 : i16 -> i1
    %5 = llhd.extract_slice %shift_q.prb, 12 : i16 -> i4
    %6 = llhd.insert_slice %2, %5, 0 : i16, i4
    %7 = llhd.extract_slice %6, 0 : i16 -> i1
    %8 = llhd.xor %4, %7 : i1
    %9 = llhd.extract_slice %shift_q.prb, 5 : i16 -> i11
    %10 = llhd.insert_slice %2, %9, 0 : i16, i11
    %11 = llhd.extract_slice %10, 0 : i16 -> i1
    %12 = llhd.xor %8, %11 : i1
    %13 = llhd.extract_slice %shift_q.prb, 1 : i16 -> i15
    %14 = llhd.insert_slice %2, %13, 0 : i16, i15
    %15 = llhd.extract_slice %14, 0 : i16 -> i1
    %16 = llhd.xor %12, %15 : i1
    %17 = llhd.neq %16, %0 : i1
    %18 = llhd.not %17 : i1
    llhd.store %shift_in, %18 : !llhd.ptr<i1>
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %shift_q.prb after %19 : !llhd.sig<i16>
    %en_i.prb = llhd.prb %en_i : !llhd.sig<i1>
    %20 = llhd.neq %en_i.prb, %0 : i1
    cond_br %20, ^if_true, ^if_exit
^if_exit:
    llhd.drv %out_o, %shift_q.prb after %19 : !llhd.sig<i16>
    llhd.wait (%en_i, %shift_q : !llhd.sig<i1>, !llhd.sig<i16>), ^body
^if_true:
    %shift_in.ld = llhd.load %shift_in : !llhd.ptr<i1>
    %21 = llhd.insert_slice %2, %shift_in.ld, 0 : i16, i1
    %22 = llhd.extract_slice %shift_q.prb, 0 : i16 -> i15
    %concat = llhd.insert_slice %21, %22, 1 : i16, i15
    llhd.drv %shift_d, %concat after %19 : !llhd.sig<i16>
    br ^if_exit
}

llhd.proc @lfsr_16bit.param4.always_ff.1474.4(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %shift_d: !llhd.sig<i16>) -> (%shift_q: !llhd.sig<i16> ) {
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
    %8 = llhd.const 0 : i16
    llhd.drv %shift_q, %8 after %7 : !llhd.sig<i16>
    br ^init
}

llhd.proc @lfsr_16bit.param4.initial.1492.4() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param4(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %shift_d = llhd.sig "shift_d" %0 : i16
    %shift_q = llhd.sig "shift_q" %0 : i16
    llhd.inst "inst" @lfsr_16bit.param4.always_comb.1433.4(%en_i, %shift_q) -> (%out_o, %shift_d) : (!llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param4.always_ff.1474.4(%clk_i, %rst_ni, %shift_d) -> (%shift_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param4.initial.1492.4() -> () : () -> ()
}

llhd.proc @stream_delay.param1.always_comb.400.1(%valid_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>, %state_q: !llhd.sig<i2>, %count_out: !llhd.sig<i4>, %counter_load: !llhd.sig<i4>) -> (%ready_o: !llhd.sig<i1> , %valid_o: !llhd.sig<i1> , %state_d: !llhd.sig<i2> , %load: !llhd.sig<i1> , %en: !llhd.sig<i1> ) {
    br ^body
^body:
    %state_q.prb = llhd.prb %state_q : !llhd.sig<i2>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %state_q.prb after %0 : !llhd.sig<i2>
    %1 = llhd.const 0 : i1
    llhd.drv %valid_o, %1 after %0 : !llhd.sig<i1>
    llhd.drv %ready_o, %1 after %0 : !llhd.sig<i1>
    llhd.drv %load, %1 after %0 : !llhd.sig<i1>
    llhd.drv %en, %1 after %0 : !llhd.sig<i1>
    %2 = llhd.const 0 : i2
    %3 = llhd.eq %state_q.prb, %2 : i2
    %4 = llhd.const 1 : i2
    %5 = llhd.const 1 : i1
    %6 = llhd.const 0 : i32
    %7 = llhd.const 2 : i2
    %ready_i.prb = llhd.prb %ready_i : !llhd.sig<i1>
    cond_br %3, ^case_body, ^8
^8:
    %9 = llhd.eq %state_q.prb, %4 : i2
    cond_br %9, ^case_body1, ^10
^case_body:
    %valid_i.prb = llhd.prb %valid_i : !llhd.sig<i1>
    %11 = llhd.neq %valid_i.prb, %1 : i1
    cond_br %11, ^if_true, ^check
^check:
    llhd.wait (%valid_i, %ready_i, %state_q, %count_out, %counter_load : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>), ^body
^if_true:
    llhd.drv %load, %5 after %0 : !llhd.sig<i1>
    llhd.drv %state_d, %4 after %0 : !llhd.sig<i2>
    %counter_load.prb = llhd.prb %counter_load : !llhd.sig<i4>
    %zext = llhd.insert_slice %6, %counter_load.prb, 0 : i32, i4
    %12 = llhd.const 1 : i32
    %13 = llhd.eq %zext, %12 : i32
    %14 = llhd.neq %13, %1 : i1
    %15 = llhd.neq %14, %1 : i1
    %16 = llhd.neq %15, %1 : i1
    cond_br %16, ^if_true1, ^if_exit
^10:
    %17 = llhd.eq %state_q.prb, %7 : i2
    cond_br %17, ^case_body2, ^check
^case_body1:
    llhd.drv %en, %5 after %0 : !llhd.sig<i1>
    %count_out.prb = llhd.prb %count_out : !llhd.sig<i4>
    %zext1 = llhd.insert_slice %6, %count_out.prb, 0 : i32, i4
    %18 = llhd.eq %zext1, %6 : i32
    %19 = llhd.neq %18, %1 : i1
    cond_br %19, ^if_true4, ^check
^if_exit:
    %20 = llhd.eq %zext, %6 : i32
    %21 = llhd.neq %20, %1 : i1
    %22 = llhd.neq %21, %1 : i1
    cond_br %22, ^if_true2, ^check
^if_true1:
    llhd.drv %state_d, %7 after %0 : !llhd.sig<i2>
    br ^if_exit
^if_true2:
    llhd.drv %valid_o, %5 after %0 : !llhd.sig<i1>
    llhd.drv %ready_o, %ready_i.prb after %0 : !llhd.sig<i1>
    %23 = llhd.neq %ready_i.prb, %1 : i1
    cond_br %23, ^if_true3, ^if_false
^if_false:
    llhd.drv %state_d, %7 after %0 : !llhd.sig<i2>
    br ^check
^if_true3:
    llhd.drv %state_d, %2 after %0 : !llhd.sig<i2>
    br ^check
^if_true4:
    llhd.drv %state_d, %7 after %0 : !llhd.sig<i2>
    br ^check
^case_body2:
    llhd.drv %valid_o, %5 after %0 : !llhd.sig<i1>
    llhd.drv %ready_o, %ready_i.prb after %0 : !llhd.sig<i1>
    %24 = llhd.neq %ready_i.prb, %1 : i1
    cond_br %24, ^if_true5, ^check
^if_true5:
    llhd.drv %state_d, %2 after %0 : !llhd.sig<i2>
    br ^check
}

llhd.proc @stream_delay.param1.always_ff.540.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %state_d: !llhd.sig<i2>) -> (%state_q: !llhd.sig<i2> ) {
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
    %state_d.prb = llhd.prb %state_d : !llhd.sig<i2>
    llhd.drv %state_q, %state_d.prb after %7 : !llhd.sig<i2>
    br ^init
^if_true:
    %8 = llhd.const 0 : i2
    llhd.drv %state_q, %8 after %7 : !llhd.sig<i2>
    br ^init
}

llhd.entity @stream_delay.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %payload_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>) -> (%ready_o: !llhd.sig<i1> , %payload_o: !llhd.sig<i32> , %valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i2
    %state_d = llhd.sig "state_d" %0 : i2
    %state_q = llhd.sig "state_q" %0 : i2
    %1 = llhd.const 0 : i1
    %load = llhd.sig "load" %1 : i1
    %2 = llhd.const 0 : i4
    %count_out = llhd.sig "count_out" %2 : i4
    %en = llhd.sig "en" %1 : i1
    %counter_load = llhd.sig "counter_load" %2 : i4
    %payload_i.prb = llhd.prb %payload_i : !llhd.sig<i32>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %payload_o, %payload_i.prb after %3 : !llhd.sig<i32>
    %4 = llhd.sig "4" %1 : i1
    %5 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %4, %1 after %5 : !llhd.sig<i1>
    %6 = llhd.const 1 : i1
    %7 = llhd.sig "7" %1 : i1
    llhd.drv %7, %6 after %5 : !llhd.sig<i1>
    %i_counter.overflow_o.default = llhd.sig "i_counter.overflow_o.default" %1 : i1
    llhd.inst "inst" @counter.param2(%clk_i, %rst_ni, %4, %en, %load, %7, %counter_load) -> (%count_out, %i_counter.overflow_o.default) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
    %8 = llhd.const 0 : i16
    %lfsr_out = llhd.sig "lfsr_out" %8 : i16
    %lfsr_out.prb = llhd.prb %lfsr_out : !llhd.sig<i16>
    %9 = llhd.extract_slice %lfsr_out.prb, 0 : i16 -> i4
    llhd.drv %counter_load, %9 after %3 : !llhd.sig<i4>
    llhd.inst "inst1" @lfsr_16bit.param4(%clk_i, %rst_ni, %load) -> (%lfsr_out) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @stream_delay.param1.always_comb.400.1(%valid_i, %ready_i, %state_q, %count_out, %counter_load) -> (%ready_o, %valid_o, %state_d, %load, %en) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst3" @stream_delay.param1.always_ff.540.1(%clk_i, %rst_ni, %state_d) -> (%state_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>) -> (!llhd.sig<i2>)
}

llhd.proc @stream_delay_tb.initial.695.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %7 = llhd.const 600000 : i32
    %loop_count = llhd.var %7 : i32
    br ^loop_body
^loop_body:
    %8 = llhd.load %loop_count : !llhd.ptr<i32>
    %9 = llhd.const 0 : i32
    %10 = llhd.neq %8, %9 : i32
    cond_br %10, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    %11 = llhd.const 1 : i1
    %12 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %11 after %12 : !llhd.sig<i1>
    %13 = llhd.const 0 : i1
    %14 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %13 after %14 : !llhd.sig<i1>
    llhd.wait  for %14, ^15
^15:
    %16 = llhd.load %loop_count : !llhd.ptr<i32>
    llhd.store %loop_count, %16 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.proc @stream_delay_tb.always.725.0(%clk_i: !llhd.sig<i1>, %ready_o: !llhd.sig<i1>) -> (%payload_i: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = llhd.prb %payload_i : !llhd.sig<i32>
    %payload_i.shadow = llhd.var %1 : i32
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %payload_i : !llhd.sig<i32>
    llhd.store %payload_i.shadow, %2 : !llhd.ptr<i32>
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i.prb, %3 : i1
    %5 = llhd.neq %clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %ready_o.prb = llhd.prb %ready_o : !llhd.sig<i1>
    %iff = llhd.and %posedge, %ready_o.prb : i1
    cond_br %iff, ^event, ^init
^event:
    %payload_i.shadow.ld = llhd.load %payload_i.shadow : !llhd.ptr<i32>
    %6 = llhd.const 1 : i32
    %7 = addi %payload_i.shadow.ld, %6 : i32
    %8 = llhd.const #llhd.time<500ps, 0d, 0e> : !llhd.time
    llhd.drv %payload_i, %7 after %8 : !llhd.sig<i32>
    br ^0
}

llhd.entity @stream_delay_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %2 = llhd.const 0 : i32
    %payload_i = llhd.sig "payload_i" %2 : i32
    %ready_o = llhd.sig "ready_o" %0 : i1
    %valid_i = llhd.sig "valid_i" %0 : i1
    %payload_o = llhd.sig "payload_o" %2 : i32
    %ready_i = llhd.sig "ready_i" %0 : i1
    %valid_o = llhd.sig "valid_o" %0 : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_i, %1 after %3 : !llhd.sig<i1>
    %valid_o.prb = llhd.prb %valid_o : !llhd.sig<i1>
    llhd.drv %ready_i, %valid_o.prb after %3 : !llhd.sig<i1>
    llhd.inst "inst" @stream_delay.param1(%clk_i, %rst_ni, %payload_i, %valid_i, %ready_i) -> (%ready_o, %payload_o, %valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @stream_delay_tb.initial.695.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst2" @stream_delay_tb.always.725.0(%clk_i, %ready_o) -> (%payload_i) : (!llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
}
