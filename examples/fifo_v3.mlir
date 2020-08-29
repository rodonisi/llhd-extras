llhd.proc @fifo_v3.param1.always_comb.289.1(%full_o: !llhd.sig<i1>, %empty_o: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>, %read_pointer_n: !llhd.sig<i4>, %read_pointer_q: !llhd.sig<i4>, %write_pointer_q: !llhd.sig<i4>, %status_cnt_q: !llhd.sig<i5>, %mem_q: !llhd.sig<!llhd.array<16xi32>>) -> (%data_o: !llhd.sig<i32> , %gate_clock: !llhd.sig<i1> , %read_pointer_n1: !llhd.sig<i4> , %write_pointer_n: !llhd.sig<i4> , %status_cnt_n: !llhd.sig<i5> , %mem_n: !llhd.sig<!llhd.array<16xi32>> ) {
    br ^0
^0:
    %1 = llhd.prb %read_pointer_n1 : !llhd.sig<i4>
    %read_pointer_n.shadow = llhd.var %1 : i4
    br ^body
^body:
    %2 = llhd.prb %read_pointer_n1 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %2 : !llhd.ptr<i4>
    %read_pointer_q1 = llhd.prb %read_pointer_q : !llhd.sig<i4>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %read_pointer_q1 after %3 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %read_pointer_q1 : !llhd.ptr<i4>
    %write_pointer_q1 = llhd.prb %write_pointer_q : !llhd.sig<i4>
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %write_pointer_q1 after %4 : !llhd.sig<i4>
    %status_cnt_q1 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %status_cnt_q1 after %5 : !llhd.sig<i5>
    %6 = llhd.const 16 : i32
    %7 = llhd.const 0 : i32
    %8 = llhd.eq %6, %7 : i32
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    %mem_q1 = llhd.prb %mem_q : !llhd.sig<!llhd.array<16xi32>>
    %read_pointer_q2 = llhd.prb %read_pointer_q : !llhd.sig<i4>
    %9 = llhd.const 0 : i32
    %10 = llhd.array_uniform %9 : !llhd.array<16xi32>
    %11 = llhd.shr %mem_q1, %10, %read_pointer_q2 : (!llhd.array<16xi32>, !llhd.array<16xi32>, i4) -> !llhd.array<16xi32>
    %12 = llhd.extract_element %11, 0 : !llhd.array<16xi32> -> i32
    %13 = llhd.array %12, %data_i1 : !llhd.array<2xi32>
    %14 = llhd.dyn_extract_element %13, %8 : (!llhd.array<2xi32>, i1) -> i32
    %15 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_o, %14 after %15 : !llhd.sig<i32>
    %mem_q2 = llhd.prb %mem_q : !llhd.sig<!llhd.array<16xi32>>
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %mem_n, %mem_q2 after %16 : !llhd.sig<!llhd.array<16xi32>>
    %17 = llhd.const 1 : i1
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %gate_clock, %17 after %18 : !llhd.sig<i1>
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %19 = llhd.not %full_o1 : i1
    %20 = llhd.and %push_i1, %19 : i1
    cond_br %20, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %write_pointer_q2 = llhd.prb %write_pointer_q : !llhd.sig<i4>
    %21 = llhd.const 0 : i32
    %22 = llhd.array_uniform %21 : !llhd.array<16xi32>
    %23 = llhd.dyn_extract_element %mem_n, %write_pointer_q2 : (!llhd.sig<!llhd.array<16xi32>>, i4) -> !llhd.sig<i32>
    %data_i2 = llhd.prb %data_i : !llhd.sig<i32>
    %24 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %23, %data_i2 after %24 : !llhd.sig<i32>
    %25 = llhd.const 0 : i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %gate_clock, %25 after %26 : !llhd.sig<i1>
    %27 = llhd.const 0 : i32
    %write_pointer_q3 = llhd.prb %write_pointer_q : !llhd.sig<i4>
    %28 = llhd.insert_slice %27, %write_pointer_q3, 0 : i32, i4
    %29 = llhd.const 16 : i32
    %30 = llhd.const 0 : i1
    %31 = llhd.const 0 : i32
    %32 = llhd.shr %29, %31, %30 : (i32, i32, i1) -> i32
    %33 = llhd.extract_slice %32, 0 : i32 -> i4
    %34 = llhd.extract_slice %33, 3 : i4 -> i1
    %35 = llhd.const 0 : i32
    %36 = llhd.not %35 : i32
    %37 = llhd.array %35, %36 : !llhd.array<2xi32>
    %38 = llhd.dyn_extract_element %37, %34 : (!llhd.array<2xi32>, i1) -> i32
    %39 = llhd.insert_slice %38, %33, 0 : i32, i4
    %40 = llhd.const 1 : i32
    %41 = subi %39, %40 : i32
    %42 = llhd.eq %28, %41 : i32
    cond_br %42, ^if_true1, ^if_false1
^check:
    llhd.wait (%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_n1, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>), ^body
^if_false1:
    %43 = llhd.const 0 : i32
    %write_pointer_q4 = llhd.prb %write_pointer_q : !llhd.sig<i4>
    %44 = llhd.insert_slice %43, %write_pointer_q4, 0 : i32, i4
    %45 = llhd.const 1 : i32
    %46 = addi %44, %45 : i32
    %47 = llhd.extract_slice %46, 0 : i32 -> i4
    %48 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %47 after %48 : !llhd.sig<i4>
    br ^if_exit1
^if_true1:
    %49 = llhd.const 0 : i4
    %50 = llhd.const 0 : i1
    %51 = llhd.insert_slice %49, %50, 0 : i4, i1
    %52 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %51 after %52 : !llhd.sig<i4>
    br ^if_exit1
^if_exit:
    %pop_i1 = llhd.prb %pop_i : !llhd.sig<i1>
    %empty_o1 = llhd.prb %empty_o : !llhd.sig<i1>
    %53 = llhd.not %empty_o1 : i1
    %54 = llhd.and %pop_i1, %53 : i1
    cond_br %54, ^if_true2, ^if_false2
^if_false2:
    br ^if_exit2
^if_true2:
    %55 = llhd.const 0 : i32
    %read_pointer_n2 = llhd.load %read_pointer_n.shadow : !llhd.ptr<i4>
    %56 = llhd.insert_slice %55, %read_pointer_n2, 0 : i32, i4
    %57 = llhd.const 16 : i32
    %58 = llhd.const 0 : i1
    %59 = llhd.const 0 : i32
    %60 = llhd.shr %57, %59, %58 : (i32, i32, i1) -> i32
    %61 = llhd.extract_slice %60, 0 : i32 -> i4
    %62 = llhd.extract_slice %61, 3 : i4 -> i1
    %63 = llhd.const 0 : i32
    %64 = llhd.not %63 : i32
    %65 = llhd.array %63, %64 : !llhd.array<2xi32>
    %66 = llhd.dyn_extract_element %65, %62 : (!llhd.array<2xi32>, i1) -> i32
    %67 = llhd.insert_slice %66, %61, 0 : i32, i4
    %68 = llhd.const 1 : i32
    %69 = subi %67, %68 : i32
    %70 = llhd.eq %56, %69 : i32
    cond_br %70, ^if_true3, ^if_false3
^if_exit1:
    %71 = llhd.const 0 : i32
    %status_cnt_q2 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %72 = llhd.insert_slice %71, %status_cnt_q2, 0 : i32, i5
    %73 = llhd.const 1 : i32
    %74 = addi %72, %73 : i32
    %75 = llhd.extract_slice %74, 0 : i32 -> i5
    %76 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %75 after %76 : !llhd.sig<i5>
    br ^if_exit
^if_false3:
    %77 = llhd.const 0 : i32
    %read_pointer_q3 = llhd.prb %read_pointer_q : !llhd.sig<i4>
    %78 = llhd.insert_slice %77, %read_pointer_q3, 0 : i32, i4
    %79 = llhd.const 1 : i32
    %80 = addi %78, %79 : i32
    %81 = llhd.extract_slice %80, 0 : i32 -> i4
    %82 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %81 after %82 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %81 : !llhd.ptr<i4>
    br ^if_exit3
^if_true3:
    %83 = llhd.const 0 : i4
    %84 = llhd.const 0 : i1
    %85 = llhd.insert_slice %83, %84, 0 : i4, i1
    %86 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %85 after %86 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %85 : !llhd.ptr<i4>
    br ^if_exit3
^if_exit2:
    %push_i2 = llhd.prb %push_i : !llhd.sig<i1>
    %pop_i2 = llhd.prb %pop_i : !llhd.sig<i1>
    %87 = llhd.and %push_i2, %pop_i2 : i1
    %full_o2 = llhd.prb %full_o : !llhd.sig<i1>
    %88 = llhd.not %full_o2 : i1
    %89 = llhd.and %87, %88 : i1
    %empty_o2 = llhd.prb %empty_o : !llhd.sig<i1>
    %90 = llhd.not %empty_o2 : i1
    %91 = llhd.and %89, %90 : i1
    cond_br %91, ^if_true4, ^if_false4
^if_false4:
    br ^if_exit4
^if_true4:
    %status_cnt_q4 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %92 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %status_cnt_q4 after %92 : !llhd.sig<i5>
    br ^if_exit4
^if_exit3:
    %93 = llhd.const 0 : i32
    %status_cnt_q3 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %94 = llhd.insert_slice %93, %status_cnt_q3, 0 : i32, i5
    %95 = llhd.const 1 : i32
    %96 = subi %94, %95 : i32
    %97 = llhd.extract_slice %96, 0 : i32 -> i5
    %98 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %97 after %98 : !llhd.sig<i5>
    br ^if_exit2
^if_exit4:
    %99 = llhd.const 0 : i1
    %100 = llhd.const 0 : i32
    %status_cnt_q5 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %101 = llhd.insert_slice %100, %status_cnt_q5, 0 : i32, i5
    %102 = llhd.const 0 : i32
    %103 = llhd.eq %101, %102 : i32
    %104 = llhd.and %99, %103 : i1
    %push_i3 = llhd.prb %push_i : !llhd.sig<i1>
    %105 = llhd.and %104, %push_i3 : i1
    cond_br %105, ^if_true5, ^if_false5
^if_false5:
    br ^if_exit5
^if_true5:
    %data_i3 = llhd.prb %data_i : !llhd.sig<i32>
    %106 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_o, %data_i3 after %106 : !llhd.sig<i32>
    %pop_i3 = llhd.prb %pop_i : !llhd.sig<i1>
    cond_br %pop_i3, ^if_true6, ^if_false6
^if_false6:
    br ^if_exit6
^if_true6:
    %status_cnt_q6 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %107 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %status_cnt_q6 after %107 : !llhd.sig<i5>
    %read_pointer_q4 = llhd.prb %read_pointer_q : !llhd.sig<i4>
    %108 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %read_pointer_q4 after %108 : !llhd.sig<i4>
    llhd.store %read_pointer_n.shadow, %read_pointer_q4 : !llhd.ptr<i4>
    %write_pointer_q5 = llhd.prb %write_pointer_q : !llhd.sig<i4>
    %109 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %write_pointer_q5 after %109 : !llhd.sig<i4>
    br ^if_exit6
^if_exit5:
    br ^check
^if_exit6:
    br ^if_exit5
}

