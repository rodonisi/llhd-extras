llhd.proc @delta_counter.param3.always_comb.1233.3(%counter_q: !llhd.sig<i5>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %delta_i: !llhd.sig<i4>, %d_i: !llhd.sig<i4>) -> (%counter_d: !llhd.sig<i5> ) {
    br ^body
^body:
    %counter_q1 = llhd.prb %counter_q : !llhd.sig<i5>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %counter_d, %counter_q1 after %0 : !llhd.sig<i5>
    %clear_i1 = llhd.prb %clear_i : !llhd.sig<i1>
    %1 = constant 0 : i1
    %2 = cmpi "ne", %clear_i1, %1 : i1
    %3 = constant 0 : i5
    cond_br %2, ^if_true, ^if_false
^if_false:
    %load_i1 = llhd.prb %load_i : !llhd.sig<i1>
    %4 = cmpi "ne", %load_i1, %1 : i1
    cond_br %4, ^if_true1, ^if_false1
^if_true:
    llhd.drv %counter_d, %3 after %0 : !llhd.sig<i5>
    br ^check
^check:
    llhd.wait (%counter_q, %clear_i, %en_i, %load_i, %down_i, %delta_i, %d_i : !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>), ^body
^if_false1:
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %5 = cmpi "ne", %en_i1, %1 : i1
    cond_br %5, ^if_true2, ^check
^if_true1:
    %d_i1 = llhd.prb %d_i : !llhd.sig<i4>
    %6 = llhd.insert_slice %3, %d_i1, 0 : i5, i4
    %7 = llhd.insert_slice %6, %1, 4 : i5, i1
    llhd.drv %counter_d, %7 after %0 : !llhd.sig<i5>
    br ^check
^if_true2:
    %down_i1 = llhd.prb %down_i : !llhd.sig<i1>
    %8 = cmpi "ne", %down_i1, %1 : i1
    %delta_i1 = llhd.prb %delta_i : !llhd.sig<i4>
    cond_br %8, ^if_true3, ^if_false2
^if_false2:
    %9 = llhd.insert_slice %3, %delta_i1, 0 : i5, i4
    %10 = addi %counter_q1, %9 : i5
    llhd.drv %counter_d, %10 after %0 : !llhd.sig<i5>
    br ^check
^if_true3:
    %11 = llhd.insert_slice %3, %delta_i1, 0 : i5, i4
    %12 = subi %counter_q1, %11 : i5
    llhd.drv %counter_d, %12 after %0 : !llhd.sig<i5>
    br ^check
}

llhd.proc @delta_counter.param3.always_ff.1272.3(%counter_d: !llhd.sig<i5>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>) -> (%counter_q: !llhd.sig<i5> ) {
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
    %5 = cmpi "ne", %rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %counter_d1 = llhd.prb %counter_d : !llhd.sig<i5>
    llhd.drv %counter_q, %counter_d1 after %8 : !llhd.sig<i5>
    br ^init
^if_true:
    %9 = constant 0 : i5
    llhd.drv %counter_q, %9 after %8 : !llhd.sig<i5>
    br ^init
}

llhd.entity @delta_counter.param3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %delta_i: !llhd.sig<i4>, %d_i: !llhd.sig<i4>) -> (%q_o: !llhd.sig<i4> , %overflow_o: !llhd.sig<i1> ) {
    %0 = constant 0 : i5
    %counter_q = llhd.sig "sig" %0 : i5
    %counter_d = llhd.sig "sig1" %0 : i5
    %counter_q1 = llhd.prb %counter_q : !llhd.sig<i5>
    %1 = llhd.extract_slice %counter_q1, 0 : i5 -> i4
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %q_o, %1 after %2 : !llhd.sig<i4>
    %3 = llhd.extract_slice %counter_q1, 4 : i5 -> i1
    %4 = llhd.insert_slice %0, %3, 0 : i5, i1
    %5 = llhd.extract_slice %4, 0 : i5 -> i1
    llhd.drv %overflow_o, %5 after %2 : !llhd.sig<i1>
    llhd.inst "delta_counter.param3.always_comb.1233.3" @delta_counter.param3.always_comb.1233.3(%counter_q, %clear_i, %en_i, %load_i, %down_i, %delta_i, %d_i) -> (%counter_d) : (!llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i5>)
    llhd.inst "delta_counter.param3.always_ff.1272.3" @delta_counter.param3.always_ff.1272.3(%counter_d, %clk_i, %rst_ni) -> (%counter_q) : (!llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i5>)
}

