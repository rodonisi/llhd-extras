llhd.proc @fifo_v3.param1.always_comb.626.1(%read_pointer_q: !llhd.sig<i4>, %write_pointer_q: !llhd.sig<i4>, %status_cnt_q: !llhd.sig<i5>, %mem_q: !llhd.sig<!llhd.array<16xi32>>, %full_o: !llhd.sig<i1>, %empty_o: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>) -> (%gate_clock: !llhd.sig<i1> , %read_pointer_n: !llhd.sig<i4> , %write_pointer_n: !llhd.sig<i4> , %status_cnt_n: !llhd.sig<i5> , %mem_n: !llhd.sig<!llhd.array<16xi32>> , %data_o: !llhd.sig<i32> ) {
    br ^body
^body:
    %read_pointer_q1 = llhd.prb %read_pointer_q : !llhd.sig<i4>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n, %read_pointer_q1 after %0 : !llhd.sig<i4>
    %write_pointer_q1 = llhd.prb %write_pointer_q : !llhd.sig<i4>
    llhd.drv %write_pointer_n, %write_pointer_q1 after %0 : !llhd.sig<i4>
    %status_cnt_q1 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    llhd.drv %status_cnt_n, %status_cnt_q1 after %0 : !llhd.sig<i5>
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    %mem_q1 = llhd.prb %mem_q : !llhd.sig<!llhd.array<16xi32>>
    %1 = llhd.const 0 : i32
    %2 = llhd.array_uniform %1 : !llhd.array<16xi32>
    // %3 = llhd.shr %mem_q1, %2, %read_pointer_q1 : (!llhd.array<16xi32>, !llhd.array<16xi32>, i4) -> !llhd.array<16xi32>
    // %4 = llhd.extract_element %3, 0 : !llhd.array<16xi32> -> i32
    %4 = llhd.dyn_extract_element %mem_q1, %read_pointer_q1 : (!llhd.array<16xi32>, i4) -> i32
    %5 = llhd.array %4, %data_i1 : !llhd.array<2xi32>
    %6 = llhd.extract_element %5, 0 : !llhd.array<2xi32> -> i32
    llhd.drv %data_o, %6 after %0 : !llhd.sig<i32>
    llhd.drv %mem_n, %mem_q1 after %0 : !llhd.sig<!llhd.array<16xi32>>
    %7 = llhd.const 1 : i1
    llhd.drv %gate_clock, %7 after %0 : !llhd.sig<i1>
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %8 = llhd.const 0 : i1
    %9 = cmpi "ne", %push_i1, %8 : i1
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %10 = llhd.not %full_o1 : i1
    %11 = cmpi "ne", %10, %8 : i1
    %12 = llhd.and %9, %11 : i1
    %13 = cmpi "ne", %12, %8 : i1
    %14 = llhd.const 0 : i4
    %15 = llhd.const 4294967295 : i32
    %16 = llhd.const 1 : i32
    %17 = llhd.insert_slice %1, %status_cnt_q1, 0 : i32, i5
    cond_br %13, ^if_true, ^if_exit
^if_exit:
    %pop_i1 = llhd.prb %pop_i : !llhd.sig<i1>
    %18 = cmpi "ne", %pop_i1, %8 : i1
    %empty_o1 = llhd.prb %empty_o : !llhd.sig<i1>
    %19 = llhd.not %empty_o1 : i1
    %20 = cmpi "ne", %19, %8 : i1
    %21 = llhd.and %18, %20 : i1
    %22 = cmpi "ne", %21, %8 : i1
    cond_br %22, ^if_true2, ^if_exit1
^if_true:
    %23 = llhd.dyn_extract_element %mem_n, %write_pointer_q1 : (!llhd.sig<!llhd.array<16xi32>>, i4) -> !llhd.sig<i32>
    llhd.drv %23, %data_i1 after %0 : !llhd.sig<i32>
    llhd.drv %gate_clock, %8 after %0 : !llhd.sig<i1>
    %24 = llhd.insert_slice %1, %write_pointer_q1, 0 : i32, i4
    %25 = llhd.array %1, %15 : !llhd.array<2xi32>
    %26 = llhd.extract_element %25, 0 : !llhd.array<2xi32> -> i32
    %27 = llhd.insert_slice %26, %14, 0 : i32, i4
    %28 = subi %27, %16 : i32
    %29 = cmpi "eq", %24, %28 : i32
    %30 = cmpi "ne", %29, %8 : i1
    cond_br %30, ^if_true1, ^if_false
^if_false:
    %31 = addi %24, %16 : i32
    %32 = llhd.extract_slice %31, 0 : i32 -> i4
    llhd.drv %write_pointer_n, %32 after %0 : !llhd.sig<i4>
    br ^if_exit2
^if_true1:
    llhd.drv %write_pointer_n, %14 after %0 : !llhd.sig<i4>
    br ^if_exit2
^if_exit1:
    %33 = llhd.and %9, %18 : i1
    %34 = cmpi "ne", %33, %8 : i1
    %35 = llhd.and %34, %11 : i1
    %36 = cmpi "ne", %35, %8 : i1
    %37 = llhd.and %36, %20 : i1
    %38 = cmpi "ne", %37, %8 : i1
    cond_br %38, ^if_true4, ^if_exit3
^if_true2:
    %read_pointer_n1 = llhd.prb %read_pointer_n : !llhd.sig<i4>
    %39 = llhd.insert_slice %1, %read_pointer_n1, 0 : i32, i4
    %40 = llhd.array %1, %15 : !llhd.array<2xi32>
    %41 = llhd.extract_element %40, 0 : !llhd.array<2xi32> -> i32
    %42 = llhd.insert_slice %41, %14, 0 : i32, i4
    %43 = subi %42, %16 : i32
    %44 = cmpi "eq", %39, %43 : i32
    %45 = cmpi "ne", %44, %8 : i1
    cond_br %45, ^if_true3, ^if_false1
^if_exit2:
    %46 = addi %17, %16 : i32
    %47 = llhd.extract_slice %46, 0 : i32 -> i5
    llhd.drv %status_cnt_n, %47 after %0 : !llhd.sig<i5>
    br ^if_exit
^if_false1:
    %48 = llhd.insert_slice %1, %read_pointer_q1, 0 : i32, i4
    %49 = addi %48, %16 : i32
    %50 = llhd.extract_slice %49, 0 : i32 -> i4
    llhd.drv %read_pointer_n, %50 after %0 : !llhd.sig<i4>
    br ^if_exit4
^if_true3:
    llhd.drv %read_pointer_n, %14 after %0 : !llhd.sig<i4>
    br ^if_exit4
^if_exit3:
    llhd.wait (%read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q, %full_o, %empty_o, %data_i, %push_i, %pop_i : !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>), ^body
^if_true4:
    llhd.drv %status_cnt_n, %status_cnt_q1 after %0 : !llhd.sig<i5>
    br ^if_exit3
^if_exit4:
    %51 = subi %17, %16 : i32
    %52 = llhd.extract_slice %51, 0 : i32 -> i5
    llhd.drv %status_cnt_n, %52 after %0 : !llhd.sig<i5>
    br ^if_exit1
}

