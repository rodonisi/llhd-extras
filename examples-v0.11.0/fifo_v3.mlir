llhd.proc @fifo_v3.param1.always_comb.626.1(%full_o: !llhd.sig<i1>, %empty_o: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>, %read_pointer_q: !llhd.sig<i4>, %write_pointer_q: !llhd.sig<i4>, %status_cnt_q: !llhd.sig<i5>, %mem_q: !llhd.sig<!llhd.array<16xi32>>) -> (%data_o: !llhd.sig<i32> , %gate_clock: !llhd.sig<i1> , %read_pointer_n: !llhd.sig<i4> , %write_pointer_n: !llhd.sig<i4> , %status_cnt_n: !llhd.sig<i5> , %mem_n: !llhd.sig<!llhd.array<16xi32>> ) {
    br ^0
^0:
    %1 = llhd.prb %read_pointer_n : !llhd.sig<i4>
    %read_pointer_n.shadow = llhd.var %1 : i4
    llhd.store %read_pointer_n.shadow, %1 : !llhd.ptr<i4>
    %read_pointer_q.prb = llhd.prb %read_pointer_q : !llhd.sig<i4>
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n, %read_pointer_q.prb after %2 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %read_pointer_q.prb : !llhd.ptr<i4>
    %write_pointer_q.prb = llhd.prb %write_pointer_q : !llhd.sig<i4>
    llhd.drv %write_pointer_n, %write_pointer_q.prb after %2 : !llhd.sig<i4>
    %status_cnt_q.prb = llhd.prb %status_cnt_q : !llhd.sig<i5>
    llhd.drv %status_cnt_n, %status_cnt_q.prb after %2 : !llhd.sig<i5>
    %data_i.prb = llhd.prb %data_i : !llhd.sig<i32>
    %mem_q.prb = llhd.prb %mem_q : !llhd.sig<!llhd.array<16xi32>>
    %3 = llhd.const 0 : i32
    %4 = llhd.array_uniform %3 : !llhd.array<16xi32>
    %5 = llhd.shr %mem_q.prb, %4, %read_pointer_q.prb : (!llhd.array<16xi32>, !llhd.array<16xi32>, i4) -> !llhd.array<16xi32>
    %6 = llhd.extract_element %5, 0 : !llhd.array<16xi32> -> i32
    %7 = llhd.array %6, %data_i.prb : !llhd.array<2xi32>
    %8 = llhd.extract_element %7, 0 : !llhd.array<2xi32> -> i32
    llhd.drv %data_o, %8 after %2 : !llhd.sig<i32>
    llhd.drv %mem_n, %mem_q.prb after %2 : !llhd.sig<!llhd.array<16xi32>>
    %9 = llhd.const 1 : i1
    llhd.drv %gate_clock, %9 after %2 : !llhd.sig<i1>
    %push_i.prb = llhd.prb %push_i : !llhd.sig<i1>
    %10 = llhd.const 0 : i1
    %11 = llhd.neq %push_i.prb, %10 : i1
    %full_o.prb = llhd.prb %full_o : !llhd.sig<i1>
    %12 = llhd.not %full_o.prb : i1
    %13 = llhd.neq %12, %10 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %10 : i1
    %16 = llhd.const 4294967295 : i32
    %17 = llhd.const 0 : i4
    %18 = llhd.const 1 : i32
    %zext = llhd.insert_slice %3, %status_cnt_q.prb, 0 : i32, i5
    cond_br %15, ^if_true, ^if_exit
^if_exit:
    %pop_i.prb = llhd.prb %pop_i : !llhd.sig<i1>
    %19 = llhd.neq %pop_i.prb, %10 : i1
    %empty_o.prb = llhd.prb %empty_o : !llhd.sig<i1>
    %20 = llhd.not %empty_o.prb : i1
    %21 = llhd.neq %20, %10 : i1
    %22 = llhd.and %19, %21 : i1
    %23 = llhd.neq %22, %10 : i1
    cond_br %23, ^if_true2, ^if_exit1
^if_true:
    %24 = llhd.dyn_extract_element %mem_n, %write_pointer_q.prb : (!llhd.sig<!llhd.array<16xi32>>, i4) -> !llhd.sig<i32>
    llhd.drv %24, %data_i.prb after %2 : !llhd.sig<i32>
    llhd.drv %gate_clock, %10 after %2 : !llhd.sig<i1>
    %zext1 = llhd.insert_slice %3, %write_pointer_q.prb, 0 : i32, i4
    %25 = llhd.eq %zext1, %16 : i32
    %26 = llhd.neq %25, %10 : i1
    cond_br %26, ^if_true1, ^if_false
^if_false:
    %27 = addi %zext1, %18 : i32
    %28 = llhd.extract_slice %27, 0 : i32 -> i4
    llhd.drv %write_pointer_n, %28 after %2 : !llhd.sig<i4>
    br ^if_exit2
^if_true1:
    llhd.drv %write_pointer_n, %17 after %2 : !llhd.sig<i4>
    br ^if_exit2
^if_exit1:
    %29 = llhd.and %11, %19 : i1
    %30 = llhd.neq %29, %10 : i1
    %31 = llhd.and %30, %13 : i1
    %32 = llhd.neq %31, %10 : i1
    %33 = llhd.and %32, %21 : i1
    %34 = llhd.neq %33, %10 : i1
    cond_br %34, ^if_true4, ^if_exit3
^if_true2:
    %read_pointer_n.shadow.ld = llhd.load %read_pointer_n.shadow : !llhd.ptr<i4>
    %zext2 = llhd.insert_slice %3, %read_pointer_n.shadow.ld, 0 : i32, i4
    %35 = llhd.eq %zext2, %16 : i32
    %36 = llhd.neq %35, %10 : i1
    cond_br %36, ^if_true3, ^if_false1
^if_exit2:
    %37 = addi %zext, %18 : i32
    %38 = llhd.extract_slice %37, 0 : i32 -> i5
    llhd.drv %status_cnt_n, %38 after %2 : !llhd.sig<i5>
    br ^if_exit
^if_false1:
    %zext3 = llhd.insert_slice %3, %read_pointer_q.prb, 0 : i32, i4
    %39 = addi %zext3, %18 : i32
    %40 = llhd.extract_slice %39, 0 : i32 -> i4
    llhd.drv %read_pointer_n, %40 after %2 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %40 : !llhd.ptr<i4>
    br ^if_exit4
^if_true3:
    llhd.drv %read_pointer_n, %17 after %2 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %17 : !llhd.ptr<i4>
    br ^if_exit4
^if_exit3:
    llhd.wait (%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>), ^0
^if_true4:
    llhd.drv %status_cnt_n, %status_cnt_q.prb after %2 : !llhd.sig<i5>
    br ^if_exit3
^if_exit4:
    %41 = subi %zext, %18 : i32
    %42 = llhd.extract_slice %41, 0 : i32 -> i5
    llhd.drv %status_cnt_n, %42 after %2 : !llhd.sig<i5>
    br ^if_exit1
}