llhd.proc @fifo_v3.param1.always_ff.290.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %read_pointer_n: !llhd.sig<i4>, %write_pointer_n: !llhd.sig<i4>, %status_cnt_n: !llhd.sig<i5>) -> (%read_pointer_q: !llhd.sig<i4> , %write_pointer_q: !llhd.sig<i4> , %status_cnt_q: !llhd.sig<i5> ) {
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
    %flush_i1 = llhd.prb %flush_i : !llhd.sig<i1>
    cond_br %flush_i1, ^if_true1, ^if_false1
^if_true:
    %8 = llhd.const 0 : i4
    %9 = llhd.const 0 : i1
    %10 = llhd.insert_slice %8, %9, 0 : i4, i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %read_pointer_q, %10 after %11 : !llhd.sig<i4>
    %12 = llhd.const 0 : i4
    %13 = llhd.const 0 : i1
    %14 = llhd.insert_slice %12, %13, 0 : i4, i1
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %write_pointer_q, %14 after %15 : !llhd.sig<i4>
    %16 = llhd.const 0 : i5
    %17 = llhd.const 0 : i1
    %18 = llhd.insert_slice %16, %17, 0 : i5, i1
    %19 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %status_cnt_q, %18 after %19 : !llhd.sig<i5>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    %read_pointer_n1 = llhd.prb %read_pointer_n : !llhd.sig<i4>
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %read_pointer_q, %read_pointer_n1 after %20 : !llhd.sig<i4>
    %write_pointer_n1 = llhd.prb %write_pointer_n : !llhd.sig<i4>
    %21 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %write_pointer_q, %write_pointer_n1 after %21 : !llhd.sig<i4>
    %status_cnt_n1 = llhd.prb %status_cnt_n : !llhd.sig<i5>
    %22 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %status_cnt_q, %status_cnt_n1 after %22 : !llhd.sig<i5>
    br ^if_exit1
^if_true1:
    %23 = llhd.const 0 : i4
    %24 = llhd.const 0 : i1
    %25 = llhd.insert_slice %23, %24, 0 : i4, i1
    %26 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %read_pointer_q, %25 after %26 : !llhd.sig<i4>
    %27 = llhd.const 0 : i4
    %28 = llhd.const 0 : i1
    %29 = llhd.insert_slice %27, %28, 0 : i4, i1
    %30 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %write_pointer_q, %29 after %30 : !llhd.sig<i4>
    %31 = llhd.const 0 : i5
    %32 = llhd.const 0 : i1
    %33 = llhd.insert_slice %31, %32, 0 : i5, i1
    %34 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %status_cnt_q, %33 after %34 : !llhd.sig<i5>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @fifo_v3.param1.always_ff.291.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %gate_clock: !llhd.sig<i1>, %mem_n: !llhd.sig<!llhd.array<16xi32>>) -> (%mem_q: !llhd.sig<!llhd.array<16xi32>> ) {
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
    %gate_clock1 = llhd.prb %gate_clock : !llhd.sig<i1>
    %8 = llhd.not %gate_clock1 : i1
    cond_br %8, ^if_true1, ^if_false1
^if_true:
    %9 = llhd.const 0 : i512
    %10 = llhd.const 0 : i1
    %11 = llhd.insert_slice %9, %10, 0 : i512, i1
    %12 = llhd.const 0 : i32
    %13 = llhd.const 0 : i512
    %14 = llhd.shr %11, %13, %12 : (i512, i512, i32) -> i512
    %15 = llhd.extract_slice %14, 0 : i512 -> i32
    %16 = llhd.const 0 : i512
    %17 = llhd.const 0 : i1
    %18 = llhd.insert_slice %16, %17, 0 : i512, i1
    %19 = llhd.const 32 : i32
    %20 = llhd.const 0 : i512
    %21 = llhd.shr %18, %20, %19 : (i512, i512, i32) -> i512
    %22 = llhd.extract_slice %21, 0 : i512 -> i32
    %23 = llhd.const 0 : i512
    %24 = llhd.const 0 : i1
    %25 = llhd.insert_slice %23, %24, 0 : i512, i1
    %26 = llhd.const 64 : i32
    %27 = llhd.const 0 : i512
    %28 = llhd.shr %25, %27, %26 : (i512, i512, i32) -> i512
    %29 = llhd.extract_slice %28, 0 : i512 -> i32
    %30 = llhd.const 0 : i512
    %31 = llhd.const 0 : i1
    %32 = llhd.insert_slice %30, %31, 0 : i512, i1
    %33 = llhd.const 96 : i32
    %34 = llhd.const 0 : i512
    %35 = llhd.shr %32, %34, %33 : (i512, i512, i32) -> i512
    %36 = llhd.extract_slice %35, 0 : i512 -> i32
    %37 = llhd.const 0 : i512
    %38 = llhd.const 0 : i1
    %39 = llhd.insert_slice %37, %38, 0 : i512, i1
    %40 = llhd.const 128 : i32
    %41 = llhd.const 0 : i512
    %42 = llhd.shr %39, %41, %40 : (i512, i512, i32) -> i512
    %43 = llhd.extract_slice %42, 0 : i512 -> i32
    %44 = llhd.const 0 : i512
    %45 = llhd.const 0 : i1
    %46 = llhd.insert_slice %44, %45, 0 : i512, i1
    %47 = llhd.const 160 : i32
    %48 = llhd.const 0 : i512
    %49 = llhd.shr %46, %48, %47 : (i512, i512, i32) -> i512
    %50 = llhd.extract_slice %49, 0 : i512 -> i32
    %51 = llhd.const 0 : i512
    %52 = llhd.const 0 : i1
    %53 = llhd.insert_slice %51, %52, 0 : i512, i1
    %54 = llhd.const 192 : i32
    %55 = llhd.const 0 : i512
    %56 = llhd.shr %53, %55, %54 : (i512, i512, i32) -> i512
    %57 = llhd.extract_slice %56, 0 : i512 -> i32
    %58 = llhd.const 0 : i512
    %59 = llhd.const 0 : i1
    %60 = llhd.insert_slice %58, %59, 0 : i512, i1
    %61 = llhd.const 224 : i32
    %62 = llhd.const 0 : i512
    %63 = llhd.shr %60, %62, %61 : (i512, i512, i32) -> i512
    %64 = llhd.extract_slice %63, 0 : i512 -> i32
    %65 = llhd.const 0 : i512
    %66 = llhd.const 0 : i1
    %67 = llhd.insert_slice %65, %66, 0 : i512, i1
    %68 = llhd.const 256 : i32
    %69 = llhd.const 0 : i512
    %70 = llhd.shr %67, %69, %68 : (i512, i512, i32) -> i512
    %71 = llhd.extract_slice %70, 0 : i512 -> i32
    %72 = llhd.const 0 : i512
    %73 = llhd.const 0 : i1
    %74 = llhd.insert_slice %72, %73, 0 : i512, i1
    %75 = llhd.const 288 : i32
    %76 = llhd.const 0 : i512
    %77 = llhd.shr %74, %76, %75 : (i512, i512, i32) -> i512
    %78 = llhd.extract_slice %77, 0 : i512 -> i32
    %79 = llhd.const 0 : i512
    %80 = llhd.const 0 : i1
    %81 = llhd.insert_slice %79, %80, 0 : i512, i1
    %82 = llhd.const 320 : i32
    %83 = llhd.const 0 : i512
    %84 = llhd.shr %81, %83, %82 : (i512, i512, i32) -> i512
    %85 = llhd.extract_slice %84, 0 : i512 -> i32
    %86 = llhd.const 0 : i512
    %87 = llhd.const 0 : i1
    %88 = llhd.insert_slice %86, %87, 0 : i512, i1
    %89 = llhd.const 352 : i32
    %90 = llhd.const 0 : i512
    %91 = llhd.shr %88, %90, %89 : (i512, i512, i32) -> i512
    %92 = llhd.extract_slice %91, 0 : i512 -> i32
    %93 = llhd.const 0 : i512
    %94 = llhd.const 0 : i1
    %95 = llhd.insert_slice %93, %94, 0 : i512, i1
    %96 = llhd.const 384 : i32
    %97 = llhd.const 0 : i512
    %98 = llhd.shr %95, %97, %96 : (i512, i512, i32) -> i512
    %99 = llhd.extract_slice %98, 0 : i512 -> i32
    %100 = llhd.const 0 : i512
    %101 = llhd.const 0 : i1
    %102 = llhd.insert_slice %100, %101, 0 : i512, i1
    %103 = llhd.const 416 : i32
    %104 = llhd.const 0 : i512
    %105 = llhd.shr %102, %104, %103 : (i512, i512, i32) -> i512
    %106 = llhd.extract_slice %105, 0 : i512 -> i32
    %107 = llhd.const 0 : i512
    %108 = llhd.const 0 : i1
    %109 = llhd.insert_slice %107, %108, 0 : i512, i1
    %110 = llhd.const 448 : i32
    %111 = llhd.const 0 : i512
    %112 = llhd.shr %109, %111, %110 : (i512, i512, i32) -> i512
    %113 = llhd.extract_slice %112, 0 : i512 -> i32
    %114 = llhd.const 0 : i512
    %115 = llhd.const 0 : i1
    %116 = llhd.insert_slice %114, %115, 0 : i512, i1
    %117 = llhd.const 480 : i32
    %118 = llhd.const 0 : i512
    %119 = llhd.shr %116, %118, %117 : (i512, i512, i32) -> i512
    %120 = llhd.extract_slice %119, 0 : i512 -> i32
    %121 = llhd.array %15, %22, %29, %36, %43, %50, %57, %64, %71, %78, %85, %92, %99, %106, %113, %120 : !llhd.array<16xi32>
    %122 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %mem_q, %121 after %122 : !llhd.sig<!llhd.array<16xi32>>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %mem_n1 = llhd.prb %mem_n : !llhd.sig<!llhd.array<16xi32>>
    %123 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %mem_q, %mem_n1 after %123 : !llhd.sig<!llhd.array<16xi32>>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @fifo_v3.param1.initial.292.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @fifo_v3.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %testmode_i: !llhd.sig<i1>, %data_i: !llhd.sig<i32>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>) -> (%full_o: !llhd.sig<i1> , %empty_o: !llhd.sig<i1> , %usage_o: !llhd.sig<i4> , %data_o: !llhd.sig<i32> ) {
    %0 = llhd.const 0 : i1
    %gate_clock = llhd.sig "gate_clock" %0 : i1
    %1 = llhd.const 0 : i4
    %read_pointer_n = llhd.sig "read_pointer_n" %1 : i4
    %2 = llhd.const 0 : i4
    %read_pointer_q = llhd.sig "read_pointer_q" %2 : i4
    %3 = llhd.const 0 : i4
    %write_pointer_n = llhd.sig "write_pointer_n" %3 : i4
    %4 = llhd.const 0 : i4
    %write_pointer_q = llhd.sig "write_pointer_q" %4 : i4
    %5 = llhd.const 0 : i5
    %status_cnt_n = llhd.sig "status_cnt_n" %5 : i5
    %6 = llhd.const 0 : i5
    %status_cnt_q = llhd.sig "status_cnt_q" %6 : i5
    %7 = llhd.const 0 : i32
    %8 = llhd.const 0 : i32
    %9 = llhd.const 0 : i32
    %10 = llhd.const 0 : i32
    %11 = llhd.const 0 : i32
    %12 = llhd.const 0 : i32
    %13 = llhd.const 0 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.const 0 : i32
    %16 = llhd.const 0 : i32
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i32
    %19 = llhd.const 0 : i32
    %20 = llhd.const 0 : i32
    %21 = llhd.const 0 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22 : !llhd.array<16xi32>
    %mem_n = llhd.sig "mem_n" %23 : !llhd.array<16xi32>
    %24 = llhd.const 0 : i32
    %25 = llhd.const 0 : i32
    %26 = llhd.const 0 : i32
    %27 = llhd.const 0 : i32
    %28 = llhd.const 0 : i32
    %29 = llhd.const 0 : i32
    %30 = llhd.const 0 : i32
    %31 = llhd.const 0 : i32
    %32 = llhd.const 0 : i32
    %33 = llhd.const 0 : i32
    %34 = llhd.const 0 : i32
    %35 = llhd.const 0 : i32
    %36 = llhd.const 0 : i32
    %37 = llhd.const 0 : i32
    %38 = llhd.const 0 : i32
    %39 = llhd.const 0 : i32
    %40 = llhd.array %24, %25, %26, %27, %28, %29, %30, %31, %32, %33, %34, %35, %36, %37, %38, %39 : !llhd.array<16xi32>
    %mem_q = llhd.sig "mem_q" %40 : !llhd.array<16xi32>
    %status_cnt_q1 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %41 = llhd.const 0 : i1
    %42 = llhd.const 0 : i5
    %43 = llhd.shr %status_cnt_q1, %42, %41 : (i5, i5, i1) -> i5
    %44 = llhd.extract_slice %43, 0 : i5 -> i4
    %45 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %usage_o, %44 after %45 : !llhd.sig<i4>
    %status_cnt_q2 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %46 = llhd.const 16 : i32
    %47 = llhd.const 0 : i1
    %48 = llhd.const 0 : i32
    %49 = llhd.shr %46, %48, %47 : (i32, i32, i1) -> i32
    %50 = llhd.extract_slice %49, 0 : i32 -> i5
    %51 = llhd.eq %status_cnt_q2, %50 : i5
    %52 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %full_o, %51 after %52 : !llhd.sig<i1>
    %53 = llhd.const 0 : i32
    %status_cnt_q3 = llhd.prb %status_cnt_q : !llhd.sig<i5>
    %54 = llhd.insert_slice %53, %status_cnt_q3, 0 : i32, i5
    %55 = llhd.const 0 : i32
    %56 = llhd.eq %54, %55 : i32
    %57 = llhd.const 0 : i1
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %58 = llhd.and %57, %push_i1 : i1
    %59 = llhd.not %58 : i1
    %60 = llhd.and %56, %59 : i1
    %61 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %empty_o, %60 after %61 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param1.always_comb.289.1(%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_n, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q) -> (%data_o, %gate_clock, %read_pointer_n, %write_pointer_n, %status_cnt_n, %mem_n) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>, !llhd.sig<!llhd.array<16xi32>>)
    llhd.inst "inst1" @fifo_v3.param1.always_ff.290.1(%clk_i, %rst_ni, %flush_i, %read_pointer_n, %write_pointer_n, %status_cnt_n) -> (%read_pointer_q, %write_pointer_q, %status_cnt_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>) -> (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i5>)
    llhd.inst "inst2" @fifo_v3.param1.always_ff.291.1(%clk_i, %rst_ni, %gate_clock, %mem_n) -> (%mem_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<!llhd.array<16xi32>>) -> (!llhd.sig<!llhd.array<16xi32>>)
    llhd.inst "inst3" @fifo_v3.param1.initial.292.1() -> () : () -> ()
}