llhd.entity @counter.param2(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clear_i: !llhd.sig<i1>, %en_i: !llhd.sig<i1>, %load_i: !llhd.sig<i1>, %down_i: !llhd.sig<i1>, %d_i: !llhd.sig<i4>) -> (%q_o: !llhd.sig<i4> , %overflow_o: !llhd.sig<i1> ) {
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = llhd.sig "sig" %0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1, %clk_i1 after %2 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %3 = llhd.sig "sig1" %0 : i1
    llhd.drv %3, %rst_ni1 after %2 : !llhd.sig<i1>
    %clear_i1 = llhd.prb %clear_i : !llhd.sig<i1>
    %4 = llhd.sig "sig2" %0 : i1
    llhd.drv %4, %clear_i1 after %2 : !llhd.sig<i1>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %5 = llhd.sig "sig3" %0 : i1
    llhd.drv %5, %en_i1 after %2 : !llhd.sig<i1>
    %load_i1 = llhd.prb %load_i : !llhd.sig<i1>
    %6 = llhd.sig "sig4" %0 : i1
    llhd.drv %6, %load_i1 after %2 : !llhd.sig<i1>
    %down_i1 = llhd.prb %down_i : !llhd.sig<i1>
    %7 = llhd.sig "sig5" %0 : i1
    llhd.drv %7, %down_i1 after %2 : !llhd.sig<i1>
    %8 = constant 1 : i4
    %9 = constant 0 : i4
    %10 = llhd.sig "sig6" %9 : i4
    llhd.drv %10, %8 after %2 : !llhd.sig<i4>
    %d_i1 = llhd.prb %d_i : !llhd.sig<i4>
    %11 = llhd.sig "sig7" %9 : i4
    llhd.drv %11, %d_i1 after %2 : !llhd.sig<i4>
    llhd.inst "delta_counter.param3" @delta_counter.param3(%1, %3, %4, %5, %6, %7, %10, %11) -> (%q_o, %overflow_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
}

llhd.proc @lfsr_16bit.param4.always_comb.1432.4(%shift_q: !llhd.sig<i16>, %en_i: !llhd.sig<i1>) -> (%shift_d: !llhd.sig<i16> , %out_o: !llhd.sig<i16> ) {
    br ^body
^body:
    %shift_q1 = llhd.prb %shift_q : !llhd.sig<i16>
    %0 = llhd.extract_slice %shift_q1, 15 : i16 -> i1
    %1 = constant 0 : i16
    %2 = llhd.insert_slice %1, %0, 0 : i16, i1
    %3 = llhd.extract_slice %2, 0 : i16 -> i1
    %4 = llhd.extract_slice %shift_q1, 12 : i16 -> i4
    %5 = llhd.insert_slice %1, %4, 0 : i16, i4
    %6 = llhd.extract_slice %5, 0 : i16 -> i1
    %7 = llhd.xor %3, %6 : i1
    %8 = llhd.extract_slice %shift_q1, 5 : i16 -> i11
    %9 = llhd.insert_slice %1, %8, 0 : i16, i11
    %10 = llhd.extract_slice %9, 0 : i16 -> i1
    %11 = llhd.xor %7, %10 : i1
    %12 = llhd.extract_slice %shift_q1, 1 : i16 -> i15
    %13 = llhd.insert_slice %1, %12, 0 : i16, i15
    %14 = llhd.extract_slice %13, 0 : i16 -> i1
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
    %21 = llhd.insert_slice %1, %18, 0 : i16, i1
    %22 = llhd.extract_slice %shift_q1, 0 : i16 -> i15
    %23 = llhd.insert_slice %21, %22, 1 : i16, i15
    llhd.drv %shift_d, %23 after %19 : !llhd.sig<i16>
    br ^if_exit
}

llhd.proc @lfsr_16bit.param4.always_ff.1473.4(%shift_d: !llhd.sig<i16>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>) -> (%shift_q: !llhd.sig<i16> ) {
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
    %8 = constant 0 : i16
    llhd.drv %shift_q, %8 after %7 : !llhd.sig<i16>
    br ^init
}

llhd.proc @lfsr_16bit.param4.initial.1491.4() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param4(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = constant 0 : i16
    %shift_d = llhd.sig "sig" %0 : i16
    %shift_q = llhd.sig "sig1" %0 : i16
    llhd.inst "lfsr_16bit.param4.always_comb.1432.4" @lfsr_16bit.param4.always_comb.1432.4(%shift_q, %en_i) -> (%shift_d, %out_o) : (!llhd.sig<i16>, !llhd.sig<i1>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "lfsr_16bit.param4.always_ff.1473.4" @lfsr_16bit.param4.always_ff.1473.4(%shift_d, %clk_i, %rst_ni) -> (%shift_q) : (!llhd.sig<i16>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "lfsr_16bit.param4.initial.1491.4" @lfsr_16bit.param4.initial.1491.4() -> () : () -> ()
}

llhd.proc @stream_delay.param1.always_comb.399.1(%state_q: !llhd.sig<i2>, %count_out: !llhd.sig<i4>, %counter_load: !llhd.sig<i4>, %valid_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>) -> (%state_d: !llhd.sig<i2> , %load: !llhd.sig<i1> , %en: !llhd.sig<i1> , %ready_o: !llhd.sig<i1> , %valid_o: !llhd.sig<i1> ) {
    br ^body
^body:
    %state_q1 = llhd.prb %state_q : !llhd.sig<i2>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %state_d, %state_q1 after %0 : !llhd.sig<i2>
    %1 = constant 0 : i1
    llhd.drv %valid_o, %1 after %0 : !llhd.sig<i1>
    llhd.drv %ready_o, %1 after %0 : !llhd.sig<i1>
    llhd.drv %load, %1 after %0 : !llhd.sig<i1>
    llhd.drv %en, %1 after %0 : !llhd.sig<i1>
    %2 = constant 0 : i2
    %3 = cmpi "eq", %state_q1, %2 : i2
    %4 = constant 1 : i2
    %5 = constant 1 : i1
    %6 = constant 0 : i32
    %7 = constant 2 : i2
    %ready_i1 = llhd.prb %ready_i : !llhd.sig<i1>
    cond_br %3, ^case_body, ^8
^8:
    %9 = cmpi "eq", %state_q1, %4 : i2
    cond_br %9, ^case_body1, ^10
^case_body:
    %valid_i1 = llhd.prb %valid_i : !llhd.sig<i1>
    %11 = cmpi "ne", %valid_i1, %1 : i1
    cond_br %11, ^if_true, ^check
^check:
    llhd.wait (%state_q, %count_out, %counter_load, %valid_i, %ready_i : !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>), ^body
^if_true:
    llhd.drv %load, %5 after %0 : !llhd.sig<i1>
    llhd.drv %state_d, %4 after %0 : !llhd.sig<i2>
    %counter_load1 = llhd.prb %counter_load : !llhd.sig<i4>
    %12 = llhd.insert_slice %6, %counter_load1, 0 : i32, i4
    %13 = constant 1 : i32
    %14 = cmpi "eq", %12, %13 : i32
    %15 = cmpi "ne", %14, %1 : i1
    %16 = cmpi "ne", %15, %1 : i1
    %17 = cmpi "ne", %16, %1 : i1
    cond_br %17, ^if_true1, ^if_exit
^10:
    %18 = cmpi "eq", %state_q1, %7 : i2
    cond_br %18, ^case_body2, ^check
^case_body1:
    llhd.drv %en, %5 after %0 : !llhd.sig<i1>
    %count_out1 = llhd.prb %count_out : !llhd.sig<i4>
    %19 = llhd.insert_slice %6, %count_out1, 0 : i32, i4
    %20 = cmpi "eq", %19, %6 : i32
    %21 = cmpi "ne", %20, %1 : i1
    cond_br %21, ^if_true4, ^check
^if_exit:
    %22 = cmpi "eq", %12, %6 : i32
    %23 = cmpi "ne", %22, %1 : i1
    %24 = cmpi "ne", %23, %1 : i1
    cond_br %24, ^if_true2, ^check
^if_true1:
    llhd.drv %state_d, %7 after %0 : !llhd.sig<i2>
    br ^if_exit
^if_true2:
    llhd.drv %valid_o, %5 after %0 : !llhd.sig<i1>
    llhd.drv %ready_o, %ready_i1 after %0 : !llhd.sig<i1>
    %25 = cmpi "ne", %ready_i1, %1 : i1
    cond_br %25, ^if_true3, ^if_false
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
    llhd.drv %ready_o, %ready_i1 after %0 : !llhd.sig<i1>
    %26 = cmpi "ne", %ready_i1, %1 : i1
    cond_br %26, ^if_true5, ^check
^if_true5:
    llhd.drv %state_d, %2 after %0 : !llhd.sig<i2>
    br ^check
}

llhd.proc @stream_delay.param1.always_ff.539.1(%state_d: !llhd.sig<i2>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>) -> (%state_q: !llhd.sig<i2> ) {
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
    %state_d1 = llhd.prb %state_d : !llhd.sig<i2>
    llhd.drv %state_q, %state_d1 after %7 : !llhd.sig<i2>
    br ^init
^if_true:
    %8 = constant 0 : i2
    llhd.drv %state_q, %8 after %7 : !llhd.sig<i2>
    br ^init
}

llhd.entity @stream_delay.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %payload_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>) -> (%ready_o: !llhd.sig<i1> , %payload_o: !llhd.sig<i32> , %valid_o: !llhd.sig<i1> ) {
    %0 = constant 0 : i2
    %state_d = llhd.sig "sig" %0 : i2
    %state_q = llhd.sig "sig1" %0 : i2
    %1 = constant 0 : i1
    %load = llhd.sig "sig2" %1 : i1
    %2 = constant 0 : i4
    %count_out = llhd.sig "sig3" %2 : i4
    %en = llhd.sig "sig4" %1 : i1
    %counter_load = llhd.sig "sig5" %2 : i4
    %payload_i1 = llhd.prb %payload_i : !llhd.sig<i32>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %payload_o, %payload_i1 after %3 : !llhd.sig<i32>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %4 = llhd.sig "sig6" %1 : i1
    llhd.drv %4, %clk_i1 after %3 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %5 = llhd.sig "sig7" %1 : i1
    llhd.drv %5, %rst_ni1 after %3 : !llhd.sig<i1>
    %6 = llhd.sig "sig8" %1 : i1
    llhd.drv %6, %1 after %3 : !llhd.sig<i1>
    %en1 = llhd.prb %en : !llhd.sig<i1>
    %7 = llhd.sig "sig9" %1 : i1
    llhd.drv %7, %en1 after %3 : !llhd.sig<i1>
    %load1 = llhd.prb %load : !llhd.sig<i1>
    %8 = llhd.sig "sig10" %1 : i1
    llhd.drv %8, %load1 after %3 : !llhd.sig<i1>
    %9 = constant 1 : i1
    %10 = llhd.sig "sig11" %1 : i1
    llhd.drv %10, %9 after %3 : !llhd.sig<i1>
    %counter_load1 = llhd.prb %counter_load : !llhd.sig<i4>
    %11 = llhd.sig "sig12" %2 : i4
    llhd.drv %11, %counter_load1 after %3 : !llhd.sig<i4>
    %i_counter.overflow_o.default = llhd.sig "sig13" %1 : i1
    llhd.inst "counter.param2" @counter.param2(%4, %5, %6, %7, %8, %10, %11) -> (%count_out, %i_counter.overflow_o.default) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
    %12 = constant 0 : i16
    %lfsr_out = llhd.sig "sig14" %12 : i16
    %lfsr_out1 = llhd.prb %lfsr_out : !llhd.sig<i16>
    %13 = llhd.extract_slice %lfsr_out1, 0 : i16 -> i4
    llhd.drv %counter_load, %13 after %3 : !llhd.sig<i4>
    %14 = llhd.sig "sig15" %1 : i1
    llhd.drv %14, %clk_i1 after %3 : !llhd.sig<i1>
    %15 = llhd.sig "sig16" %1 : i1
    llhd.drv %15, %rst_ni1 after %3 : !llhd.sig<i1>
    %16 = llhd.sig "sig17" %1 : i1
    llhd.drv %16, %load1 after %3 : !llhd.sig<i1>
    llhd.inst "lfsr_16bit.param4" @lfsr_16bit.param4(%14, %15, %16) -> (%lfsr_out) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "stream_delay.param1.always_comb.399.1" @stream_delay.param1.always_comb.399.1(%state_q, %count_out, %counter_load, %valid_i, %ready_i) -> (%state_d, %load, %en, %ready_o, %valid_o) : (!llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i2>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "stream_delay.param1.always_ff.539.1" @stream_delay.param1.always_ff.539.1(%state_d, %clk_i, %rst_ni) -> (%state_q) : (!llhd.sig<i2>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i2>)
}

llhd.proc @stream_delay_tb.initial.694.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %7 = constant 600000 : i32
    br ^loop_body(%7: i32)
^loop_body(%8: i32):
    %9 = constant 0 : i32
    %10 = cmpi "ne", %8, %9 : i32
    cond_br %10, ^loop_continue, ^loop_exit
^11:
    %12 = constant 1 : i32
    %13 = subi %8, %12 : i32
    br ^loop_body(%13: i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %14 = constant 1 : i1
    %15 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %14 after %15 : !llhd.sig<i1>
    %16 = constant 0 : i1
    %17 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %16 after %17 : !llhd.sig<i1>
    llhd.wait  for %17, ^11
}

llhd.proc @stream_delay_tb.always.724.0(%clk_i: !llhd.sig<i1>, %ready_o: !llhd.sig<i1>) -> (%payload_i: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %clk_i1, %0 : i1
    %2 = cmpi "ne", %clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %ready_o1 = llhd.prb %ready_o : !llhd.sig<i1>
    %iff = llhd.and %posedge, %ready_o1 : i1
    cond_br %iff, ^event, ^init
^event:
    %payload_i1 = llhd.prb %payload_i : !llhd.sig<i32>
    %3 = constant 1 : i32
    %4 = addi %payload_i1, %3 : i32
    %5 = llhd.const #llhd.time<500ps, 0d, 0e> : !llhd.time
    llhd.drv %payload_i, %4 after %5 : !llhd.sig<i32>
    br ^init
}

llhd.entity @root () -> () {
    %0 = constant 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = constant 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %2 = constant 0 : i32
    %payload_i = llhd.sig "payload_i" %2 : i32
    %ready_o = llhd.sig "ready_o" %0 : i1
    %valid_i = llhd.sig "valid_i" %0 : i1
    %payload_o = llhd.sig "payload_o" %2 : i32
    %ready_i = llhd.sig "ready_i" %0 : i1
    %valid_o = llhd.sig "valid_o" %0 : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_i, %1 after %3 : !llhd.sig<i1>
    %valid_o1 = llhd.prb %valid_o : !llhd.sig<i1>
    llhd.drv %ready_i, %valid_o1 after %3 : !llhd.sig<i1>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %4 = llhd.sig "sig8" %0 : i1
    llhd.drv %4, %clk_i1 after %3 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %5 = llhd.sig "sig9" %0 : i1
    llhd.drv %5, %rst_ni1 after %3 : !llhd.sig<i1>
    %payload_i1 = llhd.prb %payload_i : !llhd.sig<i32>
    %6 = llhd.sig "sig10" %2 : i32
    llhd.drv %6, %payload_i1 after %3 : !llhd.sig<i32>
    %valid_i1 = llhd.prb %valid_i : !llhd.sig<i1>
    %7 = llhd.sig "sig11" %0 : i1
    llhd.drv %7, %valid_i1 after %3 : !llhd.sig<i1>
    %ready_i1 = llhd.prb %ready_i : !llhd.sig<i1>
    %8 = llhd.sig "sig12" %0 : i1
    llhd.drv %8, %ready_i1 after %3 : !llhd.sig<i1>
    llhd.inst "stream_delay.param1" @stream_delay.param1(%4, %5, %6, %7, %8) -> (%ready_o, %payload_o, %valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "stream_delay_tb.initial.694.0" @stream_delay_tb.initial.694.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "stream_delay_tb.always.724.0" @stream_delay_tb.always.724.0(%clk_i, %ready_o) -> (%payload_i) : (!llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
}
