llhd.proc @cdc_2phase_src.param2.always_ff.287.2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %ready_o: !llhd.sig<i1>) -> (%req_src_q: !llhd.sig<i1> , %data_src_q: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
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
    %valid_i1 = llhd.prb %valid_i : !llhd.sig<i1>
    %9 = cmpi "ne", %valid_i1, %0 : i1
    %ready_o1 = llhd.prb %ready_o : !llhd.sig<i1>
    %10 = cmpi "ne", %ready_o1, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = cmpi "ne", %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    llhd.drv %req_src_q, %0 after %8 : !llhd.sig<i1>
    %13 = llhd.const 0 : i32
    llhd.drv %data_src_q, %13 after %8 : !llhd.sig<i32>
    br ^init
^if_true1:
    %req_src_q1 = llhd.prb %req_src_q : !llhd.sig<i1>
    %14 = llhd.not %req_src_q1 : i1
    llhd.drv %req_src_q, %14 after %8 : !llhd.sig<i1>
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    llhd.drv %data_src_q, %data_i1 after %8 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_2phase_src.param2.always_ff.348.2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %async_ack_i: !llhd.sig<i1>) -> (%ack_src_q: !llhd.sig<i1> , %ack_q: !llhd.sig<i1> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
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
    %async_ack_i1 = llhd.prb %async_ack_i : !llhd.sig<i1>
    llhd.drv %ack_src_q, %async_ack_i1 after %8 : !llhd.sig<i1>
    %ack_src_q1 = llhd.prb %ack_src_q : !llhd.sig<i1>
    llhd.drv %ack_q, %ack_src_q1 after %8 : !llhd.sig<i1>
    br ^init
^if_true:
    llhd.drv %ack_src_q, %0 after %8 : !llhd.sig<i1>
    llhd.drv %ack_q, %0 after %8 : !llhd.sig<i1>
    br ^init
}

