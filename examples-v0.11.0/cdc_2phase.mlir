llhd.proc @cdc_2phase_src.param2.always_ff.287.2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %ready_o: !llhd.sig<i1>) -> (%req_src_q: !llhd.sig<i1> , %data_src_q: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = llhd.prb %req_src_q : !llhd.sig<i1>
    %req_src_q.shadow = llhd.var %1 : i1
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %req_src_q : !llhd.sig<i1>
    llhd.store %req_src_q.shadow, %2 : !llhd.ptr<i1>
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i.prb, %3 : i1
    %5 = llhd.neq %clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %rst_ni.prb1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %6 = llhd.neq %rst_ni.prb, %3 : i1
    %7 = llhd.eq %rst_ni.prb1, %3 : i1
    %negedge = llhd.and %7, %6 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %8 = llhd.neq %rst_ni.prb1, %3 : i1
    %9 = llhd.not %8 : i1
    %10 = llhd.neq %9, %3 : i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %10, ^if_true, ^if_false
^if_false:
    %valid_i.prb = llhd.prb %valid_i : !llhd.sig<i1>
    %12 = llhd.neq %valid_i.prb, %3 : i1
    %ready_o.prb = llhd.prb %ready_o : !llhd.sig<i1>
    %13 = llhd.neq %ready_o.prb, %3 : i1
    %14 = llhd.and %12, %13 : i1
    %15 = llhd.neq %14, %3 : i1
    cond_br %15, ^if_true1, ^0
^if_true:
    llhd.drv %req_src_q, %3 after %11 : !llhd.sig<i1>
    %16 = llhd.const 0 : i32
    llhd.drv %data_src_q, %16 after %11 : !llhd.sig<i32>
    br ^0
^if_true1:
    %req_src_q.shadow.ld = llhd.load %req_src_q.shadow : !llhd.ptr<i1>
    %17 = llhd.not %req_src_q.shadow.ld : i1
    llhd.drv %req_src_q, %17 after %11 : !llhd.sig<i1>
    %data_i.prb = llhd.prb %data_i : !llhd.sig<i32>
    llhd.drv %data_src_q, %data_i.prb after %11 : !llhd.sig<i32>
    br ^0
}

llhd.proc @cdc_2phase_src.param2.always_ff.348.2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %async_ack_i: !llhd.sig<i1>) -> (%ack_src_q: !llhd.sig<i1> , %ack_q: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %ack_src_q : !llhd.sig<i1>
    %ack_src_q.shadow = llhd.var %1 : i1
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %ack_src_q : !llhd.sig<i1>
    llhd.store %ack_src_q.shadow, %2 : !llhd.ptr<i1>
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i.prb, %3 : i1
    %5 = llhd.neq %clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %rst_ni.prb1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %6 = llhd.neq %rst_ni.prb, %3 : i1
    %7 = llhd.eq %rst_ni.prb1, %3 : i1
    %negedge = llhd.and %7, %6 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %8 = llhd.neq %rst_ni.prb1, %3 : i1
    %9 = llhd.not %8 : i1
    %10 = llhd.neq %9, %3 : i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %10, ^if_true, ^if_false
^if_false:
    %async_ack_i.prb = llhd.prb %async_ack_i : !llhd.sig<i1>
    llhd.drv %ack_src_q, %async_ack_i.prb after %11 : !llhd.sig<i1>
    %ack_src_q.shadow.ld = llhd.load %ack_src_q.shadow : !llhd.ptr<i1>
    llhd.drv %ack_q, %ack_src_q.shadow.ld after %11 : !llhd.sig<i1>
    br ^0
^if_true:
    llhd.drv %ack_src_q, %3 after %11 : !llhd.sig<i1>
    llhd.drv %ack_q, %3 after %11 : !llhd.sig<i1>
    br ^0
}

