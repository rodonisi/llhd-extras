llhd.proc @cdc_2phase_src.param2.always_ff.331.2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %ready_o: !llhd.sig<i1>, %req_src_q: !llhd.sig<i1>) -> (%req_src_q1: !llhd.sig<i1> , %data_src_q: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = llhd.prb %req_src_q1 : !llhd.sig<i1>
    %req_src_q.shadow = llhd.var %1 : i1
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %req_src_q1 : !llhd.sig<i1>
    llhd.store %req_src_q.shadow, %2 : !llhd.ptr<i1>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i1, %3 : i1
    %5 = llhd.neq %clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.neq %rst_ni1, %6 : i1
    %8 = llhd.eq %rst_ni2, %6 : i1
    %negedge = llhd.and %8, %7 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %rst_ni3 = llhd.prb %rst_ni : !llhd.sig<i1>
    %9 = llhd.not %rst_ni3 : i1
    cond_br %9, ^if_true, ^if_false
^if_false:
    %valid_i1 = llhd.prb %valid_i : !llhd.sig<i1>
    %ready_o1 = llhd.prb %ready_o : !llhd.sig<i1>
    %10 = llhd.and %valid_i1, %ready_o1 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    %11 = llhd.const 0 : i32
    %12 = llhd.extract_slice %11, 0 : i32 -> i1
    %13 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_src_q1, %12 after %13 : !llhd.sig<i1>
    %14 = llhd.const 0 : i32
    %15 = llhd.const 0 : i1
    %16 = llhd.insert_slice %14, %15, 0 : i32, i1
    %17 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %data_src_q, %16 after %17 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %req_src_q2 = llhd.load %req_src_q.shadow : !llhd.ptr<i1>
    %18 = llhd.not %req_src_q2 : i1
    %19 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_src_q1, %18 after %19 : !llhd.sig<i1>
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %data_src_q, %data_i1 after %20 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_2phase_src.param2.always_ff.332.2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %async_ack_i: !llhd.sig<i1>, %ack_src_q: !llhd.sig<i1>) -> (%ack_src_q1: !llhd.sig<i1> , %ack_q: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %ack_src_q1 : !llhd.sig<i1>
    %ack_src_q.shadow = llhd.var %1 : i1
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %ack_src_q1 : !llhd.sig<i1>
    llhd.store %ack_src_q.shadow, %2 : !llhd.ptr<i1>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i1, %3 : i1
    %5 = llhd.neq %clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.neq %rst_ni1, %6 : i1
    %8 = llhd.eq %rst_ni2, %6 : i1
    %negedge = llhd.and %8, %7 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %rst_ni3 = llhd.prb %rst_ni : !llhd.sig<i1>
    %9 = llhd.not %rst_ni3 : i1
    cond_br %9, ^if_true, ^if_false
^if_false:
    %async_ack_i1 = llhd.prb %async_ack_i : !llhd.sig<i1>
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %ack_src_q1, %async_ack_i1 after %10 : !llhd.sig<i1>
    %ack_src_q2 = llhd.load %ack_src_q.shadow : !llhd.ptr<i1>
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %ack_q, %ack_src_q2 after %11 : !llhd.sig<i1>
    br ^if_exit
^if_true:
    %12 = llhd.const 0 : i32
    %13 = llhd.extract_slice %12, 0 : i32 -> i1
    %14 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %ack_src_q1, %13 after %14 : !llhd.sig<i1>
    %15 = llhd.const 0 : i32
    %16 = llhd.extract_slice %15, 0 : i32 -> i1
    %17 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %ack_q, %16 after %17 : !llhd.sig<i1>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.entity @cdc_2phase_src.param2(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %valid_i: !llhd.sig<i1>, %async_ack_i: !llhd.sig<i1>) -> (%ready_o: !llhd.sig<i1> , %async_req_o: !llhd.sig<i1> , %async_data_o: !llhd.sig<i32> ) {
    %0 = llhd.const 0 : i1
    %req_src_q = llhd.sig "req_src_q" %0 : i1
    %1 = llhd.const 0 : i1
    %ack_src_q = llhd.sig "ack_src_q" %1 : i1
    %2 = llhd.const 0 : i1
    %ack_q = llhd.sig "ack_q" %2 : i1
    %3 = llhd.const 0 : i32
    %data_src_q = llhd.sig "data_src_q" %3 : i32
    %req_src_q1 = llhd.prb %req_src_q : !llhd.sig<i1>
    %ack_q1 = llhd.prb %ack_q : !llhd.sig<i1>
    %4 = llhd.eq %req_src_q1, %ack_q1 : i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ready_o, %4 after %5 : !llhd.sig<i1>
    %req_src_q2 = llhd.prb %req_src_q : !llhd.sig<i1>
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %async_req_o, %req_src_q2 after %6 : !llhd.sig<i1>
    %data_src_q1 = llhd.prb %data_src_q : !llhd.sig<i32>
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %async_data_o, %data_src_q1 after %7 : !llhd.sig<i32>
    llhd.inst "inst" @cdc_2phase_src.param2.always_ff.331.2(%rst_ni, %clk_i, %data_i, %valid_i, %ready_o, %req_src_q) -> (%req_src_q, %data_src_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>)
    llhd.inst "inst1" @cdc_2phase_src.param2.always_ff.332.2(%rst_ni, %clk_i, %async_ack_i, %ack_src_q) -> (%ack_src_q, %ack_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @cdc_2phase_dst.param3.always_ff.491.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %valid_o: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>, %ack_dst_q: !llhd.sig<i1>) -> (%ack_dst_q1: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %ack_dst_q1 : !llhd.sig<i1>
    %ack_dst_q.shadow = llhd.var %1 : i1
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %ack_dst_q1 : !llhd.sig<i1>
    llhd.store %ack_dst_q.shadow, %2 : !llhd.ptr<i1>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i1, %3 : i1
    %5 = llhd.neq %clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.neq %rst_ni1, %6 : i1
    %8 = llhd.eq %rst_ni2, %6 : i1
    %negedge = llhd.and %8, %7 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %rst_ni3 = llhd.prb %rst_ni : !llhd.sig<i1>
    %9 = llhd.not %rst_ni3 : i1
    cond_br %9, ^if_true, ^if_false
^if_false:
    %valid_o1 = llhd.prb %valid_o : !llhd.sig<i1>
    %ready_i1 = llhd.prb %ready_i : !llhd.sig<i1>
    %10 = llhd.and %valid_o1, %ready_i1 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    %11 = llhd.const 0 : i32
    %12 = llhd.extract_slice %11, 0 : i32 -> i1
    %13 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %ack_dst_q1, %12 after %13 : !llhd.sig<i1>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %ack_dst_q2 = llhd.load %ack_dst_q.shadow : !llhd.ptr<i1>
    %14 = llhd.not %ack_dst_q2 : i1
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %ack_dst_q1, %14 after %15 : !llhd.sig<i1>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_2phase_dst.param3.always_ff.492.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %valid_o: !llhd.sig<i1>, %async_data_i: !llhd.sig<i32>, %req_q0: !llhd.sig<i1>, %req_q1: !llhd.sig<i1>) -> (%data_dst_q: !llhd.sig<i32> ) {
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
    %req_q01 = llhd.prb %req_q0 : !llhd.sig<i1>
    %req_q11 = llhd.prb %req_q1 : !llhd.sig<i1>
    %8 = llhd.neq %req_q01, %req_q11 : i1
    %valid_o1 = llhd.prb %valid_o : !llhd.sig<i1>
    %9 = llhd.not %valid_o1 : i1
    %10 = llhd.and %8, %9 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    %11 = llhd.const 0 : i32
    %12 = llhd.const 0 : i1
    %13 = llhd.insert_slice %11, %12, 0 : i32, i1
    %14 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %data_dst_q, %13 after %14 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %async_data_i1 = llhd.prb %async_data_i : !llhd.sig<i32>
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %data_dst_q, %async_data_i1 after %15 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_2phase_dst.param3.always_ff.493.3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %async_req_i: !llhd.sig<i1>, %req_dst_q: !llhd.sig<i1>, %req_q0: !llhd.sig<i1>) -> (%req_dst_q1: !llhd.sig<i1> , %req_q01: !llhd.sig<i1> , %req_q1: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %req_dst_q1 : !llhd.sig<i1>
    %req_dst_q.shadow = llhd.var %1 : i1
    %2 = llhd.prb %req_q01 : !llhd.sig<i1>
    %req_q0.shadow = llhd.var %2 : i1
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %3 = llhd.prb %req_dst_q1 : !llhd.sig<i1>
    llhd.store %req_dst_q.shadow, %3 : !llhd.ptr<i1>
    %4 = llhd.prb %req_q01 : !llhd.sig<i1>
    llhd.store %req_q0.shadow, %4 : !llhd.ptr<i1>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %5 = llhd.const 0 : i1
    %6 = llhd.eq %clk_i1, %5 : i1
    %7 = llhd.neq %clk_i2, %5 : i1
    %posedge = llhd.and %6, %7 : i1
    %rst_ni2 = llhd.prb %rst_ni : !llhd.sig<i1>
    %8 = llhd.const 0 : i1
    %9 = llhd.neq %rst_ni1, %8 : i1
    %10 = llhd.eq %rst_ni2, %8 : i1
    %negedge = llhd.and %10, %9 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %rst_ni3 = llhd.prb %rst_ni : !llhd.sig<i1>
    %11 = llhd.not %rst_ni3 : i1
    cond_br %11, ^if_true, ^if_false
^if_false:
    %async_req_i1 = llhd.prb %async_req_i : !llhd.sig<i1>
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_dst_q1, %async_req_i1 after %12 : !llhd.sig<i1>
    %req_dst_q2 = llhd.load %req_dst_q.shadow : !llhd.ptr<i1>
    %13 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_q01, %req_dst_q2 after %13 : !llhd.sig<i1>
    %req_q02 = llhd.load %req_q0.shadow : !llhd.ptr<i1>
    %14 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_q1, %req_q02 after %14 : !llhd.sig<i1>
    br ^if_exit
^if_true:
    %15 = llhd.const 0 : i32
    %16 = llhd.extract_slice %15, 0 : i32 -> i1
    %17 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_dst_q1, %16 after %17 : !llhd.sig<i1>
    %18 = llhd.const 0 : i32
    %19 = llhd.extract_slice %18, 0 : i32 -> i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_q01, %19 after %20 : !llhd.sig<i1>
    %21 = llhd.const 0 : i32
    %22 = llhd.extract_slice %21, 0 : i32 -> i1
    %23 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %req_q1, %22 after %23 : !llhd.sig<i1>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.entity @cdc_2phase_dst.param3(%rst_ni: !llhd.sig<i1>, %clk_i: !llhd.sig<i1>, %ready_i: !llhd.sig<i1>, %async_req_i: !llhd.sig<i1>, %async_data_i: !llhd.sig<i32>) -> (%data_o: !llhd.sig<i32> , %valid_o: !llhd.sig<i1> , %async_ack_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i1
    %req_dst_q = llhd.sig "req_dst_q" %0 : i1
    %1 = llhd.const 0 : i1
    %req_q0 = llhd.sig "req_q0" %1 : i1
    %2 = llhd.const 0 : i1
    %req_q1 = llhd.sig "req_q1" %2 : i1
    %3 = llhd.const 0 : i1
    %ack_dst_q = llhd.sig "ack_dst_q" %3 : i1
    %4 = llhd.const 0 : i32
    %data_dst_q = llhd.sig "data_dst_q" %4 : i32
    %ack_dst_q1 = llhd.prb %ack_dst_q : !llhd.sig<i1>
    %req_q11 = llhd.prb %req_q1 : !llhd.sig<i1>
    %5 = llhd.neq %ack_dst_q1, %req_q11 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_o, %5 after %6 : !llhd.sig<i1>
    %data_dst_q1 = llhd.prb %data_dst_q : !llhd.sig<i32>
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_o, %data_dst_q1 after %7 : !llhd.sig<i32>
    %ack_dst_q2 = llhd.prb %ack_dst_q : !llhd.sig<i1>
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %async_ack_o, %ack_dst_q2 after %8 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase_dst.param3.always_ff.491.3(%rst_ni, %clk_i, %valid_o, %ready_i, %ack_dst_q) -> (%ack_dst_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst1" @cdc_2phase_dst.param3.always_ff.492.3(%rst_ni, %clk_i, %valid_o, %async_data_i, %req_q0, %req_q1) -> (%data_dst_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst2" @cdc_2phase_dst.param3.always_ff.493.3(%rst_ni, %clk_i, %async_req_i, %req_dst_q, %req_q0) -> (%req_dst_q, %req_q0, %req_q1) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.entity @cdc_2phase.param1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_data_i: !llhd.sig<i32>, %src_valid_i: !llhd.sig<i1>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%src_ready_o: !llhd.sig<i1> , %dst_data_o: !llhd.sig<i32> , %dst_valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i1
    %async_req = llhd.sig "async_req" %0 : i1
    %1 = llhd.const 0 : i1
    %async_ack = llhd.sig "async_ack" %1 : i1
    %2 = llhd.const 0 : i32
    %async_data = llhd.sig "async_data" %2 : i32
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.sig "4" %3 : i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %src_rst_ni1 after %5 : !llhd.sig<i1>
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.sig "7" %6 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %7, %src_clk_i1 after %8 : !llhd.sig<i1>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %9 = llhd.const 0 : i32
    %10 = llhd.sig "10" %9 : i32
    %11 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %10, %src_data_i1 after %11 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %12 = llhd.const 0 : i1
    %13 = llhd.sig "13" %12 : i1
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %13, %src_valid_i1 after %14 : !llhd.sig<i1>
    %async_ack1 = llhd.prb %async_ack : !llhd.sig<i1>
    %15 = llhd.const 0 : i1
    %16 = llhd.sig "16" %15 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %16, %async_ack1 after %17 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase_src.param2(%4, %7, %10, %13, %16) -> (%src_ready_o, %async_req, %async_data) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>)
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %18 = llhd.const 0 : i1
    %19 = llhd.sig "19" %18 : i1
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %19, %dst_rst_ni1 after %20 : !llhd.sig<i1>
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %21 = llhd.const 0 : i1
    %22 = llhd.sig "22" %21 : i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %22, %dst_clk_i1 after %23 : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %24 = llhd.const 0 : i1
    %25 = llhd.sig "25" %24 : i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %25, %dst_ready_i1 after %26 : !llhd.sig<i1>
    %async_req1 = llhd.prb %async_req : !llhd.sig<i1>
    %27 = llhd.const 0 : i1
    %28 = llhd.sig "28" %27 : i1
    %29 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %28, %async_req1 after %29 : !llhd.sig<i1>
    %async_data1 = llhd.prb %async_data : !llhd.sig<i32>
    %30 = llhd.const 0 : i32
    %31 = llhd.sig "31" %30 : i32
    %32 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %31, %async_data1 after %32 : !llhd.sig<i32>
    llhd.inst "inst1" @cdc_2phase_dst.param3(%19, %22, %25, %28, %31) -> (%dst_data_o, %dst_valid_o, %async_ack) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @cdc_2phase_tb.initial.249.0(%src_ready_o: !llhd.sig<i1>) -> (%src_rst_ni: !llhd.sig<i1> , %src_clk_i: !llhd.sig<i1> , %src_data_i: !llhd.sig<i32> , %src_valid_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i32
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %2 after %3 : !llhd.sig<i1>
    %4 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %4, ^5
^5:
    %6 = llhd.const 1 : i32
    %7 = llhd.extract_slice %6, 0 : i32 -> i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %9, ^10
^10:
    %11 = llhd.const 0 : i32
    %i = llhd.var %11 : i32
    br ^loop_body
^loop_body:
    %i1 = llhd.load %i : !llhd.ptr<i32>
    %12 = llhd.const 500000 : i32
    %13 = cmpi "slt", %i1, %12 : i32
    cond_br %13, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    br ^loop_body1
^loop_body1:
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %14 = llhd.not %src_ready_o1 : i1
    cond_br %14, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %15 = llhd.const 1 : i32
    %16 = llhd.extract_slice %15, 0 : i32 -> i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %16 after %17 : !llhd.sig<i1>
    %i2 = llhd.load %i : !llhd.ptr<i32>
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_data_i, %i2 after %18 : !llhd.sig<i32>
    %19 = llhd.const 1 : i32
    %20 = llhd.extract_slice %19, 0 : i32 -> i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_valid_i, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %22, ^23
^loop_continue1:
    %24 = llhd.const 1 : i32
    %25 = llhd.extract_slice %24, 0 : i32 -> i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %25 after %26 : !llhd.sig<i1>
    %27 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %27, ^28
^23:
    %29 = llhd.const 0 : i32
    %30 = llhd.extract_slice %29, 0 : i32 -> i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %32, ^33
^28:
    %34 = llhd.const 0 : i32
    %35 = llhd.extract_slice %34, 0 : i32 -> i1
    %36 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %35 after %36 : !llhd.sig<i1>
    %37 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %37, ^38
^38:
    br ^loop_body1
^33:
    %i3 = llhd.load %i : !llhd.ptr<i32>
    %39 = llhd.const 1 : i32
    %40 = addi %i3, %39 : i32
    llhd.store %i, %40 : !llhd.ptr<i32>
    %i4 = llhd.load %i : !llhd.ptr<i32>
    %41 = llhd.const 1 : i32
    %42 = addi %i4, %41 : i32
    %43 = llhd.const 0 : i32
    %44 = llhd.neq %42, %43 : i32
    br ^loop_body
}

llhd.proc @cdc_2phase_tb.initial.250.0(%dst_data_o: !llhd.sig<i32>, %dst_valid_o: !llhd.sig<i1>) -> (%ERRORS: !llhd.sig<i32> , %dst_rst_ni: !llhd.sig<i1> , %dst_clk_i: !llhd.sig<i1> , %dst_ready_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i32
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %2 after %3 : !llhd.sig<i1>
    %4 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %4, ^5
^5:
    %6 = llhd.const 1 : i32
    %7 = llhd.extract_slice %6, 0 : i32 -> i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %9, ^10
^10:
    %11 = llhd.const 1 : i32
    %12 = llhd.extract_slice %11, 0 : i32 -> i1
    %13 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_ready_i, %12 after %13 : !llhd.sig<i1>
    %14 = llhd.const 0 : i32
    %i = llhd.var %14 : i32
    br ^loop_body
^loop_body:
    %i1 = llhd.load %i : !llhd.ptr<i32>
    %15 = llhd.const 500000 : i32
    %16 = cmpi "slt", %i1, %15 : i32
    cond_br %16, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    br ^loop_body1
^loop_body1:
    %dst_valid_o1 = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %17 = llhd.not %dst_valid_o1 : i1
    cond_br %17, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %18 = llhd.const 1 : i32
    %19 = llhd.extract_slice %18, 0 : i32 -> i1
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %19 after %20 : !llhd.sig<i1>
    %21 = llhd.const 0 : i32
    %i2 = llhd.load %i : !llhd.ptr<i32>
    %dst_data_o1 = llhd.prb %dst_data_o : !llhd.sig<i32>
    %22 = llhd.neq %i2, %dst_data_o1 : i32
    %23 = llhd.insert_slice %21, %22, 0 : i32, i1
    %ERRORS1 = llhd.prb %ERRORS : !llhd.sig<i32>
    %24 = addi %ERRORS1, %23 : i32
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ERRORS, %24 after %25 : !llhd.sig<i32>
    %26 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %26, ^27
^loop_continue1:
    %28 = llhd.const 1 : i32
    %29 = llhd.extract_slice %28, 0 : i32 -> i1
    %30 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %29 after %30 : !llhd.sig<i1>
    %31 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %31, ^32
^27:
    %33 = llhd.const 0 : i32
    %34 = llhd.extract_slice %33, 0 : i32 -> i1
    %35 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %34 after %35 : !llhd.sig<i1>
    %36 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %36, ^37
^32:
    %38 = llhd.const 0 : i32
    %39 = llhd.extract_slice %38, 0 : i32 -> i1
    %40 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %39 after %40 : !llhd.sig<i1>
    %41 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %41, ^42
^42:
    br ^loop_body1
^37:
    %i3 = llhd.load %i : !llhd.ptr<i32>
    %43 = llhd.const 1 : i32
    %44 = addi %i3, %43 : i32
    llhd.store %i, %44 : !llhd.ptr<i32>
    %i4 = llhd.load %i : !llhd.ptr<i32>
    %45 = llhd.const 1 : i32
    %46 = addi %i4, %45 : i32
    %47 = llhd.const 0 : i32
    %48 = llhd.neq %46, %47 : i32
    br ^loop_body
}

llhd.entity @cdc_2phase_tb() -> () {
    %0 = llhd.const 0 : i32
    %ERRORS = llhd.sig "ERRORS" %0 : i32
    %1 = llhd.const 1 : i1
    %src_rst_ni = llhd.sig "src_rst_ni" %1 : i1
    %2 = llhd.const 0 : i1
    %src_clk_i = llhd.sig "src_clk_i" %2 : i1
    %3 = llhd.const 0 : i32
    %src_data_i = llhd.sig "src_data_i" %3 : i32
    %4 = llhd.const 0 : i1
    %src_valid_i = llhd.sig "src_valid_i" %4 : i1
    %5 = llhd.const 0 : i1
    %src_ready_o = llhd.sig "src_ready_o" %5 : i1
    %6 = llhd.const 1 : i1
    %dst_rst_ni = llhd.sig "dst_rst_ni" %6 : i1
    %7 = llhd.const 0 : i1
    %dst_clk_i = llhd.sig "dst_clk_i" %7 : i1
    %8 = llhd.const 0 : i32
    %dst_data_o = llhd.sig "dst_data_o" %8 : i32
    %9 = llhd.const 0 : i1
    %dst_valid_o = llhd.sig "dst_valid_o" %9 : i1
    %10 = llhd.const 0 : i1
    %dst_ready_i = llhd.sig "dst_ready_i" %10 : i1
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %11 = llhd.const 0 : i1
    %12 = llhd.sig "12" %11 : i1
    %13 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %12, %src_rst_ni1 after %13 : !llhd.sig<i1>
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %14 = llhd.const 0 : i1
    %15 = llhd.sig "15" %14 : i1
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %15, %src_clk_i1 after %16 : !llhd.sig<i1>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.sig "18" %17 : i32
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %18, %src_data_i1 after %19 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %20 = llhd.const 0 : i1
    %21 = llhd.sig "21" %20 : i1
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %21, %src_valid_i1 after %22 : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %23 = llhd.const 0 : i1
    %24 = llhd.sig "24" %23 : i1
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %24, %dst_rst_ni1 after %25 : !llhd.sig<i1>
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %26 = llhd.const 0 : i1
    %27 = llhd.sig "27" %26 : i1
    %28 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %27, %dst_clk_i1 after %28 : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %29 = llhd.const 0 : i1
    %30 = llhd.sig "30" %29 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %30, %dst_ready_i1 after %31 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_2phase.param1(%12, %15, %18, %21, %24, %27, %30) -> (%src_ready_o, %dst_data_o, %dst_valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @cdc_2phase_tb.initial.249.0(%src_ready_o) -> (%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst2" @cdc_2phase_tb.initial.250.0(%dst_data_o, %dst_valid_o) -> (%ERRORS, %dst_rst_ni, %dst_clk_i, %dst_ready_i) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