llhd.proc @fifo_v3.param1.always_ff.745.1(%read_pointer_n: !llhd.sig<i4>, %write_pointer_n: !llhd.sig<i4>, %status_cnt_n: !llhd.sig<i5>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>) -> (%read_pointer_q: !llhd.sig<i4> , %write_pointer_q: !llhd.sig<i4> , %status_cnt_q: !llhd.sig<i5> ) {
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
    %5 = llhd.not %rst_ni2 : i1
    %6 = cmpi "ne", %5, %0 : i1
    %7 = llhd.const 0 : i4
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    %9 = llhd.const 0 : i5
    cond_br %6, ^if_true, ^if_false
^if_false:
    %flush_i1 = llhd.prb %flush_i : !llhd.sig<i1>
    %10 = cmpi "ne", %flush_i1, %0 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    llhd.drv %read_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %write_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %status_cnt_q, %9 after %8 : !llhd.sig<i5>
    br ^init
^if_false1:
    %read_pointer_n1 = llhd.prb %read_pointer_n : !llhd.sig<i4>
    llhd.drv %read_pointer_q, %read_pointer_n1 after %8 : !llhd.sig<i4>
    %write_pointer_n1 = llhd.prb %write_pointer_n : !llhd.sig<i4>
    llhd.drv %write_pointer_q, %write_pointer_n1 after %8 : !llhd.sig<i4>
    %status_cnt_n1 = llhd.prb %status_cnt_n : !llhd.sig<i5>
    llhd.drv %status_cnt_q, %status_cnt_n1 after %8 : !llhd.sig<i5>
    br ^init
^if_true1:
    llhd.drv %read_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %write_pointer_q, %7 after %8 : !llhd.sig<i4>
    llhd.drv %status_cnt_q, %9 after %8 : !llhd.sig<i5>
    br ^init
}