llhd.entity @cdc_2phase_src.param2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %async_ack_i: !llhd.sig<i1>) -> (%ready_o: !llhd.sig<i1> , %async_req_o: !llhd.sig<i1> , %async_data_o: !llhd.sig<i32> ) {
    %0 = llhd.const 0 : i1
    %req_src_q = llhd.sig "req_src_q" %0 : i1
    %ack_src_q = llhd.sig "ack_src_q" %0 : i1
    %ack_q = llhd.sig "ack_q" %0 : i1
    %1 = llhd.const 0 : i32
    %data_src_q = llhd.sig "data_src_q" %1 : i32
    %req_src_q.prb = llhd.prb %req_src_q : !llhd.sig<i1>
    %ack_q.prb = llhd.prb %ack_q : !llhd.sig<i1>
    %2 = llhd.eq %req_src_q.prb, %ack_q.prb : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_o, %2 after %3 : !llhd.sig<i1>
    llhd.drv %async_req_o, %req_src_q.prb after %3 : !llhd.sig<i1>
    %data_src_q.prb = llhd.prb %data_src_q : !llhd.sig<i32>
    llhd.drv %async_data_o, %data_src_q.prb after %3 : !llhd.sig<i32>
    llhd.inst "inst" @cdc_2phase_src.param2.always_ff.287.2(%rst_ni, %clk_i, %data_i, %valid_i, %ready_o) -> (%req_src_q, %data_src_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>)
    llhd.inst "inst1" @cdc_2phase_src.param2.always_ff.348.2(%rst_ni, %clk_i, %async_ack_i) -> (%ack_src_q, %ack_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @cdc_2phase_dst.param3.always_ff.483.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %valid_o: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>) -> (%ack_dst_q: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %ack_dst_q : !llhd.sig<i1>
    %ack_dst_q.shadow = llhd.var %1 : i1
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %ack_dst_q : !llhd.sig<i1>
    llhd.store %ack_dst_q.shadow, %2 : !llhd.ptr<i1>
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i.prb, %3 : i1
    %5 = llhd.neq %clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %rst_ni.prb1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %6 = llhd.neq %rst_ni.prb, %3 : i1
    %7 = llhd.eq %rst_ni.prb1, %3 : i1
    %negedge = llhd.and %7, %6 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %8 = llhd.neq %rst_ni.prb1, %3 : i1
    %9 = llhd.not %8 : i1
    %10 = llhd.neq %9, %3 : i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %10, ^if_true, ^if_false
^if_false:
    %valid_o.prb = llhd.prb %valid_o : !llhd.sig<i1>
    %12 = llhd.neq %valid_o.prb, %3 : i1
    %ready_i.prb = llhd.prb %ready_i : !llhd.sig<i1>
    %13 = llhd.neq %ready_i.prb, %3 : i1
    %14 = llhd.and %12, %13 : i1
    %15 = llhd.neq %14, %3 : i1
    cond_br %15, ^if_true1, ^0
^if_true:
    llhd.drv %ack_dst_q, %3 after %11 : !llhd.sig<i1>
    br ^0
^if_true1:
    %ack_dst_q.shadow.ld = llhd.load %ack_dst_q.shadow : !llhd.ptr<i1>
    %16 = llhd.not %ack_dst_q.shadow.ld : i1
    llhd.drv %ack_dst_q, %16 after %11 : !llhd.sig<i1>
    br ^0
}

llhd.proc @cdc_2phase_dst.param3.always_ff.535.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %valid_o: !llhd.sig<i1>, %async_data_i: !llhd.sig<i32>, %req_q0: !llhd.sig<i1>, %req_q1: !llhd.sig<i1>) -> (%data_dst_q: !llhd.sig<i32> ) {
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
    %req_q0.prb = llhd.prb %req_q0 : !llhd.sig<i1>
    %req_q1.prb = llhd.prb %req_q1 : !llhd.sig<i1>
    %9 = llhd.neq %req_q0.prb, %req_q1.prb : i1
    %10 = llhd.neq %9, %0 : i1
    %valid_o.prb = llhd.prb %valid_o : !llhd.sig<i1>
    %11 = llhd.neq %valid_o.prb, %0 : i1
    %12 = llhd.not %11 : i1
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %10, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.const 0 : i32
    llhd.drv %data_dst_q, %16 after %8 : !llhd.sig<i32>
    br ^init
^if_true1:
    %async_data_i.prb = llhd.prb %async_data_i : !llhd.sig<i32>
    llhd.drv %data_dst_q, %async_data_i.prb after %8 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_2phase_dst.param3.always_ff.618.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %async_req_i: !llhd.sig<i1>) -> (%req_dst_q: !llhd.sig<i1> , %req_q0: !llhd.sig<i1> , %req_q1: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %req_q0 : !llhd.sig<i1>
    %req_q0.shadow = llhd.var %1 : i1
    %2 = llhd.prb %req_dst_q : !llhd.sig<i1>
    %req_dst_q.shadow = llhd.var %2 : i1
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %3 = llhd.prb %req_q0 : !llhd.sig<i1>
    llhd.store %req_q0.shadow, %3 : !llhd.ptr<i1>
    %4 = llhd.prb %req_dst_q : !llhd.sig<i1>
    llhd.store %req_dst_q.shadow, %4 : !llhd.ptr<i1>
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %5 = llhd.const 0 : i1
    %6 = llhd.eq %clk_i.prb, %5 : i1
    %7 = llhd.neq %clk_i.prb1, %5 : i1
    %posedge = llhd.and %6, %7 : i1
    %rst_ni.prb1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %8 = llhd.neq %rst_ni.prb, %5 : i1
    %9 = llhd.eq %rst_ni.prb1, %5 : i1
    %negedge = llhd.and %9, %8 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %10 = llhd.neq %rst_ni.prb1, %5 : i1
    %11 = llhd.not %10 : i1
    %12 = llhd.neq %11, %5 : i1
    %13 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %12, ^if_true, ^if_false
^if_false:
    %async_req_i.prb = llhd.prb %async_req_i : !llhd.sig<i1>
    llhd.drv %req_dst_q, %async_req_i.prb after %13 : !llhd.sig<i1>
    %req_dst_q.shadow.ld = llhd.load %req_dst_q.shadow : !llhd.ptr<i1>
    llhd.drv %req_q0, %req_dst_q.shadow.ld after %13 : !llhd.sig<i1>
    %req_q0.shadow.ld = llhd.load %req_q0.shadow : !llhd.ptr<i1>
    llhd.drv %req_q1, %req_q0.shadow.ld after %13 : !llhd.sig<i1>
    br ^0
^if_true:
    llhd.drv %req_dst_q, %5 after %13 : !llhd.sig<i1>
    llhd.drv %req_q0, %5 after %13 : !llhd.sig<i1>
    llhd.drv %req_q1, %5 after %13 : !llhd.sig<i1>
    br ^0
}