llhd.proc @fifo_v3_tb.initial.240.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %9 = llhd.const 1000000 : i32
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

llhd.proc @fifo_v3_tb.always_comb.241.0(%full_o: !llhd.sig<i1>) -> (%push_i: !llhd.sig<i1> ) {
    br ^0
^0:
    br ^body
^body:
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %1 = llhd.not %full_o1 : i1
    %2 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %push_i, %1 after %2 : !llhd.sig<i1>
    br ^check
^check:
    llhd.wait (%full_o : !llhd.sig<i1>), ^body
}

llhd.proc @fifo_v3_tb.always.242.0(%clk_i: !llhd.sig<i1>, %full_o: !llhd.sig<i1>, %data_i: !llhd.sig<i32>) -> (%data_i1: !llhd.sig<i32> ) {
    br ^0
^0:
    %1 = llhd.prb %data_i1 : !llhd.sig<i32>
    %data_i.shadow = llhd.var %1 : i32
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %data_i1 : !llhd.sig<i32>
    llhd.store %data_i.shadow, %2 : !llhd.ptr<i32>
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %clk_i1, %3 : i1
    %5 = llhd.neq %clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %6 = llhd.not %full_o1 : i1
    %iff = llhd.and %posedge, %6 : i1
    cond_br %iff, ^event, ^init
^event:
    %data_i2 = llhd.load %data_i.shadow : !llhd.ptr<i32>
    %7 = llhd.const 1 : i32
    %8 = addi %data_i2, %7 : i32
    %9 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %data_i1, %8 after %9 : !llhd.sig<i32>
    br ^0
}