llhd.proc @fifo_v3.param1.always_ff.789.1(%gate_clock: !llhd.sig<i1>, %mem_n: !llhd.sig<!llhd.array<16xi32>>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>) -> (%mem_q: !llhd.sig<!llhd.array<16xi32>> ) {
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
    %5 = llhd.not %rst_ni2 : i1
    %6 = cmpi "ne", %5, %0 : i1
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %6, ^if_true, ^if_false
^if_false:
    %gate_clock1 = llhd.prb %gate_clock : !llhd.sig<i1>
    %8 = cmpi "ne", %gate_clock1, %0 : i1
    %9 = llhd.not %8 : i1
    %10 = cmpi "ne", %9, %0 : i1
    cond_br %10, ^if_true1, ^init
^if_true:
    %11 = llhd.const 0 : i32
    %12 = llhd.array %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11, %11 : !llhd.array<16xi32>
    llhd.drv %mem_q, %12 after %7 : !llhd.sig<!llhd.array<16xi32>>
    br ^init
^if_true1:
    %mem_n1 = llhd.prb %mem_n : !llhd.sig<!llhd.array<16xi32>>
    llhd.drv %mem_q, %mem_n1 after %7 : !llhd.sig<!llhd.array<16xi32>>
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
    %status_cnt_q1 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %5 = llhd.extract_slice %status_cnt_q1, 0 : i5 -> i4
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %usage_o, %5 after %6 : !llhd.sig<i4>
    %7 = llhd.const 16 : i5
    %8 = cmpi "eq", %status_cnt_q1, %7 : i5
    llhd.drv %full_o, %8 after %6 : !llhd.sig<i1>
    %9 = llhd.insert_slice %3, %status_cnt_q1, 0 : i32, i5
    %10 = cmpi "eq", %9, %3 : i32
    llhd.drv %empty_o, %10 after %6 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param1.always_comb.626.1(%read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q, %full_o, %empty_o, %data_i, %push_i, %pop_i) -> (%gate_clock, %read_pointer_n, %write_pointer_n, %status_cnt_n, %mem_n, %data_o) : (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>, !llhd.sig<i32>)
    llhd.inst "inst1" @fifo_v3.param1.always_ff.745.1(%read_pointer_n, %write_pointer_n, %status_cnt_n, %clk_i, %rst_ni, %flush_i) -> (%read_pointer_q, %write_pointer_q, %status_cnt_q) : (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>)
    llhd.inst "inst2" @fifo_v3.param1.always_ff.789.1(%gate_clock, %mem_n, %clk_i, %rst_ni) -> (%mem_q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<16xi32>>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<!llhd.array<16xi32>>)
    llhd.inst "inst3" @fifo_v3.param1.initial.805.1() -> () : () -> ()
}