llhd.proc @fifo_v3.param1.always_ff.745.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %read_pointer_n: !llhd.sig<i4>, %write_pointer_n: !llhd.sig<i4>, %status_cnt_n: !llhd.sig<i5>) -> (%read_pointer_q: !llhd.sig<i4> , %write_pointer_q: !llhd.sig<i4> , %status_cnt_q: !llhd.sig<i5> ) {
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
    %7 = llhd.const 0 : i4
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    %9 = llhd.const 0 : i5
    cond_br %6, ^if_true, ^if_false
^if_false:
    %flush_i.prb = llhd.prb %flush_i : !llhd.sig<i1>
    %10 = llhd.neq %flush_i.prb, %0 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    llhd.drv %read_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %write_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %status_cnt_q, %9 after %8 : !llhd.sig<i5>
    br ^init
^if_false1:
    %read_pointer_n.prb = llhd.prb %read_pointer_n : !llhd.sig<i4>
    llhd.drv %read_pointer_q, %read_pointer_n.prb after %8 : !llhd.sig<i4>
    %write_pointer_n.prb = llhd.prb %write_pointer_n : !llhd.sig<i4>
    llhd.drv %write_pointer_q, %write_pointer_n.prb after %8 : !llhd.sig<i4>
    %status_cnt_n.prb = llhd.prb %status_cnt_n : !llhd.sig<i5>
    llhd.drv %status_cnt_q, %status_cnt_n.prb after %8 : !llhd.sig<i5>
    br ^init
^if_true1:
    llhd.drv %read_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %write_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %status_cnt_q, %9 after %8 : !llhd.sig<i5>
    br ^init
}