llhd.proc @fifo_v3_tb.always_comb.243.0(%empty_o: !llhd.sig<i1>) -> (%pop_i: !llhd.sig<i1> ) {
    br ^0
^0:
    br ^body
^body:
    %empty_o1 = llhd.prb %empty_o : !llhd.sig<i1>
    %1 = llhd.not %empty_o1 : i1
    %2 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.drv %pop_i, %1 after %2 : !llhd.sig<i1>
    br ^check
^check:
    llhd.wait (%empty_o : !llhd.sig<i1>), ^body
}

llhd.entity @fifo_v3_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %2 = llhd.const 0 : i1
    %full_o = llhd.sig "full_o" %2 : i1
    %3 = llhd.const 0 : i1
    %empty_o = llhd.sig "empty_o" %3 : i1
    %4 = llhd.const 0 : i32
    %data_i = llhd.sig "data_i" %4 : i32
    %5 = llhd.const 0 : i1
    %push_i = llhd.sig "push_i" %5 : i1
    %6 = llhd.const 0 : i32
    %data_o = llhd.sig "data_o" %6 : i32
    %7 = llhd.const 0 : i1
    %pop_i = llhd.sig "pop_i" %7 : i1
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %8 = llhd.const 0 : i1
    %9 = llhd.sig "9" %8 : i1
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %9, %clk_i1 after %10 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %11 = llhd.const 0 : i1
    %12 = llhd.sig "12" %11 : i1
    %13 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %12, %rst_ni1 after %13 : !llhd.sig<i1>
    %14 = llhd.const 0 : i1
    %15 = llhd.const 0 : i1
    %16 = llhd.sig "16" %15 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %16, %14 after %17 : !llhd.sig<i1>
    %18 = llhd.const 0 : i1
    %19 = llhd.const 0 : i1
    %20 = llhd.sig "20" %19 : i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %20, %18 after %21 : !llhd.sig<i1>
    %22 = llhd.const 0 : i4
    %23 = llhd.sig "23" %22 : i4
    %data_i1 = llhd.prb %data_i : !llhd.sig<i32>
    %24 = llhd.const 0 : i32
    %25 = llhd.sig "25" %24 : i32
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %25, %data_i1 after %26 : !llhd.sig<i32>
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %27 = llhd.const 0 : i1
    %28 = llhd.sig "28" %27 : i1
    %29 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %28, %push_i1 after %29 : !llhd.sig<i1>
    %pop_i1 = llhd.prb %pop_i : !llhd.sig<i1>
    %30 = llhd.const 0 : i1
    %31 = llhd.sig "31" %30 : i1
    %32 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %31, %pop_i1 after %32 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param1(%9, %12, %16, %20, %25, %28, %31) -> (%full_o, %empty_o, %23, %data_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i32>)
    llhd.inst "inst1" @fifo_v3_tb.initial.240.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst2" @fifo_v3_tb.always_comb.241.0(%full_o) -> (%push_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst3" @fifo_v3_tb.always.242.0(%clk_i, %full_o, %data_i) -> (%data_i) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst4" @fifo_v3_tb.always_comb.243.0(%empty_o) -> (%pop_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>)
}