llhd.entity @cdc_2phase_src.param2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %async_ack_i: !llhd.sig<i1>) -> (%ready_o: !llhd.sig<i1> , %async_req_o: !llhd.sig<i1> , %async_data_o: !llhd.sig<i32> ) {
    %0 = llhd.const 0 : i1
    %req_src_q = llhd.sig "sig" %0 : i1
    %ack_src_q = llhd.sig "sig1" %0 : i1
    %ack_q = llhd.sig "sig2" %0 : i1
    %1 = llhd.const 0 : i32
    %data_src_q = llhd.sig "sig3" %1 : i32
    %req_src_q1 = llhd.prb %req_src_q : !llhd.sig<i1>
    %ack_q1 = llhd.prb %ack_q : !llhd.sig<i1>
    %2 = cmpi "eq", %req_src_q1, %ack_q1 : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_o, %2 after %3 : !llhd.sig<i1>
    llhd.drv %async_req_o, %req_src_q1 after %3 : !llhd.sig<i1>
    %data_src_q1 = llhd.prb %data_src_q : !llhd.sig<i32>
    llhd.drv %async_data_o, %data_src_q1 after %3 : !llhd.sig<i32>
    llhd.inst "inst" @cdc_2phase_src.param2.always_ff.287.2(%rst_ni, %clk_i, %data_i, %valid_i, %ready_o) -> (%req_src_q, %data_src_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>)
    llhd.inst "inst1" @cdc_2phase_src.param2.always_ff.348.2(%rst_ni, %clk_i, %async_ack_i) -> (%ack_src_q, %ack_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @cdc_2phase_dst.param3.always_ff.483.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %valid_o: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>) -> (%ack_dst_q: !llhd.sig<i1> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
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
    %valid_o1 = llhd.prb %valid_o : !llhd.sig<i1>
    %9 = cmpi "ne", %valid_o1, %0 : i1
    %ready_i1 = llhd.prb %ready_i : !llhd.sig<i1>
    %10 = cmpi "ne", %ready_i1, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = cmpi "ne", %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    llhd.drv %ack_dst_q, %0 after %8 : !llhd.sig<i1>
    br ^init
^if_true1:
    %ack_dst_q1 = llhd.prb %ack_dst_q : !llhd.sig<i1>
    %13 = llhd.not %ack_dst_q1 : i1
    llhd.drv %ack_dst_q, %13 after %8 : !llhd.sig<i1>
    br ^init
}

llhd.proc @cdc_2phase_dst.param3.always_ff.535.3(%req_q0: !llhd.sig<i1>, %req_q1: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %valid_o: !llhd.sig<i1>, %async_data_i: !llhd.sig<i32>) -> (%data_dst_q: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
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
    %req_q01 = llhd.prb %req_q0 : !llhd.sig<i1>
    %req_q11 = llhd.prb %req_q1 : !llhd.sig<i1>
    %9 = cmpi "ne", %req_q01, %req_q11 : i1
    %10 = cmpi "ne", %9, %0 : i1
    %valid_o1 = llhd.prb %valid_o : !llhd.sig<i1>
    %11 = cmpi "ne", %valid_o1, %0 : i1
    %12 = llhd.not %11 : i1
    %13 = cmpi "ne", %12, %0 : i1
    %14 = llhd.and %10, %13 : i1
    %15 = cmpi "ne", %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.const 0 : i32
    llhd.drv %data_dst_q, %16 after %8 : !llhd.sig<i32>
    br ^init
^if_true1:
    %async_data_i1 = llhd.prb %async_data_i : !llhd.sig<i32>
    llhd.drv %data_dst_q, %async_data_i1 after %8 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_2phase_dst.param3.always_ff.618.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %async_req_i: !llhd.sig<i1>) -> (%req_dst_q: !llhd.sig<i1> , %req_q0: !llhd.sig<i1> , %req_q1: !llhd.sig<i1> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
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
    %async_req_i1 = llhd.prb %async_req_i : !llhd.sig<i1>
    llhd.drv %req_dst_q, %async_req_i1 after %8 : !llhd.sig<i1>
    %req_dst_q1 = llhd.prb %req_dst_q : !llhd.sig<i1>
    llhd.drv %req_q0, %req_dst_q1 after %8 : !llhd.sig<i1>
    %req_q01 = llhd.prb %req_q0 : !llhd.sig<i1>
    llhd.drv %req_q1, %req_q01 after %8 : !llhd.sig<i1>
    br ^init
^if_true:
    llhd.drv %req_dst_q, %0 after %8 : !llhd.sig<i1>
    llhd.drv %req_q0, %0 after %8 : !llhd.sig<i1>
    llhd.drv %req_q1, %0 after %8 : !llhd.sig<i1>
    br ^init
}

llhd.entity @cdc_2phase_dst.param3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>, %async_req_i: !llhd.sig<i1>, %async_data_i: !llhd.sig<i32>) -> (%data_o: !llhd.sig<i32> , %valid_o: !llhd.sig<i1> , %async_ack_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i1
    %req_dst_q = llhd.sig "sig" %0 : i1
    %req_q0 = llhd.sig "sig1" %0 : i1
    %req_q1 = llhd.sig "sig2" %0 : i1
    %ack_dst_q = llhd.sig "sig3" %0 : i1
    %1 = llhd.const 0 : i32
    %data_dst_q = llhd.sig "sig4" %1 : i32
    %ack_dst_q1 = llhd.prb %ack_dst_q : !llhd.sig<i1>
    %req_q11 = llhd.prb %req_q1 : !llhd.sig<i1>
    %2 = cmpi "ne", %ack_dst_q1, %req_q11 : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_o, %2 after %3 : !llhd.sig<i1>
    %data_dst_q1 = llhd.prb %data_dst_q : !llhd.sig<i32>
    llhd.drv %data_o, %data_dst_q1 after %3 : !llhd.sig<i32>
    llhd.drv %async_ack_o, %ack_dst_q1 after %3 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase_dst.param3.always_ff.483.3(%rst_ni, %clk_i, %valid_o, %ready_i) -> (%ack_dst_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst1" @cdc_2phase_dst.param3.always_ff.535.3(%req_q0, %req_q1, %rst_ni, %clk_i, %valid_o, %async_data_i) -> (%data_dst_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst2" @cdc_2phase_dst.param3.always_ff.618.3(%rst_ni, %clk_i, %async_req_i) -> (%req_dst_q, %req_q0, %req_q1) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.entity @cdc_2phase.param1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_data_i: !llhd.sig<i32>, %src_valid_i: !llhd.sig<i1>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%src_ready_o: !llhd.sig<i1> , %dst_data_o: !llhd.sig<i32> , %dst_valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i1
    %async_req = llhd.sig "sig" %0 : i1
    %async_ack = llhd.sig "sig1" %0 : i1
    %1 = llhd.const 0 : i32
    %async_data = llhd.sig "sig2" %1 : i32
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %2 = llhd.sig "sig3" %0 : i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %2, %src_rst_ni1 after %3 : !llhd.sig<i1>
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %4 = llhd.sig "sig4" %0 : i1
    llhd.drv %4, %src_clk_i1 after %3 : !llhd.sig<i1>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %5 = llhd.sig "sig5" %1 : i32
    llhd.drv %5, %src_data_i1 after %3 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %6 = llhd.sig "sig6" %0 : i1
    llhd.drv %6, %src_valid_i1 after %3 : !llhd.sig<i1>
    %async_ack1 = llhd.prb %async_ack : !llhd.sig<i1>
    %7 = llhd.sig "sig7" %0 : i1
    llhd.drv %7, %async_ack1 after %3 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase_src.param2(%2, %4, %5, %6, %7) -> (%src_ready_o, %async_req, %async_data) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>)
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %8 = llhd.sig "sig8" %0 : i1
    llhd.drv %8, %dst_rst_ni1 after %3 : !llhd.sig<i1>
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %9 = llhd.sig "sig9" %0 : i1
    llhd.drv %9, %dst_clk_i1 after %3 : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %10 = llhd.sig "sig10" %0 : i1
    llhd.drv %10, %dst_ready_i1 after %3 : !llhd.sig<i1>
    %async_req1 = llhd.prb %async_req : !llhd.sig<i1>
    %11 = llhd.sig "sig11" %0 : i1
    llhd.drv %11, %async_req1 after %3 : !llhd.sig<i1>
    %async_data1 = llhd.prb %async_data : !llhd.sig<i32>
    %12 = llhd.sig "sig12" %1 : i32
    llhd.drv %12, %async_data1 after %3 : !llhd.sig<i32>
    llhd.inst "inst1" @cdc_2phase_dst.param3(%8, %9, %10, %11, %12) -> (%dst_data_o, %dst_valid_o, %async_ack) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>)
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
    br ^loop_body(%9: i32)