llhd.proc @fifo_v3.param1.always_ff.789.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %gate_clock: !llhd.sig<i1>, %mem_n: !llhd.sig<!llhd.array<16xi32>>) -> (%mem_q: !llhd.sig<!llhd.array<16xi32>> ) {
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
    %gate_clock.prb = llhd.prb %gate_clock : !llhd.sig<i1>
    %8 = llhd.neq %gate_clock.prb, %0 : i1
    %9 = llhd.not %8 : i1
    %10 = llhd.neq %9, %0 : i1
    cond_br %10, ^if_true1, ^init
^if_true:
    %11 = llhd.const 0 : i32
    %12 = llhd.array %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11 : !llhd.array<16xi32>
    llhd.drv %mem_q, %12 after %7 : !llhd.sig<!llhd.array<16xi32>>
    br ^init
^if_true1:
    %mem_n.prb = llhd.prb %mem_n : !llhd.sig<!llhd.array<16xi32>>
    llhd.drv %mem_q, %mem_n.prb after %7 : !llhd.sig<!llhd.array<16xi32>>
    br ^init
}

llhd.proc @fifo_v3.param1.initial.805.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @fifo_v3.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %testmode_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>) -> (%full_o: !llhd.sig<i1> , %empty_o: !llhd.sig<i1> , %usage_o: !llhd.sig<i4> , %data_o: !llhd.sig<i32> ) {
    %0 = llhd.const 0 : i1
    %gate_clock = llhd.sig "gate_clock" %0 : i1
    %1 = llhd.const 0 : i4
    %read_pointer_n = llhd.sig "read_pointer_n" %1 : i4
    %read_pointer_q = llhd.sig "read_pointer_q" %1 : i4
    %write_pointer_n = llhd.sig "write_pointer_n" %1 : i4
    %write_pointer_q = llhd.sig "write_pointer_q" %1 : i4
    %2 = llhd.const 0 : i5
    %status_cnt_n = llhd.sig "status_cnt_n" %2 : i5
    %status_cnt_q = llhd.sig "status_cnt_q" %2 : i5
    %3 = llhd.const 0 : i32
    %4 = llhd.array %3, %3, %3, %3, %3, %3, %3, %3, %3, %3, %3, %3, %3, %3, %3, %3 : !llhd.array<16xi32>
    %mem_n = llhd.sig "mem_n" %4 : !llhd.array<16xi32>
    %mem_q = llhd.sig "mem_q" %4 : !llhd.array<16xi32>
    %status_cnt_q.prb = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %5 = llhd.extract_slice %status_cnt_q.prb, 0 : i5 -> i4
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %usage_o, %5 after %6 : !llhd.sig<i4>
    %7 = llhd.const 16 : i5
    %8 = llhd.eq %status_cnt_q.prb, %7 : i5
    llhd.drv %full_o, %8 after %6 : !llhd.sig<i1>
    %zext = llhd.insert_slice %3, %status_cnt_q.prb, 0 : i32, i5
    %9 = llhd.eq %zext, %3 : i32
    llhd.drv %empty_o, %9 after %6 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param1.always_comb.626.1(%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q) -> (%data_o, %gate_clock, %read_pointer_n, %write_pointer_n, %status_cnt_n, %mem_n) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>)
    llhd.inst "inst1" @fifo_v3.param1.always_ff.745.1(%clk_i, %rst_ni, %flush_i, %read_pointer_n, %write_pointer_n, %status_cnt_n) -> (%read_pointer_q, %write_pointer_q, %status_cnt_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>) -> (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>)
    llhd.inst "inst2" @fifo_v3.param1.always_ff.789.1(%clk_i, %rst_ni, %gate_clock, %mem_n) -> (%mem_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<!llhd.array<16xi32>>) -> (!llhd.sig<!llhd.array<16xi32>>)
    llhd.inst "inst3" @fifo_v3.param1.initial.805.1() -> () : () -> ()
}