llhd.entity @cdc_2phase_dst.param3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>, %async_req_i: !llhd.sig<i1>, %async_data_i: !llhd.sig<i32>) -> (%data_o: !llhd.sig<i32> , %valid_o: !llhd.sig<i1> , %async_ack_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i1
    %req_dst_q = llhd.sig "req_dst_q" %0 : i1
    %req_q0 = llhd.sig "req_q0" %0 : i1
    %req_q1 = llhd.sig "req_q1" %0 : i1
    %ack_dst_q = llhd.sig "ack_dst_q" %0 : i1
    %1 = llhd.const 0 : i32
    %data_dst_q = llhd.sig "data_dst_q" %1 : i32
    %ack_dst_q.prb = llhd.prb %ack_dst_q : !llhd.sig<i1>
    %req_q1.prb = llhd.prb %req_q1 : !llhd.sig<i1>
    %2 = llhd.neq %ack_dst_q.prb, %req_q1.prb : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_o, %2 after %3 : !llhd.sig<i1>
    %data_dst_q.prb = llhd.prb %data_dst_q : !llhd.sig<i32>
    llhd.drv %data_o, %data_dst_q.prb after %3 : !llhd.sig<i32>
    llhd.drv %async_ack_o, %ack_dst_q.prb after %3 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase_dst.param3.always_ff.483.3(%rst_ni, %clk_i, %valid_o, %ready_i) -> (%ack_dst_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst1" @cdc_2phase_dst.param3.always_ff.535.3(%rst_ni, %clk_i, %valid_o, %async_data_i, %req_q0, %req_q1) -> (%data_dst_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst2" @cdc_2phase_dst.param3.always_ff.618.3(%rst_ni, %clk_i, %async_req_i) -> (%req_dst_q, %req_q0, %req_q1) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.entity @cdc_2phase.param1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_data_i: !llhd.sig<i32>, %src_valid_i: !llhd.sig<i1>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%src_ready_o: !llhd.sig<i1> , %dst_data_o: !llhd.sig<i32> , %dst_valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i1
    %async_req = llhd.sig "async_req" %0 : i1
    %async_ack = llhd.sig "async_ack" %0 : i1
    %1 = llhd.const 0 : i32
    %async_data = llhd.sig "async_data" %1 : i32
    llhd.inst "inst" @cdc_2phase_src.param2(%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i, %async_ack) -> (%src_ready_o, %async_req, %async_data) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>)
    llhd.inst "inst1" @cdc_2phase_dst.param3(%dst_rst_ni, %dst_clk_i, %dst_ready_i, %async_req, %async_data) -> (%dst_data_o, %dst_valid_o, %async_ack) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @cdc_2phase_tb.initial.903.0(%src_ready_o: !llhd.sig<i1>) -> (%src_rst_ni: !llhd.sig<i1> , %src_clk_i: !llhd.sig<i1> , %src_data_i: !llhd.sig<i32> , %src_valid_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %3, ^4
^4:
    %5 = llhd.const 1 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %7, ^8
^8:
    %9 = llhd.const 0 : i32
    %i = llhd.var %9 : i32
    br ^loop_body
^loop_body:
    %i.ld = llhd.load %i : !llhd.ptr<i32>
    %10 = llhd.const 500000 : i32
    %11 = cmpi "slt", %i.ld, %10 : i32
    cond_br %11, ^loop_body1, ^loop_exit
^loop_exit:
    llhd.halt
^loop_body1:
    %src_ready_o.prb = llhd.prb %src_ready_o : !llhd.sig<i1>
    %12 = llhd.const 0 : i1
    %13 = llhd.neq %src_ready_o.prb, %12 : i1
    %14 = llhd.not %13 : i1
    %15 = llhd.neq %14, %12 : i1
    %16 = llhd.const 1 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %18 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %15, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %src_clk_i, %16 after %17 : !llhd.sig<i1>
    %i.ld1 = llhd.load %i : !llhd.ptr<i32>
    llhd.drv %src_data_i, %i.ld1 after %17 : !llhd.sig<i32>
    llhd.drv %src_valid_i, %16 after %17 : !llhd.sig<i1>
    llhd.wait  for %18, ^19
^loop_continue:
    llhd.drv %src_clk_i, %16 after %17 : !llhd.sig<i1>
    llhd.wait  for %18, ^20
^19:
    %21 = llhd.const 0 : i1
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %21 after %22 : !llhd.sig<i1>
    %23 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %23, ^24
^20:
    %25 = llhd.const 0 : i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %25 after %26 : !llhd.sig<i1>
    %27 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %27, ^28
^28:
    br ^loop_body1
^24:
    %i.ld2 = llhd.load %i : !llhd.ptr<i32>
    %29 = llhd.const 1 : i32
    %30 = addi %i.ld2, %29 : i32
    llhd.store %i, %30 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.proc @cdc_2phase_tb.initial.1048.0(%dst_data_o: !llhd.sig<i32>, %dst_valid_o: !llhd.sig<i1>) -> (%ERRORS: !llhd.sig<i32> , %dst_rst_ni: !llhd.sig<i1> , %dst_clk_i: !llhd.sig<i1> , %dst_ready_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %3, ^4
^4:
    %5 = llhd.const 1 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %7, ^8
^8:
    %9 = llhd.const 1 : i1
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_ready_i, %9 after %10 : !llhd.sig<i1>
    %11 = llhd.const 0 : i32
    %i = llhd.var %11 : i32
    br ^loop_body
^loop_body:
    %i.ld = llhd.load %i : !llhd.ptr<i32>
    %12 = llhd.const 500000 : i32
    %13 = cmpi "slt", %i.ld, %12 : i32
    cond_br %13, ^loop_body1, ^loop_exit
^loop_exit:
    llhd.halt
^loop_body1:
    %dst_valid_o.prb = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %14 = llhd.const 0 : i1
    %15 = llhd.neq %dst_valid_o.prb, %14 : i1
    %16 = llhd.not %15 : i1
    %17 = llhd.neq %16, %14 : i1
    %18 = llhd.const 1 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %20 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %17, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %dst_clk_i, %18 after %19 : !llhd.sig<i1>
    %21 = llhd.const 0 : i32
    %i.ld1 = llhd.load %i : !llhd.ptr<i32>
    %dst_data_o.prb = llhd.prb %dst_data_o : !llhd.sig<i32>
    %22 = llhd.neq %i.ld1, %dst_data_o.prb : i32
    %zext = llhd.insert_slice %21, %22, 0 : i32, i1
    %ERRORS.prb = llhd.prb %ERRORS : !llhd.sig<i32>
    %23 = addi %ERRORS.prb, %zext : i32
    llhd.drv %ERRORS, %23 after %19 : !llhd.sig<i32>
    llhd.wait  for %20, ^24
^loop_continue:
    llhd.drv %dst_clk_i, %18 after %19 : !llhd.sig<i1>
    llhd.wait  for %20, ^25
^24:
    %26 = llhd.const 0 : i1
    %27 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %26 after %27 : !llhd.sig<i1>
    %28 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %28, ^29
^25:
    %30 = llhd.const 0 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %32, ^33
^33:
    br ^loop_body1
^29:
    %i.ld2 = llhd.load %i : !llhd.ptr<i32>
    %34 = llhd.const 1 : i32
    %35 = addi %i.ld2, %34 : i32
    llhd.store %i, %35 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.entity @cdc_2phase_tb() -> () {
    %0 = llhd.const 0 : i32
    %ERRORS = llhd.sig "ERRORS" %0 : i32
    %1 = llhd.const 1 : i1
    %src_rst_ni = llhd.sig "src_rst_ni" %1 : i1
    %2 = llhd.const 0 : i1
    %src_clk_i = llhd.sig "src_clk_i" %2 : i1
    %src_data_i = llhd.sig "src_data_i" %0 : i32
    %src_valid_i = llhd.sig "src_valid_i" %2 : i1
    %src_ready_o = llhd.sig "src_ready_o" %2 : i1
    %dst_rst_ni = llhd.sig "dst_rst_ni" %1 : i1
    %dst_clk_i = llhd.sig "dst_clk_i" %2 : i1
    %dst_data_o = llhd.sig "dst_data_o" %0 : i32
    %dst_valid_o = llhd.sig "dst_valid_o" %2 : i1
    %dst_ready_i = llhd.sig "dst_ready_i" %2 : i1
    llhd.inst "inst" @cdc_2phase.param1(%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i, %dst_rst_ni, %dst_clk_i, %dst_ready_i) -> (%src_ready_o, %dst_data_o, %dst_valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @cdc_2phase_tb.initial.903.0(%src_ready_o) -> (%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst2" @cdc_2phase_tb.initial.1048.0(%dst_data_o, %dst_valid_o) -> (%ERRORS, %dst_rst_ni, %dst_clk_i, %dst_ready_i) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