^loop_body(%i: i32):
    %10 = llhd.const 500000 : i32
    %11 = cmpi "slt", %i, %10 : i32
    cond_br %11, ^loop_body1, ^loop_exit
^12:
    %13 = llhd.const 1 : i32
    %14 = addi %i, %13 : i32
    br ^loop_body(%14: i32)
^loop_exit:
    llhd.halt
^loop_body1:
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %15 = llhd.const 0 : i1
    %16 = cmpi "ne", %src_ready_o1, %15 : i1
    %17 = llhd.not %16 : i1
    %18 = cmpi "ne", %17, %15 : i1
    %19 = llhd.const 1 : i1
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %21 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %18, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %src_clk_i, %19 after %20 : !llhd.sig<i1>
    llhd.drv %src_data_i, %i after %20 : !llhd.sig<i32>
    llhd.drv %src_valid_i, %19 after %20 : !llhd.sig<i1>
    llhd.wait  for %21, ^22
^loop_continue:
    llhd.drv %src_clk_i, %19 after %20 : !llhd.sig<i1>
    llhd.wait  for %21, ^23
^22:
    %24 = llhd.const 0 : i1
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %24 after %25 : !llhd.sig<i1>
    %26 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %26, ^12
^23:
    %27 = llhd.const 0 : i1
    %28 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %27 after %28 : !llhd.sig<i1>
    %29 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %29, ^30