llhd.proc @fifo_v3_tb.initial.979.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    br ^loop_body(%7: i32)
^loop_body(%8: i32):
    %9 = llhd.const 0 : i32
    %10 = cmpi "ne", %8, %9 : i32
    cond_br %10, ^loop_continue, ^loop_exit
^11:
    %12 = llhd.const 1 : i32
    %13 = subi %8, %12 : i32
    br ^loop_body(%13: i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %14 = llhd.const 1 : i1
    %15 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %14 after %15 : !llhd.sig<i1>
    %16 = llhd.const 0 : i1
    %17 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %16 after %17 : !llhd.sig<i1>
    llhd.wait  for %17, ^11
}

llhd.proc @fifo_v3_tb.always_comb.995.0(%full_o: !llhd.sig<i1>) -> (%push_i: !llhd.sig<i1> ) {
    br ^body
^body:
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = cmpi "ne", %full_o1, %0 : i1
    %2 = llhd.not %1 : i1
    %3 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %push_i, %2 after %3 : !llhd.sig<i1>
    llhd.wait (%full_o : !llhd.sig<i1>), ^body
}

llhd.proc @fifo_v3_tb.always.1020.0(%clk_i: !llhd.sig<i1>, %full_o: !llhd.sig<i1>) -> (%data_i: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = cmpi "eq", %clk_i1, %0 : i1
    %2 = cmpi "ne", %clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %3 = cmpi "ne", %full_o1, %0 : i1
    %4 = llhd.not %3 : i1
    %iff = llhd.and %posedge, %4 : i1
    cond_br %iff, ^event, ^init
^event:
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    %5 = llhd.const 1 : i32
    %6 = addi %data_i1, %5 : i32
    %7 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %data_i, %6 after %7 : !llhd.sig<i32>
    br ^init
}

llhd.proc @fifo_v3_tb.always_comb.1036.0(%empty_o: !llhd.sig<i1>) -> (%pop_i: !llhd.sig<i1> ) {
    br ^body
^body:
    %empty_o1 = llhd.prb %empty_o : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = cmpi "ne", %empty_o1, %0 : i1
    %2 = llhd.not %1 : i1
    %3 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %pop_i, %2 after %3 : !llhd.sig<i1>
    llhd.wait (%empty_o : !llhd.sig<i1>), ^body
}

llhd.entity @fifo_v3_tb () -> () {
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
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.sig "sig8" %0 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %clk_i1 after %4 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %5 = llhd.sig "sig9" %0 : i1
    llhd.drv %5, %rst_ni1 after %4 : !llhd.sig<i1>
    %6 = llhd.sig "sig10" %0 : i1
    llhd.drv %6, %0 after %4 : !llhd.sig<i1>
    %7 = llhd.sig "sig11" %0 : i1
    llhd.drv %7, %0 after %4 : !llhd.sig<i1>
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    %8 = llhd.sig "sig12" %2 : i32
    llhd.drv %8, %data_i1 after %4 : !llhd.sig<i32>
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %9 = llhd.sig "sig13" %0 : i1
    llhd.drv %9, %push_i1 after %4 : !llhd.sig<i1>
    %pop_i1 = llhd.prb %pop_i : !llhd.sig<i1>
    %10 = llhd.sig "sig14" %0 : i1
    llhd.drv %10, %pop_i1 after %4 : !llhd.sig<i1>
    %11 = llhd.const 0 : i4
    %dut.usage_o.default = llhd.sig "sig15" %11 : i4
    llhd.inst "inst" @fifo_v3.param1(%3, %5, %6, %7, %8, %9, %10) -> (%full_o, %empty_o, %dut.usage_o.default, %data_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i32>)
    llhd.inst "inst1" @fifo_v3_tb.initial.979.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst2" @fifo_v3_tb.always_comb.995.0(%full_o) -> (%push_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst3" @fifo_v3_tb.always.1020.0(%clk_i, %full_o) -> (%data_i) : (!llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst4" @fifo_v3_tb.always_comb.1036.0(%empty_o) -> (%pop_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>)
}