llhd.proc @fifo_v3_tb.initial.987.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %7 = llhd.const 1000000 : i32
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

llhd.proc @fifo_v3_tb.always_comb.1003.0(%full_o: !llhd.sig<i1>) -> (%push_i: !llhd.sig<i1> ) {
    br ^body
^body:
    %full_o.prb = llhd.prb %full_o : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.neq %full_o.prb, %0 : i1
    %2 = llhd.not %1 : i1
    %3 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %push_i, %2 after %3 : !llhd.sig<i1>
    llhd.wait (%full_o : !llhd.sig<i1>), ^body
}

llhd.proc @fifo_v3_tb.always.1028.0(%clk_i: !llhd.sig<i1>, %full_o: !llhd.sig<i1>) -> (%data_i: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = llhd.prb %data_i : !llhd.sig<i32>
    %data_i.shadow = llhd.var %1 : i32
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %data_i : !llhd.sig<i32>
    llhd.store %data_i.shadow, %2 : !llhd.ptr<i32>
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i.prb, %3 : i1
    %5 = llhd.neq %clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %full_o.prb = llhd.prb %full_o : !llhd.sig<i1>
    %6 = llhd.neq %full_o.prb, %3 : i1
    %7 = llhd.not %6 : i1
    %iff = llhd.and %posedge, %7 : i1
    cond_br %iff, ^event, ^init
^event:
    %data_i.shadow.ld = llhd.load %data_i.shadow : !llhd.ptr<i32>
    %8 = llhd.const 1 : i32
    %9 = addi %data_i.shadow.ld, %8 : i32
    %10 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %data_i, %9 after %10 : !llhd.sig<i32>
    br ^0
}

llhd.proc @fifo_v3_tb.always_comb.1044.0(%empty_o: !llhd.sig<i1>) -> (%pop_i: !llhd.sig<i1> ) {
    br ^body
^body:
    %empty_o.prb = llhd.prb %empty_o : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.neq %empty_o.prb, %0 : i1
    %2 = llhd.not %1 : i1
    %3 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %pop_i, %2 after %3 : !llhd.sig<i1>
    llhd.wait (%empty_o : !llhd.sig<i1>), ^body
}

llhd.entity @fifo_v3_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %full_o = llhd.sig "full_o" %0 : i1
    %empty_o = llhd.sig "empty_o" %0 : i1
    %2 = llhd.const 0 : i32
    %data_i = llhd.sig "data_i" %2 : i32
    %push_i = llhd.sig "push_i" %0 : i1
    %data_o = llhd.sig "data_o" %2 : i32
    %pop_i = llhd.sig "pop_i" %0 : i1
    %3 = llhd.sig "3" %0 : i1
    %4 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %3, %0 after %4 : !llhd.sig<i1>
    %5 = llhd.sig "5" %0 : i1
    llhd.drv %5, %0 after %4 : !llhd.sig<i1>
    %6 = llhd.const 0 : i4
    %dut.usage_o.default = llhd.sig "dut.usage_o.default" %6 : i4
    llhd.inst "inst" @fifo_v3.param1(%clk_i, %rst_ni, %3, %5, %data_i, %push_i, %pop_i) -> (%full_o, %empty_o, %dut.usage_o.default, %data_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i32>)
    llhd.inst "inst1" @fifo_v3_tb.initial.987.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst2" @fifo_v3_tb.always_comb.1003.0(%full_o) -> (%push_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst3" @fifo_v3_tb.always.1028.0(%clk_i, %full_o) -> (%data_i) : (!llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst4" @fifo_v3_tb.always_comb.1044.0(%empty_o) -> (%pop_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>)
}