^30:
    br ^loop_body1
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
    br ^loop_body(%11: i32)
^loop_body(%i: i32):
    %12 = llhd.const 500000 : i32
    %13 = cmpi "slt", %i, %12 : i32
    cond_br %13, ^loop_body1, ^loop_exit
^14:
    %15 = llhd.const 1 : i32
    %16 = addi %i, %15 : i32
    br ^loop_body(%16: i32)
^loop_exit:
    llhd.halt
^loop_body1:
    %dst_valid_o1 = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %17 = llhd.const 0 : i1
    %18 = cmpi "ne", %dst_valid_o1, %17 : i1
    %19 = llhd.not %18 : i1
    %20 = cmpi "ne", %19, %17 : i1
    %21 = llhd.const 1 : i1
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %23 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %20, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %dst_clk_i, %21 after %22 : !llhd.sig<i1>
    %24 = llhd.const 0 : i32
    %dst_data_o1 = llhd.prb %dst_data_o : !llhd.sig<i32>
    %25 = cmpi "ne", %i, %dst_data_o1 : i32
    %26 = llhd.insert_slice %24, %25, 0 : i32, i1
    %ERRORS1 = llhd.prb %ERRORS : !llhd.sig<i32>
    %27 = addi %ERRORS1, %26 : i32
    llhd.drv %ERRORS, %27 after %22 : !llhd.sig<i32>
    llhd.wait  for %23, ^28
^loop_continue:
    llhd.drv %dst_clk_i, %21 after %22 : !llhd.sig<i1>
    llhd.wait  for %23, ^29
^28:
    %30 = llhd.const 0 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %32, ^14
^29:
    %33 = llhd.const 0 : i1
    %34 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %33 after %34 : !llhd.sig<i1>
    %35 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %35, ^36
^36:
    br ^loop_body1
}

llhd.entity @root() -> () {
    %0 = llhd.const 0 : i32
    %ERRORS = llhd.sig "sig" %0 : i32
    %1 = llhd.const 1 : i1
    %src_rst_ni = llhd.sig "sig1" %1 : i1
    %2 = llhd.const 0 : i1
    %src_clk_i = llhd.sig "sig2" %2 : i1
    %src_data_i = llhd.sig "sig3" %0 : i32
    %src_valid_i = llhd.sig "sig4" %2 : i1
    %src_ready_o = llhd.sig "sig5" %2 : i1
    %dst_rst_ni = llhd.sig "sig6" %1 : i1
    %dst_clk_i = llhd.sig "sig7" %2 : i1
    %dst_data_o = llhd.sig "sig8" %0 : i32
    %dst_valid_o = llhd.sig "sig9" %2 : i1
    %dst_ready_i = llhd.sig "sig10" %2 : i1
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.sig "sig11" %2 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %src_rst_ni1 after %4 : !llhd.sig<i1>
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %5 = llhd.sig "sig12" %2 : i1
    llhd.drv %5, %src_clk_i1 after %4 : !llhd.sig<i1>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %6 = llhd.sig "sig13" %0 : i32
    llhd.drv %6, %src_data_i1 after %4 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %7 = llhd.sig "sig14" %2 : i1
    llhd.drv %7, %src_valid_i1 after %4 : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %8 = llhd.sig "sig15" %2 : i1
    llhd.drv %8, %dst_rst_ni1 after %4 : !llhd.sig<i1>
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %9 = llhd.sig "sig16" %2 : i1
    llhd.drv %9, %dst_clk_i1 after %4 : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %10 = llhd.sig "sig17" %2 : i1
    llhd.drv %10, %dst_ready_i1 after %4 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase.param1(%3, %5, %6, %7, %8, %9, %10) -> (%src_ready_o, %dst_data_o, %dst_valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @cdc_2phase_tb.initial.903.0(%src_ready_o) -> (%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst2" @cdc_2phase_tb.initial.1048.0(%dst_data_o, %dst_valid_o) -> (%ERRORS, %dst_rst_ni, %dst_clk_i, %dst_ready_i) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
