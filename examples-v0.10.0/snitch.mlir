llhd.proc @snitch_regfile.param3.always_comb.24878.3(%waddr_i: !llhd.sig<!llhd.array<1xi5>>, %we_i: !llhd.sig<i1>) -> (%we_dec: !llhd.sig<!llhd.array<1xi32>> ) {
    br ^body
^body:
    %0 = llhd.const 0 : i32
    br ^loop_body(%0 : i32)
^loop_body(%j.ld: i32):
    %1 = llhd.const 1 : i32
    %2 = cmpi "ult", %j.ld, %1 : i32
    cond_br %2, ^loop_continue, ^check
^check:
    llhd.wait (%waddr_i, %we_i : !llhd.sig<!llhd.array<1xi5>>, !llhd.sig<i1>), ^body
^loop_exit:
    %3 = addi %j.ld, %1 : i32
    br ^loop_body(%3 : i32)
^loop_continue:
    br ^loop_body1(%0 : i32)
^loop_body1(%j.ld1: i32):
    %4 = llhd.const 32 : i32
    %5 = cmpi "ult", %j.ld1, %4 : i32
    cond_br %5, ^loop_continue1, ^loop_exit
^if_exit(%j.ld2: i32):
    %6 = addi %j.ld2, %1 : i32
    br ^loop_body1(%6 : i32)
^loop_continue1:
    %waddr_i.prb = llhd.prb %waddr_i : !llhd.sig<!llhd.array<1xi5>>
    %7 = llhd.const 0 : i5
    %8 = llhd.array_uniform %7 : !llhd.array<1xi5>
    %9 = llhd.shr %waddr_i.prb, %8, %j.ld : (!llhd.array<1xi5>, !llhd.array<1xi5>, i32) -> !llhd.array<1xi5>
    %10 = llhd.extract_element %9, 0 : !llhd.array<1xi5> -> i5
    %zext = llhd.insert_slice %0, %10, 0 : i32, i5
    %11 = llhd.eq %zext, %j.ld1 : i32
    %12 = llhd.const 0 : i1
    %13 = llhd.neq %11, %12 : i1
    %14 = llhd.array_uniform %0 : !llhd.array<1xi32>
    %15 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    cond_br %13, ^if_true, ^if_false
^if_false:
    %16 = llhd.dyn_extract_element %we_dec, %j.ld : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.dyn_extract_slice %16, %j.ld1 : (!llhd.sig<i32>, i32) -> !llhd.sig<i1>
    llhd.drv %17, %12 after %15 : !llhd.sig<i1>
    br ^if_exit(%j.ld1 : i32)
^if_true:
    %18 = llhd.dyn_extract_element %we_dec, %j.ld : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %19 = llhd.dyn_extract_slice %18, %j.ld1 : (!llhd.sig<i32>, i32) -> !llhd.sig<i1>
    %we_i.prb = llhd.prb %we_i : !llhd.sig<i1>
    %20 = llhd.shr %we_i.prb, %12, %j.ld : (i1, i1, i32) -> i1
    llhd.drv %19, %20 after %15 : !llhd.sig<i1>
    br ^if_exit(%j.ld1 : i32)
}

llhd.proc @snitch_regfile.param3.always_ff.25008.3(%clk_i: !llhd.sig<i1>, %wdata_i: !llhd.sig<!llhd.array<1xi32>>, %we_dec: !llhd.sig<!llhd.array<1xi32>>) -> (%mem: !llhd.sig<!llhd.array<32xi32>> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = llhd.const 0 : i32
    br ^loop_body(%3 : i32)
^loop_body(%j.ld: i32):
    %4 = llhd.const 1 : i32
    %5 = cmpi "ult", %j.ld, %4 : i32
    cond_br %5, ^loop_continue, ^init
^loop_exit:
    %6 = llhd.extract_element %mem, 0 : !llhd.sig<!llhd.array<32xi32>> -> !llhd.sig<i32>
    llhd.drv %6, %3 after %7 : !llhd.sig<i32>
    %8 = addi %j.ld, %4 : i32
    br ^loop_body(%8 : i32)
^loop_continue:
    br ^loop_body1(%3 : i32)
^loop_body1(%i.ld: i32):
    %9 = llhd.const 32 : i32
    %10 = cmpi "ult", %i.ld, %9 : i32
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %10, ^loop_continue1, ^loop_exit
^if_exit(%j.ld1: i32):
    %11 = addi %j.ld1, %4 : i32
    br ^loop_body1(%11 : i32)
^loop_continue1:
    %we_dec.prb = llhd.prb %we_dec : !llhd.sig<!llhd.array<1xi32>>
    %12 = llhd.array_uniform %3 : !llhd.array<1xi32>
    %13 = llhd.shr %we_dec.prb, %12, %j.ld : (!llhd.array<1xi32>, !llhd.array<1xi32>, i32) -> !llhd.array<1xi32>
    %14 = llhd.extract_element %13, 0 : !llhd.array<1xi32> -> i32
    %15 = llhd.shr %14, %3, %i.ld : (i32, i32, i32) -> i32
    %16 = llhd.extract_slice %15, 0 : i32 -> i1
    %17 = llhd.neq %16, %0 : i1
    cond_br %17, ^if_true, ^if_false
^if_false:
    br ^if_exit(%i.ld : i32)
^if_true:
    %18 = llhd.array_uniform %3 : !llhd.array<32xi32>
    %19 = llhd.dyn_extract_element %mem, %i.ld : (!llhd.sig<!llhd.array<32xi32>>, i32) -> !llhd.sig<i32>
    %wdata_i.prb = llhd.prb %wdata_i : !llhd.sig<!llhd.array<1xi32>>
    %20 = llhd.shr %wdata_i.prb, %12, %j.ld : (!llhd.array<1xi32>, !llhd.array<1xi32>, i32) -> !llhd.array<1xi32>
    %21 = llhd.extract_element %20, 0 : !llhd.array<1xi32> -> i32
    llhd.drv %19, %21 after %7 : !llhd.sig<i32>
    br ^if_exit(%i.ld : i32)
}

llhd.entity @snitch_regfile.param3(%clk_i: !llhd.sig<i1>, %raddr_i: !llhd.sig<!llhd.array<2xi5>>, %waddr_i: !llhd.sig<!llhd.array<1xi5>>, %wdata_i: !llhd.sig<!llhd.array<1xi32>>, %we_i: !llhd.sig<i1>) -> (%rdata_o: !llhd.sig<!llhd.array<2xi32>> ) {
    %0 = llhd.const 0 : i32
    %1 = llhd.array %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0 : !llhd.array<32xi32>
    %mem = llhd.sig "mem" %1 : !llhd.array<32xi32>
    %2 = llhd.array %0 : !llhd.array<1xi32>
    %we_dec = llhd.sig "we_dec" %2 : !llhd.array<1xi32>
    %3 = llhd.extract_element %rdata_o, 0 : !llhd.sig<!llhd.array<2xi32>> -> !llhd.sig<i32>
    %mem.prb = llhd.prb %mem : !llhd.sig<!llhd.array<32xi32>>
    %raddr_i.prb = llhd.prb %raddr_i : !llhd.sig<!llhd.array<2xi5>>
    %4 = llhd.extract_element %raddr_i.prb, 0 : !llhd.array<2xi5> -> i5
    %5 = llhd.array_uniform %0 : !llhd.array<32xi32>
    %6 = llhd.shr %mem.prb, %5, %4 : (!llhd.array<32xi32>, !llhd.array<32xi32>, i5) -> !llhd.array<32xi32>
    %7 = llhd.extract_element %6, 0 : !llhd.array<32xi32> -> i32
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %7 after %8 : !llhd.sig<i32>
    %9 = llhd.const 1 : i32
    %10 = llhd.array_uniform %0 : !llhd.array<2xi32>
    %11 = llhd.sig "11" %10 : !llhd.array<2xi32>
    %12 = llhd.shr %rdata_o, %11, %9 : (!llhd.sig<!llhd.array<2xi32>>, !llhd.sig<!llhd.array<2xi32>>, i32) -> !llhd.sig<!llhd.array<2xi32>>
    %13 = llhd.extract_element %12, 0 : !llhd.sig<!llhd.array<2xi32>> -> !llhd.sig<i32>
    %14 = llhd.const 0 : i5
    %15 = llhd.array_uniform %14 : !llhd.array<2xi5>
    %16 = llhd.extract_slice %15, 0 : !llhd.array<2xi5> -> !llhd.array<1xi5>
    %17 = llhd.extract_slice %raddr_i.prb, 1 : !llhd.array<2xi5> -> !llhd.array<1xi5>
    %18 = llhd.insert_slice %15, %16, 1 : !llhd.array<2xi5>, !llhd.array<1xi5>
    %19 = llhd.insert_slice %18, %17, 0 : !llhd.array<2xi5>, !llhd.array<1xi5>
    %20 = llhd.extract_element %19, 0 : !llhd.array<2xi5> -> i5
    %21 = llhd.shr %mem.prb, %5, %20 : (!llhd.array<32xi32>, !llhd.array<32xi32>, i5) -> !llhd.array<32xi32>
    %22 = llhd.extract_element %21, 0 : !llhd.array<32xi32> -> i32
    llhd.drv %13, %22 after %8 : !llhd.sig<i32>
    llhd.inst "inst" @snitch_regfile.param3.always_comb.24878.3(%waddr_i, %we_i) -> (%we_dec) : (!llhd.sig<!llhd.array<1xi5>>, !llhd.sig<i1>) -> (!llhd.sig<!llhd.array<1xi32>>)
    llhd.inst "inst1" @snitch_regfile.param3.always_ff.25008.3(%clk_i, %wdata_i, %we_dec) -> (%mem) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<1xi32>>, !llhd.sig<!llhd.array<1xi32>>) -> (!llhd.sig<!llhd.array<32xi32>>)
    // %23 = llhd.array %0, %0 : !llhd.array<2xi32>
    // %24 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %rdata_o, %23 after %24 : !llhd.sig<!llhd.array<2xi32>>
}

llhd.proc @fifo_v3.param9.always_comb.26642.9(%full_o: !llhd.sig<i1>, %empty_o: !llhd.sig<i1>, %data_i: !llhd.sig<tuple<i5, i1, i3, i2>>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>, %read_pointer_q: !llhd.sig<i1>, %write_pointer_q: !llhd.sig<i1>, %status_cnt_q: !llhd.sig<i2>, %mem_q: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (%data_o: !llhd.sig<tuple<i5, i1, i3, i2>> , %gate_clock: !llhd.sig<i1> , %read_pointer_n: !llhd.sig<i1> , %write_pointer_n: !llhd.sig<i1> , %status_cnt_n: !llhd.sig<i2> , %mem_n: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>> ) {
    br ^body
^body:
    %read_pointer_q.prb = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n, %read_pointer_q.prb after %0 : !llhd.sig<i1>
    %write_pointer_q.prb = llhd.prb %write_pointer_q : !llhd.sig<i1>
    llhd.drv %write_pointer_n, %write_pointer_q.prb after %0 : !llhd.sig<i1>
    %status_cnt_q.prb = llhd.prb %status_cnt_q : !llhd.sig<i2>
    llhd.drv %status_cnt_n, %status_cnt_q.prb after %0 : !llhd.sig<i2>
    %1 = llhd.const 0 : i11
    %data_i.prb = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %2 = llhd.extract_element %data_i.prb, 3 : tuple<i5, i1, i3, i2> -> i2
    %3 = llhd.insert_slice %1, %2, 0 : i11, i2
    %4 = llhd.extract_element %data_i.prb, 2 : tuple<i5, i1, i3, i2> -> i3
    %5 = llhd.insert_slice %3, %4, 2 : i11, i3
    %6 = llhd.extract_element %data_i.prb, 1 : tuple<i5, i1, i3, i2> -> i1
    %7 = llhd.insert_slice %5, %6, 5 : i11, i1
    %8 = llhd.extract_element %data_i.prb, 0 : tuple<i5, i1, i3, i2> -> i5
    %concat = llhd.insert_slice %7, %8, 6 : i11, i5
    %mem_q.prb = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %9 = llhd.const 0 : i5
    %10 = llhd.const 0 : i1
    %11 = llhd.const 0 : i3
    %12 = llhd.const 0 : i2
    %13 = llhd.tuple %9, %10, %11, %12 : tuple<i5, i1, i3, i2>
    %14 = llhd.array_uniform %13 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %15 = llhd.shr %mem_q.prb, %14, %read_pointer_q.prb : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %16 = llhd.extract_element %15, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %17 = llhd.extract_element %16, 3 : tuple<i5, i1, i3, i2> -> i2
    %18 = llhd.insert_slice %1, %17, 0 : i11, i2
    %19 = llhd.extract_element %16, 2 : tuple<i5, i1, i3, i2> -> i3
    %20 = llhd.insert_slice %18, %19, 2 : i11, i3
    %21 = llhd.extract_element %16, 1 : tuple<i5, i1, i3, i2> -> i1
    %22 = llhd.insert_slice %20, %21, 5 : i11, i1
    %23 = llhd.extract_element %16, 0 : tuple<i5, i1, i3, i2> -> i5
    %concat1 = llhd.insert_slice %22, %23, 6 : i11, i5
    %24 = llhd.array %concat1, %concat : !llhd.array<2xi11>
    %25 = llhd.extract_element %24, 0 : !llhd.array<2xi11> -> i11
    %26 = llhd.extract_slice %25, 0 : i11 -> i5
    %27 = llhd.extract_slice %25, 5 : i11 -> i6
    %28 = llhd.insert_slice %1, %27, 0 : i11, i6
    %29 = llhd.extract_slice %28, 0 : i11 -> i1
    %30 = llhd.extract_slice %25, 6 : i11 -> i5
    %31 = llhd.insert_slice %1, %30, 0 : i11, i5
    %32 = llhd.extract_slice %31, 0 : i11 -> i3
    %33 = llhd.extract_slice %25, 9 : i11 -> i2
    %34 = llhd.insert_slice %1, %33, 0 : i11, i2
    %35 = llhd.extract_slice %34, 0 : i11 -> i2
    %36 = llhd.tuple %26, %29, %32, %35 : tuple<i5, i1, i3, i2>
    llhd.drv %data_o, %36 after %0 : !llhd.sig<tuple<i5, i1, i3, i2>>
    llhd.drv %mem_n, %mem_q.prb after %0 : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %37 = llhd.const 1 : i1
    llhd.drv %gate_clock, %37 after %0 : !llhd.sig<i1>
    %push_i.prb = llhd.prb %push_i : !llhd.sig<i1>
    %38 = llhd.neq %push_i.prb, %10 : i1
    %full_o.prb = llhd.prb %full_o : !llhd.sig<i1>
    %39 = llhd.not %full_o.prb : i1
    %40 = llhd.neq %39, %10 : i1
    %41 = llhd.and %38, %40 : i1
    %42 = llhd.neq %41, %10 : i1
    %43 = llhd.const 0 : i32
    %44 = llhd.const 1 : i32
    cond_br %42, ^if_true, ^if_exit
^if_exit:
    %pop_i.prb = llhd.prb %pop_i : !llhd.sig<i1>
    %45 = llhd.neq %pop_i.prb, %10 : i1
    %empty_o.prb = llhd.prb %empty_o : !llhd.sig<i1>
    %46 = llhd.not %empty_o.prb : i1
    %47 = llhd.neq %46, %10 : i1
    %48 = llhd.and %45, %47 : i1
    %49 = llhd.neq %48, %10 : i1
    cond_br %49, ^if_true2, ^if_exit1
^if_true:
    %50 = llhd.dyn_extract_element %mem_n, %write_pointer_q.prb : (!llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>, i1) -> !llhd.sig<tuple<i5, i1, i3, i2>>
    llhd.drv %50, %data_i.prb after %0 : !llhd.sig<tuple<i5, i1, i3, i2>>
    llhd.drv %gate_clock, %10 after %0 : !llhd.sig<i1>
    %zext = llhd.insert_slice %43, %write_pointer_q.prb, 0 : i32, i1
    %51 = llhd.eq %zext, %43 : i32
    %52 = llhd.neq %51, %10 : i1
    cond_br %52, ^if_true1, ^if_false
^if_false:
    %53 = addi %zext, %44 : i32
    %54 = llhd.extract_slice %53, 0 : i32 -> i1
    llhd.drv %write_pointer_n, %54 after %0 : !llhd.sig<i1>
    br ^if_exit2
^if_true1:
    llhd.drv %write_pointer_n, %10 after %0 : !llhd.sig<i1>
    br ^if_exit2
^if_exit1:
    %55 = llhd.and %38, %45 : i1
    %56 = llhd.neq %55, %10 : i1
    %57 = llhd.and %56, %40 : i1
    %58 = llhd.neq %57, %10 : i1
    %59 = llhd.and %58, %47 : i1
    %60 = llhd.neq %59, %10 : i1
    cond_br %60, ^if_true4, ^if_exit3
^if_true2:
    %read_pointer_n.prb = llhd.prb %read_pointer_n : !llhd.sig<i1>
    %zext2 = llhd.insert_slice %43, %read_pointer_n.prb, 0 : i32, i1
    %61 = llhd.eq %zext2, %43 : i32
    %62 = llhd.neq %61, %10 : i1
    cond_br %62, ^if_true3, ^if_false1
^if_exit2:
    %zext1 = llhd.insert_slice %43, %status_cnt_q.prb, 0 : i32, i2
    %63 = addi %zext1, %44 : i32
    %64 = llhd.extract_slice %63, 0 : i32 -> i2
    llhd.drv %status_cnt_n, %64 after %0 : !llhd.sig<i2>
    br ^if_exit
^if_false1:
    %zext3 = llhd.insert_slice %43, %read_pointer_q.prb, 0 : i32, i1
    %65 = addi %zext3, %44 : i32
    %66 = llhd.extract_slice %65, 0 : i32 -> i1
    llhd.drv %read_pointer_n, %66 after %0 : !llhd.sig<i1>
    br ^if_exit4
^if_true3:
    llhd.drv %read_pointer_n, %10 after %0 : !llhd.sig<i1>
    br ^if_exit4
^if_exit3:
    llhd.wait (%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>), ^body
^if_true4:
    llhd.drv %status_cnt_n, %status_cnt_q.prb after %0 : !llhd.sig<i2>
    br ^if_exit3
^if_exit4:
    %zext4 = llhd.insert_slice %43, %status_cnt_q.prb, 0 : i32, i2
    %67 = subi %zext4, %44 : i32
    %68 = llhd.extract_slice %67, 0 : i32 -> i2
    llhd.drv %status_cnt_n, %68 after %0 : !llhd.sig<i2>
    br ^if_exit1
}

llhd.proc @fifo_v3.param9.always_ff.26761.9(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %read_pointer_n: !llhd.sig<i1>, %write_pointer_n: !llhd.sig<i1>, %status_cnt_n: !llhd.sig<i2>) -> (%read_pointer_q: !llhd.sig<i1> , %write_pointer_q: !llhd.sig<i1> , %status_cnt_q: !llhd.sig<i2> ) {
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
    %8 = llhd.const 0 : i2
    cond_br %6, ^if_true, ^if_false
^if_false:
    %flush_i.prb = llhd.prb %flush_i : !llhd.sig<i1>
    %9 = llhd.neq %flush_i.prb, %0 : i1
    cond_br %9, ^if_true1, ^if_false1
^if_true:
    llhd.drv %read_pointer_q, %0 after %7 : !llhd.sig<i1>
    llhd.drv %write_pointer_q, %0 after %7 : !llhd.sig<i1>
    llhd.drv %status_cnt_q, %8 after %7 : !llhd.sig<i2>
    br ^init
^if_false1:
    %read_pointer_n.prb = llhd.prb %read_pointer_n : !llhd.sig<i1>
    llhd.drv %read_pointer_q, %read_pointer_n.prb after %7 : !llhd.sig<i1>
    %write_pointer_n.prb = llhd.prb %write_pointer_n : !llhd.sig<i1>
    llhd.drv %write_pointer_q, %write_pointer_n.prb after %7 : !llhd.sig<i1>
    %status_cnt_n.prb = llhd.prb %status_cnt_n : !llhd.sig<i2>
    llhd.drv %status_cnt_q, %status_cnt_n.prb after %7 : !llhd.sig<i2>
    br ^init
^if_true1:
    llhd.drv %read_pointer_q, %0 after %7 : !llhd.sig<i1>
    llhd.drv %write_pointer_q, %0 after %7 : !llhd.sig<i1>
    llhd.drv %status_cnt_q, %8 after %7 : !llhd.sig<i2>
    br ^init
}

llhd.proc @fifo_v3.param9.always_ff.26805.9(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %gate_clock: !llhd.sig<i1>, %mem_n: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (%mem_q: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>> ) {
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
    %11 = llhd.const 0 : i5
    %12 = llhd.const 0 : i3
    %13 = llhd.const 0 : i2
    %14 = llhd.tuple %11, %0, %12, %13 : tuple<i5, i1, i3, i2>
    %15 = llhd.array %14 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    llhd.drv %mem_q, %15 after %7 : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    br ^init
^if_true1:
    %mem_n.prb = llhd.prb %mem_n : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    llhd.drv %mem_q, %mem_n.prb after %7 : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    br ^init
}

llhd.proc @fifo_v3.param9.initial.26821.9() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @fifo_v3.param9(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %testmode_i: !llhd.sig<i1>, %data_i: !llhd.sig<tuple<i5, i1, i3, i2>>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>) -> (%full_o: !llhd.sig<i1> , %empty_o: !llhd.sig<i1> , %usage_o: !llhd.sig<i1> , %data_o: !llhd.sig<tuple<i5, i1, i3, i2>> ) {
    %0 = llhd.const 0 : i1
    %gate_clock = llhd.sig "gate_clock" %0 : i1
    %read_pointer_n = llhd.sig "read_pointer_n" %0 : i1
    %read_pointer_q = llhd.sig "read_pointer_q" %0 : i1
    %write_pointer_n = llhd.sig "write_pointer_n" %0 : i1
    %write_pointer_q = llhd.sig "write_pointer_q" %0 : i1
    %1 = llhd.const 0 : i2
    %status_cnt_n = llhd.sig "status_cnt_n" %1 : i2
    %status_cnt_q = llhd.sig "status_cnt_q" %1 : i2
    %2 = llhd.const 0 : i5
    %3 = llhd.const 0 : i3
    %4 = llhd.tuple %2, %0, %3, %1 : tuple<i5, i1, i3, i2>
    %5 = llhd.array %4 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %mem_n = llhd.sig "mem_n" %5 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %mem_q = llhd.sig "mem_q" %5 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %status_cnt_q.prb = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %6 = llhd.extract_slice %status_cnt_q.prb, 0 : i2 -> i1
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %usage_o, %6 after %7 : !llhd.sig<i1>
    %8 = llhd.const 1 : i2
    %9 = llhd.eq %status_cnt_q.prb, %8 : i2
    llhd.drv %full_o, %9 after %7 : !llhd.sig<i1>
    %10 = llhd.const 0 : i32
    %zext = llhd.insert_slice %10, %status_cnt_q.prb, 0 : i32, i2
    %11 = llhd.eq %zext, %10 : i32
    llhd.drv %empty_o, %11 after %7 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param9.always_comb.26642.9(%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q) -> (%data_o, %gate_clock, %read_pointer_n, %write_pointer_n, %status_cnt_n, %mem_n) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (!llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>)
    llhd.inst "inst1" @fifo_v3.param9.always_ff.26761.9(%clk_i, %rst_ni, %flush_i, %read_pointer_n, %write_pointer_n, %status_cnt_n) -> (%read_pointer_q, %write_pointer_q, %status_cnt_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>)
    llhd.inst "inst2" @fifo_v3.param9.always_ff.26805.9(%clk_i, %rst_ni, %gate_clock, %mem_n) -> (%mem_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (!llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>)
    llhd.inst "inst3" @fifo_v3.param9.initial.26821.9() -> () : () -> ()
}

llhd.proc @snitch_lsu.param5.always_comb.25524.5(%lsu_qaddr_i: !llhd.sig<i32>, %lsu_qsize_i: !llhd.sig<i2>) -> (%data_qstrb_o: !llhd.sig<i8> ) {
    br ^body
^body:
    %lsu_qsize_i.prb = llhd.prb %lsu_qsize_i : !llhd.sig<i2>
    %0 = llhd.const 0 : i2
    %1 = llhd.eq %lsu_qsize_i.prb, %0 : i2
    %lsu_qaddr_i.prb = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %2 = llhd.const 0 : i8
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %4 = llhd.const 1 : i8
    cond_br %1, ^case_body, ^5
^5:
    %6 = llhd.const 1 : i2
    %7 = llhd.eq %lsu_qsize_i.prb, %6 : i2
    %8 = llhd.extract_slice %lsu_qaddr_i.prb, 0 : i32 -> i3
    cond_br %7, ^case_body1, ^9
^case_body:
    %10 = llhd.extract_slice %lsu_qaddr_i.prb, 0 : i32 -> i3
    %11 = llhd.shl %4, %2, %10 : (i8, i8, i3) -> i8
    llhd.drv %data_qstrb_o, %11 after %3 : !llhd.sig<i8>
    br ^check
^check:
    llhd.wait (%lsu_qaddr_i, %lsu_qsize_i : !llhd.sig<i32>, !llhd.sig<i2>), ^body
^9:
    %12 = llhd.const 2 : i2
    %13 = llhd.eq %lsu_qsize_i.prb, %12 : i2
    cond_br %13, ^case_body2, ^14
^case_body1:
    %15 = llhd.const 3 : i8
    %16 = llhd.shl %15, %2, %8 : (i8, i8, i3) -> i8
    llhd.drv %data_qstrb_o, %16 after %3 : !llhd.sig<i8>
    br ^check
^14:
    %17 = llhd.const 3 : i2
    %18 = llhd.eq %lsu_qsize_i.prb, %17 : i2
    cond_br %18, ^case_body3, ^19
^case_body2:
    %20 = llhd.const 15 : i8
    %21 = llhd.shl %20, %2, %8 : (i8, i8, i3) -> i8
    llhd.drv %data_qstrb_o, %21 after %3 : !llhd.sig<i8>
    br ^check
^19:
    llhd.drv %data_qstrb_o, %2 after %3 : !llhd.sig<i8>
    br ^check
^case_body3:
    llhd.drv %data_qstrb_o, %4 after %3 : !llhd.sig<i8>
    br ^check
}

llhd.proc @snitch_lsu.param5.always_comb.25765.5(%lsu_qaddr_i: !llhd.sig<i32>, %lsu_qdata_i: !llhd.sig<i64>) -> (%data_qdata_o: !llhd.sig<i64> ) {
    br ^body
^body:
    %lsu_qaddr_i.prb = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %0 = llhd.extract_slice %lsu_qaddr_i.prb, 0 : i32 -> i3
    %1 = llhd.const 0 : i3
    %2 = llhd.eq %0, %1 : i3
    %lsu_qdata_i.prb = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    cond_br %2, ^case_body, ^4
^4:
    %5 = llhd.const 1 : i3
    %6 = llhd.eq %0, %5 : i3
    %7 = llhd.const 0 : i64
    cond_br %6, ^case_body1, ^8
^case_body:
    llhd.drv %data_qdata_o, %lsu_qdata_i.prb after %3 : !llhd.sig<i64>
    br ^check
^check:
    llhd.wait (%lsu_qaddr_i, %lsu_qdata_i : !llhd.sig<i32>, !llhd.sig<i64>), ^body
^8:
    %9 = llhd.const 2 : i3
    %10 = llhd.eq %0, %9 : i3
    cond_br %10, ^case_body2, ^11
^case_body1:
    %12 = llhd.extract_slice %lsu_qdata_i.prb, 56 : i64 -> i8
    %13 = llhd.insert_slice %7, %12, 0 : i64, i8
    %14 = llhd.extract_slice %13, 0 : i64 -> i8
    %15 = llhd.insert_slice %7, %14, 0 : i64, i8
    %16 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i56
    %concat = llhd.insert_slice %15, %16, 8 : i64, i56
    llhd.drv %data_qdata_o, %concat after %3 : !llhd.sig<i64>
    br ^check
^11:
    %17 = llhd.const 3 : i3
    %18 = llhd.eq %0, %17 : i3
    cond_br %18, ^case_body3, ^19
^case_body2:
    %20 = llhd.extract_slice %lsu_qdata_i.prb, 48 : i64 -> i16
    %21 = llhd.insert_slice %7, %20, 0 : i64, i16
    %22 = llhd.extract_slice %21, 0 : i64 -> i16
    %23 = llhd.insert_slice %7, %22, 0 : i64, i16
    %24 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i48
    %concat1 = llhd.insert_slice %23, %24, 16 : i64, i48
    llhd.drv %data_qdata_o, %concat1 after %3 : !llhd.sig<i64>
    br ^check
^19:
    %25 = llhd.const 4 : i3
    %26 = llhd.eq %0, %25 : i3
    cond_br %26, ^case_body4, ^27
^case_body3:
    %28 = llhd.extract_slice %lsu_qdata_i.prb, 40 : i64 -> i24
    %29 = llhd.insert_slice %7, %28, 0 : i64, i24
    %30 = llhd.extract_slice %29, 0 : i64 -> i24
    %31 = llhd.insert_slice %7, %30, 0 : i64, i24
    %32 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i40
    %concat2 = llhd.insert_slice %31, %32, 24 : i64, i40
    llhd.drv %data_qdata_o, %concat2 after %3 : !llhd.sig<i64>
    br ^check
^27:
    %33 = llhd.const 5 : i3
    %34 = llhd.eq %0, %33 : i3
    cond_br %34, ^case_body5, ^35
^case_body4:
    %36 = llhd.extract_slice %lsu_qdata_i.prb, 32 : i64 -> i32
    %37 = llhd.insert_slice %7, %36, 0 : i64, i32
    %38 = llhd.extract_slice %37, 0 : i64 -> i32
    %39 = llhd.insert_slice %7, %38, 0 : i64, i32
    %40 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i32
    %concat3 = llhd.insert_slice %39, %40, 32 : i64, i32
    llhd.drv %data_qdata_o, %concat3 after %3 : !llhd.sig<i64>
    br ^check
^35:
    %41 = llhd.const 6 : i3
    %42 = llhd.eq %0, %41 : i3
    cond_br %42, ^case_body6, ^43
^case_body5:
    %44 = llhd.extract_slice %lsu_qdata_i.prb, 24 : i64 -> i40
    %45 = llhd.insert_slice %7, %44, 0 : i64, i40
    %46 = llhd.extract_slice %45, 0 : i64 -> i40
    %47 = llhd.insert_slice %7, %46, 0 : i64, i40
    %48 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i24
    %concat4 = llhd.insert_slice %47, %48, 40 : i64, i24
    llhd.drv %data_qdata_o, %concat4 after %3 : !llhd.sig<i64>
    br ^check
^43:
    %49 = llhd.const 7 : i3
    %50 = llhd.eq %0, %49 : i3
    cond_br %50, ^case_body7, ^51
^case_body6:
    %52 = llhd.extract_slice %lsu_qdata_i.prb, 16 : i64 -> i48
    %53 = llhd.insert_slice %7, %52, 0 : i64, i48
    %54 = llhd.extract_slice %53, 0 : i64 -> i48
    %55 = llhd.insert_slice %7, %54, 0 : i64, i48
    %56 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i16
    %concat5 = llhd.insert_slice %55, %56, 48 : i64, i16
    llhd.drv %data_qdata_o, %concat5 after %3 : !llhd.sig<i64>
    br ^check
^51:
    llhd.drv %data_qdata_o, %lsu_qdata_i.prb after %3 : !llhd.sig<i64>
    br ^check
^case_body7:
    %57 = llhd.extract_slice %lsu_qdata_i.prb, 8 : i64 -> i56
    %58 = llhd.insert_slice %7, %57, 0 : i64, i56
    %59 = llhd.extract_slice %58, 0 : i64 -> i56
    %60 = llhd.insert_slice %7, %59, 0 : i64, i56
    %61 = llhd.extract_slice %lsu_qdata_i.prb, 0 : i64 -> i8
    %concat6 = llhd.insert_slice %60, %61, 56 : i64, i8
    llhd.drv %data_qdata_o, %concat6 after %3 : !llhd.sig<i64>
    br ^check
}

llhd.proc @snitch_lsu.param5.always_comb.25969.5(%laq_out: !llhd.sig<tuple<i5, i1, i3, i2>>, %shifted_data: !llhd.sig<i64>) -> (%ld_result: !llhd.sig<i64> ) {
    br ^body
^body:
    %laq_out.prb = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %0 = llhd.extract_element %laq_out.prb, 3 : tuple<i5, i1, i3, i2> -> i2
    %1 = llhd.const 0 : i2
    %2 = llhd.eq %0, %1 : i2
    %3 = llhd.const 0 : i64
    %shifted_data.prb = llhd.prb %shifted_data : !llhd.sig<i64>
    %4 = llhd.extract_element %laq_out.prb, 1 : tuple<i5, i1, i3, i2> -> i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    cond_br %2, ^case_body, ^6
^6:
    %7 = llhd.const 1 : i2
    %8 = llhd.eq %0, %7 : i2
    cond_br %8, ^case_body1, ^9
^case_body:
    %10 = llhd.extract_slice %shifted_data.prb, 0 : i64 -> i8
    %11 = llhd.insert_slice %3, %10, 0 : i64, i8
    %12 = llhd.extract_slice %shifted_data.prb, 7 : i64 -> i57
    %13 = llhd.insert_slice %3, %12, 0 : i64, i57
    %14 = llhd.extract_slice %13, 0 : i64 -> i1
    %concat = llhd.and %14, %4 : i1
    %15 = llhd.const 0 : i56
    %16 = llhd.insert_slice %15, %concat, 0 : i56, i1
    %17 = llhd.insert_slice %16, %concat, 1 : i56, i1
    %18 = llhd.insert_slice %17, %concat, 2 : i56, i1
    %19 = llhd.insert_slice %18, %concat, 3 : i56, i1
    %20 = llhd.insert_slice %19, %concat, 4 : i56, i1
    %21 = llhd.insert_slice %20, %concat, 5 : i56, i1
    %22 = llhd.insert_slice %21, %concat, 6 : i56, i1
    %23 = llhd.insert_slice %22, %concat, 7 : i56, i1
    %24 = llhd.insert_slice %23, %concat, 8 : i56, i1
    %25 = llhd.insert_slice %24, %concat, 9 : i56, i1
    %26 = llhd.insert_slice %25, %concat, 10 : i56, i1
    %27 = llhd.insert_slice %26, %concat, 11 : i56, i1
    %28 = llhd.insert_slice %27, %concat, 12 : i56, i1
    %29 = llhd.insert_slice %28, %concat, 13 : i56, i1
    %30 = llhd.insert_slice %29, %concat, 14 : i56, i1
    %31 = llhd.insert_slice %30, %concat, 15 : i56, i1
    %32 = llhd.insert_slice %31, %concat, 16 : i56, i1
    %33 = llhd.insert_slice %32, %concat, 17 : i56, i1
    %34 = llhd.insert_slice %33, %concat, 18 : i56, i1
    %35 = llhd.insert_slice %34, %concat, 19 : i56, i1
    %36 = llhd.insert_slice %35, %concat, 20 : i56, i1
    %37 = llhd.insert_slice %36, %concat, 21 : i56, i1
    %38 = llhd.insert_slice %37, %concat, 22 : i56, i1
    %39 = llhd.insert_slice %38, %concat, 23 : i56, i1
    %40 = llhd.insert_slice %39, %concat, 24 : i56, i1
    %41 = llhd.insert_slice %40, %concat, 25 : i56, i1
    %42 = llhd.insert_slice %41, %concat, 26 : i56, i1
    %43 = llhd.insert_slice %42, %concat, 27 : i56, i1
    %44 = llhd.insert_slice %43, %concat, 28 : i56, i1
    %45 = llhd.insert_slice %44, %concat, 29 : i56, i1
    %46 = llhd.insert_slice %45, %concat, 30 : i56, i1
    %47 = llhd.insert_slice %46, %concat, 31 : i56, i1
    %48 = llhd.insert_slice %47, %concat, 32 : i56, i1
    %49 = llhd.insert_slice %48, %concat, 33 : i56, i1
    %50 = llhd.insert_slice %49, %concat, 34 : i56, i1
    %51 = llhd.insert_slice %50, %concat, 35 : i56, i1
    %52 = llhd.insert_slice %51, %concat, 36 : i56, i1
    %53 = llhd.insert_slice %52, %concat, 37 : i56, i1
    %54 = llhd.insert_slice %53, %concat, 38 : i56, i1
    %55 = llhd.insert_slice %54, %concat, 39 : i56, i1
    %56 = llhd.insert_slice %55, %concat, 40 : i56, i1
    %57 = llhd.insert_slice %56, %concat, 41 : i56, i1
    %58 = llhd.insert_slice %57, %concat, 42 : i56, i1
    %59 = llhd.insert_slice %58, %concat, 43 : i56, i1
    %60 = llhd.insert_slice %59, %concat, 44 : i56, i1
    %61 = llhd.insert_slice %60, %concat, 45 : i56, i1
    %62 = llhd.insert_slice %61, %concat, 46 : i56, i1
    %63 = llhd.insert_slice %62, %concat, 47 : i56, i1
    %64 = llhd.insert_slice %63, %concat, 48 : i56, i1
    %65 = llhd.insert_slice %64, %concat, 49 : i56, i1
    %66 = llhd.insert_slice %65, %concat, 50 : i56, i1
    %67 = llhd.insert_slice %66, %concat, 51 : i56, i1
    %68 = llhd.insert_slice %67, %concat, 52 : i56, i1
    %69 = llhd.insert_slice %68, %concat, 53 : i56, i1
    %70 = llhd.insert_slice %69, %concat, 54 : i56, i1
    %repeat = llhd.insert_slice %70, %concat, 55 : i56, i1
    %concat1 = llhd.insert_slice %11, %repeat, 8 : i64, i56
    llhd.drv %ld_result, %concat1 after %5 : !llhd.sig<i64>
    br ^check
^check:
    llhd.wait (%laq_out, %shifted_data : !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i64>), ^body
^9:
    %71 = llhd.const 2 : i2
    %72 = llhd.eq %0, %71 : i2
    cond_br %72, ^case_body2, ^73
^case_body1:
    %74 = llhd.extract_slice %shifted_data.prb, 0 : i64 -> i16
    %75 = llhd.insert_slice %3, %74, 0 : i64, i16
    %76 = llhd.extract_slice %shifted_data.prb, 15 : i64 -> i49
    %77 = llhd.insert_slice %3, %76, 0 : i64, i49
    %78 = llhd.extract_slice %77, 0 : i64 -> i1
    %concat2 = llhd.and %78, %4 : i1
    %79 = llhd.const 0 : i48
    %80 = llhd.insert_slice %79, %concat2, 0 : i48, i1
    %81 = llhd.insert_slice %80, %concat2, 1 : i48, i1
    %82 = llhd.insert_slice %81, %concat2, 2 : i48, i1
    %83 = llhd.insert_slice %82, %concat2, 3 : i48, i1
    %84 = llhd.insert_slice %83, %concat2, 4 : i48, i1
    %85 = llhd.insert_slice %84, %concat2, 5 : i48, i1
    %86 = llhd.insert_slice %85, %concat2, 6 : i48, i1
    %87 = llhd.insert_slice %86, %concat2, 7 : i48, i1
    %88 = llhd.insert_slice %87, %concat2, 8 : i48, i1
    %89 = llhd.insert_slice %88, %concat2, 9 : i48, i1
    %90 = llhd.insert_slice %89, %concat2, 10 : i48, i1
    %91 = llhd.insert_slice %90, %concat2, 11 : i48, i1
    %92 = llhd.insert_slice %91, %concat2, 12 : i48, i1
    %93 = llhd.insert_slice %92, %concat2, 13 : i48, i1
    %94 = llhd.insert_slice %93, %concat2, 14 : i48, i1
    %95 = llhd.insert_slice %94, %concat2, 15 : i48, i1
    %96 = llhd.insert_slice %95, %concat2, 16 : i48, i1
    %97 = llhd.insert_slice %96, %concat2, 17 : i48, i1
    %98 = llhd.insert_slice %97, %concat2, 18 : i48, i1
    %99 = llhd.insert_slice %98, %concat2, 19 : i48, i1
    %100 = llhd.insert_slice %99, %concat2, 20 : i48, i1
    %101 = llhd.insert_slice %100, %concat2, 21 : i48, i1
    %102 = llhd.insert_slice %101, %concat2, 22 : i48, i1
    %103 = llhd.insert_slice %102, %concat2, 23 : i48, i1
    %104 = llhd.insert_slice %103, %concat2, 24 : i48, i1
    %105 = llhd.insert_slice %104, %concat2, 25 : i48, i1
    %106 = llhd.insert_slice %105, %concat2, 26 : i48, i1
    %107 = llhd.insert_slice %106, %concat2, 27 : i48, i1
    %108 = llhd.insert_slice %107, %concat2, 28 : i48, i1
    %109 = llhd.insert_slice %108, %concat2, 29 : i48, i1
    %110 = llhd.insert_slice %109, %concat2, 30 : i48, i1
    %111 = llhd.insert_slice %110, %concat2, 31 : i48, i1
    %112 = llhd.insert_slice %111, %concat2, 32 : i48, i1
    %113 = llhd.insert_slice %112, %concat2, 33 : i48, i1
    %114 = llhd.insert_slice %113, %concat2, 34 : i48, i1
    %115 = llhd.insert_slice %114, %concat2, 35 : i48, i1
    %116 = llhd.insert_slice %115, %concat2, 36 : i48, i1
    %117 = llhd.insert_slice %116, %concat2, 37 : i48, i1
    %118 = llhd.insert_slice %117, %concat2, 38 : i48, i1
    %119 = llhd.insert_slice %118, %concat2, 39 : i48, i1
    %120 = llhd.insert_slice %119, %concat2, 40 : i48, i1
    %121 = llhd.insert_slice %120, %concat2, 41 : i48, i1
    %122 = llhd.insert_slice %121, %concat2, 42 : i48, i1
    %123 = llhd.insert_slice %122, %concat2, 43 : i48, i1
    %124 = llhd.insert_slice %123, %concat2, 44 : i48, i1
    %125 = llhd.insert_slice %124, %concat2, 45 : i48, i1
    %126 = llhd.insert_slice %125, %concat2, 46 : i48, i1
    %repeat1 = llhd.insert_slice %126, %concat2, 47 : i48, i1
    %concat3 = llhd.insert_slice %75, %repeat1, 16 : i64, i48
    llhd.drv %ld_result, %concat3 after %5 : !llhd.sig<i64>
    br ^check
^73:
    %127 = llhd.const 3 : i2
    %128 = llhd.eq %0, %127 : i2
    cond_br %128, ^case_body3, ^129
^case_body2:
    %130 = llhd.extract_slice %shifted_data.prb, 0 : i64 -> i32
    %131 = llhd.insert_slice %3, %130, 0 : i64, i32
    %132 = llhd.extract_slice %shifted_data.prb, 31 : i64 -> i33
    %133 = llhd.insert_slice %3, %132, 0 : i64, i33
    %134 = llhd.extract_slice %133, 0 : i64 -> i1
    %concat4 = llhd.and %134, %4 : i1
    %135 = llhd.const 0 : i32
    %136 = llhd.insert_slice %135, %concat4, 0 : i32, i1
    %137 = llhd.insert_slice %136, %concat4, 1 : i32, i1
    %138 = llhd.insert_slice %137, %concat4, 2 : i32, i1
    %139 = llhd.insert_slice %138, %concat4, 3 : i32, i1
    %140 = llhd.insert_slice %139, %concat4, 4 : i32, i1
    %141 = llhd.insert_slice %140, %concat4, 5 : i32, i1
    %142 = llhd.insert_slice %141, %concat4, 6 : i32, i1
    %143 = llhd.insert_slice %142, %concat4, 7 : i32, i1
    %144 = llhd.insert_slice %143, %concat4, 8 : i32, i1
    %145 = llhd.insert_slice %144, %concat4, 9 : i32, i1
    %146 = llhd.insert_slice %145, %concat4, 10 : i32, i1
    %147 = llhd.insert_slice %146, %concat4, 11 : i32, i1
    %148 = llhd.insert_slice %147, %concat4, 12 : i32, i1
    %149 = llhd.insert_slice %148, %concat4, 13 : i32, i1
    %150 = llhd.insert_slice %149, %concat4, 14 : i32, i1
    %151 = llhd.insert_slice %150, %concat4, 15 : i32, i1
    %152 = llhd.insert_slice %151, %concat4, 16 : i32, i1
    %153 = llhd.insert_slice %152, %concat4, 17 : i32, i1
    %154 = llhd.insert_slice %153, %concat4, 18 : i32, i1
    %155 = llhd.insert_slice %154, %concat4, 19 : i32, i1
    %156 = llhd.insert_slice %155, %concat4, 20 : i32, i1
    %157 = llhd.insert_slice %156, %concat4, 21 : i32, i1
    %158 = llhd.insert_slice %157, %concat4, 22 : i32, i1
    %159 = llhd.insert_slice %158, %concat4, 23 : i32, i1
    %160 = llhd.insert_slice %159, %concat4, 24 : i32, i1
    %161 = llhd.insert_slice %160, %concat4, 25 : i32, i1
    %162 = llhd.insert_slice %161, %concat4, 26 : i32, i1
    %163 = llhd.insert_slice %162, %concat4, 27 : i32, i1
    %164 = llhd.insert_slice %163, %concat4, 28 : i32, i1
    %165 = llhd.insert_slice %164, %concat4, 29 : i32, i1
    %166 = llhd.insert_slice %165, %concat4, 30 : i32, i1
    %repeat2 = llhd.insert_slice %166, %concat4, 31 : i32, i1
    %concat5 = llhd.insert_slice %131, %repeat2, 32 : i64, i32
    llhd.drv %ld_result, %concat5 after %5 : !llhd.sig<i64>
    br ^check
^129:
    llhd.drv %ld_result, %shifted_data.prb after %5 : !llhd.sig<i64>
    br ^check
^case_body3:
    llhd.drv %ld_result, %shifted_data.prb after %5 : !llhd.sig<i64>
    br ^check
}

llhd.entity @snitch_lsu.param5(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %lsu_qtag_i: !llhd.sig<i5>, %lsu_qwrite: !llhd.sig<i1>, %lsu_qsigned: !llhd.sig<i1>, %lsu_qaddr_i: !llhd.sig<i32>, %lsu_qdata_i: !llhd.sig<i64>, %lsu_qsize_i: !llhd.sig<i2>, %lsu_qamo_i: !llhd.sig<i4>, %lsu_qvalid_i: !llhd.sig<i1>, %lsu_pready_i: !llhd.sig<i1>, %data_qready_i: !llhd.sig<i1>, %data_pdata_i: !llhd.sig<i64>, %data_perror_i: !llhd.sig<i1>, %data_pvalid_i: !llhd.sig<i1>) -> (%lsu_qready_o: !llhd.sig<i1> , %lsu_pdata_o: !llhd.sig<i64> , %lsu_ptag_o: !llhd.sig<i5> , %lsu_perror_o: !llhd.sig<i1> , %lsu_pvalid_o: !llhd.sig<i1> , %data_qaddr_o: !llhd.sig<i32> , %data_qwrite_o: !llhd.sig<i1> , %data_qamo_o: !llhd.sig<i4> , %data_qdata_o: !llhd.sig<i64> , %data_qstrb_o: !llhd.sig<i8> , %data_qvalid_o: !llhd.sig<i1> , %data_pready_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i64
    %ld_result = llhd.sig "ld_result" %0 : i64
    %1 = llhd.const 0 : i5
    %2 = llhd.const 0 : i1
    %3 = llhd.const 0 : i3
    %4 = llhd.const 0 : i2
    %5 = llhd.tuple %1, %2, %3, %4 : tuple<i5, i1, i3, i2>
    %laq_in = llhd.sig "laq_in" %5 : tuple<i5, i1, i3, i2>
    %laq_out = llhd.sig "laq_out" %5 : tuple<i5, i1, i3, i2>
    %laq_full = llhd.sig "laq_full" %2 : i1
    %laq_push = llhd.sig "laq_push" %2 : i1
    %shifted_data = llhd.sig "shifted_data" %0 : i64
    %lsu_qtag_i.prb = llhd.prb %lsu_qtag_i : !llhd.sig<i5>
    %lsu_qsigned.prb = llhd.prb %lsu_qsigned : !llhd.sig<i1>
    %lsu_qaddr_i.prb = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %6 = llhd.extract_slice %lsu_qaddr_i.prb, 0 : i32 -> i3
    %lsu_qsize_i.prb = llhd.prb %lsu_qsize_i : !llhd.sig<i2>
    %7 = llhd.tuple %lsu_qtag_i.prb, %lsu_qsigned.prb, %6, %lsu_qsize_i.prb : tuple<i5, i1, i3, i2>
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %laq_in, %7 after %8 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %lsu_qvalid_i.prb = llhd.prb %lsu_qvalid_i : !llhd.sig<i1>
    %lsu_qwrite.prb = llhd.prb %lsu_qwrite : !llhd.sig<i1>
    %laq_full.prb = llhd.prb %laq_full : !llhd.sig<i1>
    %9 = llhd.not %laq_full.prb : i1
    %10 = llhd.or %lsu_qwrite.prb, %9 : i1
    %11 = llhd.and %lsu_qvalid_i.prb, %10 : i1
    llhd.drv %data_qvalid_o, %11 after %8 : !llhd.sig<i1>
    llhd.drv %data_qwrite_o, %lsu_qwrite.prb after %8 : !llhd.sig<i1>
    %12 = llhd.const 0 : i32
    %13 = llhd.extract_slice %lsu_qaddr_i.prb, 3 : i32 -> i29
    %14 = llhd.insert_slice %12, %13, 0 : i32, i29
    %15 = llhd.extract_slice %14, 0 : i32 -> i29
    %concat = llhd.insert_slice %12, %15, 3 : i32, i29
    llhd.drv %data_qaddr_o, %concat after %8 : !llhd.sig<i32>
    %lsu_qamo_i.prb = llhd.prb %lsu_qamo_i : !llhd.sig<i4>
    llhd.drv %data_qamo_o, %lsu_qamo_i.prb after %8 : !llhd.sig<i4>
    %data_qvalid_o.prb = llhd.prb %data_qvalid_o : !llhd.sig<i1>
    %data_qready_i.prb = llhd.prb %data_qready_i : !llhd.sig<i1>
    %16 = llhd.not %data_qready_i.prb : i1
    %17 = llhd.and %data_qvalid_o.prb, %16 : i1
    %18 = llhd.not %17 : i1
    %19 = llhd.and %18, %9 : i1
    llhd.drv %lsu_qready_o, %19 after %8 : !llhd.sig<i1>
    %20 = llhd.and %data_qready_i.prb, %data_qvalid_o.prb : i1
    %21 = llhd.and %20, %9 : i1
    llhd.drv %laq_push, %21 after %8 : !llhd.sig<i1>
    %data_pdata_i.prb = llhd.prb %data_pdata_i : !llhd.sig<i64>
    %22 = llhd.const 0 : i6
    %laq_out.prb = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %23 = llhd.extract_element %laq_out.prb, 2 : tuple<i5, i1, i3, i2> -> i3
    %concat1 = llhd.insert_slice %22, %23, 3 : i6, i3
    %24 = llhd.shr %data_pdata_i.prb, %0, %concat1 : (i64, i64, i6) -> i64
    llhd.drv %shifted_data, %24 after %8 : !llhd.sig<i64>
    %data_perror_i.prb = llhd.prb %data_perror_i : !llhd.sig<i1>
    llhd.drv %lsu_perror_o, %data_perror_i.prb after %8 : !llhd.sig<i1>
    %ld_result.prb = llhd.prb %ld_result : !llhd.sig<i64>
    llhd.drv %lsu_pdata_o, %ld_result.prb after %8 : !llhd.sig<i64>
    %25 = llhd.extract_element %laq_out.prb, 0 : tuple<i5, i1, i3, i2> -> i5
    llhd.drv %lsu_ptag_o, %25 after %8 : !llhd.sig<i5>
    %data_pvalid_i.prb = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    llhd.drv %lsu_pvalid_o, %data_pvalid_i.prb after %8 : !llhd.sig<i1>
    %lsu_pready_i.prb = llhd.prb %lsu_pready_i : !llhd.sig<i1>
    llhd.drv %data_pready_o, %lsu_pready_i.prb after %8 : !llhd.sig<i1>
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %26 = llhd.sig "26" %2 : i1
    llhd.drv %26, %clk_i.prb after %8 : !llhd.sig<i1>
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %27 = llhd.not %rst_i.prb : i1
    %28 = llhd.sig "28" %2 : i1
    llhd.drv %28, %27 after %8 : !llhd.sig<i1>
    %29 = llhd.sig "29" %2 : i1
    llhd.drv %29, %2 after %8 : !llhd.sig<i1>
    %30 = llhd.sig "30" %2 : i1
    llhd.drv %30, %2 after %8 : !llhd.sig<i1>
    %laq_in.prb = llhd.prb %laq_in : !llhd.sig<tuple<i5, i1, i3, i2>>
    %31 = llhd.sig "31" %5 : tuple<i5, i1, i3, i2>
    llhd.drv %31, %laq_in.prb after %8 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %laq_push.prb = llhd.prb %laq_push : !llhd.sig<i1>
    %32 = llhd.sig "32" %2 : i1
    llhd.drv %32, %laq_push.prb after %8 : !llhd.sig<i1>
    %data_pready_o.prb = llhd.prb %data_pready_o : !llhd.sig<i1>
    %33 = llhd.and %data_pvalid_i.prb, %data_pready_o.prb : i1
    %34 = llhd.sig "34" %2 : i1
    llhd.drv %34, %33 after %8 : !llhd.sig<i1>
    %i_fifo_laq.empty_o.default = llhd.sig "i_fifo_laq.empty_o.default" %2 : i1
    %i_fifo_laq.usage_o.default = llhd.sig "i_fifo_laq.usage_o.default" %2 : i1
    llhd.inst "inst" @fifo_v3.param9(%26, %28, %29, %30, %31, %32, %34) -> (%laq_full, %i_fifo_laq.empty_o.default, %i_fifo_laq.usage_o.default, %laq_out) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>)
    llhd.inst "inst1" @snitch_lsu.param5.always_comb.25524.5(%lsu_qaddr_i, %lsu_qsize_i) -> (%data_qstrb_o) : (!llhd.sig<i32>, !llhd.sig<i2>) -> (!llhd.sig<i8>)
    llhd.inst "inst2" @snitch_lsu.param5.always_comb.25765.5(%lsu_qaddr_i, %lsu_qdata_i) -> (%data_qdata_o) : (!llhd.sig<i32>, !llhd.sig<i64>) -> (!llhd.sig<i64>)
    llhd.inst "inst3" @snitch_lsu.param5.always_comb.25969.5(%laq_out, %shifted_data) -> (%ld_result) : (!llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i64>) -> (!llhd.sig<i64>)
}

llhd.proc @snitch.param1.always_ff.12501.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %pc_d: !llhd.sig<i32>) -> (%pc_q: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %3 = llhd.neq %rst_i.prb, %0 : i1
    %4 = llhd.const 65536 : i32
    %pc_d.prb = llhd.prb %pc_d : !llhd.sig<i32>
    %5 = llhd.array %pc_d.prb, %4 : !llhd.array<2xi32>
    %6 = llhd.dyn_extract_element %5, %3 : (!llhd.array<2xi32>, i1) -> i32
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %pc_q, %6 after %7 : !llhd.sig<i32>
    br ^init
}

llhd.proc @snitch.param1.always_ff.12525.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %wfi_d: !llhd.sig<i1>) -> (%wfi_q: !llhd.sig<i1> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %3 = llhd.neq %rst_i.prb, %0 : i1
    %wfi_d.prb = llhd.prb %wfi_d : !llhd.sig<i1>
    %4 = llhd.array %wfi_d.prb, %0 : !llhd.array<2xi1>
    %5 = llhd.dyn_extract_element %4, %3 : (!llhd.array<2xi1>, i1) -> i1
    %6 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %wfi_q, %5 after %6 : !llhd.sig<i1>
    br ^init
}

llhd.proc @snitch.param1.always_ff.12549.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %sb_d: !llhd.sig<i32>) -> (%sb_q: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %3 = llhd.neq %rst_i.prb, %0 : i1
    %4 = llhd.const 0 : i32
    %sb_d.prb = llhd.prb %sb_d : !llhd.sig<i32>
    %5 = llhd.array %sb_d.prb, %4 : !llhd.array<2xi32>
    %6 = llhd.dyn_extract_element %5, %3 : (!llhd.array<2xi32>, i1) -> i32
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %sb_q, %6 after %7 : !llhd.sig<i32>
    br ^init
}

llhd.proc @snitch.param1.always_ff.12573.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %fcsr_d: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (%fcsr_q: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %3 = llhd.neq %rst_i.prb, %0 : i1
    %4 = llhd.const 0 : i8
    %5 = llhd.const 0 : i5
    %fcsr_d.prb = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %6 = llhd.extract_element %fcsr_d.prb, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %7 = llhd.extract_element %6, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %8 = llhd.insert_slice %5, %7, 0 : i5, i1
    %9 = llhd.extract_element %6, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %10 = llhd.insert_slice %8, %9, 1 : i5, i1
    %11 = llhd.extract_element %6, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %12 = llhd.insert_slice %10, %11, 2 : i5, i1
    %13 = llhd.extract_element %6, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %14 = llhd.insert_slice %12, %13, 3 : i5, i1
    %15 = llhd.extract_element %6, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %concat = llhd.insert_slice %14, %15, 4 : i5, i1
    %16 = llhd.insert_slice %4, %concat, 0 : i8, i5
    %17 = llhd.extract_element %fcsr_d.prb, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %concat1 = llhd.insert_slice %16, %17, 5 : i8, i3
    %18 = llhd.array %concat1, %4 : !llhd.array<2xi8>
    %19 = llhd.dyn_extract_element %18, %3 : (!llhd.array<2xi8>, i1) -> i8
    %20 = llhd.extract_slice %19, 0 : i8 -> i3
    %21 = llhd.extract_slice %19, 3 : i8 -> i5
    %22 = llhd.insert_slice %4, %21, 0 : i8, i5
    %23 = llhd.extract_slice %22, 0 : i8 -> i5
    %24 = llhd.extract_slice %23, 0 : i5 -> i1
    %25 = llhd.extract_slice %23, 1 : i5 -> i4
    %26 = llhd.insert_slice %5, %25, 0 : i5, i4
    %27 = llhd.extract_slice %26, 0 : i5 -> i1
    %28 = llhd.extract_slice %23, 2 : i5 -> i3
    %29 = llhd.insert_slice %5, %28, 0 : i5, i3
    %30 = llhd.extract_slice %29, 0 : i5 -> i1
    %31 = llhd.extract_slice %23, 3 : i5 -> i2
    %32 = llhd.insert_slice %5, %31, 0 : i5, i2
    %33 = llhd.extract_slice %32, 0 : i5 -> i1
    %34 = llhd.extract_slice %23, 4 : i5 -> i1
    %35 = llhd.insert_slice %5, %34, 0 : i5, i1
    %36 = llhd.extract_slice %35, 0 : i5 -> i1
    %37 = llhd.tuple %24, %27, %30, %33, %36 : tuple<i1, i1, i1, i1, i1>
    %38 = llhd.tuple %20, %37 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %39 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %fcsr_q, %38 after %39 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    br ^init
}

llhd.proc @snitch.param1.always_comb.12607.1(%stall: !llhd.sig<i1>) -> (%core_events_o: !llhd.sig<tuple<i1, i1, i1, i1>> ) {
    br ^body
^body:
    %0 = llhd.const 0 : i1
    %1 = llhd.tuple %0, %0, %0, %0 : tuple<i1, i1, i1, i1>
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %core_events_o, %1 after %2 : !llhd.sig<tuple<i1, i1, i1, i1>>
    %3 = llhd.extract_element %core_events_o, 3 : !llhd.sig<tuple<i1, i1, i1, i1>> -> !llhd.sig<i1>
    %stall.prb = llhd.prb %stall : !llhd.sig<i1>
    %4 = llhd.not %stall.prb : i1
    llhd.drv %3, %4 after %2 : !llhd.sig<i1>
    llhd.wait (%stall : !llhd.sig<i1>), ^body
}

llhd.proc @snitch.param1.always_comb.12929.1(%acc_pid_i: !llhd.sig<i5>, %rd: !llhd.sig<i5>, %stall: !llhd.sig<i1>, %sb_q: !llhd.sig<i32>, %is_load: !llhd.sig<i1>, %lsu_rd: !llhd.sig<i5>, %retire_load: !llhd.sig<i1>, %retire_acc: !llhd.sig<i1>, %acc_register_rd: !llhd.sig<i1>) -> (%sb_d: !llhd.sig<i32> ) {
    br ^body
^body:
    %sb_q.prb = llhd.prb %sb_q : !llhd.sig<i32>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %sb_d, %sb_q.prb after %0 : !llhd.sig<i32>
    %retire_load.prb = llhd.prb %retire_load : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.neq %retire_load.prb, %1 : i1
    %3 = llhd.const 0 : i32
    cond_br %2, ^if_true, ^if_exit
^if_exit:
    %is_load.prb = llhd.prb %is_load : !llhd.sig<i1>
    %acc_register_rd.prb = llhd.prb %acc_register_rd : !llhd.sig<i1>
    %4 = llhd.or %is_load.prb, %acc_register_rd.prb : i1
    %5 = llhd.neq %4, %1 : i1
    %stall.prb = llhd.prb %stall : !llhd.sig<i1>
    %6 = llhd.neq %stall.prb, %1 : i1
    %7 = llhd.not %6 : i1
    %8 = llhd.neq %7, %1 : i1
    %9 = llhd.and %5, %8 : i1
    %10 = llhd.neq %9, %1 : i1
    cond_br %10, ^if_true1, ^if_exit1
^if_true:
    %lsu_rd.prb = llhd.prb %lsu_rd : !llhd.sig<i5>
    %11 = llhd.dyn_extract_slice %sb_d, %lsu_rd.prb : (!llhd.sig<i32>, i5) -> !llhd.sig<i1>
    llhd.drv %11, %1 after %0 : !llhd.sig<i1>
    br ^if_exit
^if_exit1:
    %retire_acc.prb = llhd.prb %retire_acc : !llhd.sig<i1>
    %12 = llhd.neq %retire_acc.prb, %1 : i1
    cond_br %12, ^if_true2, ^if_exit2
^if_true1:
    %rd.prb = llhd.prb %rd : !llhd.sig<i5>
    %13 = llhd.dyn_extract_slice %sb_d, %rd.prb : (!llhd.sig<i32>, i5) -> !llhd.sig<i1>
    %14 = llhd.const 1 : i1
    llhd.drv %13, %14 after %0 : !llhd.sig<i1>
    br ^if_exit1
^if_exit2:
    %15 = llhd.extract_slice %sb_d, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    llhd.drv %15, %1 after %0 : !llhd.sig<i1>
    llhd.wait (%acc_pid_i, %rd, %stall, %sb_q, %is_load, %lsu_rd, %retire_load, %retire_acc, %acc_register_rd : !llhd.sig<i5>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>), ^body
^if_true2:
    %acc_pid_i.prb = llhd.prb %acc_pid_i : !llhd.sig<i5>
    %16 = llhd.dyn_extract_slice %sb_d, %acc_pid_i.prb : (!llhd.sig<i32>, i5) -> !llhd.sig<i1>
    llhd.drv %16, %1 after %0 : !llhd.sig<i1>
    br ^if_exit2
}

llhd.proc @snitch.param1.always_comb.13188.1(%zero_lsb: !llhd.sig<i1>, %pc_q: !llhd.sig<i32>, %wfi_q: !llhd.sig<i1>, %consec_pc: !llhd.sig<i32>, %alu_result: !llhd.sig<i32>, %stall: !llhd.sig<i1>, %next_pc: !llhd.sig<i2>) -> (%pc_d: !llhd.sig<i32> ) {
    br ^body
^body:
    %pc_q.prb = llhd.prb %pc_q : !llhd.sig<i32>
    %0 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %pc_d, %pc_q.prb after %0 : !llhd.sig<i32>
    %stall.prb = llhd.prb %stall : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.neq %stall.prb, %1 : i1
    %3 = llhd.not %2 : i1
    %4 = llhd.neq %3, %1 : i1
    %wfi_q.prb = llhd.prb %wfi_q : !llhd.sig<i1>
    %5 = llhd.neq %wfi_q.prb, %1 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %1 : i1
    %8 = llhd.and %4, %7 : i1
    %9 = llhd.neq %8, %1 : i1
    cond_br %9, ^if_true, ^check
^check:
    llhd.wait (%zero_lsb, %pc_q, %wfi_q, %consec_pc, %alu_result, %stall, %next_pc : !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i2>), ^body
^if_true:
    %next_pc.prb = llhd.prb %next_pc : !llhd.sig<i2>
    %10 = llhd.const 0 : i2
    %11 = llhd.eq %next_pc.prb, %10 : i2
    cond_br %11, ^case_body, ^12
^12:
    %13 = llhd.const 1 : i2
    %14 = llhd.eq %next_pc.prb, %13 : i2
    cond_br %14, ^case_body1, ^15
^case_body:
    %consec_pc.prb = llhd.prb %consec_pc : !llhd.sig<i32>
    llhd.drv %pc_d, %consec_pc.prb after %0 : !llhd.sig<i32>
    br ^check
^15:
    %16 = llhd.const 2 : i2
    %17 = llhd.eq %next_pc.prb, %16 : i2
    cond_br %17, ^case_body2, ^check
^case_body1:
    %alu_result.prb = llhd.prb %alu_result : !llhd.sig<i32>
    %18 = llhd.const 0 : i32
    %zero_lsb.prb = llhd.prb %zero_lsb : !llhd.sig<i1>
    %19 = llhd.not %zero_lsb.prb : i1
    %20 = llhd.insert_slice %18, %19, 0 : i32, i1
    %21 = llhd.const 2147483647 : i31
    %concat = llhd.insert_slice %20, %21, 1 : i32, i31
    %22 = llhd.and %alu_result.prb, %concat : i32
    llhd.drv %pc_d, %22 after %0 : !llhd.sig<i32>
    br ^check
^case_body2:
    %23 = llhd.const 65536 : i32
    llhd.drv %pc_d, %23 after %0 : !llhd.sig<i32>
    br ^check
}

llhd.proc @snitch.param1.always_comb.22810.1(%inst_data_i: !llhd.sig<i32>, %wake_up_sync_i: !llhd.sig<i1>, %wfi_q: !llhd.sig<i1>, %uimm: !llhd.sig<i32>, %valid_instr: !llhd.sig<i1>, %csr_rvalue: !llhd.sig<i32>) -> (%acc_qvalid_o: !llhd.sig<i1> , %illegal_inst: !llhd.sig<i1> , %zero_lsb: !llhd.sig<i1> , %wfi_d: !llhd.sig<i1> , %is_load: !llhd.sig<i1> , %is_store: !llhd.sig<i1> , %is_signed: !llhd.sig<i1> , %ls_size: !llhd.sig<i2> , %ls_amo: !llhd.sig<i4> , %alu_op: !llhd.sig<i4> , %opa_select: !llhd.sig<i4> , %opb_select: !llhd.sig<i4> , %write_rd: !llhd.sig<i1> , %uses_rd: !llhd.sig<i1> , %next_pc: !llhd.sig<i2> , %rd_select: !llhd.sig<i2> , %rd_bypass: !llhd.sig<i32> , %is_branch: !llhd.sig<i1> , %csr_en: !llhd.sig<i1> , %acc_register_rd: !llhd.sig<i1> ) {
    br ^body
^body:
    %0 = llhd.const 0 : i1
    %1 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst, %0 after %1 : !llhd.sig<i1>
    %2 = llhd.const 0 : i4
    llhd.drv %alu_op, %2 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %2 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %2 after %1 : !llhd.sig<i4>
    %3 = llhd.const 0 : i2
    llhd.drv %next_pc, %3 after %1 : !llhd.sig<i2>
    llhd.drv %rd_select, %3 after %1 : !llhd.sig<i2>
    %4 = llhd.const 1 : i1
    llhd.drv %write_rd, %4 after %1 : !llhd.sig<i1>
    %write_rd.prb = llhd.prb %write_rd : !llhd.sig<i1>
    llhd.drv %uses_rd, %write_rd.prb after %1 : !llhd.sig<i1>
    %5 = llhd.const 0 : i32
    llhd.drv %rd_bypass, %5 after %1 : !llhd.sig<i32>
    llhd.drv %zero_lsb, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_branch, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_store, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %0 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %3 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %2 after %1 : !llhd.sig<i4>
    llhd.drv %acc_qvalid_o, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_register_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %csr_en, %0 after %1 : !llhd.sig<i1>
    %wake_up_sync_i.prb = llhd.prb %wake_up_sync_i : !llhd.sig<i1>
    %6 = llhd.neq %wake_up_sync_i.prb, %0 : i1
    %wfi_q.prb = llhd.prb %wfi_q : !llhd.sig<i1>
    %7 = llhd.array %wfi_q.prb, %0 : !llhd.array<2xi1>
    %8 = llhd.dyn_extract_element %7, %6 : (!llhd.array<2xi1>, i1) -> i1
    llhd.drv %wfi_d, %8 after %1 : !llhd.sig<i1>
    %inst_data_i.prb = llhd.prb %inst_data_i : !llhd.sig<i32>
    %9 = llhd.const 4261441663 : i32
    %10 = llhd.and %inst_data_i.prb, %9 : i32
    %11 = llhd.const 51 : i32
    %12 = llhd.eq %10, %11 : i32
    %13 = llhd.const 1 : i4
    %14 = llhd.const 2 : i2
    cond_br %12, ^case_body, ^15
^15:
    %16 = llhd.const 28799 : i32
    %17 = llhd.and %inst_data_i.prb, %16 : i32
    %18 = llhd.const 19 : i32
    %19 = llhd.eq %17, %18 : i32
    %20 = llhd.const 2 : i4
    cond_br %19, ^case_body1, ^21
^case_body:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^check:
    llhd.wait (%inst_data_i, %wake_up_sync_i, %wfi_q, %uimm, %valid_instr, %csr_rvalue : !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>), ^body
^case_exit:
    %illegal_inst.prb = llhd.prb %illegal_inst : !llhd.sig<i1>
    %22 = llhd.neq %illegal_inst.prb, %0 : i1
    cond_br %22, ^if_true, ^check
^if_true:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %next_pc, %14 after %1 : !llhd.sig<i2>
    br ^check
^21:
    %23 = llhd.const 1073741875 : i32
    %24 = llhd.eq %10, %23 : i32
    cond_br %24, ^case_body2, ^25
^case_body1:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^25:
    %26 = llhd.const 16435 : i32
    %27 = llhd.eq %10, %26 : i32
    %28 = llhd.const 7 : i4
    cond_br %27, ^case_body3, ^29
^case_body2:
    llhd.drv %alu_op, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^29:
    %30 = llhd.const 16403 : i32
    %31 = llhd.eq %17, %30 : i32
    cond_br %31, ^case_body4, ^32
^case_body3:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %alu_op, %28 after %1 : !llhd.sig<i4>
    br ^case_exit
^32:
    %33 = llhd.const 24627 : i32
    %34 = llhd.eq %10, %33 : i32
    %35 = llhd.const 8 : i4
    cond_br %34, ^case_body5, ^36
^case_body4:
    llhd.drv %alu_op, %28 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^36:
    %37 = llhd.const 24595 : i32
    %38 = llhd.eq %17, %37 : i32
    cond_br %38, ^case_body6, ^39
^case_body5:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %alu_op, %35 after %1 : !llhd.sig<i4>
    br ^case_exit
^39:
    %40 = llhd.const 28723 : i32
    %41 = llhd.eq %10, %40 : i32
    %42 = llhd.const 9 : i4
    cond_br %41, ^case_body7, ^43
^case_body6:
    llhd.drv %alu_op, %35 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^43:
    %44 = llhd.const 28691 : i32
    %45 = llhd.eq %17, %44 : i32
    cond_br %45, ^case_body8, ^46
^case_body7:
    llhd.drv %alu_op, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^46:
    %47 = llhd.const 8243 : i32
    %48 = llhd.eq %10, %47 : i32
    cond_br %48, ^case_body9, ^49
^case_body8:
    llhd.drv %alu_op, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^49:
    %50 = llhd.const 8211 : i32
    %51 = llhd.eq %17, %50 : i32
    cond_br %51, ^case_body10, ^52
^case_body9:
    llhd.drv %alu_op, %20 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^52:
    %53 = llhd.const 12339 : i32
    %54 = llhd.eq %10, %53 : i32
    %55 = llhd.const 3 : i4
    cond_br %54, ^case_body11, ^56
^case_body10:
    llhd.drv %alu_op, %20 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^56:
    %57 = llhd.const 12307 : i32
    %58 = llhd.eq %17, %57 : i32
    cond_br %58, ^case_body12, ^59
^case_body11:
    llhd.drv %alu_op, %55 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^59:
    %60 = llhd.const 4147 : i32
    %61 = llhd.eq %10, %60 : i32
    %62 = llhd.const 4 : i4
    cond_br %61, ^case_body13, ^63
^case_body12:
    llhd.drv %alu_op, %55 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^63:
    %64 = llhd.const 20531 : i32
    %65 = llhd.eq %10, %64 : i32
    %66 = llhd.const 5 : i4
    cond_br %65, ^case_body14, ^67
^case_body13:
    llhd.drv %alu_op, %62 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^67:
    %68 = llhd.const 1073762355 : i32
    %69 = llhd.eq %10, %68 : i32
    %70 = llhd.const 6 : i4
    cond_br %69, ^case_body15, ^71
^case_body14:
    llhd.drv %alu_op, %66 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^71:
    %72 = llhd.const 4227887231 : i32
    %73 = llhd.and %inst_data_i.prb, %72 : i32
    %74 = llhd.const 4115 : i32
    %75 = llhd.eq %73, %74 : i32
    cond_br %75, ^case_body16, ^76
^case_body15:
    llhd.drv %alu_op, %70 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^76:
    %77 = llhd.const 20499 : i32
    %78 = llhd.eq %73, %77 : i32
    cond_br %78, ^case_body17, ^79
^case_body16:
    llhd.drv %alu_op, %62 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^79:
    %80 = llhd.const 1073762323 : i32
    %81 = llhd.eq %73, %80 : i32
    cond_br %81, ^case_body18, ^82
^case_body17:
    llhd.drv %alu_op, %66 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^82:
    %83 = llhd.const 127 : i32
    %84 = llhd.and %inst_data_i.prb, %83 : i32
    %85 = llhd.const 55 : i32
    %86 = llhd.eq %84, %85 : i32
    cond_br %86, ^case_body19, ^87
^case_body18:
    llhd.drv %alu_op, %70 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^87:
    %88 = llhd.const 23 : i32
    %89 = llhd.eq %84, %88 : i32
    cond_br %89, ^case_body20, ^90
^case_body19:
    llhd.drv %opa_select, %2 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %2 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    %uimm.prb = llhd.prb %uimm : !llhd.sig<i32>
    llhd.drv %rd_bypass, %uimm.prb after %1 : !llhd.sig<i32>
    br ^case_exit
^90:
    %91 = llhd.const 111 : i32
    %92 = llhd.eq %84, %91 : i32
    %93 = llhd.const 1 : i2
    cond_br %92, ^case_body21, ^94
^case_body20:
    llhd.drv %opa_select, %55 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %28 after %1 : !llhd.sig<i4>
    br ^case_exit
^94:
    %95 = llhd.const 103 : i32
    %96 = llhd.eq %17, %95 : i32
    cond_br %96, ^case_body22, ^97
^case_body21:
    llhd.drv %rd_select, %93 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %62 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %28 after %1 : !llhd.sig<i4>
    llhd.drv %next_pc, %93 after %1 : !llhd.sig<i2>
    br ^case_exit
^97:
    %98 = llhd.const 99 : i32
    %99 = llhd.eq %17, %98 : i32
    %100 = llhd.const 11 : i4
    cond_br %99, ^case_body23, ^101
^case_body22:
    llhd.drv %rd_select, %93 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    llhd.drv %next_pc, %93 after %1 : !llhd.sig<i2>
    llhd.drv %zero_lsb, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^101:
    %102 = llhd.const 4195 : i32
    %103 = llhd.eq %17, %102 : i32
    cond_br %103, ^case_body24, ^104
^case_body23:
    llhd.drv %is_branch, %4 after %1 : !llhd.sig<i1>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %alu_op, %100 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^104:
    %105 = llhd.const 16483 : i32
    %106 = llhd.eq %17, %105 : i32
    cond_br %106, ^case_body25, ^107
^case_body24:
    llhd.drv %is_branch, %4 after %1 : !llhd.sig<i1>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    %108 = llhd.const 12 : i4
    llhd.drv %alu_op, %108 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^107:
    %109 = llhd.const 24675 : i32
    %110 = llhd.eq %17, %109 : i32
    cond_br %110, ^case_body26, ^111
^case_body25:
    llhd.drv %is_branch, %4 after %1 : !llhd.sig<i1>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %alu_op, %20 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^111:
    %112 = llhd.const 20579 : i32
    %113 = llhd.eq %17, %112 : i32
    cond_br %113, ^case_body27, ^114
^case_body26:
    llhd.drv %is_branch, %4 after %1 : !llhd.sig<i1>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %alu_op, %55 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^114:
    %115 = llhd.const 28771 : i32
    %116 = llhd.eq %17, %115 : i32
    cond_br %116, ^case_body28, ^117
^case_body27:
    llhd.drv %is_branch, %4 after %1 : !llhd.sig<i1>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    %118 = llhd.const 13 : i4
    llhd.drv %alu_op, %118 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^117:
    %119 = llhd.const 35 : i32
    %120 = llhd.eq %17, %119 : i32
    cond_br %120, ^case_body29, ^121
^case_body28:
    llhd.drv %is_branch, %4 after %1 : !llhd.sig<i1>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    %122 = llhd.const 14 : i4
    llhd.drv %alu_op, %122 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^121:
    %123 = llhd.const 4131 : i32
    %124 = llhd.eq %17, %123 : i32
    cond_br %124, ^case_body30, ^125
^case_body29:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_store, %4 after %1 : !llhd.sig<i1>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %66 after %1 : !llhd.sig<i4>
    br ^case_exit
^125:
    %126 = llhd.const 8227 : i32
    %127 = llhd.eq %17, %126 : i32
    cond_br %127, ^case_body31, ^128
^case_body30:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_store, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %93 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %66 after %1 : !llhd.sig<i4>
    br ^case_exit
^128:
    %129 = llhd.const 3 : i32
    %130 = llhd.eq %17, %129 : i32
    cond_br %130, ^case_body32, ^131
^case_body31:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %is_store, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %66 after %1 : !llhd.sig<i4>
    br ^case_exit
^131:
    %132 = llhd.const 4099 : i32
    %133 = llhd.eq %17, %132 : i32
    cond_br %133, ^case_body33, ^134
^case_body32:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^134:
    %135 = llhd.const 8195 : i32
    %136 = llhd.eq %17, %135 : i32
    cond_br %136, ^case_body34, ^137
^case_body33:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %93 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^137:
    %138 = llhd.const 16387 : i32
    %139 = llhd.eq %17, %138 : i32
    cond_br %139, ^case_body35, ^140
^case_body34:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^140:
    %141 = llhd.const 20483 : i32
    %142 = llhd.eq %17, %141 : i32
    cond_br %142, ^case_body36, ^143
^case_body35:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^143:
    %144 = llhd.const 4211 : i32
    %145 = llhd.eq %17, %144 : i32
    %csr_rvalue.prb = llhd.prb %csr_rvalue : !llhd.sig<i32>
    cond_br %145, ^case_body37, ^146
^case_body36:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %93 after %1 : !llhd.sig<i2>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    br ^case_exit
^146:
    %147 = llhd.const 20595 : i32
    %148 = llhd.eq %17, %147 : i32
    cond_br %148, ^case_body38, ^149
^case_body37:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %2 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    llhd.drv %rd_bypass, %csr_rvalue.prb after %1 : !llhd.sig<i32>
    llhd.drv %csr_en, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^149:
    %150 = llhd.const 8307 : i32
    %151 = llhd.eq %17, %150 : i32
    cond_br %151, ^case_body39, ^152
^case_body38:
    llhd.drv %opa_select, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %2 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    llhd.drv %rd_bypass, %csr_rvalue.prb after %1 : !llhd.sig<i32>
    llhd.drv %csr_en, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^152:
    %153 = llhd.const 24691 : i32
    %154 = llhd.eq %17, %153 : i32
    %155 = llhd.extract_slice %inst_data_i.prb, 20 : i32 -> i12
    %156 = llhd.const 1984 : i12
    %valid_instr.prb = llhd.prb %valid_instr : !llhd.sig<i1>
    cond_br %154, ^case_body40, ^157
^case_body39:
    llhd.drv %alu_op, %35 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %35 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    llhd.drv %rd_bypass, %csr_rvalue.prb after %1 : !llhd.sig<i32>
    llhd.drv %csr_en, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^157:
    %158 = llhd.const 12403 : i32
    %159 = llhd.eq %17, %158 : i32
    %160 = llhd.const 10 : i4
    cond_br %159, ^case_body41, ^161
^case_body40:
    %162 = llhd.insert_slice %5, %155, 0 : i32, i12
    %163 = llhd.extract_slice %162, 0 : i32 -> i12
    %164 = llhd.neq %163, %156 : i12
    %165 = llhd.neq %164, %0 : i1
    cond_br %165, ^if_true1, ^if_false
^if_false:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^if_true1:
    llhd.drv %alu_op, %35 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %35 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    llhd.drv %rd_bypass, %csr_rvalue.prb after %1 : !llhd.sig<i32>
    llhd.drv %csr_en, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^161:
    %166 = llhd.const 28787 : i32
    %167 = llhd.eq %17, %166 : i32
    cond_br %167, ^case_body42, ^168
^case_body41:
    llhd.drv %alu_op, %160 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %35 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    llhd.drv %rd_bypass, %csr_rvalue.prb after %1 : !llhd.sig<i32>
    llhd.drv %csr_en, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^168:
    %169 = llhd.const 115 : i32
    %170 = llhd.eq %inst_data_i.prb, %169 : i32
    %171 = llhd.const 1048691 : i32
    %172 = llhd.eq %inst_data_i.prb, %171 : i32
    %173 = llhd.or %170, %172 : i1
    cond_br %173, ^case_body43, ^174
^case_body42:
    %175 = llhd.insert_slice %5, %155, 0 : i32, i12
    %176 = llhd.extract_slice %175, 0 : i32 -> i12
    %177 = llhd.neq %176, %156 : i12
    %178 = llhd.neq %177, %0 : i1
    cond_br %178, ^if_true2, ^if_false1
^if_false1:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^if_true2:
    llhd.drv %alu_op, %160 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %35 after %1 : !llhd.sig<i4>
    llhd.drv %rd_select, %14 after %1 : !llhd.sig<i2>
    llhd.drv %rd_bypass, %csr_rvalue.prb after %1 : !llhd.sig<i32>
    llhd.drv %csr_en, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^174:
    %179 = llhd.const 15 : i32
    %180 = llhd.eq %17, %179 : i32
    cond_br %180, ^case_body44, ^181
^case_body43:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    br ^case_exit
^181:
    %182 = llhd.const 273678451 : i32
    %183 = llhd.eq %inst_data_i.prb, %182 : i32
    cond_br %183, ^case_body45, ^184
^case_body44:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    br ^case_exit
^184:
    %185 = llhd.const 4160778367 : i32
    %186 = llhd.and %inst_data_i.prb, %185 : i32
    %187 = llhd.const 8239 : i32
    %188 = llhd.eq %186, %187 : i32
    %189 = llhd.const 15 : i4
    cond_br %188, ^case_body46, ^190
^case_body45:
    llhd.drv %wfi_d, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^190:
    %191 = llhd.const 536879151 : i32
    %192 = llhd.eq %186, %191 : i32
    cond_br %192, ^case_body47, ^193
^case_body46:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %20 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^193:
    %194 = llhd.const 1073750063 : i32
    %195 = llhd.eq %186, %194 : i32
    cond_br %195, ^case_body48, ^196
^case_body47:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %66 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^196:
    %197 = llhd.const 1610620975 : i32
    %198 = llhd.eq %186, %197 : i32
    cond_br %198, ^case_body49, ^199
^case_body48:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %62 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^199:
    %200 = llhd.const 2147491887 : i32
    %201 = llhd.eq %186, %200 : i32
    cond_br %201, ^case_body50, ^202
^case_body49:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %55 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^202:
    %203 = llhd.const 2684362799 : i32
    %204 = llhd.eq %186, %203 : i32
    cond_br %204, ^case_body51, ^205
^case_body50:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^205:
    %206 = llhd.const 3221233711 : i32
    %207 = llhd.eq %186, %206 : i32
    cond_br %207, ^case_body52, ^208
^case_body51:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %70 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^208:
    %209 = llhd.const 3758104623 : i32
    %210 = llhd.eq %186, %209 : i32
    cond_br %210, ^case_body53, ^211
^case_body52:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %42 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^211:
    %212 = llhd.const 134225967 : i32
    %213 = llhd.eq %186, %212 : i32
    cond_br %213, ^case_body54, ^214
^case_body53:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %28 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^214:
    %215 = llhd.const 4193284223 : i32
    %216 = llhd.and %inst_data_i.prb, %215 : i32
    %217 = llhd.const 268443695 : i32
    %218 = llhd.eq %216, %217 : i32
    cond_br %218, ^case_body55, ^219
^case_body54:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^219:
    %220 = llhd.const 402661423 : i32
    %221 = llhd.eq %186, %220 : i32
    cond_br %221, ^case_body56, ^222
^case_body55:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %160 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^222:
    %223 = llhd.const 33554483 : i32
    %224 = llhd.eq %10, %223 : i32
    %225 = llhd.const 33558579 : i32
    %226 = llhd.eq %10, %225 : i32
    %227 = llhd.or %224, %226 : i1
    %228 = llhd.const 33562675 : i32
    %229 = llhd.eq %10, %228 : i32
    %230 = llhd.or %227, %229 : i1
    %231 = llhd.const 33566771 : i32
    %232 = llhd.eq %10, %231 : i32
    %233 = llhd.or %230, %232 : i1
    %234 = llhd.const 33570867 : i32
    %235 = llhd.eq %10, %234 : i32
    %236 = llhd.or %233, %235 : i1
    %237 = llhd.const 33574963 : i32
    %238 = llhd.eq %10, %237 : i32
    %239 = llhd.or %236, %238 : i1
    %240 = llhd.const 33579059 : i32
    %241 = llhd.eq %10, %240 : i32
    %242 = llhd.or %239, %241 : i1
    %243 = llhd.const 33583155 : i32
    %244 = llhd.eq %10, %243 : i32
    %245 = llhd.or %242, %244 : i1
    %246 = llhd.const 33554491 : i32
    %247 = llhd.eq %10, %246 : i32
    %248 = llhd.or %245, %247 : i1
    %249 = llhd.const 33570875 : i32
    %250 = llhd.eq %10, %249 : i32
    %251 = llhd.or %248, %250 : i1
    %252 = llhd.const 33574971 : i32
    %253 = llhd.eq %10, %252 : i32
    %254 = llhd.or %251, %253 : i1
    %255 = llhd.const 33579067 : i32
    %256 = llhd.eq %10, %255 : i32
    %257 = llhd.or %254, %256 : i1
    %258 = llhd.const 33583163 : i32
    %259 = llhd.eq %10, %258 : i32
    %260 = llhd.or %257, %259 : i1
    cond_br %260, ^case_body57, ^261
^case_body56:
    llhd.drv %alu_op, %189 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_load, %4 after %1 : !llhd.sig<i1>
    llhd.drv %is_signed, %4 after %1 : !llhd.sig<i1>
    llhd.drv %ls_size, %14 after %1 : !llhd.sig<i2>
    llhd.drv %ls_amo, %100 after %1 : !llhd.sig<i4>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    br ^case_exit
^261:
    %262 = llhd.const 4261412991 : i32
    %263 = llhd.and %inst_data_i.prb, %262 : i32
    %264 = llhd.const 83 : i32
    %265 = llhd.eq %263, %264 : i32
    %266 = llhd.const 134217811 : i32
    %267 = llhd.eq %263, %266 : i32
    %268 = llhd.or %265, %267 : i1
    %269 = llhd.const 268435539 : i32
    %270 = llhd.eq %263, %269 : i32
    %271 = llhd.or %268, %270 : i1
    %272 = llhd.const 402653267 : i32
    %273 = llhd.eq %263, %272 : i32
    %274 = llhd.or %271, %273 : i1
    %275 = llhd.const 536870995 : i32
    %276 = llhd.eq %10, %275 : i32
    %277 = llhd.or %274, %276 : i1
    %278 = llhd.const 536875091 : i32
    %279 = llhd.eq %10, %278 : i32
    %280 = llhd.or %277, %279 : i1
    %281 = llhd.const 536879187 : i32
    %282 = llhd.eq %10, %281 : i32
    %283 = llhd.or %280, %282 : i1
    %284 = llhd.const 671088723 : i32
    %285 = llhd.eq %10, %284 : i32
    %286 = llhd.or %283, %285 : i1
    %287 = llhd.const 671092819 : i32
    %288 = llhd.eq %10, %287 : i32
    %289 = llhd.or %286, %288 : i1
    %290 = llhd.const 4293918847 : i32
    %291 = llhd.and %inst_data_i.prb, %290 : i32
    %292 = llhd.const 1476395091 : i32
    %293 = llhd.eq %291, %292 : i32
    %294 = llhd.or %289, %293 : i1
    %295 = llhd.const 100663423 : i32
    %296 = llhd.and %inst_data_i.prb, %295 : i32
    %297 = llhd.const 67 : i32
    %298 = llhd.eq %296, %297 : i32
    %299 = llhd.or %294, %298 : i1
    %300 = llhd.const 71 : i32
    %301 = llhd.eq %296, %300 : i32
    %302 = llhd.or %299, %301 : i1
    %303 = llhd.const 75 : i32
    %304 = llhd.eq %296, %303 : i32
    %305 = llhd.or %302, %304 : i1
    %306 = llhd.const 79 : i32
    %307 = llhd.eq %296, %306 : i32
    %308 = llhd.or %305, %307 : i1
    cond_br %308, ^case_body58, ^309
^case_body57:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %acc_register_rd, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^309:
    %310 = llhd.const 2181038131 : i32
    %311 = llhd.eq %10, %310 : i32
    %312 = llhd.const 2181054515 : i32
    %313 = llhd.eq %10, %312 : i32
    %314 = llhd.or %311, %313 : i1
    %315 = llhd.const 2214592563 : i32
    %316 = llhd.eq %10, %315 : i32
    %317 = llhd.or %314, %316 : i1
    %318 = llhd.const 2214608947 : i32
    %319 = llhd.eq %10, %318 : i32
    %320 = llhd.or %317, %319 : i1
    %321 = llhd.const 2248146995 : i32
    %322 = llhd.eq %10, %321 : i32
    %323 = llhd.or %320, %322 : i1
    %324 = llhd.const 2248163379 : i32
    %325 = llhd.eq %10, %324 : i32
    %326 = llhd.or %323, %325 : i1
    %327 = llhd.const 2281701427 : i32
    %328 = llhd.eq %10, %327 : i32
    %329 = llhd.or %326, %328 : i1
    %330 = llhd.const 2281717811 : i32
    %331 = llhd.eq %10, %330 : i32
    %332 = llhd.or %329, %331 : i1
    %333 = llhd.const 2315255859 : i32
    %334 = llhd.eq %10, %333 : i32
    %335 = llhd.or %332, %334 : i1
    %336 = llhd.const 2315272243 : i32
    %337 = llhd.eq %10, %336 : i32
    %338 = llhd.or %335, %337 : i1
    %339 = llhd.const 2348810291 : i32
    %340 = llhd.eq %10, %339 : i32
    %341 = llhd.or %338, %340 : i1
    %342 = llhd.const 2348826675 : i32
    %343 = llhd.eq %10, %342 : i32
    %344 = llhd.or %341, %343 : i1
    %345 = llhd.const 4293947519 : i32
    %346 = llhd.and %inst_data_i.prb, %345 : i32
    %347 = llhd.const 2382364723 : i32
    %348 = llhd.eq %346, %347 : i32
    %349 = llhd.or %344, %348 : i1
    %350 = llhd.const 2415919155 : i32
    %351 = llhd.eq %10, %350 : i32
    %352 = llhd.or %349, %351 : i1
    %353 = llhd.const 2415935539 : i32
    %354 = llhd.eq %10, %353 : i32
    %355 = llhd.or %352, %354 : i1
    %356 = llhd.const 2449473587 : i32
    %357 = llhd.eq %10, %356 : i32
    %358 = llhd.or %355, %357 : i1
    %359 = llhd.const 2449489971 : i32
    %360 = llhd.eq %10, %359 : i32
    %361 = llhd.or %358, %360 : i1
    %362 = llhd.const 2583691315 : i32
    %363 = llhd.eq %10, %362 : i32
    %364 = llhd.or %361, %363 : i1
    %365 = llhd.const 2583707699 : i32
    %366 = llhd.eq %10, %365 : i32
    %367 = llhd.or %364, %366 : i1
    %368 = llhd.const 2617245747 : i32
    %369 = llhd.eq %10, %368 : i32
    %370 = llhd.or %367, %369 : i1
    %371 = llhd.const 2617262131 : i32
    %372 = llhd.eq %10, %371 : i32
    %373 = llhd.or %370, %372 : i1
    %374 = llhd.const 2650800179 : i32
    %375 = llhd.eq %10, %374 : i32
    %376 = llhd.or %373, %375 : i1
    %377 = llhd.const 2650816563 : i32
    %378 = llhd.eq %10, %377 : i32
    %379 = llhd.or %376, %378 : i1
    %380 = llhd.const 2952790067 : i32
    %381 = llhd.eq %10, %380 : i32
    %382 = llhd.or %379, %381 : i1
    %383 = llhd.const 3019898931 : i32
    %384 = llhd.eq %10, %383 : i32
    %385 = llhd.or %382, %384 : i1
    cond_br %385, ^case_body59, ^386
^case_body58:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^386:
    %387 = llhd.const 33554515 : i32
    %388 = llhd.eq %263, %387 : i32
    %389 = llhd.const 167772243 : i32
    %390 = llhd.eq %263, %389 : i32
    %391 = llhd.or %388, %390 : i1
    %392 = llhd.const 301989971 : i32
    %393 = llhd.eq %263, %392 : i32
    %394 = llhd.or %391, %393 : i1
    %395 = llhd.const 436207699 : i32
    %396 = llhd.eq %263, %395 : i32
    %397 = llhd.or %394, %396 : i1
    %398 = llhd.const 570425427 : i32
    %399 = llhd.eq %10, %398 : i32
    %400 = llhd.or %397, %399 : i1
    %401 = llhd.const 570429523 : i32
    %402 = llhd.eq %10, %401 : i32
    %403 = llhd.or %400, %402 : i1
    %404 = llhd.const 570433619 : i32
    %405 = llhd.eq %10, %404 : i32
    %406 = llhd.or %403, %405 : i1
    %407 = llhd.const 704643155 : i32
    %408 = llhd.eq %10, %407 : i32
    %409 = llhd.or %406, %408 : i1
    %410 = llhd.const 704647251 : i32
    %411 = llhd.eq %10, %410 : i32
    %412 = llhd.or %409, %411 : i1
    %413 = llhd.const 1509949523 : i32
    %414 = llhd.eq %291, %413 : i32
    %415 = llhd.or %412, %414 : i1
    %416 = llhd.const 33554499 : i32
    %417 = llhd.eq %296, %416 : i32
    %418 = llhd.or %415, %417 : i1
    %419 = llhd.const 33554503 : i32
    %420 = llhd.eq %296, %419 : i32
    %421 = llhd.or %418, %420 : i1
    %422 = llhd.const 33554507 : i32
    %423 = llhd.eq %296, %422 : i32
    %424 = llhd.or %421, %423 : i1
    %425 = llhd.const 33554511 : i32
    %426 = llhd.eq %296, %425 : i32
    %427 = llhd.or %424, %426 : i1
    cond_br %427, ^case_body60, ^428
^case_body59:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^428:
    %429 = llhd.const 1074790483 : i32
    %430 = llhd.eq %291, %429 : i32
    %431 = llhd.const 1107296339 : i32
    %432 = llhd.eq %291, %431 : i32
    %433 = llhd.or %430, %432 : i1
    cond_br %433, ^case_body61, ^434
^case_body60:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^434:
    %435 = llhd.const 67108947 : i32
    %436 = llhd.eq %263, %435 : i32
    %437 = llhd.const 201326675 : i32
    %438 = llhd.eq %263, %437 : i32
    %439 = llhd.or %436, %438 : i1
    %440 = llhd.const 335544403 : i32
    %441 = llhd.eq %263, %440 : i32
    %442 = llhd.or %439, %441 : i1
    %443 = llhd.const 469762131 : i32
    %444 = llhd.eq %263, %443 : i32
    %445 = llhd.or %442, %444 : i1
    %446 = llhd.const 1543503955 : i32
    %447 = llhd.eq %291, %446 : i32
    %448 = llhd.or %445, %447 : i1
    %449 = llhd.const 67108931 : i32
    %450 = llhd.eq %296, %449 : i32
    %451 = llhd.or %448, %450 : i1
    %452 = llhd.const 67108935 : i32
    %453 = llhd.eq %296, %452 : i32
    %454 = llhd.or %451, %453 : i1
    %455 = llhd.const 67108939 : i32
    %456 = llhd.eq %296, %455 : i32
    %457 = llhd.or %454, %456 : i1
    %458 = llhd.const 67108943 : i32
    %459 = llhd.eq %296, %458 : i32
    %460 = llhd.or %457, %459 : i1
    cond_br %460, ^case_body62, ^461
^case_body61:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^461:
    %462 = llhd.const 603979859 : i32
    %463 = llhd.eq %10, %462 : i32
    %464 = llhd.const 603983955 : i32
    %465 = llhd.eq %10, %464 : i32
    %466 = llhd.or %463, %465 : i1
    %467 = llhd.const 603988051 : i32
    %468 = llhd.eq %10, %467 : i32
    %469 = llhd.or %466, %468 : i1
    %470 = llhd.const 738197587 : i32
    %471 = llhd.eq %10, %470 : i32
    %472 = llhd.or %469, %471 : i1
    %473 = llhd.const 738201683 : i32
    %474 = llhd.eq %10, %473 : i32
    %475 = llhd.or %472, %474 : i1
    cond_br %475, ^case_body63, ^476
^case_body62:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^476:
    %477 = llhd.const 1075839059 : i32
    %478 = llhd.eq %346, %477 : i32
    %479 = llhd.const 1140850771 : i32
    %480 = llhd.eq %291, %479 : i32
    %481 = llhd.or %478, %480 : i1
    cond_br %481, ^case_body64, ^482
^case_body63:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^482:
    %483 = llhd.const 1109393491 : i32
    %484 = llhd.eq %346, %483 : i32
    %485 = llhd.const 1141899347 : i32
    %486 = llhd.eq %291, %485 : i32
    %487 = llhd.or %484, %486 : i1
    cond_br %487, ^case_body65, ^488
^case_body64:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^488:
    %489 = llhd.const 2181046323 : i32
    %490 = llhd.eq %10, %489 : i32
    %491 = llhd.const 2181062707 : i32
    %492 = llhd.eq %10, %491 : i32
    %493 = llhd.or %490, %492 : i1
    %494 = llhd.const 2214600755 : i32
    %495 = llhd.eq %10, %494 : i32
    %496 = llhd.or %493, %495 : i1
    %497 = llhd.const 2214617139 : i32
    %498 = llhd.eq %10, %497 : i32
    %499 = llhd.or %496, %498 : i1
    %500 = llhd.const 2248155187 : i32
    %501 = llhd.eq %10, %500 : i32
    %502 = llhd.or %499, %501 : i1
    %503 = llhd.const 2248171571 : i32
    %504 = llhd.eq %10, %503 : i32
    %505 = llhd.or %502, %504 : i1
    %506 = llhd.const 2281709619 : i32
    %507 = llhd.eq %10, %506 : i32
    %508 = llhd.or %505, %507 : i1
    %509 = llhd.const 2281726003 : i32
    %510 = llhd.eq %10, %509 : i32
    %511 = llhd.or %508, %510 : i1
    %512 = llhd.const 2315264051 : i32
    %513 = llhd.eq %10, %512 : i32
    %514 = llhd.or %511, %513 : i1
    %515 = llhd.const 2315280435 : i32
    %516 = llhd.eq %10, %515 : i32
    %517 = llhd.or %514, %516 : i1
    %518 = llhd.const 2348818483 : i32
    %519 = llhd.eq %10, %518 : i32
    %520 = llhd.or %517, %519 : i1
    %521 = llhd.const 2348834867 : i32
    %522 = llhd.eq %10, %521 : i32
    %523 = llhd.or %520, %522 : i1
    %524 = llhd.const 2382372915 : i32
    %525 = llhd.eq %346, %524 : i32
    %526 = llhd.or %523, %525 : i1
    %527 = llhd.const 2415927347 : i32
    %528 = llhd.eq %10, %527 : i32
    %529 = llhd.or %526, %528 : i1
    %530 = llhd.const 2415943731 : i32
    %531 = llhd.eq %10, %530 : i32
    %532 = llhd.or %529, %531 : i1
    %533 = llhd.const 2449481779 : i32
    %534 = llhd.eq %10, %533 : i32
    %535 = llhd.or %532, %534 : i1
    %536 = llhd.const 2449498163 : i32
    %537 = llhd.eq %10, %536 : i32
    %538 = llhd.or %535, %537 : i1
    %539 = llhd.const 2583699507 : i32
    %540 = llhd.eq %10, %539 : i32
    %541 = llhd.or %538, %540 : i1
    %542 = llhd.const 2583715891 : i32
    %543 = llhd.eq %10, %542 : i32
    %544 = llhd.or %541, %543 : i1
    %545 = llhd.const 2617253939 : i32
    %546 = llhd.eq %10, %545 : i32
    %547 = llhd.or %544, %546 : i1
    %548 = llhd.const 2617270323 : i32
    %549 = llhd.eq %10, %548 : i32
    %550 = llhd.or %547, %549 : i1
    %551 = llhd.const 2650808371 : i32
    %552 = llhd.eq %10, %551 : i32
    %553 = llhd.or %550, %552 : i1
    %554 = llhd.const 2650824755 : i32
    %555 = llhd.eq %10, %554 : i32
    %556 = llhd.or %553, %555 : i1
    %557 = llhd.const 2952798259 : i32
    %558 = llhd.eq %10, %557 : i32
    %559 = llhd.or %556, %558 : i1
    cond_br %559, ^case_body66, ^560
^case_body65:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^560:
    %561 = llhd.const 2556428339 : i32
    %562 = llhd.eq %346, %561 : i32
    %563 = llhd.const 2556444723 : i32
    %564 = llhd.eq %346, %563 : i32
    %565 = llhd.or %562, %564 : i1
    %566 = llhd.const 2554339379 : i32
    %567 = llhd.eq %346, %566 : i32
    %568 = llhd.or %565, %567 : i1
    %569 = llhd.const 2554355763 : i32
    %570 = llhd.eq %346, %569 : i32
    %571 = llhd.or %568, %570 : i1
    %572 = llhd.const 2952814643 : i32
    %573 = llhd.eq %10, %572 : i32
    %574 = llhd.or %571, %573 : i1
    %575 = llhd.const 3019907123 : i32
    %576 = llhd.eq %10, %575 : i32
    %577 = llhd.or %574, %576 : i1
    %578 = llhd.const 3019923507 : i32
    %579 = llhd.eq %10, %578 : i32
    %580 = llhd.or %577, %579 : i1
    cond_br %580, ^case_body67, ^581
^case_body66:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^581:
    %582 = llhd.const 603996243 : i32
    %583 = llhd.eq %10, %582 : i32
    %584 = llhd.const 604000339 : i32
    %585 = llhd.eq %10, %584 : i32
    %586 = llhd.or %583, %585 : i1
    %587 = llhd.const 604004435 : i32
    %588 = llhd.eq %10, %587 : i32
    %589 = llhd.or %586, %588 : i1
    %590 = llhd.const 738213971 : i32
    %591 = llhd.eq %10, %590 : i32
    %592 = llhd.or %589, %591 : i1
    %593 = llhd.const 738218067 : i32
    %594 = llhd.eq %10, %593 : i32
    %595 = llhd.or %592, %594 : i1
    cond_br %595, ^case_body68, ^596
^case_body67:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^596:
    %597 = llhd.const 1080033363 : i32
    %598 = llhd.eq %346, %597 : i32
    cond_br %598, ^case_body69, ^599
^case_body68:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^599:
    %600 = llhd.const 1113587795 : i32
    %601 = llhd.eq %346, %600 : i32
    cond_br %601, ^case_body70, ^602
^case_body69:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^602:
    %603 = llhd.const 1147142227 : i32
    %604 = llhd.eq %291, %603 : i32
    %605 = llhd.const 1142968403 : i32
    %606 = llhd.eq %346, %605 : i32
    %607 = llhd.or %604, %606 : i1
    cond_br %607, ^case_body71, ^608
^case_body70:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^608:
    %609 = llhd.const 2181042227 : i32
    %610 = llhd.eq %10, %609 : i32
    %611 = llhd.const 2181058611 : i32
    %612 = llhd.eq %10, %611 : i32
    %613 = llhd.or %610, %612 : i1
    %614 = llhd.const 2214596659 : i32
    %615 = llhd.eq %10, %614 : i32
    %616 = llhd.or %613, %615 : i1
    %617 = llhd.const 2214613043 : i32
    %618 = llhd.eq %10, %617 : i32
    %619 = llhd.or %616, %618 : i1
    %620 = llhd.const 2248151091 : i32
    %621 = llhd.eq %10, %620 : i32
    %622 = llhd.or %619, %621 : i1
    %623 = llhd.const 2248167475 : i32
    %624 = llhd.eq %10, %623 : i32
    %625 = llhd.or %622, %624 : i1
    %626 = llhd.const 2281705523 : i32
    %627 = llhd.eq %10, %626 : i32
    %628 = llhd.or %625, %627 : i1
    %629 = llhd.const 2281721907 : i32
    %630 = llhd.eq %10, %629 : i32
    %631 = llhd.or %628, %630 : i1
    %632 = llhd.const 2315259955 : i32
    %633 = llhd.eq %10, %632 : i32
    %634 = llhd.or %631, %633 : i1
    %635 = llhd.const 2315276339 : i32
    %636 = llhd.eq %10, %635 : i32
    %637 = llhd.or %634, %636 : i1
    %638 = llhd.const 2348814387 : i32
    %639 = llhd.eq %10, %638 : i32
    %640 = llhd.or %637, %639 : i1
    %641 = llhd.const 2348830771 : i32
    %642 = llhd.eq %10, %641 : i32
    %643 = llhd.or %640, %642 : i1
    %644 = llhd.const 2382368819 : i32
    %645 = llhd.eq %346, %644 : i32
    %646 = llhd.or %643, %645 : i1
    %647 = llhd.const 2415923251 : i32
    %648 = llhd.eq %10, %647 : i32
    %649 = llhd.or %646, %648 : i1
    %650 = llhd.const 2415939635 : i32
    %651 = llhd.eq %10, %650 : i32
    %652 = llhd.or %649, %651 : i1
    %653 = llhd.const 2449477683 : i32
    %654 = llhd.eq %10, %653 : i32
    %655 = llhd.or %652, %654 : i1
    %656 = llhd.const 2449494067 : i32
    %657 = llhd.eq %10, %656 : i32
    %658 = llhd.or %655, %657 : i1
    %659 = llhd.const 2583695411 : i32
    %660 = llhd.eq %10, %659 : i32
    %661 = llhd.or %658, %660 : i1
    %662 = llhd.const 2583711795 : i32
    %663 = llhd.eq %10, %662 : i32
    %664 = llhd.or %661, %663 : i1
    %665 = llhd.const 2617249843 : i32
    %666 = llhd.eq %10, %665 : i32
    %667 = llhd.or %664, %666 : i1
    %668 = llhd.const 2617266227 : i32
    %669 = llhd.eq %10, %668 : i32
    %670 = llhd.or %667, %669 : i1
    %671 = llhd.const 2650804275 : i32
    %672 = llhd.eq %10, %671 : i32
    %673 = llhd.or %670, %672 : i1
    %674 = llhd.const 2650820659 : i32
    %675 = llhd.eq %10, %674 : i32
    %676 = llhd.or %673, %675 : i1
    %677 = llhd.const 2952794163 : i32
    %678 = llhd.eq %10, %677 : i32
    %679 = llhd.or %676, %678 : i1
    cond_br %679, ^case_body72, ^680
^case_body71:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^680:
    %681 = llhd.const 2555379763 : i32
    %682 = llhd.eq %346, %681 : i32
    %683 = llhd.const 2555396147 : i32
    %684 = llhd.eq %346, %683 : i32
    %685 = llhd.or %682, %684 : i1
    %686 = llhd.const 2554335283 : i32
    %687 = llhd.eq %346, %686 : i32
    %688 = llhd.or %685, %687 : i1
    %689 = llhd.const 2554351667 : i32
    %690 = llhd.eq %346, %689 : i32
    %691 = llhd.or %688, %690 : i1
    %692 = llhd.const 2952810547 : i32
    %693 = llhd.eq %10, %692 : i32
    %694 = llhd.or %691, %693 : i1
    %695 = llhd.const 3019903027 : i32
    %696 = llhd.eq %10, %695 : i32
    %697 = llhd.or %694, %696 : i1
    %698 = llhd.const 3019919411 : i32
    %699 = llhd.eq %10, %698 : i32
    %700 = llhd.or %697, %699 : i1
    cond_br %700, ^case_body73, ^701
^case_body72:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^701:
    %702 = llhd.const 2555387955 : i32
    %703 = llhd.eq %346, %702 : i32
    %704 = llhd.const 2555404339 : i32
    %705 = llhd.eq %346, %704 : i32
    %706 = llhd.or %703, %705 : i1
    %707 = llhd.const 2556432435 : i32
    %708 = llhd.eq %346, %707 : i32
    %709 = llhd.or %706, %708 : i1
    %710 = llhd.const 2556448819 : i32
    %711 = llhd.eq %346, %710 : i32
    %712 = llhd.or %709, %711 : i1
    cond_br %712, ^case_body74, ^713
^case_body73:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^713:
    %714 = llhd.const 100663379 : i32
    %715 = llhd.eq %263, %714 : i32
    %716 = llhd.const 234881107 : i32
    %717 = llhd.eq %263, %716 : i32
    %718 = llhd.or %715, %717 : i1
    %719 = llhd.const 369098835 : i32
    %720 = llhd.eq %263, %719 : i32
    %721 = llhd.or %718, %720 : i1
    %722 = llhd.const 503316563 : i32
    %723 = llhd.eq %263, %722 : i32
    %724 = llhd.or %721, %723 : i1
    %725 = llhd.const 637534291 : i32
    %726 = llhd.eq %10, %725 : i32
    %727 = llhd.or %724, %726 : i1
    %728 = llhd.const 637538387 : i32
    %729 = llhd.eq %10, %728 : i32
    %730 = llhd.or %727, %729 : i1
    %731 = llhd.const 637542483 : i32
    %732 = llhd.eq %10, %731 : i32
    %733 = llhd.or %730, %732 : i1
    %734 = llhd.const 771752019 : i32
    %735 = llhd.eq %10, %734 : i32
    %736 = llhd.or %733, %735 : i1
    %737 = llhd.const 771756115 : i32
    %738 = llhd.eq %10, %737 : i32
    %739 = llhd.or %736, %738 : i1
    %740 = llhd.const 1577058387 : i32
    %741 = llhd.eq %291, %740 : i32
    %742 = llhd.or %739, %741 : i1
    %743 = llhd.const 100663363 : i32
    %744 = llhd.eq %296, %743 : i32
    %745 = llhd.or %742, %744 : i1
    %746 = llhd.const 100663367 : i32
    %747 = llhd.eq %296, %746 : i32
    %748 = llhd.or %745, %747 : i1
    %749 = llhd.const 100663371 : i32
    %750 = llhd.eq %296, %749 : i32
    %751 = llhd.or %748, %750 : i1
    %752 = llhd.const 100663375 : i32
    %753 = llhd.eq %296, %752 : i32
    %754 = llhd.or %751, %753 : i1
    cond_br %754, ^case_body75, ^755
^case_body74:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^755:
    %756 = llhd.const 1076887635 : i32
    %757 = llhd.eq %346, %756 : i32
    %758 = llhd.const 1174405203 : i32
    %759 = llhd.eq %291, %758 : i32
    %760 = llhd.or %757, %759 : i1
    cond_br %760, ^case_body76, ^761
^case_body75:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^761:
    %762 = llhd.const 1110442067 : i32
    %763 = llhd.eq %346, %762 : i32
    %764 = llhd.const 1175453779 : i32
    %765 = llhd.eq %291, %764 : i32
    %766 = llhd.or %763, %765 : i1
    cond_br %766, ^case_body77, ^767
^case_body76:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^767:
    %768 = llhd.const 1143996499 : i32
    %769 = llhd.eq %346, %768 : i32
    %770 = llhd.const 1176502355 : i32
    %771 = llhd.eq %291, %770 : i32
    %772 = llhd.or %769, %771 : i1
    cond_br %772, ^case_body78, ^773
^case_body77:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^773:
    %774 = llhd.const 1144016979 : i32
    %775 = llhd.eq %346, %774 : i32
    %776 = llhd.const 1180696659 : i32
    %777 = llhd.eq %291, %776 : i32
    %778 = llhd.or %775, %777 : i1
    cond_br %778, ^case_body79, ^779
^case_body78:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^779:
    %780 = llhd.const 2181050419 : i32
    %781 = llhd.eq %10, %780 : i32
    %782 = llhd.const 2181066803 : i32
    %783 = llhd.eq %10, %782 : i32
    %784 = llhd.or %781, %783 : i1
    %785 = llhd.const 2214604851 : i32
    %786 = llhd.eq %10, %785 : i32
    %787 = llhd.or %784, %786 : i1
    %788 = llhd.const 2214621235 : i32
    %789 = llhd.eq %10, %788 : i32
    %790 = llhd.or %787, %789 : i1
    %791 = llhd.const 2248159283 : i32
    %792 = llhd.eq %10, %791 : i32
    %793 = llhd.or %790, %792 : i1
    %794 = llhd.const 2248175667 : i32
    %795 = llhd.eq %10, %794 : i32
    %796 = llhd.or %793, %795 : i1
    %797 = llhd.const 2281713715 : i32
    %798 = llhd.eq %10, %797 : i32
    %799 = llhd.or %796, %798 : i1
    %800 = llhd.const 2281730099 : i32
    %801 = llhd.eq %10, %800 : i32
    %802 = llhd.or %799, %801 : i1
    %803 = llhd.const 2315268147 : i32
    %804 = llhd.eq %10, %803 : i32
    %805 = llhd.or %802, %804 : i1
    %806 = llhd.const 2315284531 : i32
    %807 = llhd.eq %10, %806 : i32
    %808 = llhd.or %805, %807 : i1
    %809 = llhd.const 2348822579 : i32
    %810 = llhd.eq %10, %809 : i32
    %811 = llhd.or %808, %810 : i1
    %812 = llhd.const 2348838963 : i32
    %813 = llhd.eq %10, %812 : i32
    %814 = llhd.or %811, %813 : i1
    %815 = llhd.const 2382377011 : i32
    %816 = llhd.eq %346, %815 : i32
    %817 = llhd.or %814, %816 : i1
    %818 = llhd.const 2415931443 : i32
    %819 = llhd.eq %10, %818 : i32
    %820 = llhd.or %817, %819 : i1
    %821 = llhd.const 2415947827 : i32
    %822 = llhd.eq %10, %821 : i32
    %823 = llhd.or %820, %822 : i1
    %824 = llhd.const 2449485875 : i32
    %825 = llhd.eq %10, %824 : i32
    %826 = llhd.or %823, %825 : i1
    %827 = llhd.const 2449502259 : i32
    %828 = llhd.eq %10, %827 : i32
    %829 = llhd.or %826, %828 : i1
    %830 = llhd.const 2583703603 : i32
    %831 = llhd.eq %10, %830 : i32
    %832 = llhd.or %829, %831 : i1
    %833 = llhd.const 2583719987 : i32
    %834 = llhd.eq %10, %833 : i32
    %835 = llhd.or %832, %834 : i1
    %836 = llhd.const 2617258035 : i32
    %837 = llhd.eq %10, %836 : i32
    %838 = llhd.or %835, %837 : i1
    %839 = llhd.const 2617274419 : i32
    %840 = llhd.eq %10, %839 : i32
    %841 = llhd.or %838, %840 : i1
    %842 = llhd.const 2650812467 : i32
    %843 = llhd.eq %10, %842 : i32
    %844 = llhd.or %841, %843 : i1
    %845 = llhd.const 2650828851 : i32
    %846 = llhd.eq %10, %845 : i32
    %847 = llhd.or %844, %846 : i1
    cond_br %847, ^case_body80, ^848
^case_body79:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^848:
    %849 = llhd.const 2952802355 : i32
    %850 = llhd.eq %10, %849 : i32
    %851 = llhd.const 2952818739 : i32
    %852 = llhd.eq %10, %851 : i32
    %853 = llhd.or %850, %852 : i1
    cond_br %853, ^case_body81, ^854
^case_body80:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^854:
    %855 = llhd.const 2557476915 : i32
    %856 = llhd.eq %346, %855 : i32
    %857 = llhd.const 2557493299 : i32
    %858 = llhd.eq %346, %857 : i32
    %859 = llhd.or %856, %858 : i1
    %860 = llhd.const 2554343475 : i32
    %861 = llhd.eq %346, %860 : i32
    %862 = llhd.or %859, %861 : i1
    %863 = llhd.const 2554359859 : i32
    %864 = llhd.eq %346, %863 : i32
    %865 = llhd.or %862, %864 : i1
    cond_br %865, ^case_body82, ^866
^case_body81:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^866:
    %867 = llhd.const 2986356787 : i32
    %868 = llhd.eq %10, %867 : i32
    %869 = llhd.const 2986373171 : i32
    %870 = llhd.eq %10, %869 : i32
    %871 = llhd.or %868, %870 : i1
    %872 = llhd.const 3019911219 : i32
    %873 = llhd.eq %10, %872 : i32
    %874 = llhd.or %871, %873 : i1
    %875 = llhd.const 3019927603 : i32
    %876 = llhd.eq %10, %875 : i32
    %877 = llhd.or %874, %876 : i1
    %878 = llhd.const 3053465651 : i32
    %879 = llhd.eq %10, %878 : i32
    %880 = llhd.or %877, %879 : i1
    %881 = llhd.const 3053482035 : i32
    %882 = llhd.eq %10, %881 : i32
    %883 = llhd.or %880, %882 : i1
    cond_br %883, ^case_body83, ^884
^case_body82:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^884:
    %885 = llhd.const 2557485107 : i32
    %886 = llhd.eq %346, %885 : i32
    %887 = llhd.const 2557501491 : i32
    %888 = llhd.eq %346, %887 : i32
    %889 = llhd.or %886, %888 : i1
    %890 = llhd.const 2556440627 : i32
    %891 = llhd.eq %346, %890 : i32
    %892 = llhd.or %889, %891 : i1
    %893 = llhd.const 2556457011 : i32
    %894 = llhd.eq %346, %893 : i32
    %895 = llhd.or %892, %894 : i1
    cond_br %895, ^case_body84, ^896
^case_body83:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^896:
    %897 = llhd.const 2557481011 : i32
    %898 = llhd.eq %346, %897 : i32
    %899 = llhd.const 2557497395 : i32
    %900 = llhd.eq %346, %899 : i32
    %901 = llhd.or %898, %900 : i1
    %902 = llhd.const 2555392051 : i32
    %903 = llhd.eq %346, %902 : i32
    %904 = llhd.or %901, %903 : i1
    %905 = llhd.const 2555408435 : i32
    %906 = llhd.eq %346, %905 : i32
    %907 = llhd.or %904, %906 : i1
    cond_br %907, ^case_body85, ^908
^case_body84:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^908:
    %909 = llhd.const 2684354643 : i32
    %910 = llhd.eq %10, %909 : i32
    %911 = llhd.const 2684358739 : i32
    %912 = llhd.eq %10, %911 : i32
    %913 = llhd.or %910, %912 : i1
    %914 = llhd.const 2684362835 : i32
    %915 = llhd.eq %10, %914 : i32
    %916 = llhd.or %913, %915 : i1
    %917 = llhd.const 3758100563 : i32
    %918 = llhd.eq %346, %917 : i32
    %919 = llhd.or %916, %918 : i1
    %920 = llhd.const 3221225555 : i32
    %921 = llhd.eq %291, %920 : i32
    %922 = llhd.or %919, %921 : i1
    %923 = llhd.const 3222274131 : i32
    %924 = llhd.eq %291, %923 : i32
    %925 = llhd.or %922, %924 : i1
    %926 = llhd.const 3758096467 : i32
    %927 = llhd.eq %346, %926 : i32
    %928 = llhd.or %925, %927 : i1
    cond_br %928, ^case_body86, ^929
^case_body85:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^929:
    %930 = llhd.const 2684354611 : i32
    %931 = llhd.eq %10, %930 : i32
    %932 = llhd.const 2684370995 : i32
    %933 = llhd.eq %10, %932 : i32
    %934 = llhd.or %931, %933 : i1
    %935 = llhd.const 2717909043 : i32
    %936 = llhd.eq %10, %935 : i32
    %937 = llhd.or %934, %936 : i1
    %938 = llhd.const 2717925427 : i32
    %939 = llhd.eq %10, %938 : i32
    %940 = llhd.or %937, %939 : i1
    %941 = llhd.const 2751463475 : i32
    %942 = llhd.eq %10, %941 : i32
    %943 = llhd.or %940, %942 : i1
    %944 = llhd.const 2751479859 : i32
    %945 = llhd.eq %10, %944 : i32
    %946 = llhd.or %943, %945 : i1
    %947 = llhd.const 2785017907 : i32
    %948 = llhd.eq %10, %947 : i32
    %949 = llhd.or %946, %948 : i1
    %950 = llhd.const 2785034291 : i32
    %951 = llhd.eq %10, %950 : i32
    %952 = llhd.or %949, %951 : i1
    %953 = llhd.const 2818572339 : i32
    %954 = llhd.eq %10, %953 : i32
    %955 = llhd.or %952, %954 : i1
    %956 = llhd.const 2818588723 : i32
    %957 = llhd.eq %10, %956 : i32
    %958 = llhd.or %955, %957 : i1
    %959 = llhd.const 2852126771 : i32
    %960 = llhd.eq %10, %959 : i32
    %961 = llhd.or %958, %960 : i1
    %962 = llhd.const 2852143155 : i32
    %963 = llhd.eq %10, %962 : i32
    %964 = llhd.or %961, %963 : i1
    %965 = llhd.const 2551185459 : i32
    %966 = llhd.eq %346, %965 : i32
    %967 = llhd.or %964, %966 : i1
    cond_br %967, ^case_body87, ^968
^case_body86:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    llhd.drv %acc_register_rd, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^968:
    %969 = llhd.const 2717909075 : i32
    %970 = llhd.eq %10, %969 : i32
    %971 = llhd.const 2717913171 : i32
    %972 = llhd.eq %10, %971 : i32
    %973 = llhd.or %970, %972 : i1
    %974 = llhd.const 2717917267 : i32
    %975 = llhd.eq %10, %974 : i32
    %976 = llhd.or %973, %975 : i1
    %977 = llhd.const 3791654995 : i32
    %978 = llhd.eq %346, %977 : i32
    %979 = llhd.or %976, %978 : i1
    %980 = llhd.const 3254779987 : i32
    %981 = llhd.eq %291, %980 : i32
    %982 = llhd.or %979, %981 : i1
    %983 = llhd.const 3255828563 : i32
    %984 = llhd.eq %291, %983 : i32
    %985 = llhd.or %982, %984 : i1
    cond_br %985, ^case_body88, ^986
^case_body87:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^986:
    %987 = llhd.const 2751463507 : i32
    %988 = llhd.eq %10, %987 : i32
    %989 = llhd.const 2751467603 : i32
    %990 = llhd.eq %10, %989 : i32
    %991 = llhd.or %988, %990 : i1
    %992 = llhd.const 2751471699 : i32
    %993 = llhd.eq %10, %992 : i32
    %994 = llhd.or %991, %993 : i1
    %995 = llhd.const 3825209427 : i32
    %996 = llhd.eq %346, %995 : i32
    %997 = llhd.or %994, %996 : i1
    %998 = llhd.const 3288334419 : i32
    %999 = llhd.eq %291, %998 : i32
    %1000 = llhd.or %997, %999 : i1
    %1001 = llhd.const 3289382995 : i32
    %1002 = llhd.eq %291, %1001 : i32
    %1003 = llhd.or %1000, %1002 : i1
    %1004 = llhd.const 3825205331 : i32
    %1005 = llhd.eq %346, %1004 : i32
    %1006 = llhd.or %1003, %1005 : i1
    cond_br %1006, ^case_body89, ^1007
^case_body88:
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %uses_rd, %4 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    llhd.drv %acc_register_rd, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1007:
    %1008 = llhd.const 2684362803 : i32
    %1009 = llhd.eq %10, %1008 : i32
    %1010 = llhd.const 2684379187 : i32
    %1011 = llhd.eq %10, %1010 : i32
    %1012 = llhd.or %1009, %1011 : i1
    %1013 = llhd.const 2717917235 : i32
    %1014 = llhd.eq %10, %1013 : i32
    %1015 = llhd.or %1012, %1014 : i1
    %1016 = llhd.const 2717933619 : i32
    %1017 = llhd.eq %10, %1016 : i32
    %1018 = llhd.or %1015, %1017 : i1
    %1019 = llhd.const 2751471667 : i32
    %1020 = llhd.eq %10, %1019 : i32
    %1021 = llhd.or %1018, %1020 : i1
    %1022 = llhd.const 2751488051 : i32
    %1023 = llhd.eq %10, %1022 : i32
    %1024 = llhd.or %1021, %1023 : i1
    %1025 = llhd.const 2785026099 : i32
    %1026 = llhd.eq %10, %1025 : i32
    %1027 = llhd.or %1024, %1026 : i1
    %1028 = llhd.const 2785042483 : i32
    %1029 = llhd.eq %10, %1028 : i32
    %1030 = llhd.or %1027, %1029 : i1
    %1031 = llhd.const 2818580531 : i32
    %1032 = llhd.eq %10, %1031 : i32
    %1033 = llhd.or %1030, %1032 : i1
    %1034 = llhd.const 2818596915 : i32
    %1035 = llhd.eq %10, %1034 : i32
    %1036 = llhd.or %1033, %1035 : i1
    %1037 = llhd.const 2852134963 : i32
    %1038 = llhd.eq %10, %1037 : i32
    %1039 = llhd.or %1036, %1038 : i1
    %1040 = llhd.const 2852151347 : i32
    %1041 = llhd.eq %10, %1040 : i32
    %1042 = llhd.or %1039, %1041 : i1
    %1043 = llhd.const 2551193651 : i32
    %1044 = llhd.eq %346, %1043 : i32
    %1045 = llhd.or %1042, %1044 : i1
    cond_br %1045, ^case_body90, ^1046
^case_body89:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1046:
    %1047 = llhd.const 2550145075 : i32
    %1048 = llhd.eq %346, %1047 : i32
    %1049 = llhd.const 2552242227 : i32
    %1050 = llhd.eq %346, %1049 : i32
    %1051 = llhd.or %1048, %1050 : i1
    %1052 = llhd.const 2552258611 : i32
    %1053 = llhd.eq %346, %1052 : i32
    %1054 = llhd.or %1051, %1053 : i1
    cond_br %1054, ^case_body91, ^1055
^case_body90:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1055:
    %1056 = llhd.const 2751479891 : i32
    %1057 = llhd.eq %10, %1056 : i32
    %1058 = llhd.const 2751483987 : i32
    %1059 = llhd.eq %10, %1058 : i32
    %1060 = llhd.or %1057, %1059 : i1
    %1061 = llhd.const 2751488083 : i32
    %1062 = llhd.eq %10, %1061 : i32
    %1063 = llhd.or %1060, %1062 : i1
    %1064 = llhd.const 3825225811 : i32
    %1065 = llhd.eq %346, %1064 : i32
    %1066 = llhd.or %1063, %1065 : i1
    %1067 = llhd.const 3825221715 : i32
    %1068 = llhd.eq %346, %1067 : i32
    %1069 = llhd.or %1066, %1068 : i1
    cond_br %1069, ^case_body92, ^1070
^case_body91:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1070:
    %1071 = llhd.const 2684358707 : i32
    %1072 = llhd.eq %10, %1071 : i32
    %1073 = llhd.const 2684375091 : i32
    %1074 = llhd.eq %10, %1073 : i32
    %1075 = llhd.or %1072, %1074 : i1
    %1076 = llhd.const 2717913139 : i32
    %1077 = llhd.eq %10, %1076 : i32
    %1078 = llhd.or %1075, %1077 : i1
    %1079 = llhd.const 2717929523 : i32
    %1080 = llhd.eq %10, %1079 : i32
    %1081 = llhd.or %1078, %1080 : i1
    %1082 = llhd.const 2751467571 : i32
    %1083 = llhd.eq %10, %1082 : i32
    %1084 = llhd.or %1081, %1083 : i1
    %1085 = llhd.const 2751483955 : i32
    %1086 = llhd.eq %10, %1085 : i32
    %1087 = llhd.or %1084, %1086 : i1
    %1088 = llhd.const 2785022003 : i32
    %1089 = llhd.eq %10, %1088 : i32
    %1090 = llhd.or %1087, %1089 : i1
    %1091 = llhd.const 2785038387 : i32
    %1092 = llhd.eq %10, %1091 : i32
    %1093 = llhd.or %1090, %1092 : i1
    %1094 = llhd.const 2818576435 : i32
    %1095 = llhd.eq %10, %1094 : i32
    %1096 = llhd.or %1093, %1095 : i1
    %1097 = llhd.const 2818592819 : i32
    %1098 = llhd.eq %10, %1097 : i32
    %1099 = llhd.or %1096, %1098 : i1
    %1100 = llhd.const 2852130867 : i32
    %1101 = llhd.eq %10, %1100 : i32
    %1102 = llhd.or %1099, %1101 : i1
    %1103 = llhd.const 2852147251 : i32
    %1104 = llhd.eq %10, %1103 : i32
    %1105 = llhd.or %1102, %1104 : i1
    %1106 = llhd.const 2551189555 : i32
    %1107 = llhd.eq %346, %1106 : i32
    %1108 = llhd.or %1105, %1107 : i1
    cond_br %1108, ^case_body93, ^1109
^case_body92:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1109:
    %1110 = llhd.const 2550140979 : i32
    %1111 = llhd.eq %346, %1110 : i32
    %1112 = llhd.const 2552238131 : i32
    %1113 = llhd.eq %346, %1112 : i32
    %1114 = llhd.or %1111, %1113 : i1
    %1115 = llhd.const 2552254515 : i32
    %1116 = llhd.eq %346, %1115 : i32
    %1117 = llhd.or %1114, %1116 : i1
    cond_br %1117, ^case_body94, ^1118
^case_body93:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1118:
    %1119 = llhd.const 2785017939 : i32
    %1120 = llhd.eq %10, %1119 : i32
    %1121 = llhd.const 2785022035 : i32
    %1122 = llhd.eq %10, %1121 : i32
    %1123 = llhd.or %1120, %1122 : i1
    %1124 = llhd.const 2785026131 : i32
    %1125 = llhd.eq %10, %1124 : i32
    %1126 = llhd.or %1123, %1125 : i1
    %1127 = llhd.const 3858763859 : i32
    %1128 = llhd.eq %346, %1127 : i32
    %1129 = llhd.or %1126, %1128 : i1
    %1130 = llhd.const 3321888851 : i32
    %1131 = llhd.eq %291, %1130 : i32
    %1132 = llhd.or %1129, %1131 : i1
    %1133 = llhd.const 3322937427 : i32
    %1134 = llhd.eq %291, %1133 : i32
    %1135 = llhd.or %1132, %1134 : i1
    %1136 = llhd.const 3858759763 : i32
    %1137 = llhd.eq %346, %1136 : i32
    %1138 = llhd.or %1135, %1137 : i1
    cond_br %1138, ^case_body95, ^1139
^case_body94:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1139:
    %1140 = llhd.const 2684366899 : i32
    %1141 = llhd.eq %10, %1140 : i32
    %1142 = llhd.const 2684383283 : i32
    %1143 = llhd.eq %10, %1142 : i32
    %1144 = llhd.or %1141, %1143 : i1
    %1145 = llhd.const 2717921331 : i32
    %1146 = llhd.eq %10, %1145 : i32
    %1147 = llhd.or %1144, %1146 : i1
    %1148 = llhd.const 2717937715 : i32
    %1149 = llhd.eq %10, %1148 : i32
    %1150 = llhd.or %1147, %1149 : i1
    %1151 = llhd.const 2751475763 : i32
    %1152 = llhd.eq %10, %1151 : i32
    %1153 = llhd.or %1150, %1152 : i1
    %1154 = llhd.const 2751492147 : i32
    %1155 = llhd.eq %10, %1154 : i32
    %1156 = llhd.or %1153, %1155 : i1
    %1157 = llhd.const 2785030195 : i32
    %1158 = llhd.eq %10, %1157 : i32
    %1159 = llhd.or %1156, %1158 : i1
    %1160 = llhd.const 2785046579 : i32
    %1161 = llhd.eq %10, %1160 : i32
    %1162 = llhd.or %1159, %1161 : i1
    %1163 = llhd.const 2818584627 : i32
    %1164 = llhd.eq %10, %1163 : i32
    %1165 = llhd.or %1162, %1164 : i1
    %1166 = llhd.const 2818601011 : i32
    %1167 = llhd.eq %10, %1166 : i32
    %1168 = llhd.or %1165, %1167 : i1
    %1169 = llhd.const 2852139059 : i32
    %1170 = llhd.eq %10, %1169 : i32
    %1171 = llhd.or %1168, %1170 : i1
    %1172 = llhd.const 2852155443 : i32
    %1173 = llhd.eq %10, %1172 : i32
    %1174 = llhd.or %1171, %1173 : i1
    cond_br %1174, ^case_body96, ^1175
^case_body95:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1175:
    %1176 = llhd.const 2550149171 : i32
    %1177 = llhd.eq %346, %1176 : i32
    %1178 = llhd.const 2551197747 : i32
    %1179 = llhd.eq %346, %1178 : i32
    %1180 = llhd.or %1177, %1179 : i1
    %1181 = llhd.const 2552246323 : i32
    %1182 = llhd.eq %346, %1181 : i32
    %1183 = llhd.or %1180, %1182 : i1
    %1184 = llhd.const 2552262707 : i32
    %1185 = llhd.eq %346, %1184 : i32
    %1186 = llhd.or %1183, %1185 : i1
    cond_br %1186, ^case_body97, ^1187
^case_body96:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1187:
    %1188 = llhd.const 4026531923 : i32
    %1189 = llhd.eq %346, %1188 : i32
    %1190 = llhd.const 3489661011 : i32
    %1191 = llhd.eq %291, %1190 : i32
    %1192 = llhd.or %1189, %1191 : i1
    %1193 = llhd.const 3490709587 : i32
    %1194 = llhd.eq %291, %1193 : i32
    %1195 = llhd.or %1192, %1194 : i1
    cond_br %1195, ^case_body98, ^1196
^case_body97:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1196:
    %1197 = llhd.const 3523215443 : i32
    %1198 = llhd.eq %291, %1197 : i32
    %1199 = llhd.const 3524264019 : i32
    %1200 = llhd.eq %291, %1199 : i32
    %1201 = llhd.or %1198, %1200 : i1
    cond_br %1201, ^case_body99, ^1202
^case_body98:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1202:
    %1203 = llhd.const 4093640787 : i32
    %1204 = llhd.eq %346, %1203 : i32
    %1205 = llhd.const 3556769875 : i32
    %1206 = llhd.eq %291, %1205 : i32
    %1207 = llhd.or %1204, %1206 : i1
    %1208 = llhd.const 3557818451 : i32
    %1209 = llhd.eq %291, %1208 : i32
    %1210 = llhd.or %1207, %1209 : i1
    cond_br %1210, ^case_body100, ^1211
^case_body99:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1211:
    %1212 = llhd.const 2550161459 : i32
    %1213 = llhd.eq %346, %1212 : i32
    %1214 = llhd.const 2553290803 : i32
    %1215 = llhd.eq %346, %1214 : i32
    %1216 = llhd.or %1213, %1215 : i1
    %1217 = llhd.const 2553307187 : i32
    %1218 = llhd.eq %346, %1217 : i32
    %1219 = llhd.or %1216, %1218 : i1
    cond_br %1219, ^case_body101, ^1220
^case_body100:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1220:
    %1221 = llhd.const 4093657171 : i32
    %1222 = llhd.eq %346, %1221 : i32
    cond_br %1222, ^case_body102, ^1223
^case_body101:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1223:
    %1224 = llhd.const 2550157363 : i32
    %1225 = llhd.eq %346, %1224 : i32
    %1226 = llhd.const 2553286707 : i32
    %1227 = llhd.eq %346, %1226 : i32
    %1228 = llhd.or %1225, %1227 : i1
    %1229 = llhd.const 2553303091 : i32
    %1230 = llhd.eq %346, %1229 : i32
    %1231 = llhd.or %1228, %1230 : i1
    cond_br %1231, ^case_body103, ^1232
^case_body102:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1232:
    %1233 = llhd.const 4127195219 : i32
    %1234 = llhd.eq %346, %1233 : i32
    %1235 = llhd.const 3590324307 : i32
    %1236 = llhd.eq %291, %1235 : i32
    %1237 = llhd.or %1234, %1236 : i1
    %1238 = llhd.const 3591372883 : i32
    %1239 = llhd.eq %291, %1238 : i32
    %1240 = llhd.or %1237, %1239 : i1
    cond_br %1240, ^case_body104, ^1241
^case_body103:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1241:
    %1242 = llhd.const 2550165555 : i32
    %1243 = llhd.eq %346, %1242 : i32
    %1244 = llhd.const 2553294899 : i32
    %1245 = llhd.eq %346, %1244 : i32
    %1246 = llhd.or %1243, %1245 : i1
    %1247 = llhd.const 2553311283 : i32
    %1248 = llhd.eq %346, %1247 : i32
    %1249 = llhd.or %1246, %1248 : i1
    cond_br %1249, ^case_body105, ^1250
^case_body104:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1250:
    %1251 = llhd.const 11 : i32
    %1252 = llhd.eq %84, %1251 : i32
    cond_br %1252, ^case_body106, ^1253
^case_body105:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1253:
    %1254 = llhd.const 8199 : i32
    %1255 = llhd.eq %17, %1254 : i32
    cond_br %1255, ^case_body107, ^1256
^case_body106:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1256:
    %1257 = llhd.const 8231 : i32
    %1258 = llhd.eq %17, %1257 : i32
    cond_br %1258, ^case_body108, ^1259
^case_body107:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1259:
    %1260 = llhd.const 12295 : i32
    %1261 = llhd.eq %17, %1260 : i32
    cond_br %1261, ^case_body109, ^1262
^case_body108:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %70 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1262:
    %1263 = llhd.const 12327 : i32
    %1264 = llhd.eq %17, %1263 : i32
    cond_br %1264, ^case_body110, ^1265
^case_body109:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %20 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1265:
    %1266 = llhd.const 4103 : i32
    %1267 = llhd.eq %17, %1266 : i32
    cond_br %1267, ^case_body111, ^1268
^case_body110:
    llhd.drv %opa_select, %13 after %1 : !llhd.sig<i4>
    llhd.drv %opb_select, %70 after %1 : !llhd.sig<i4>
    llhd.drv %write_rd, %0 after %1 : !llhd.sig<i1>
    llhd.drv %acc_qvalid_o, %valid_instr.prb after %1 : !llhd.sig<i1>
    br ^case_exit
^1268:
    %1269 = llhd.const 4135 : i32
    %1270 = llhd.eq %17, %1269 : i32
    cond_br %1270, ^case_body112, ^1271
^case_body111:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1271:
    %1272 = llhd.const 7 : i32
    %1273 = llhd.eq %17, %1272 : i32
    cond_br %1273, ^case_body113, ^1274
^case_body112:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1274:
    %1275 = llhd.const 39 : i32
    %1276 = llhd.eq %17, %1275 : i32
    cond_br %1276, ^case_body114, ^1277
^case_body113:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^1277:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
^case_body114:
    llhd.drv %illegal_inst, %4 after %1 : !llhd.sig<i1>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.23058.1(%hart_id_i: !llhd.sig<i32>, %inst_data_i: !llhd.sig<i32>, %fpu_status_i: !llhd.sig<tuple<i1, i1, i1, i1, i1>>, %alu_result: !llhd.sig<i32>, %csr_en: !llhd.sig<i1>, %fcsr_q: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (%csr_rvalue: !llhd.sig<i32> , %fcsr_d: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> ) {
    br ^body
^body:
    %0 = llhd.const 0 : i32
    %1 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %0 after %1 : !llhd.sig<i32>
    %fcsr_q.prb = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    llhd.drv %fcsr_d, %fcsr_q.prb after %1 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %2 = llhd.extract_element %fcsr_d, 1 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> -> !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %3 = llhd.const 0 : i5
    %4 = llhd.extract_element %fcsr_q.prb, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %5 = llhd.extract_element %4, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %6 = llhd.insert_slice %3, %5, 0 : i5, i1
    %7 = llhd.extract_element %4, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %8 = llhd.insert_slice %6, %7, 1 : i5, i1
    %9 = llhd.extract_element %4, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %10 = llhd.insert_slice %8, %9, 2 : i5, i1
    %11 = llhd.extract_element %4, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %12 = llhd.insert_slice %10, %11, 3 : i5, i1
    %13 = llhd.extract_element %4, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %concat = llhd.insert_slice %12, %13, 4 : i5, i1
    %fpu_status_i.prb = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %14 = llhd.extract_element %fpu_status_i.prb, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %15 = llhd.insert_slice %3, %14, 0 : i5, i1
    %16 = llhd.extract_element %fpu_status_i.prb, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %17 = llhd.insert_slice %15, %16, 1 : i5, i1
    %18 = llhd.extract_element %fpu_status_i.prb, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %19 = llhd.insert_slice %17, %18, 2 : i5, i1
    %20 = llhd.extract_element %fpu_status_i.prb, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %21 = llhd.insert_slice %19, %20, 3 : i5, i1
    %22 = llhd.extract_element %fpu_status_i.prb, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %concat1 = llhd.insert_slice %21, %22, 4 : i5, i1
    %23 = llhd.or %concat, %concat1 : i5
    %24 = llhd.extract_slice %23, 0 : i5 -> i1
    %25 = llhd.extract_slice %23, 1 : i5 -> i4
    %26 = llhd.insert_slice %3, %25, 0 : i5, i4
    %27 = llhd.extract_slice %26, 0 : i5 -> i1
    %28 = llhd.extract_slice %23, 2 : i5 -> i3
    %29 = llhd.insert_slice %3, %28, 0 : i5, i3
    %30 = llhd.extract_slice %29, 0 : i5 -> i1
    %31 = llhd.extract_slice %23, 3 : i5 -> i2
    %32 = llhd.insert_slice %3, %31, 0 : i5, i2
    %33 = llhd.extract_slice %32, 0 : i5 -> i1
    %34 = llhd.extract_slice %23, 4 : i5 -> i1
    %35 = llhd.insert_slice %3, %34, 0 : i5, i1
    %36 = llhd.extract_slice %35, 0 : i5 -> i1
    %37 = llhd.tuple %24, %27, %30, %33, %36 : tuple<i1, i1, i1, i1, i1>
    llhd.drv %2, %37 after %1 : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %csr_en.prb = llhd.prb %csr_en : !llhd.sig<i1>
    %38 = llhd.const 0 : i1
    %39 = llhd.neq %csr_en.prb, %38 : i1
    cond_br %39, ^if_true, ^check
^check:
    llhd.wait (%hart_id_i, %inst_data_i, %fpu_status_i, %alu_result, %csr_en, %fcsr_q : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<tuple<i1, i1, i1, i1, i1>>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>), ^body
^if_true:
    %inst_data_i.prb = llhd.prb %inst_data_i : !llhd.sig<i32>
    %40 = llhd.extract_slice %inst_data_i.prb, 20 : i32 -> i12
    %41 = llhd.insert_slice %0, %40, 0 : i32, i12
    %42 = llhd.extract_slice %41, 0 : i32 -> i12
    %43 = llhd.const 3860 : i12
    %44 = llhd.eq %42, %43 : i12
    cond_br %44, ^case_body, ^45
^45:
    %46 = llhd.const 1 : i12
    %47 = llhd.eq %42, %46 : i12
    %alu_result.prb = llhd.prb %alu_result : !llhd.sig<i32>
    cond_br %47, ^case_body1, ^48
^case_body:
    %hart_id_i.prb = llhd.prb %hart_id_i : !llhd.sig<i32>
    llhd.drv %csr_rvalue, %hart_id_i.prb after %1 : !llhd.sig<i32>
    br ^check
^48:
    %49 = llhd.const 2 : i12
    %50 = llhd.eq %42, %49 : i12
    %51 = llhd.extract_element %fcsr_q.prb, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    cond_br %50, ^case_body2, ^52
^case_body1:
    %53 = llhd.insert_slice %0, %concat, 0 : i32, i5
    %54 = llhd.const 0 : i27
    %concat2 = llhd.insert_slice %53, %54, 5 : i32, i27
    llhd.drv %csr_rvalue, %concat2 after %1 : !llhd.sig<i32>
    %55 = llhd.extract_slice %alu_result.prb, 0 : i32 -> i5
    %56 = llhd.extract_slice %55, 0 : i5 -> i1
    %57 = llhd.extract_slice %55, 1 : i5 -> i4
    %58 = llhd.insert_slice %3, %57, 0 : i5, i4
    %59 = llhd.extract_slice %58, 0 : i5 -> i1
    %60 = llhd.extract_slice %55, 2 : i5 -> i3
    %61 = llhd.insert_slice %3, %60, 0 : i5, i3
    %62 = llhd.extract_slice %61, 0 : i5 -> i1
    %63 = llhd.extract_slice %55, 3 : i5 -> i2
    %64 = llhd.insert_slice %3, %63, 0 : i5, i2
    %65 = llhd.extract_slice %64, 0 : i5 -> i1
    %66 = llhd.extract_slice %55, 4 : i5 -> i1
    %67 = llhd.insert_slice %3, %66, 0 : i5, i1
    %68 = llhd.extract_slice %67, 0 : i5 -> i1
    %69 = llhd.tuple %56, %59, %62, %65, %68 : tuple<i1, i1, i1, i1, i1>
    llhd.drv %2, %69 after %1 : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    br ^check
^52:
    %70 = llhd.const 3 : i12
    %71 = llhd.eq %42, %70 : i12
    cond_br %71, ^case_body3, ^72
^case_body2:
    %73 = llhd.insert_slice %0, %51, 0 : i32, i3
    %74 = llhd.const 0 : i29
    %concat3 = llhd.insert_slice %73, %74, 3 : i32, i29
    llhd.drv %csr_rvalue, %concat3 after %1 : !llhd.sig<i32>
    %75 = llhd.extract_element %fcsr_d, 0 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> -> !llhd.sig<i3>
    %76 = llhd.extract_slice %alu_result.prb, 0 : i32 -> i3
    llhd.drv %75, %76 after %1 : !llhd.sig<i3>
    br ^check
^72:
    llhd.drv %csr_rvalue, %0 after %1 : !llhd.sig<i32>
    br ^check
^case_body3:
    %77 = llhd.const 0 : i8
    %78 = llhd.insert_slice %77, %concat, 0 : i8, i5
    %concat4 = llhd.insert_slice %78, %51, 5 : i8, i3
    %79 = llhd.insert_slice %0, %concat4, 0 : i32, i8
    %80 = llhd.const 0 : i24
    %concat5 = llhd.insert_slice %79, %80, 8 : i32, i24
    llhd.drv %csr_rvalue, %concat5 after %1 : !llhd.sig<i32>
    %81 = llhd.extract_slice %alu_result.prb, 0 : i32 -> i8
    %82 = llhd.extract_slice %81, 0 : i8 -> i3
    %83 = llhd.extract_slice %81, 3 : i8 -> i5
    %84 = llhd.insert_slice %77, %83, 0 : i8, i5
    %85 = llhd.extract_slice %84, 0 : i8 -> i5
    %86 = llhd.extract_slice %85, 0 : i5 -> i1
    %87 = llhd.extract_slice %85, 1 : i5 -> i4
    %88 = llhd.insert_slice %3, %87, 0 : i5, i4
    %89 = llhd.extract_slice %88, 0 : i5 -> i1
    %90 = llhd.extract_slice %85, 2 : i5 -> i3
    %91 = llhd.insert_slice %3, %90, 0 : i5, i3
    %92 = llhd.extract_slice %91, 0 : i5 -> i1
    %93 = llhd.extract_slice %85, 3 : i5 -> i2
    %94 = llhd.insert_slice %3, %93, 0 : i5, i2
    %95 = llhd.extract_slice %94, 0 : i5 -> i1
    %96 = llhd.extract_slice %85, 4 : i5 -> i1
    %97 = llhd.insert_slice %3, %96, 0 : i5, i1
    %98 = llhd.extract_slice %97, 0 : i5 -> i1
    %99 = llhd.tuple %86, %89, %92, %95, %98 : tuple<i1, i1, i1, i1, i1>
    %100 = llhd.tuple %82, %99 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    llhd.drv %fcsr_d, %100 after %1 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    br ^check
}

llhd.proc @snitch.param1.always_comb.23203.1(%uimm: !llhd.sig<i32>, %jimm: !llhd.sig<i32>, %rs1: !llhd.sig<i5>, %gpr_rdata: !llhd.sig<!llhd.array<2xi32>>, %opa_select: !llhd.sig<i4>) -> (%opa: !llhd.sig<i32> ) {
    br ^body
^body:
    %opa_select.prb = llhd.prb %opa_select : !llhd.sig<i4>
    %0 = llhd.const 0 : i4
    %1 = llhd.eq %opa_select.prb, %0 : i4
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %3 = llhd.const 0 : i32
    cond_br %1, ^case_body, ^4
^4:
    %5 = llhd.const 1 : i4
    %6 = llhd.eq %opa_select.prb, %5 : i4
    cond_br %6, ^case_body1, ^7
^case_body:
    llhd.drv %opa, %3 after %2 : !llhd.sig<i32>
    br ^check
^check:
    llhd.wait (%uimm, %jimm, %rs1, %gpr_rdata, %opa_select : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i5>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>), ^body
^7:
    %8 = llhd.const 3 : i4
    %9 = llhd.eq %opa_select.prb, %8 : i4
    cond_br %9, ^case_body2, ^10
^case_body1:
    %gpr_rdata.prb = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %11 = llhd.extract_element %gpr_rdata.prb, 0 : !llhd.array<2xi32> -> i32
    llhd.drv %opa, %11 after %2 : !llhd.sig<i32>
    br ^check
^10:
    %12 = llhd.const 4 : i4
    %13 = llhd.eq %opa_select.prb, %12 : i4
    cond_br %13, ^case_body3, ^14
^case_body2:
    %uimm.prb = llhd.prb %uimm : !llhd.sig<i32>
    llhd.drv %opa, %uimm.prb after %2 : !llhd.sig<i32>
    br ^check
^14:
    %15 = llhd.const 9 : i4
    %16 = llhd.eq %opa_select.prb, %15 : i4
    cond_br %16, ^case_body4, ^17
^case_body3:
    %jimm.prb = llhd.prb %jimm : !llhd.sig<i32>
    llhd.drv %opa, %jimm.prb after %2 : !llhd.sig<i32>
    br ^check
^17:
    llhd.drv %opa, %3 after %2 : !llhd.sig<i32>
    br ^check
^case_body4:
    %rs1.prb = llhd.prb %rs1 : !llhd.sig<i5>
    %18 = llhd.insert_slice %3, %rs1.prb, 0 : i32, i5
    %19 = llhd.const 0 : i27
    %concat = llhd.insert_slice %18, %19, 5 : i32, i27
    llhd.drv %opa, %concat after %2 : !llhd.sig<i32>
    br ^check
}

llhd.proc @snitch.param1.always_comb.23314.1(%pc_q: !llhd.sig<i32>, %iimm: !llhd.sig<i32>, %simm: !llhd.sig<i32>, %gpr_rdata: !llhd.sig<!llhd.array<2xi32>>, %opb_select: !llhd.sig<i4>, %csr_rvalue: !llhd.sig<i32>) -> (%opb: !llhd.sig<i32> ) {
    br ^body
^body:
    %opb_select.prb = llhd.prb %opb_select : !llhd.sig<i4>
    %0 = llhd.const 0 : i4
    %1 = llhd.eq %opb_select.prb, %0 : i4
    %2 = llhd.const 0 : i32
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    cond_br %1, ^case_body, ^4
^4:
    %5 = llhd.const 1 : i4
    %6 = llhd.eq %opb_select.prb, %5 : i4
    cond_br %6, ^case_body1, ^7
^case_body:
    llhd.drv %opb, %2 after %3 : !llhd.sig<i32>
    br ^check
^check:
    llhd.wait (%pc_q, %iimm, %simm, %gpr_rdata, %opb_select, %csr_rvalue : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>, !llhd.sig<i32>), ^body
^7:
    %8 = llhd.const 2 : i4
    %9 = llhd.eq %opb_select.prb, %8 : i4
    cond_br %9, ^case_body2, ^10
^case_body1:
    %gpr_rdata.prb = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %11 = llhd.array_uniform %2 : !llhd.array<2xi32>
    %12 = llhd.extract_slice %11, 0 : !llhd.array<2xi32> -> !llhd.array<1xi32>
    %13 = llhd.extract_slice %gpr_rdata.prb, 1 : !llhd.array<2xi32> -> !llhd.array<1xi32>
    %14 = llhd.insert_slice %11, %12, 1 : !llhd.array<2xi32>, !llhd.array<1xi32>
    %15 = llhd.insert_slice %14, %13, 0 : !llhd.array<2xi32>, !llhd.array<1xi32>
    %16 = llhd.extract_element %15, 0 : !llhd.array<2xi32> -> i32
    llhd.drv %opb, %16 after %3 : !llhd.sig<i32>
    br ^check
^10:
    %17 = llhd.const 6 : i4
    %18 = llhd.eq %opb_select.prb, %17 : i4
    %19 = llhd.const 5 : i4
    %20 = llhd.eq %opb_select.prb, %19 : i4
    %21 = llhd.or %18, %20 : i1
    cond_br %21, ^case_body3, ^22
^case_body2:
    %iimm.prb = llhd.prb %iimm : !llhd.sig<i32>
    llhd.drv %opb, %iimm.prb after %3 : !llhd.sig<i32>
    br ^check
^22:
    %23 = llhd.const 7 : i4
    %24 = llhd.eq %opb_select.prb, %23 : i4
    cond_br %24, ^case_body4, ^25
^case_body3:
    %simm.prb = llhd.prb %simm : !llhd.sig<i32>
    llhd.drv %opb, %simm.prb after %3 : !llhd.sig<i32>
    br ^check
^25:
    %26 = llhd.const 8 : i4
    %27 = llhd.eq %opb_select.prb, %26 : i4
    cond_br %27, ^case_body5, ^28
^case_body4:
    %pc_q.prb = llhd.prb %pc_q : !llhd.sig<i32>
    llhd.drv %opb, %pc_q.prb after %3 : !llhd.sig<i32>
    br ^check
^28:
    llhd.drv %opb, %2 after %3 : !llhd.sig<i32>
    br ^check
^case_body5:
    %csr_rvalue.prb = llhd.prb %csr_rvalue : !llhd.sig<i32>
    llhd.drv %opb, %csr_rvalue.prb after %3 : !llhd.sig<i32>
    br ^check
}

llhd.proc @snitch.param1.always_comb.24030.1(%opa: !llhd.sig<i32>, %opb: !llhd.sig<i32>, %adder_result: !llhd.sig<i33>, %alu_op: !llhd.sig<i4>, %shift_right_result: !llhd.sig<i32>, %shift_left_result: !llhd.sig<i32>) -> (%alu_result: !llhd.sig<i32> , %shift_left: !llhd.sig<i1> , %shift_arithmetic: !llhd.sig<i1> , %alu_opa: !llhd.sig<i33> , %alu_opb: !llhd.sig<i33> ) {
    br ^body
^body:
    %opa.prb = llhd.prb %opa : !llhd.sig<i32>
    %0 = llhd.extract_slice %opa.prb, 31 : i32 -> i1
    %1 = llhd.const 0 : i33
    %2 = llhd.const 8589934591 : i33
    %3 = llhd.array %1, %2 : !llhd.array<2xi33>
    %4 = llhd.dyn_extract_element %3, %0 : (!llhd.array<2xi33>, i1) -> i33
    %sext = llhd.insert_slice %4, %opa.prb, 0 : i33, i32
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opa, %sext after %5 : !llhd.sig<i33>
    %opb.prb = llhd.prb %opb : !llhd.sig<i32>
    %6 = llhd.extract_slice %opb.prb, 31 : i32 -> i1
    %7 = llhd.dyn_extract_element %3, %6 : (!llhd.array<2xi33>, i1) -> i33
    %sext1 = llhd.insert_slice %7, %opb.prb, 0 : i33, i32
    llhd.drv %alu_opb, %sext1 after %5 : !llhd.sig<i33>
    %adder_result.prb = llhd.prb %adder_result : !llhd.sig<i33>
    %8 = llhd.extract_slice %adder_result.prb, 0 : i33 -> i32
    llhd.drv %alu_result, %8 after %5 : !llhd.sig<i32>
    %9 = llhd.const 0 : i1
    llhd.drv %shift_left, %9 after %5 : !llhd.sig<i1>
    llhd.drv %shift_arithmetic, %9 after %5 : !llhd.sig<i1>
    %alu_op.prb = llhd.prb %alu_op : !llhd.sig<i4>
    %10 = llhd.const 1 : i4
    %11 = llhd.eq %alu_op.prb, %10 : i4
    %12 = llhd.neg %sext1 : i33
    cond_br %11, ^case_body, ^13
^13:
    %14 = llhd.const 2 : i4
    %15 = llhd.eq %alu_op.prb, %14 : i4
    %16 = llhd.const 0 : i32
    %17 = llhd.const 0 : i31
    %18 = llhd.extract_slice %adder_result.prb, 32 : i33 -> i1
    %19 = llhd.const 0 : i30
    cond_br %15, ^case_body1, ^20
^case_body:
    llhd.drv %alu_opb, %12 after %5 : !llhd.sig<i33>
    br ^check
^check:
    llhd.wait (%opa, %opb, %adder_result, %alu_op, %shift_right_result, %shift_left_result : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i33>, !llhd.sig<i4>, !llhd.sig<i32>, !llhd.sig<i32>), ^body
^20:
    %21 = llhd.const 13 : i4
    %22 = llhd.eq %alu_op.prb, %21 : i4
    %23 = llhd.insert_slice %1, %18, 0 : i33, i1
    cond_br %22, ^case_body2, ^24
^case_body1:
    llhd.drv %alu_opb, %12 after %5 : !llhd.sig<i33>
    %25 = llhd.insert_slice %1, %18, 0 : i33, i1
    %26 = llhd.extract_slice %25, 0 : i33 -> i1
    %27 = llhd.insert_slice %17, %26, 0 : i31, i1
    %concat = llhd.insert_slice %27, %19, 1 : i31, i30
    %zext = llhd.insert_slice %16, %concat, 0 : i32, i31
    llhd.drv %alu_result, %zext after %5 : !llhd.sig<i32>
    br ^check
^24:
    %28 = llhd.const 3 : i4
    %29 = llhd.eq %alu_op.prb, %28 : i4
    %zext2 = llhd.insert_slice %1, %opa.prb, 0 : i33, i32
    %zext3 = llhd.insert_slice %1, %opb.prb, 0 : i33, i32
    %30 = llhd.extract_slice %23, 0 : i33 -> i1
    cond_br %29, ^case_body3, ^31
^case_body2:
    llhd.drv %alu_opb, %12 after %5 : !llhd.sig<i33>
    %32 = llhd.extract_slice %23, 0 : i33 -> i1
    %33 = llhd.not %32 : i1
    %34 = llhd.insert_slice %17, %33, 0 : i31, i1
    %concat1 = llhd.insert_slice %34, %19, 1 : i31, i30
    %zext1 = llhd.insert_slice %16, %concat1, 0 : i32, i31
    llhd.drv %alu_result, %zext1 after %5 : !llhd.sig<i32>
    br ^check
^31:
    %35 = llhd.const 14 : i4
    %36 = llhd.eq %alu_op.prb, %35 : i4
    cond_br %36, ^case_body4, ^37
^case_body3:
    llhd.drv %alu_opa, %zext2 after %5 : !llhd.sig<i33>
    %38 = llhd.neg %zext3 : i33
    llhd.drv %alu_opb, %38 after %5 : !llhd.sig<i33>
    %39 = llhd.insert_slice %17, %30, 0 : i31, i1
    %concat2 = llhd.insert_slice %39, %19, 1 : i31, i30
    %zext4 = llhd.insert_slice %16, %concat2, 0 : i32, i31
    llhd.drv %alu_result, %zext4 after %5 : !llhd.sig<i32>
    br ^check
^37:
    %40 = llhd.const 4 : i4
    %41 = llhd.eq %alu_op.prb, %40 : i4
    %42 = llhd.const 1 : i1
    cond_br %41, ^case_body5, ^43
^case_body4:
    llhd.drv %alu_opa, %zext2 after %5 : !llhd.sig<i33>
    %44 = llhd.neg %zext3 : i33
    llhd.drv %alu_opb, %44 after %5 : !llhd.sig<i33>
    %45 = llhd.not %30 : i1
    %46 = llhd.insert_slice %17, %45, 0 : i31, i1
    %concat3 = llhd.insert_slice %46, %19, 1 : i31, i30
    %zext5 = llhd.insert_slice %16, %concat3, 0 : i32, i31
    llhd.drv %alu_result, %zext5 after %5 : !llhd.sig<i32>
    br ^check
^43:
    %47 = llhd.const 5 : i4
    %48 = llhd.eq %alu_op.prb, %47 : i4
    %shift_right_result.prb = llhd.prb %shift_right_result : !llhd.sig<i32>
    cond_br %48, ^case_body6, ^49
^case_body5:
    llhd.drv %shift_left, %42 after %5 : !llhd.sig<i1>
    %shift_left_result.prb = llhd.prb %shift_left_result : !llhd.sig<i32>
    llhd.drv %alu_result, %shift_left_result.prb after %5 : !llhd.sig<i32>
    br ^check
^49:
    %50 = llhd.const 6 : i4
    %51 = llhd.eq %alu_op.prb, %50 : i4
    cond_br %51, ^case_body7, ^52
^case_body6:
    llhd.drv %alu_result, %shift_right_result.prb after %5 : !llhd.sig<i32>
    br ^check
^52:
    %53 = llhd.const 7 : i4
    %54 = llhd.eq %alu_op.prb, %53 : i4
    cond_br %54, ^case_body8, ^55
^case_body7:
    llhd.drv %shift_arithmetic, %42 after %5 : !llhd.sig<i1>
    llhd.drv %alu_result, %shift_right_result.prb after %5 : !llhd.sig<i32>
    br ^check
^55:
    %56 = llhd.const 9 : i4
    %57 = llhd.eq %alu_op.prb, %56 : i4
    cond_br %57, ^case_body9, ^58
^case_body8:
    %59 = llhd.xor %opa.prb, %opb.prb : i32
    llhd.drv %alu_result, %59 after %5 : !llhd.sig<i32>
    br ^check
^58:
    %60 = llhd.const 10 : i4
    %61 = llhd.eq %alu_op.prb, %60 : i4
    cond_br %61, ^case_body10, ^62
^case_body9:
    %63 = llhd.and %opa.prb, %opb.prb : i32
    llhd.drv %alu_result, %63 after %5 : !llhd.sig<i32>
    br ^check
^62:
    %64 = llhd.const 8 : i4
    %65 = llhd.eq %alu_op.prb, %64 : i4
    cond_br %65, ^case_body11, ^66
^case_body10:
    %67 = llhd.not %opa.prb : i32
    %68 = llhd.and %67, %opb.prb : i32
    llhd.drv %alu_result, %68 after %5 : !llhd.sig<i32>
    br ^check
^66:
    %69 = llhd.const 11 : i4
    %70 = llhd.eq %alu_op.prb, %69 : i4
    %71 = llhd.extract_slice %adder_result.prb, 0 : i33 -> i1
    %72 = llhd.extract_slice %adder_result.prb, 1 : i33 -> i1
    %73 = llhd.extract_slice %adder_result.prb, 2 : i33 -> i1
    %74 = llhd.extract_slice %adder_result.prb, 3 : i33 -> i1
    %75 = llhd.extract_slice %adder_result.prb, 4 : i33 -> i1
    %76 = llhd.extract_slice %adder_result.prb, 5 : i33 -> i1
    %77 = llhd.extract_slice %adder_result.prb, 6 : i33 -> i1
    %78 = llhd.extract_slice %adder_result.prb, 7 : i33 -> i1
    %79 = llhd.extract_slice %adder_result.prb, 8 : i33 -> i1
    %80 = llhd.extract_slice %adder_result.prb, 9 : i33 -> i1
    %81 = llhd.extract_slice %adder_result.prb, 10 : i33 -> i1
    %82 = llhd.extract_slice %adder_result.prb, 11 : i33 -> i1
    %83 = llhd.extract_slice %adder_result.prb, 12 : i33 -> i1
    %84 = llhd.extract_slice %adder_result.prb, 13 : i33 -> i1
    %85 = llhd.extract_slice %adder_result.prb, 14 : i33 -> i1
    %86 = llhd.extract_slice %adder_result.prb, 15 : i33 -> i1
    %87 = llhd.extract_slice %adder_result.prb, 16 : i33 -> i1
    %88 = llhd.extract_slice %adder_result.prb, 17 : i33 -> i1
    %89 = llhd.extract_slice %adder_result.prb, 18 : i33 -> i1
    %90 = llhd.extract_slice %adder_result.prb, 19 : i33 -> i1
    %91 = llhd.extract_slice %adder_result.prb, 20 : i33 -> i1
    %92 = llhd.extract_slice %adder_result.prb, 21 : i33 -> i1
    %93 = llhd.extract_slice %adder_result.prb, 22 : i33 -> i1
    %94 = llhd.extract_slice %adder_result.prb, 23 : i33 -> i1
    %95 = llhd.extract_slice %adder_result.prb, 24 : i33 -> i1
    %96 = llhd.extract_slice %adder_result.prb, 25 : i33 -> i1
    %97 = llhd.extract_slice %adder_result.prb, 26 : i33 -> i1
    %98 = llhd.extract_slice %adder_result.prb, 27 : i33 -> i1
    %99 = llhd.extract_slice %adder_result.prb, 28 : i33 -> i1
    %100 = llhd.extract_slice %adder_result.prb, 29 : i33 -> i1
    %101 = llhd.extract_slice %adder_result.prb, 30 : i33 -> i1
    %102 = llhd.extract_slice %adder_result.prb, 31 : i33 -> i1
    cond_br %70, ^case_body12, ^103
^case_body11:
    %104 = llhd.or %opa.prb, %opb.prb : i32
    llhd.drv %alu_result, %104 after %5 : !llhd.sig<i32>
    br ^check
^103:
    %105 = llhd.const 12 : i4
    %106 = llhd.eq %alu_op.prb, %105 : i4
    cond_br %106, ^case_body13, ^107
^case_body12:
    llhd.drv %alu_opb, %12 after %5 : !llhd.sig<i33>
    %108 = llhd.or %71, %72 : i1
    %109 = llhd.or %108, %73 : i1
    %110 = llhd.or %109, %74 : i1
    %111 = llhd.or %110, %75 : i1
    %112 = llhd.or %111, %76 : i1
    %113 = llhd.or %112, %77 : i1
    %114 = llhd.or %113, %78 : i1
    %115 = llhd.or %114, %79 : i1
    %116 = llhd.or %115, %80 : i1
    %117 = llhd.or %116, %81 : i1
    %118 = llhd.or %117, %82 : i1
    %119 = llhd.or %118, %83 : i1
    %120 = llhd.or %119, %84 : i1
    %121 = llhd.or %120, %85 : i1
    %122 = llhd.or %121, %86 : i1
    %123 = llhd.or %122, %87 : i1
    %124 = llhd.or %123, %88 : i1
    %125 = llhd.or %124, %89 : i1
    %126 = llhd.or %125, %90 : i1
    %127 = llhd.or %126, %91 : i1
    %128 = llhd.or %127, %92 : i1
    %129 = llhd.or %128, %93 : i1
    %130 = llhd.or %129, %94 : i1
    %131 = llhd.or %130, %95 : i1
    %132 = llhd.or %131, %96 : i1
    %133 = llhd.or %132, %97 : i1
    %134 = llhd.or %133, %98 : i1
    %135 = llhd.or %134, %99 : i1
    %136 = llhd.or %135, %100 : i1
    %137 = llhd.or %136, %101 : i1
    %138 = llhd.or %137, %102 : i1
    %139 = llhd.or %138, %18 : i1
    %140 = llhd.not %139 : i1
    %zext6 = llhd.insert_slice %16, %140, 0 : i32, i1
    llhd.drv %alu_result, %zext6 after %5 : !llhd.sig<i32>
    br ^check
^107:
    %141 = llhd.const 15 : i4
    %142 = llhd.eq %alu_op.prb, %141 : i4
    cond_br %142, ^case_body14, ^143
^case_body13:
    llhd.drv %alu_opb, %12 after %5 : !llhd.sig<i33>
    %144 = llhd.or %71, %72 : i1
    %145 = llhd.or %144, %73 : i1
    %146 = llhd.or %145, %74 : i1
    %147 = llhd.or %146, %75 : i1
    %148 = llhd.or %147, %76 : i1
    %149 = llhd.or %148, %77 : i1
    %150 = llhd.or %149, %78 : i1
    %151 = llhd.or %150, %79 : i1
    %152 = llhd.or %151, %80 : i1
    %153 = llhd.or %152, %81 : i1
    %154 = llhd.or %153, %82 : i1
    %155 = llhd.or %154, %83 : i1
    %156 = llhd.or %155, %84 : i1
    %157 = llhd.or %156, %85 : i1
    %158 = llhd.or %157, %86 : i1
    %159 = llhd.or %158, %87 : i1
    %160 = llhd.or %159, %88 : i1
    %161 = llhd.or %160, %89 : i1
    %162 = llhd.or %161, %90 : i1
    %163 = llhd.or %162, %91 : i1
    %164 = llhd.or %163, %92 : i1
    %165 = llhd.or %164, %93 : i1
    %166 = llhd.or %165, %94 : i1
    %167 = llhd.or %166, %95 : i1
    %168 = llhd.or %167, %96 : i1
    %169 = llhd.or %168, %97 : i1
    %170 = llhd.or %169, %98 : i1
    %171 = llhd.or %170, %99 : i1
    %172 = llhd.or %171, %100 : i1
    %173 = llhd.or %172, %101 : i1
    %174 = llhd.or %173, %102 : i1
    %175 = llhd.or %174, %18 : i1
    %zext7 = llhd.insert_slice %16, %175, 0 : i32, i1
    llhd.drv %alu_result, %zext7 after %5 : !llhd.sig<i32>
    br ^check
^143:
    llhd.drv %alu_result, %8 after %5 : !llhd.sig<i32>
    br ^check
^case_body14:
    llhd.drv %alu_result, %opa.prb after %5 : !llhd.sig<i32>
    br ^check
}

llhd.proc @snitch.param1.always_comb.24258.1(%consec_pc: !llhd.sig<i32>, %alu_result: !llhd.sig<i32>, %rd_select: !llhd.sig<i2>, %rd_bypass: !llhd.sig<i32>) -> (%alu_writeback: !llhd.sig<i32> ) {
    br ^body
^body:
    %rd_select.prb = llhd.prb %rd_select : !llhd.sig<i2>
    %0 = llhd.const 0 : i2
    %1 = llhd.eq %rd_select.prb, %0 : i2
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %alu_result.prb = llhd.prb %alu_result : !llhd.sig<i32>
    cond_br %1, ^case_body, ^3
^3:
    %4 = llhd.const 1 : i2
    %5 = llhd.eq %rd_select.prb, %4 : i2
    cond_br %5, ^case_body1, ^6
^case_body:
    llhd.drv %alu_writeback, %alu_result.prb after %2 : !llhd.sig<i32>
    br ^check
^check:
    llhd.wait (%consec_pc, %alu_result, %rd_select, %rd_bypass : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i2>, !llhd.sig<i32>), ^body
^6:
    %7 = llhd.const 2 : i2
    %8 = llhd.eq %rd_select.prb, %7 : i2
    cond_br %8, ^case_body2, ^9
^case_body1:
    %consec_pc.prb = llhd.prb %consec_pc : !llhd.sig<i32>
    llhd.drv %alu_writeback, %consec_pc.prb after %2 : !llhd.sig<i32>
    br ^check
^9:
    llhd.drv %alu_writeback, %alu_result.prb after %2 : !llhd.sig<i32>
    br ^check
^case_body2:
    %rd_bypass.prb = llhd.prb %rd_bypass : !llhd.sig<i32>
    llhd.drv %alu_writeback, %rd_bypass.prb after %2 : !llhd.sig<i32>
    br ^check
}

llhd.proc @snitch.param1.always_comb.24550.1(%acc_pdata_i: !llhd.sig<i64>, %acc_pid_i: !llhd.sig<i5>, %acc_pvalid_i: !llhd.sig<i1>, %rd: !llhd.sig<i5>, %ld_result: !llhd.sig<i64>, %lsu_pvalid: !llhd.sig<i1>, %lsu_rd: !llhd.sig<i5>, %retire_i: !llhd.sig<i1>, %alu_writeback: !llhd.sig<i32>) -> (%acc_pready_o: !llhd.sig<i1> , %gpr_waddr: !llhd.sig<!llhd.array<1xi5>> , %gpr_wdata: !llhd.sig<!llhd.array<1xi32>> , %gpr_we: !llhd.sig<i1> , %lsu_pready: !llhd.sig<i1> , %retire_load: !llhd.sig<i1> , %retire_acc: !llhd.sig<i1> ) {
    br ^body
^body:
    %0 = llhd.extract_slice %gpr_we, 0 : !llhd.sig<i1> -> !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %0, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.extract_element %gpr_waddr, 0 : !llhd.sig<!llhd.array<1xi5>> -> !llhd.sig<i5>
    %rd.prb = llhd.prb %rd : !llhd.sig<i5>
    llhd.drv %3, %rd.prb after %2 : !llhd.sig<i5>
    %4 = llhd.extract_element %gpr_wdata, 0 : !llhd.sig<!llhd.array<1xi32>> -> !llhd.sig<i32>
    %alu_writeback.prb = llhd.prb %alu_writeback : !llhd.sig<i32>
    llhd.drv %4, %alu_writeback.prb after %2 : !llhd.sig<i32>
    llhd.drv %lsu_pready, %1 after %2 : !llhd.sig<i1>
    llhd.drv %acc_pready_o, %1 after %2 : !llhd.sig<i1>
    llhd.drv %retire_acc, %1 after %2 : !llhd.sig<i1>
    llhd.drv %retire_load, %1 after %2 : !llhd.sig<i1>
    %retire_i.prb = llhd.prb %retire_i : !llhd.sig<i1>
    %5 = llhd.neq %retire_i.prb, %1 : i1
    %6 = llhd.const 1 : i1
    cond_br %5, ^if_true, ^if_false
^if_false:
    %lsu_pvalid.prb = llhd.prb %lsu_pvalid : !llhd.sig<i1>
    %7 = llhd.neq %lsu_pvalid.prb, %1 : i1
    cond_br %7, ^if_true1, ^if_false1
^if_true:
    llhd.drv %0, %6 after %2 : !llhd.sig<i1>
    br ^check
^check:
    llhd.wait (%acc_pdata_i, %acc_pid_i, %acc_pvalid_i, %rd, %ld_result, %lsu_pvalid, %lsu_rd, %retire_i, %alu_writeback : !llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>), ^body
^if_false1:
    %acc_pvalid_i.prb = llhd.prb %acc_pvalid_i : !llhd.sig<i1>
    %8 = llhd.neq %acc_pvalid_i.prb, %1 : i1
    cond_br %8, ^if_true2, ^check
^if_true1:
    llhd.drv %retire_load, %6 after %2 : !llhd.sig<i1>
    llhd.drv %0, %6 after %2 : !llhd.sig<i1>
    %lsu_rd.prb = llhd.prb %lsu_rd : !llhd.sig<i5>
    llhd.drv %3, %lsu_rd.prb after %2 : !llhd.sig<i5>
    %ld_result.prb = llhd.prb %ld_result : !llhd.sig<i64>
    %9 = llhd.extract_slice %ld_result.prb, 0 : i64 -> i32
    llhd.drv %4, %9 after %2 : !llhd.sig<i32>
    llhd.drv %lsu_pready, %6 after %2 : !llhd.sig<i1>
    br ^check
^if_true2:
    llhd.drv %retire_acc, %6 after %2 : !llhd.sig<i1>
    llhd.drv %0, %6 after %2 : !llhd.sig<i1>
    %acc_pid_i.prb = llhd.prb %acc_pid_i : !llhd.sig<i5>
    llhd.drv %3, %acc_pid_i.prb after %2 : !llhd.sig<i5>
    %acc_pdata_i.prb = llhd.prb %acc_pdata_i : !llhd.sig<i64>
    %10 = llhd.extract_slice %acc_pdata_i.prb, 0 : i64 -> i32
    llhd.drv %4, %10 after %2 : !llhd.sig<i32>
    llhd.drv %acc_pready_o, %6 after %2 : !llhd.sig<i1>
    br ^check
}

llhd.entity @snitch.param1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %hart_id_i: !llhd.sig<i32>, %inst_data_i: !llhd.sig<i32>, %inst_ready_i: !llhd.sig<i1>, %acc_qready_i: !llhd.sig<i1>, %acc_pdata_i: !llhd.sig<i64>, %acc_pid_i: !llhd.sig<i5>, %acc_perror_i: !llhd.sig<i1>, %acc_pvalid_i: !llhd.sig<i1>, %data_qready_i: !llhd.sig<i1>, %data_pdata_i: !llhd.sig<i64>, %data_perror_i: !llhd.sig<i1>, %data_pvalid_i: !llhd.sig<i1>, %wake_up_sync_i: !llhd.sig<i1>, %fpu_status_i: !llhd.sig<tuple<i1, i1, i1, i1, i1>>) -> (%inst_addr_o: !llhd.sig<i32> , %inst_valid_o: !llhd.sig<i1> , %acc_qaddr_o: !llhd.sig<i32> , %acc_qid_o: !llhd.sig<i5> , %acc_qdata_op_o: !llhd.sig<i32> , %acc_qdata_arga_o: !llhd.sig<i64> , %acc_qdata_argb_o: !llhd.sig<i64> , %acc_qdata_argc_o: !llhd.sig<i64> , %acc_qvalid_o: !llhd.sig<i1> , %acc_pready_o: !llhd.sig<i1> , %data_qaddr_o: !llhd.sig<i32> , %data_qwrite_o: !llhd.sig<i1> , %data_qamo_o: !llhd.sig<i4> , %data_qdata_o: !llhd.sig<i64> , %data_qstrb_o: !llhd.sig<i8> , %data_qvalid_o: !llhd.sig<i1> , %data_pready_o: !llhd.sig<i1> , %fpu_rnd_mode_o: !llhd.sig<i3> , %core_events_o: !llhd.sig<tuple<i1, i1, i1, i1>> ) {
    %0 = llhd.const 0 : i1
    %illegal_inst = llhd.sig "illegal_inst" %0 : i1
    %zero_lsb = llhd.sig "zero_lsb" %0 : i1
    %1 = llhd.const 0 : i32
    %pc_d = llhd.sig "pc_d" %1 : i32
    %pc_q = llhd.sig "pc_q" %1 : i32
    %wfi_d = llhd.sig "wfi_d" %0 : i1
    %wfi_q = llhd.sig "wfi_q" %0 : i1
    %consec_pc = llhd.sig "consec_pc" %1 : i32
    %iimm = llhd.sig "iimm" %1 : i32
    %uimm = llhd.sig "uimm" %1 : i32
    %jimm = llhd.sig "jimm" %1 : i32
    %bimm = llhd.sig "bimm" %1 : i32
    %simm = llhd.sig "simm" %1 : i32
    %opa = llhd.sig "opa" %1 : i32
    %opb = llhd.sig "opb" %1 : i32
    %2 = llhd.const 0 : i33
    %adder_result = llhd.sig "adder_result" %2 : i33
    %alu_result = llhd.sig "alu_result" %1 : i32
    %3 = llhd.const 0 : i5
    %rd = llhd.sig "rd" %3 : i5
    %rs1 = llhd.sig "rs1" %3 : i5
    %rs2 = llhd.sig "rs2" %3 : i5
    %stall = llhd.sig "stall" %0 : i1
    %lsu_stall = llhd.sig "lsu_stall" %0 : i1
    %4 = llhd.array %3, %3 : !llhd.array<2xi5>
    %gpr_raddr = llhd.sig "gpr_raddr" %4 : !llhd.array<2xi5>
    %5 = llhd.array %1, %1 : !llhd.array<2xi32>
    %gpr_rdata = llhd.sig "gpr_rdata" %5 : !llhd.array<2xi32>
    %6 = llhd.array %3 : !llhd.array<1xi5>
    %gpr_waddr = llhd.sig "gpr_waddr" %6 : !llhd.array<1xi5>
    %7 = llhd.array %1 : !llhd.array<1xi32>
    %gpr_wdata = llhd.sig "gpr_wdata" %7 : !llhd.array<1xi32>
    %gpr_we = llhd.sig "gpr_we" %0 : i1
    %sb_d = llhd.sig "sb_d" %1 : i32
    %sb_q = llhd.sig "sb_q" %1 : i32
    %is_load = llhd.sig "is_load" %0 : i1
    %is_store = llhd.sig "is_store" %0 : i1
    %is_signed = llhd.sig "is_signed" %0 : i1
    %8 = llhd.const 0 : i2
    %ls_size = llhd.sig "ls_size" %8 : i2
    %9 = llhd.const 0 : i4
    %ls_amo = llhd.sig "ls_amo" %9 : i4
    %10 = llhd.const 0 : i64
    %ld_result = llhd.sig "ld_result" %10 : i64
    %lsu_qready = llhd.sig "lsu_qready" %0 : i1
    %lsu_qvalid = llhd.sig "lsu_qvalid" %0 : i1
    %lsu_pvalid = llhd.sig "lsu_pvalid" %0 : i1
    %lsu_pready = llhd.sig "lsu_pready" %0 : i1
    %lsu_rd = llhd.sig "lsu_rd" %3 : i5
    %retire_load = llhd.sig "retire_load" %0 : i1
    %retire_i = llhd.sig "retire_i" %0 : i1
    %retire_acc = llhd.sig "retire_acc" %0 : i1
    %acc_stall = llhd.sig "acc_stall" %0 : i1
    %valid_instr = llhd.sig "valid_instr" %0 : i1
    %alu_op = llhd.sig "alu_op" %9 : i4
    %opa_select = llhd.sig "opa_select" %9 : i4
    %opb_select = llhd.sig "opb_select" %9 : i4
    %write_rd = llhd.sig "write_rd" %0 : i1
    %uses_rd = llhd.sig "uses_rd" %0 : i1
    %next_pc = llhd.sig "next_pc" %8 : i2
    %rd_select = llhd.sig "rd_select" %8 : i2
    %rd_bypass = llhd.sig "rd_bypass" %1 : i32
    %is_branch = llhd.sig "is_branch" %0 : i1
    %csr_rvalue = llhd.sig "csr_rvalue" %1 : i32
    %csr_en = llhd.sig "csr_en" %0 : i1
    %11 = llhd.const 0 : i3
    %12 = llhd.tuple %0, %0, %0, %0, %0 : tuple<i1, i1, i1, i1, i1>
    %13 = llhd.tuple %11, %12 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %fcsr_d = llhd.sig "fcsr_d" %13 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %fcsr_q = llhd.sig "fcsr_q" %13 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %acc_register_rd = llhd.sig "acc_register_rd" %0 : i1
    %operands_ready = llhd.sig "operands_ready" %0 : i1
    %dst_ready = llhd.sig "dst_ready" %0 : i1
    %opa_ready = llhd.sig "opa_ready" %0 : i1
    %opb_ready = llhd.sig "opb_ready" %0 : i1
    %shift_opa = llhd.sig "shift_opa" %1 : i32
    %shift_opa_reversed = llhd.sig "shift_opa_reversed" %1 : i32
    %shift_right_result = llhd.sig "shift_right_result" %1 : i32
    %shift_left_result = llhd.sig "shift_left_result" %1 : i32
    %shift_opa_ext = llhd.sig "shift_opa_ext" %2 : i33
    %shift_right_result_ext = llhd.sig "shift_right_result_ext" %2 : i33
    %shift_left = llhd.sig "shift_left" %0 : i1
    %shift_arithmetic = llhd.sig "shift_arithmetic" %0 : i1
    %alu_opa = llhd.sig "alu_opa" %2 : i33
    %alu_opb = llhd.sig "alu_opb" %2 : i33
    %alu_writeback = llhd.sig "alu_writeback" %1 : i32
    %inst_data_i.prb = llhd.prb %inst_data_i : !llhd.sig<i32>
    %14 = llhd.extract_slice %inst_data_i.prb, 20 : i32 -> i12
    %15 = llhd.insert_slice %1, %14, 0 : i32, i12
    %concat = llhd.extract_slice %15, 0 : i32 -> i12
    %16 = llhd.extract_slice %concat, 11 : i12 -> i1
    %17 = llhd.const 4294967295 : i32
    %18 = llhd.array %1, %17 : !llhd.array<2xi32>
    %19 = llhd.dyn_extract_element %18, %16 : (!llhd.array<2xi32>, i1) -> i32
    %sext = llhd.insert_slice %19, %concat, 0 : i32, i12
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %iimm, %sext after %20 : !llhd.sig<i32>
    %21 = llhd.extract_slice %inst_data_i.prb, 12 : i32 -> i20
    %22 = llhd.insert_slice %1, %21, 0 : i32, i20
    %23 = llhd.extract_slice %22, 0 : i32 -> i20
    %concat1 = llhd.insert_slice %1, %23, 12 : i32, i20
    llhd.drv %uimm, %concat1 after %20 : !llhd.sig<i32>
    %24 = llhd.const 0 : i21
    %25 = llhd.extract_slice %inst_data_i.prb, 21 : i32 -> i11
    %26 = llhd.insert_slice %1, %25, 0 : i32, i11
    %27 = llhd.extract_slice %26, 0 : i32 -> i10
    %28 = llhd.insert_slice %24, %27, 1 : i21, i10
    %29 = llhd.extract_slice %15, 0 : i32 -> i1
    %30 = llhd.insert_slice %28, %29, 11 : i21, i1
    %31 = llhd.extract_slice %22, 0 : i32 -> i8
    %32 = llhd.insert_slice %30, %31, 12 : i21, i8
    %33 = llhd.extract_slice %inst_data_i.prb, 31 : i32 -> i1
    %34 = llhd.insert_slice %1, %33, 0 : i32, i1
    %35 = llhd.extract_slice %34, 0 : i32 -> i1
    %concat2 = llhd.insert_slice %32, %35, 20 : i21, i1
    %36 = llhd.extract_slice %concat2, 20 : i21 -> i1
    %37 = llhd.dyn_extract_element %18, %36 : (!llhd.array<2xi32>, i1) -> i32
    %sext1 = llhd.insert_slice %37, %concat2, 0 : i32, i21
    llhd.drv %jimm, %sext1 after %20 : !llhd.sig<i32>
    %38 = llhd.const 0 : i13
    %39 = llhd.extract_slice %inst_data_i.prb, 8 : i32 -> i24
    %40 = llhd.insert_slice %1, %39, 0 : i32, i24
    %41 = llhd.extract_slice %40, 0 : i32 -> i4
    %42 = llhd.insert_slice %38, %41, 1 : i13, i4
    %43 = llhd.extract_slice %inst_data_i.prb, 25 : i32 -> i7
    %44 = llhd.insert_slice %1, %43, 0 : i32, i7
    %45 = llhd.extract_slice %44, 0 : i32 -> i6
    %46 = llhd.insert_slice %42, %45, 5 : i13, i6
    %47 = llhd.extract_slice %inst_data_i.prb, 7 : i32 -> i25
    %48 = llhd.insert_slice %1, %47, 0 : i32, i25
    %49 = llhd.extract_slice %48, 0 : i32 -> i1
    %50 = llhd.insert_slice %46, %49, 11 : i13, i1
    %concat3 = llhd.insert_slice %50, %35, 12 : i13, i1
    %51 = llhd.extract_slice %concat3, 12 : i13 -> i1
    %52 = llhd.dyn_extract_element %18, %51 : (!llhd.array<2xi32>, i1) -> i32
    %sext2 = llhd.insert_slice %52, %concat3, 0 : i32, i13
    llhd.drv %bimm, %sext2 after %20 : !llhd.sig<i32>
    %53 = llhd.const 0 : i12
    %54 = llhd.extract_slice %48, 0 : i32 -> i5
    %55 = llhd.insert_slice %53, %54, 0 : i12, i5
    %56 = llhd.extract_slice %44, 0 : i32 -> i7
    %concat4 = llhd.insert_slice %55, %56, 5 : i12, i7
    %57 = llhd.extract_slice %concat4, 11 : i12 -> i1
    %58 = llhd.dyn_extract_element %18, %57 : (!llhd.array<2xi32>, i1) -> i32
    %sext3 = llhd.insert_slice %58, %concat4, 0 : i32, i12
    llhd.drv %simm, %sext3 after %20 : !llhd.sig<i32>
    %fcsr_q.prb = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %59 = llhd.extract_element %fcsr_q.prb, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    llhd.drv %fpu_rnd_mode_o, %59 after %20 : !llhd.sig<i3>
    %hart_id_i.prb = llhd.prb %hart_id_i : !llhd.sig<i32>
    llhd.drv %acc_qaddr_o, %hart_id_i.prb after %20 : !llhd.sig<i32>
    %rd.prb = llhd.prb %rd : !llhd.sig<i5>
    llhd.drv %acc_qid_o, %rd.prb after %20 : !llhd.sig<i5>
    llhd.drv %acc_qdata_op_o, %inst_data_i.prb after %20 : !llhd.sig<i32>
    %gpr_rdata.prb = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %60 = llhd.extract_element %gpr_rdata.prb, 0 : !llhd.array<2xi32> -> i32
    %61 = llhd.insert_slice %10, %60, 0 : i64, i32
    %62 = llhd.extract_slice %60, 31 : i32 -> i1
    %63 = llhd.insert_slice %1, %62, 0 : i32, i1
    %concat5 = llhd.extract_slice %63, 0 : i32 -> i1
    %64 = llhd.insert_slice %1, %concat5, 0 : i32, i1
    %65 = llhd.insert_slice %64, %concat5, 1 : i32, i1
    %66 = llhd.insert_slice %65, %concat5, 2 : i32, i1
    %67 = llhd.insert_slice %66, %concat5, 3 : i32, i1
    %68 = llhd.insert_slice %67, %concat5, 4 : i32, i1
    %69 = llhd.insert_slice %68, %concat5, 5 : i32, i1
    %70 = llhd.insert_slice %69, %concat5, 6 : i32, i1
    %71 = llhd.insert_slice %70, %concat5, 7 : i32, i1
    %72 = llhd.insert_slice %71, %concat5, 8 : i32, i1
    %73 = llhd.insert_slice %72, %concat5, 9 : i32, i1
    %74 = llhd.insert_slice %73, %concat5, 10 : i32, i1
    %75 = llhd.insert_slice %74, %concat5, 11 : i32, i1
    %76 = llhd.insert_slice %75, %concat5, 12 : i32, i1
    %77 = llhd.insert_slice %76, %concat5, 13 : i32, i1
    %78 = llhd.insert_slice %77, %concat5, 14 : i32, i1
    %79 = llhd.insert_slice %78, %concat5, 15 : i32, i1
    %80 = llhd.insert_slice %79, %concat5, 16 : i32, i1
    %81 = llhd.insert_slice %80, %concat5, 17 : i32, i1
    %82 = llhd.insert_slice %81, %concat5, 18 : i32, i1
    %83 = llhd.insert_slice %82, %concat5, 19 : i32, i1
    %84 = llhd.insert_slice %83, %concat5, 20 : i32, i1
    %85 = llhd.insert_slice %84, %concat5, 21 : i32, i1
    %86 = llhd.insert_slice %85, %concat5, 22 : i32, i1
    %87 = llhd.insert_slice %86, %concat5, 23 : i32, i1
    %88 = llhd.insert_slice %87, %concat5, 24 : i32, i1
    %89 = llhd.insert_slice %88, %concat5, 25 : i32, i1
    %90 = llhd.insert_slice %89, %concat5, 26 : i32, i1
    %91 = llhd.insert_slice %90, %concat5, 27 : i32, i1
    %92 = llhd.insert_slice %91, %concat5, 28 : i32, i1
    %93 = llhd.insert_slice %92, %concat5, 29 : i32, i1
    %94 = llhd.insert_slice %93, %concat5, 30 : i32, i1
    %repeat = llhd.insert_slice %94, %concat5, 31 : i32, i1
    %concat6 = llhd.insert_slice %61, %repeat, 32 : i64, i32
    llhd.drv %acc_qdata_arga_o, %concat6 after %20 : !llhd.sig<i64>
    %95 = llhd.array_uniform %1 : !llhd.array<2xi32>
    %96 = llhd.extract_slice %95, 0 : !llhd.array<2xi32> -> !llhd.array<1xi32>
    %97 = llhd.extract_slice %gpr_rdata.prb, 1 : !llhd.array<2xi32> -> !llhd.array<1xi32>
    %98 = llhd.insert_slice %95, %96, 1 : !llhd.array<2xi32>, !llhd.array<1xi32>
    %99 = llhd.insert_slice %98, %97, 0 : !llhd.array<2xi32>, !llhd.array<1xi32>
    %100 = llhd.extract_element %99, 0 : !llhd.array<2xi32> -> i32
    %101 = llhd.insert_slice %10, %100, 0 : i64, i32
    %102 = llhd.extract_slice %100, 31 : i32 -> i1
    %103 = llhd.insert_slice %1, %102, 0 : i32, i1
    %concat7 = llhd.extract_slice %103, 0 : i32 -> i1
    %104 = llhd.insert_slice %1, %concat7, 0 : i32, i1
    %105 = llhd.insert_slice %104, %concat7, 1 : i32, i1
    %106 = llhd.insert_slice %105, %concat7, 2 : i32, i1
    %107 = llhd.insert_slice %106, %concat7, 3 : i32, i1
    %108 = llhd.insert_slice %107, %concat7, 4 : i32, i1
    %109 = llhd.insert_slice %108, %concat7, 5 : i32, i1
    %110 = llhd.insert_slice %109, %concat7, 6 : i32, i1
    %111 = llhd.insert_slice %110, %concat7, 7 : i32, i1
    %112 = llhd.insert_slice %111, %concat7, 8 : i32, i1
    %113 = llhd.insert_slice %112, %concat7, 9 : i32, i1
    %114 = llhd.insert_slice %113, %concat7, 10 : i32, i1
    %115 = llhd.insert_slice %114, %concat7, 11 : i32, i1
    %116 = llhd.insert_slice %115, %concat7, 12 : i32, i1
    %117 = llhd.insert_slice %116, %concat7, 13 : i32, i1
    %118 = llhd.insert_slice %117, %concat7, 14 : i32, i1
    %119 = llhd.insert_slice %118, %concat7, 15 : i32, i1
    %120 = llhd.insert_slice %119, %concat7, 16 : i32, i1
    %121 = llhd.insert_slice %120, %concat7, 17 : i32, i1
    %122 = llhd.insert_slice %121, %concat7, 18 : i32, i1
    %123 = llhd.insert_slice %122, %concat7, 19 : i32, i1
    %124 = llhd.insert_slice %123, %concat7, 20 : i32, i1
    %125 = llhd.insert_slice %124, %concat7, 21 : i32, i1
    %126 = llhd.insert_slice %125, %concat7, 22 : i32, i1
    %127 = llhd.insert_slice %126, %concat7, 23 : i32, i1
    %128 = llhd.insert_slice %127, %concat7, 24 : i32, i1
    %129 = llhd.insert_slice %128, %concat7, 25 : i32, i1
    %130 = llhd.insert_slice %129, %concat7, 26 : i32, i1
    %131 = llhd.insert_slice %130, %concat7, 27 : i32, i1
    %132 = llhd.insert_slice %131, %concat7, 28 : i32, i1
    %133 = llhd.insert_slice %132, %concat7, 29 : i32, i1
    %134 = llhd.insert_slice %133, %concat7, 30 : i32, i1
    %repeat1 = llhd.insert_slice %134, %concat7, 31 : i32, i1
    %concat8 = llhd.insert_slice %101, %repeat1, 32 : i64, i32
    llhd.drv %acc_qdata_argb_o, %concat8 after %20 : !llhd.sig<i64>
    %alu_result.prb = llhd.prb %alu_result : !llhd.sig<i32>
    %135 = llhd.insert_slice %10, %alu_result.prb, 0 : i64, i32
    %concat9 = llhd.insert_slice %135, %1, 32 : i64, i32
    llhd.drv %acc_qdata_argc_o, %concat9 after %20 : !llhd.sig<i64>
    %pc_q.prb = llhd.prb %pc_q : !llhd.sig<i32>
    llhd.drv %inst_addr_o, %pc_q.prb after %20 : !llhd.sig<i32>
    %wfi_q.prb = llhd.prb %wfi_q : !llhd.sig<i1>
    %136 = llhd.not %wfi_q.prb : i1
    llhd.drv %inst_valid_o, %136 after %20 : !llhd.sig<i1>
    %opa_select.prb = llhd.prb %opa_select : !llhd.sig<i4>
    %137 = llhd.const 1 : i4
    %138 = llhd.neq %opa_select.prb, %137 : i4
    %sb_q.prb = llhd.prb %sb_q : !llhd.sig<i32>
    %rs1.prb = llhd.prb %rs1 : !llhd.sig<i5>
    %139 = llhd.shr %sb_q.prb, %1, %rs1.prb : (i32, i32, i5) -> i32
    %140 = llhd.extract_slice %139, 0 : i32 -> i1
    %141 = llhd.not %140 : i1
    %142 = llhd.or %138, %141 : i1
    llhd.drv %opa_ready, %142 after %20 : !llhd.sig<i1>
    %opb_select.prb = llhd.prb %opb_select : !llhd.sig<i4>
    %143 = llhd.neq %opb_select.prb, %137 : i4
    %144 = llhd.const 5 : i4
    %145 = llhd.neq %opb_select.prb, %144 : i4
    %146 = llhd.and %143, %145 : i1
    %rs2.prb = llhd.prb %rs2 : !llhd.sig<i5>
    %147 = llhd.shr %sb_q.prb, %1, %rs2.prb : (i32, i32, i5) -> i32
    %148 = llhd.extract_slice %147, 0 : i32 -> i1
    %149 = llhd.not %148 : i1
    %150 = llhd.or %146, %149 : i1
    llhd.drv %opb_ready, %150 after %20 : !llhd.sig<i1>
    %opa_ready.prb = llhd.prb %opa_ready : !llhd.sig<i1>
    %opb_ready.prb = llhd.prb %opb_ready : !llhd.sig<i1>
    %151 = llhd.and %opa_ready.prb, %opb_ready.prb : i1
    llhd.drv %operands_ready, %151 after %20 : !llhd.sig<i1>
    %uses_rd.prb = llhd.prb %uses_rd : !llhd.sig<i1>
    %152 = llhd.shr %sb_q.prb, %1, %rd.prb : (i32, i32, i5) -> i32
    %153 = llhd.extract_slice %152, 0 : i32 -> i1
    %154 = llhd.not %153 : i1
    %155 = llhd.and %uses_rd.prb, %154 : i1
    llhd.drv %dst_ready, %155 after %20 : !llhd.sig<i1>
    %inst_ready_i.prb = llhd.prb %inst_ready_i : !llhd.sig<i1>
    %inst_valid_o.prb = llhd.prb %inst_valid_o : !llhd.sig<i1>
    %156 = llhd.and %inst_ready_i.prb, %inst_valid_o.prb : i1
    %operands_ready.prb = llhd.prb %operands_ready : !llhd.sig<i1>
    %157 = llhd.and %156, %operands_ready.prb : i1
    %dst_ready.prb = llhd.prb %dst_ready : !llhd.sig<i1>
    %158 = llhd.and %157, %dst_ready.prb : i1
    llhd.drv %valid_instr, %158 after %20 : !llhd.sig<i1>
    %acc_qvalid_o.prb = llhd.prb %acc_qvalid_o : !llhd.sig<i1>
    %acc_qready_i.prb = llhd.prb %acc_qready_i : !llhd.sig<i1>
    %159 = llhd.not %acc_qready_i.prb : i1
    %160 = llhd.and %acc_qvalid_o.prb, %159 : i1
    llhd.drv %acc_stall, %160 after %20 : !llhd.sig<i1>
    %lsu_qvalid.prb = llhd.prb %lsu_qvalid : !llhd.sig<i1>
    %lsu_qready.prb = llhd.prb %lsu_qready : !llhd.sig<i1>
    %161 = llhd.not %lsu_qready.prb : i1
    %162 = llhd.and %lsu_qvalid.prb, %161 : i1
    llhd.drv %lsu_stall, %162 after %20 : !llhd.sig<i1>
    %valid_instr.prb = llhd.prb %valid_instr : !llhd.sig<i1>
    %163 = llhd.not %valid_instr.prb : i1
    %lsu_stall.prb = llhd.prb %lsu_stall : !llhd.sig<i1>
    %164 = llhd.or %163, %lsu_stall.prb : i1
    %acc_stall.prb = llhd.prb %acc_stall : !llhd.sig<i1>
    %165 = llhd.or %164, %acc_stall.prb : i1
    llhd.drv %stall, %165 after %20 : !llhd.sig<i1>
    %is_branch.prb = llhd.prb %is_branch : !llhd.sig<i1>
    %166 = llhd.extract_slice %alu_result.prb, 0 : i32 -> i1
    %167 = llhd.and %is_branch.prb, %166 : i1
    %168 = llhd.neq %167, %0 : i1
    %bimm.prb = llhd.prb %bimm : !llhd.sig<i32>
    %169 = llhd.const 4 : i32
    %170 = llhd.array %169, %bimm.prb : !llhd.array<2xi32>
    %171 = llhd.dyn_extract_element %170, %168 : (!llhd.array<2xi32>, i1) -> i32
    %172 = addi %pc_q.prb, %171 : i32
    llhd.drv %consec_pc, %172 after %20 : !llhd.sig<i32>
    llhd.drv %rd, %54 after %20 : !llhd.sig<i5>
    %173 = llhd.extract_slice %inst_data_i.prb, 15 : i32 -> i17
    %174 = llhd.insert_slice %1, %173, 0 : i32, i17
    %175 = llhd.extract_slice %174, 0 : i32 -> i5
    llhd.drv %rs1, %175 after %20 : !llhd.sig<i5>
    %176 = llhd.extract_slice %15, 0 : i32 -> i5
    llhd.drv %rs2, %176 after %20 : !llhd.sig<i5>
    %177 = llhd.extract_element %gpr_raddr, 0 : !llhd.sig<!llhd.array<2xi5>> -> !llhd.sig<i5>
    llhd.drv %177, %rs1.prb after %20 : !llhd.sig<i5>
    %178 = llhd.const 1 : i32
    %179 = llhd.array_uniform %3 : !llhd.array<2xi5>
    %180 = llhd.sig "180" %179 : !llhd.array<2xi5>
    %181 = llhd.shr %gpr_raddr, %180, %178 : (!llhd.sig<!llhd.array<2xi5>>, !llhd.sig<!llhd.array<2xi5>>, i32) -> !llhd.sig<!llhd.array<2xi5>>
    %182 = llhd.extract_element %181, 0 : !llhd.sig<!llhd.array<2xi5>> -> !llhd.sig<i5>
    llhd.drv %182, %rs2.prb after %20 : !llhd.sig<i5>
    %shift_left.prb = llhd.prb %shift_left : !llhd.sig<i1>
    %183 = llhd.neq %shift_left.prb, %0 : i1
    %shift_opa_reversed.prb = llhd.prb %shift_opa_reversed : !llhd.sig<i32>
    %opa.prb = llhd.prb %opa : !llhd.sig<i32>
    %184 = llhd.array %opa.prb, %shift_opa_reversed.prb : !llhd.array<2xi32>
    %185 = llhd.dyn_extract_element %184, %183 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %shift_opa, %185 after %20 : !llhd.sig<i32>
    %shift_opa.prb = llhd.prb %shift_opa : !llhd.sig<i32>
    %186 = llhd.insert_slice %2, %shift_opa.prb, 0 : i33, i32
    %187 = llhd.extract_slice %shift_opa.prb, 31 : i32 -> i1
    %188 = llhd.insert_slice %1, %187, 0 : i32, i1
    %189 = llhd.extract_slice %188, 0 : i32 -> i1
    %shift_arithmetic.prb = llhd.prb %shift_arithmetic : !llhd.sig<i1>
    %190 = llhd.and %189, %shift_arithmetic.prb : i1
    %concat10 = llhd.insert_slice %186, %190, 32 : i33, i1
    llhd.drv %shift_opa_ext, %concat10 after %20 : !llhd.sig<i33>
    %shift_opa_ext.prb = llhd.prb %shift_opa_ext : !llhd.sig<i33>
    %opb.prb = llhd.prb %opb : !llhd.sig<i32>
    %191 = llhd.extract_slice %opb.prb, 0 : i32 -> i5
    %192 = llhd.shr %shift_opa_ext.prb, %2, %191 : (i33, i33, i5) -> i33
    llhd.drv %shift_right_result_ext, %192 after %20 : !llhd.sig<i33>
    %shift_right_result_ext.prb = llhd.prb %shift_right_result_ext : !llhd.sig<i33>
    %193 = llhd.extract_slice %shift_right_result_ext.prb, 0 : i33 -> i32
    llhd.drv %shift_right_result, %193 after %20 : !llhd.sig<i32>
    %alu_opa.prb = llhd.prb %alu_opa : !llhd.sig<i33>
    %alu_opb.prb = llhd.prb %alu_opb : !llhd.sig<i33>
    %194 = addi %alu_opa.prb, %alu_opb.prb : i33
    llhd.drv %adder_result, %194 after %20 : !llhd.sig<i33>
    %is_load.prb = llhd.prb %is_load : !llhd.sig<i1>
    %is_store.prb = llhd.prb %is_store : !llhd.sig<i1>
    %195 = llhd.or %is_load.prb, %is_store.prb : i1
    %196 = llhd.and %valid_instr.prb, %195 : i1
    llhd.drv %lsu_qvalid, %196 after %20 : !llhd.sig<i1>
    %write_rd.prb = llhd.prb %write_rd : !llhd.sig<i1>
    %197 = llhd.and %write_rd.prb, %valid_instr.prb : i1
    %zext = llhd.insert_slice %1, %rd.prb, 0 : i32, i5
    %198 = llhd.neq %zext, %1 : i32
    %199 = llhd.and %197, %198 : i1
    llhd.drv %retire_i, %199 after %20 : !llhd.sig<i1>
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %200 = llhd.sig "200" %0 : i1
    llhd.drv %200, %clk_i.prb after %20 : !llhd.sig<i1>
    %gpr_raddr.prb = llhd.prb %gpr_raddr : !llhd.sig<!llhd.array<2xi5>>
    %201 = llhd.sig "201" %179 : !llhd.array<2xi5>
    llhd.drv %201, %gpr_raddr.prb after %20 : !llhd.sig<!llhd.array<2xi5>>
    %gpr_waddr.prb = llhd.prb %gpr_waddr : !llhd.sig<!llhd.array<1xi5>>
    %202 = llhd.array_uniform %3 : !llhd.array<1xi5>
    %203 = llhd.sig "203" %202 : !llhd.array<1xi5>
    llhd.drv %203, %gpr_waddr.prb after %20 : !llhd.sig<!llhd.array<1xi5>>
    %gpr_wdata.prb = llhd.prb %gpr_wdata : !llhd.sig<!llhd.array<1xi32>>
    %204 = llhd.array_uniform %1 : !llhd.array<1xi32>
    %205 = llhd.sig "205" %204 : !llhd.array<1xi32>
    llhd.drv %205, %gpr_wdata.prb after %20 : !llhd.sig<!llhd.array<1xi32>>
    %gpr_we.prb = llhd.prb %gpr_we : !llhd.sig<i1>
    %206 = llhd.sig "206" %0 : i1
    llhd.drv %206, %gpr_we.prb after %20 : !llhd.sig<i1>
    llhd.inst "inst" @snitch_regfile.param3(%200, %201, %203, %205, %206) -> (%gpr_rdata) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<2xi5>>, !llhd.sig<!llhd.array<1xi5>>, !llhd.sig<!llhd.array<1xi32>>, !llhd.sig<i1>) -> (!llhd.sig<!llhd.array<2xi32>>)
    %207 = llhd.sig "207" %0 : i1
    llhd.drv %207, %clk_i.prb after %20 : !llhd.sig<i1>
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %208 = llhd.sig "208" %0 : i1
    llhd.drv %208, %rst_i.prb after %20 : !llhd.sig<i1>
    %209 = llhd.sig "209" %3 : i5
    llhd.drv %209, %rd.prb after %20 : !llhd.sig<i5>
    %210 = llhd.sig "210" %0 : i1
    llhd.drv %210, %is_store.prb after %20 : !llhd.sig<i1>
    %is_signed.prb = llhd.prb %is_signed : !llhd.sig<i1>
    %211 = llhd.sig "211" %0 : i1
    llhd.drv %211, %is_signed.prb after %20 : !llhd.sig<i1>
    %212 = llhd.sig "212" %1 : i32
    llhd.drv %212, %alu_result.prb after %20 : !llhd.sig<i32>
    %concat11 = llhd.insert_slice %101, %1, 32 : i64, i32
    %213 = llhd.sig "213" %10 : i64
    llhd.drv %213, %concat11 after %20 : !llhd.sig<i64>
    %ls_size.prb = llhd.prb %ls_size : !llhd.sig<i2>
    %214 = llhd.sig "214" %8 : i2
    llhd.drv %214, %ls_size.prb after %20 : !llhd.sig<i2>
    %ls_amo.prb = llhd.prb %ls_amo : !llhd.sig<i4>
    %215 = llhd.sig "215" %9 : i4
    llhd.drv %215, %ls_amo.prb after %20 : !llhd.sig<i4>
    %216 = llhd.sig "216" %0 : i1
    llhd.drv %216, %lsu_qvalid.prb after %20 : !llhd.sig<i1>
    %lsu_pready.prb = llhd.prb %lsu_pready : !llhd.sig<i1>
    %217 = llhd.sig "217" %0 : i1
    llhd.drv %217, %lsu_pready.prb after %20 : !llhd.sig<i1>
    %data_qready_i.prb = llhd.prb %data_qready_i : !llhd.sig<i1>
    %218 = llhd.sig "218" %0 : i1
    llhd.drv %218, %data_qready_i.prb after %20 : !llhd.sig<i1>
    %data_pdata_i.prb = llhd.prb %data_pdata_i : !llhd.sig<i64>
    %219 = llhd.sig "219" %10 : i64
    llhd.drv %219, %data_pdata_i.prb after %20 : !llhd.sig<i64>
    %data_perror_i.prb = llhd.prb %data_perror_i : !llhd.sig<i1>
    %220 = llhd.sig "220" %0 : i1
    llhd.drv %220, %data_perror_i.prb after %20 : !llhd.sig<i1>
    %data_pvalid_i.prb = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %221 = llhd.sig "221" %0 : i1
    llhd.drv %221, %data_pvalid_i.prb after %20 : !llhd.sig<i1>
    %i_snitch_lsu.lsu_perror_o.default = llhd.sig "i_snitch_lsu.lsu_perror_o.default" %0 : i1
    llhd.inst "inst1" @snitch_lsu.param5(%207, %208, %209, %210, %211, %212, %213, %214, %215, %216, %217, %218, %219, %220, %221) -> (%lsu_qready, %ld_result, %lsu_rd, %i_snitch_lsu.lsu_perror_o.default, %lsu_pvalid, %data_qaddr_o, %data_qwrite_o, %data_qamo_o, %data_qdata_o, %data_qstrb_o, %data_qvalid_o, %data_pready_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i64>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i64>, !llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i1>)
    %222 = llhd.extract_slice %shift_opa_reversed, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %223 = llhd.extract_slice %opa.prb, 31 : i32 -> i1
    %224 = llhd.insert_slice %1, %223, 0 : i32, i1
    %225 = llhd.extract_slice %224, 0 : i32 -> i1
    llhd.drv %222, %225 after %20 : !llhd.sig<i1>
    %226 = llhd.extract_slice %shift_left_result, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result.prb = llhd.prb %shift_right_result : !llhd.sig<i32>
    %227 = llhd.extract_slice %shift_right_result.prb, 31 : i32 -> i1
    %228 = llhd.insert_slice %1, %227, 0 : i32, i1
    %229 = llhd.extract_slice %228, 0 : i32 -> i1
    llhd.drv %226, %229 after %20 : !llhd.sig<i1>
    %230 = llhd.sig "230" %1 : i32
    %231 = llhd.shr %shift_opa_reversed, %230, %178 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %232 = llhd.extract_slice %231, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %233 = llhd.extract_slice %opa.prb, 30 : i32 -> i2
    %234 = llhd.insert_slice %1, %233, 0 : i32, i2
    %235 = llhd.extract_slice %234, 0 : i32 -> i1
    llhd.drv %232, %235 after %20 : !llhd.sig<i1>
    %236 = llhd.sig "236" %1 : i32
    %237 = llhd.shr %shift_left_result, %236, %178 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %238 = llhd.extract_slice %237, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %239 = llhd.extract_slice %shift_right_result.prb, 30 : i32 -> i2
    %240 = llhd.insert_slice %1, %239, 0 : i32, i2
    %241 = llhd.extract_slice %240, 0 : i32 -> i1
    llhd.drv %238, %241 after %20 : !llhd.sig<i1>
    %242 = llhd.const 2 : i32
    %243 = llhd.sig "243" %1 : i32
    %244 = llhd.shr %shift_opa_reversed, %243, %242 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %245 = llhd.extract_slice %244, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %246 = llhd.extract_slice %opa.prb, 29 : i32 -> i3
    %247 = llhd.insert_slice %1, %246, 0 : i32, i3
    %248 = llhd.extract_slice %247, 0 : i32 -> i1
    llhd.drv %245, %248 after %20 : !llhd.sig<i1>
    %249 = llhd.sig "249" %1 : i32
    %250 = llhd.shr %shift_left_result, %249, %242 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %251 = llhd.extract_slice %250, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %252 = llhd.extract_slice %shift_right_result.prb, 29 : i32 -> i3
    %253 = llhd.insert_slice %1, %252, 0 : i32, i3
    %254 = llhd.extract_slice %253, 0 : i32 -> i1
    llhd.drv %251, %254 after %20 : !llhd.sig<i1>
    %255 = llhd.const 3 : i32
    %256 = llhd.sig "256" %1 : i32
    %257 = llhd.shr %shift_opa_reversed, %256, %255 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %258 = llhd.extract_slice %257, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %259 = llhd.extract_slice %opa.prb, 28 : i32 -> i4
    %260 = llhd.insert_slice %1, %259, 0 : i32, i4
    %261 = llhd.extract_slice %260, 0 : i32 -> i1
    llhd.drv %258, %261 after %20 : !llhd.sig<i1>
    %262 = llhd.sig "262" %1 : i32
    %263 = llhd.shr %shift_left_result, %262, %255 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %264 = llhd.extract_slice %263, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %265 = llhd.extract_slice %shift_right_result.prb, 28 : i32 -> i4
    %266 = llhd.insert_slice %1, %265, 0 : i32, i4
    %267 = llhd.extract_slice %266, 0 : i32 -> i1
    llhd.drv %264, %267 after %20 : !llhd.sig<i1>
    %268 = llhd.sig "268" %1 : i32
    %269 = llhd.shr %shift_opa_reversed, %268, %169 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %270 = llhd.extract_slice %269, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %271 = llhd.extract_slice %opa.prb, 27 : i32 -> i5
    %272 = llhd.insert_slice %1, %271, 0 : i32, i5
    %273 = llhd.extract_slice %272, 0 : i32 -> i1
    llhd.drv %270, %273 after %20 : !llhd.sig<i1>
    %274 = llhd.sig "274" %1 : i32
    %275 = llhd.shr %shift_left_result, %274, %169 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %276 = llhd.extract_slice %275, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %277 = llhd.extract_slice %shift_right_result.prb, 27 : i32 -> i5
    %278 = llhd.insert_slice %1, %277, 0 : i32, i5
    %279 = llhd.extract_slice %278, 0 : i32 -> i1
    llhd.drv %276, %279 after %20 : !llhd.sig<i1>
    %280 = llhd.const 5 : i32
    %281 = llhd.sig "281" %1 : i32
    %282 = llhd.shr %shift_opa_reversed, %281, %280 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %283 = llhd.extract_slice %282, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %284 = llhd.extract_slice %opa.prb, 26 : i32 -> i6
    %285 = llhd.insert_slice %1, %284, 0 : i32, i6
    %286 = llhd.extract_slice %285, 0 : i32 -> i1
    llhd.drv %283, %286 after %20 : !llhd.sig<i1>
    %287 = llhd.sig "287" %1 : i32
    %288 = llhd.shr %shift_left_result, %287, %280 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %289 = llhd.extract_slice %288, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %290 = llhd.extract_slice %shift_right_result.prb, 26 : i32 -> i6
    %291 = llhd.insert_slice %1, %290, 0 : i32, i6
    %292 = llhd.extract_slice %291, 0 : i32 -> i1
    llhd.drv %289, %292 after %20 : !llhd.sig<i1>
    %293 = llhd.const 6 : i32
    %294 = llhd.sig "294" %1 : i32
    %295 = llhd.shr %shift_opa_reversed, %294, %293 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %296 = llhd.extract_slice %295, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %297 = llhd.extract_slice %opa.prb, 25 : i32 -> i7
    %298 = llhd.insert_slice %1, %297, 0 : i32, i7
    %299 = llhd.extract_slice %298, 0 : i32 -> i1
    llhd.drv %296, %299 after %20 : !llhd.sig<i1>
    %300 = llhd.sig "300" %1 : i32
    %301 = llhd.shr %shift_left_result, %300, %293 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %302 = llhd.extract_slice %301, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %303 = llhd.extract_slice %shift_right_result.prb, 25 : i32 -> i7
    %304 = llhd.insert_slice %1, %303, 0 : i32, i7
    %305 = llhd.extract_slice %304, 0 : i32 -> i1
    llhd.drv %302, %305 after %20 : !llhd.sig<i1>
    %306 = llhd.const 7 : i32
    %307 = llhd.sig "307" %1 : i32
    %308 = llhd.shr %shift_opa_reversed, %307, %306 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %309 = llhd.extract_slice %308, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %310 = llhd.extract_slice %opa.prb, 24 : i32 -> i8
    %311 = llhd.insert_slice %1, %310, 0 : i32, i8
    %312 = llhd.extract_slice %311, 0 : i32 -> i1
    llhd.drv %309, %312 after %20 : !llhd.sig<i1>
    %313 = llhd.sig "313" %1 : i32
    %314 = llhd.shr %shift_left_result, %313, %306 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %315 = llhd.extract_slice %314, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %316 = llhd.extract_slice %shift_right_result.prb, 24 : i32 -> i8
    %317 = llhd.insert_slice %1, %316, 0 : i32, i8
    %318 = llhd.extract_slice %317, 0 : i32 -> i1
    llhd.drv %315, %318 after %20 : !llhd.sig<i1>
    %319 = llhd.const 8 : i32
    %320 = llhd.sig "320" %1 : i32
    %321 = llhd.shr %shift_opa_reversed, %320, %319 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %322 = llhd.extract_slice %321, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %323 = llhd.extract_slice %opa.prb, 23 : i32 -> i9
    %324 = llhd.insert_slice %1, %323, 0 : i32, i9
    %325 = llhd.extract_slice %324, 0 : i32 -> i1
    llhd.drv %322, %325 after %20 : !llhd.sig<i1>
    %326 = llhd.sig "326" %1 : i32
    %327 = llhd.shr %shift_left_result, %326, %319 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %328 = llhd.extract_slice %327, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %329 = llhd.extract_slice %shift_right_result.prb, 23 : i32 -> i9
    %330 = llhd.insert_slice %1, %329, 0 : i32, i9
    %331 = llhd.extract_slice %330, 0 : i32 -> i1
    llhd.drv %328, %331 after %20 : !llhd.sig<i1>
    %332 = llhd.const 9 : i32
    %333 = llhd.sig "333" %1 : i32
    %334 = llhd.shr %shift_opa_reversed, %333, %332 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %335 = llhd.extract_slice %334, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %336 = llhd.extract_slice %opa.prb, 22 : i32 -> i10
    %337 = llhd.insert_slice %1, %336, 0 : i32, i10
    %338 = llhd.extract_slice %337, 0 : i32 -> i1
    llhd.drv %335, %338 after %20 : !llhd.sig<i1>
    %339 = llhd.sig "339" %1 : i32
    %340 = llhd.shr %shift_left_result, %339, %332 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %341 = llhd.extract_slice %340, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %342 = llhd.extract_slice %shift_right_result.prb, 22 : i32 -> i10
    %343 = llhd.insert_slice %1, %342, 0 : i32, i10
    %344 = llhd.extract_slice %343, 0 : i32 -> i1
    llhd.drv %341, %344 after %20 : !llhd.sig<i1>
    %345 = llhd.const 10 : i32
    %346 = llhd.sig "346" %1 : i32
    %347 = llhd.shr %shift_opa_reversed, %346, %345 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %348 = llhd.extract_slice %347, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %349 = llhd.extract_slice %opa.prb, 21 : i32 -> i11
    %350 = llhd.insert_slice %1, %349, 0 : i32, i11
    %351 = llhd.extract_slice %350, 0 : i32 -> i1
    llhd.drv %348, %351 after %20 : !llhd.sig<i1>
    %352 = llhd.sig "352" %1 : i32
    %353 = llhd.shr %shift_left_result, %352, %345 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %354 = llhd.extract_slice %353, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %355 = llhd.extract_slice %shift_right_result.prb, 21 : i32 -> i11
    %356 = llhd.insert_slice %1, %355, 0 : i32, i11
    %357 = llhd.extract_slice %356, 0 : i32 -> i1
    llhd.drv %354, %357 after %20 : !llhd.sig<i1>
    %358 = llhd.const 11 : i32
    %359 = llhd.sig "359" %1 : i32
    %360 = llhd.shr %shift_opa_reversed, %359, %358 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %361 = llhd.extract_slice %360, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %362 = llhd.extract_slice %opa.prb, 20 : i32 -> i12
    %363 = llhd.insert_slice %1, %362, 0 : i32, i12
    %364 = llhd.extract_slice %363, 0 : i32 -> i1
    llhd.drv %361, %364 after %20 : !llhd.sig<i1>
    %365 = llhd.sig "365" %1 : i32
    %366 = llhd.shr %shift_left_result, %365, %358 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %367 = llhd.extract_slice %366, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %368 = llhd.extract_slice %shift_right_result.prb, 20 : i32 -> i12
    %369 = llhd.insert_slice %1, %368, 0 : i32, i12
    %370 = llhd.extract_slice %369, 0 : i32 -> i1
    llhd.drv %367, %370 after %20 : !llhd.sig<i1>
    %371 = llhd.const 12 : i32
    %372 = llhd.sig "372" %1 : i32
    %373 = llhd.shr %shift_opa_reversed, %372, %371 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %374 = llhd.extract_slice %373, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %375 = llhd.extract_slice %opa.prb, 19 : i32 -> i13
    %376 = llhd.insert_slice %1, %375, 0 : i32, i13
    %377 = llhd.extract_slice %376, 0 : i32 -> i1
    llhd.drv %374, %377 after %20 : !llhd.sig<i1>
    %378 = llhd.sig "378" %1 : i32
    %379 = llhd.shr %shift_left_result, %378, %371 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %380 = llhd.extract_slice %379, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %381 = llhd.extract_slice %shift_right_result.prb, 19 : i32 -> i13
    %382 = llhd.insert_slice %1, %381, 0 : i32, i13
    %383 = llhd.extract_slice %382, 0 : i32 -> i1
    llhd.drv %380, %383 after %20 : !llhd.sig<i1>
    %384 = llhd.const 13 : i32
    %385 = llhd.sig "385" %1 : i32
    %386 = llhd.shr %shift_opa_reversed, %385, %384 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %387 = llhd.extract_slice %386, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %388 = llhd.extract_slice %opa.prb, 18 : i32 -> i14
    %389 = llhd.insert_slice %1, %388, 0 : i32, i14
    %390 = llhd.extract_slice %389, 0 : i32 -> i1
    llhd.drv %387, %390 after %20 : !llhd.sig<i1>
    %391 = llhd.sig "391" %1 : i32
    %392 = llhd.shr %shift_left_result, %391, %384 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %393 = llhd.extract_slice %392, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %394 = llhd.extract_slice %shift_right_result.prb, 18 : i32 -> i14
    %395 = llhd.insert_slice %1, %394, 0 : i32, i14
    %396 = llhd.extract_slice %395, 0 : i32 -> i1
    llhd.drv %393, %396 after %20 : !llhd.sig<i1>
    %397 = llhd.const 14 : i32
    %398 = llhd.sig "398" %1 : i32
    %399 = llhd.shr %shift_opa_reversed, %398, %397 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %400 = llhd.extract_slice %399, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %401 = llhd.extract_slice %opa.prb, 17 : i32 -> i15
    %402 = llhd.insert_slice %1, %401, 0 : i32, i15
    %403 = llhd.extract_slice %402, 0 : i32 -> i1
    llhd.drv %400, %403 after %20 : !llhd.sig<i1>
    %404 = llhd.sig "404" %1 : i32
    %405 = llhd.shr %shift_left_result, %404, %397 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %406 = llhd.extract_slice %405, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %407 = llhd.extract_slice %shift_right_result.prb, 17 : i32 -> i15
    %408 = llhd.insert_slice %1, %407, 0 : i32, i15
    %409 = llhd.extract_slice %408, 0 : i32 -> i1
    llhd.drv %406, %409 after %20 : !llhd.sig<i1>
    %410 = llhd.const 15 : i32
    %411 = llhd.sig "411" %1 : i32
    %412 = llhd.shr %shift_opa_reversed, %411, %410 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %413 = llhd.extract_slice %412, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %414 = llhd.extract_slice %opa.prb, 16 : i32 -> i16
    %415 = llhd.insert_slice %1, %414, 0 : i32, i16
    %416 = llhd.extract_slice %415, 0 : i32 -> i1
    llhd.drv %413, %416 after %20 : !llhd.sig<i1>
    %417 = llhd.sig "417" %1 : i32
    %418 = llhd.shr %shift_left_result, %417, %410 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %419 = llhd.extract_slice %418, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %420 = llhd.extract_slice %shift_right_result.prb, 16 : i32 -> i16
    %421 = llhd.insert_slice %1, %420, 0 : i32, i16
    %422 = llhd.extract_slice %421, 0 : i32 -> i1
    llhd.drv %419, %422 after %20 : !llhd.sig<i1>
    %423 = llhd.const 16 : i32
    %424 = llhd.sig "424" %1 : i32
    %425 = llhd.shr %shift_opa_reversed, %424, %423 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %426 = llhd.extract_slice %425, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %427 = llhd.extract_slice %opa.prb, 15 : i32 -> i17
    %428 = llhd.insert_slice %1, %427, 0 : i32, i17
    %429 = llhd.extract_slice %428, 0 : i32 -> i1
    llhd.drv %426, %429 after %20 : !llhd.sig<i1>
    %430 = llhd.sig "430" %1 : i32
    %431 = llhd.shr %shift_left_result, %430, %423 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %432 = llhd.extract_slice %431, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %433 = llhd.extract_slice %shift_right_result.prb, 15 : i32 -> i17
    %434 = llhd.insert_slice %1, %433, 0 : i32, i17
    %435 = llhd.extract_slice %434, 0 : i32 -> i1
    llhd.drv %432, %435 after %20 : !llhd.sig<i1>
    %436 = llhd.const 17 : i32
    %437 = llhd.sig "437" %1 : i32
    %438 = llhd.shr %shift_opa_reversed, %437, %436 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %439 = llhd.extract_slice %438, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %440 = llhd.extract_slice %opa.prb, 14 : i32 -> i18
    %441 = llhd.insert_slice %1, %440, 0 : i32, i18
    %442 = llhd.extract_slice %441, 0 : i32 -> i1
    llhd.drv %439, %442 after %20 : !llhd.sig<i1>
    %443 = llhd.sig "443" %1 : i32
    %444 = llhd.shr %shift_left_result, %443, %436 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %445 = llhd.extract_slice %444, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %446 = llhd.extract_slice %shift_right_result.prb, 14 : i32 -> i18
    %447 = llhd.insert_slice %1, %446, 0 : i32, i18
    %448 = llhd.extract_slice %447, 0 : i32 -> i1
    llhd.drv %445, %448 after %20 : !llhd.sig<i1>
    %449 = llhd.const 18 : i32
    %450 = llhd.sig "450" %1 : i32
    %451 = llhd.shr %shift_opa_reversed, %450, %449 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %452 = llhd.extract_slice %451, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %453 = llhd.extract_slice %opa.prb, 13 : i32 -> i19
    %454 = llhd.insert_slice %1, %453, 0 : i32, i19
    %455 = llhd.extract_slice %454, 0 : i32 -> i1
    llhd.drv %452, %455 after %20 : !llhd.sig<i1>
    %456 = llhd.sig "456" %1 : i32
    %457 = llhd.shr %shift_left_result, %456, %449 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %458 = llhd.extract_slice %457, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %459 = llhd.extract_slice %shift_right_result.prb, 13 : i32 -> i19
    %460 = llhd.insert_slice %1, %459, 0 : i32, i19
    %461 = llhd.extract_slice %460, 0 : i32 -> i1
    llhd.drv %458, %461 after %20 : !llhd.sig<i1>
    %462 = llhd.const 19 : i32
    %463 = llhd.sig "463" %1 : i32
    %464 = llhd.shr %shift_opa_reversed, %463, %462 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %465 = llhd.extract_slice %464, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %466 = llhd.extract_slice %opa.prb, 12 : i32 -> i20
    %467 = llhd.insert_slice %1, %466, 0 : i32, i20
    %468 = llhd.extract_slice %467, 0 : i32 -> i1
    llhd.drv %465, %468 after %20 : !llhd.sig<i1>
    %469 = llhd.sig "469" %1 : i32
    %470 = llhd.shr %shift_left_result, %469, %462 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %471 = llhd.extract_slice %470, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %472 = llhd.extract_slice %shift_right_result.prb, 12 : i32 -> i20
    %473 = llhd.insert_slice %1, %472, 0 : i32, i20
    %474 = llhd.extract_slice %473, 0 : i32 -> i1
    llhd.drv %471, %474 after %20 : !llhd.sig<i1>
    %475 = llhd.const 20 : i32
    %476 = llhd.sig "476" %1 : i32
    %477 = llhd.shr %shift_opa_reversed, %476, %475 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %478 = llhd.extract_slice %477, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %479 = llhd.extract_slice %opa.prb, 11 : i32 -> i21
    %480 = llhd.insert_slice %1, %479, 0 : i32, i21
    %481 = llhd.extract_slice %480, 0 : i32 -> i1
    llhd.drv %478, %481 after %20 : !llhd.sig<i1>
    %482 = llhd.sig "482" %1 : i32
    %483 = llhd.shr %shift_left_result, %482, %475 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %484 = llhd.extract_slice %483, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %485 = llhd.extract_slice %shift_right_result.prb, 11 : i32 -> i21
    %486 = llhd.insert_slice %1, %485, 0 : i32, i21
    %487 = llhd.extract_slice %486, 0 : i32 -> i1
    llhd.drv %484, %487 after %20 : !llhd.sig<i1>
    %488 = llhd.const 21 : i32
    %489 = llhd.sig "489" %1 : i32
    %490 = llhd.shr %shift_opa_reversed, %489, %488 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %491 = llhd.extract_slice %490, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %492 = llhd.extract_slice %opa.prb, 10 : i32 -> i22
    %493 = llhd.insert_slice %1, %492, 0 : i32, i22
    %494 = llhd.extract_slice %493, 0 : i32 -> i1
    llhd.drv %491, %494 after %20 : !llhd.sig<i1>
    %495 = llhd.sig "495" %1 : i32
    %496 = llhd.shr %shift_left_result, %495, %488 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %497 = llhd.extract_slice %496, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %498 = llhd.extract_slice %shift_right_result.prb, 10 : i32 -> i22
    %499 = llhd.insert_slice %1, %498, 0 : i32, i22
    %500 = llhd.extract_slice %499, 0 : i32 -> i1
    llhd.drv %497, %500 after %20 : !llhd.sig<i1>
    %501 = llhd.const 22 : i32
    %502 = llhd.sig "502" %1 : i32
    %503 = llhd.shr %shift_opa_reversed, %502, %501 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %504 = llhd.extract_slice %503, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %505 = llhd.extract_slice %opa.prb, 9 : i32 -> i23
    %506 = llhd.insert_slice %1, %505, 0 : i32, i23
    %507 = llhd.extract_slice %506, 0 : i32 -> i1
    llhd.drv %504, %507 after %20 : !llhd.sig<i1>
    %508 = llhd.sig "508" %1 : i32
    %509 = llhd.shr %shift_left_result, %508, %501 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %510 = llhd.extract_slice %509, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %511 = llhd.extract_slice %shift_right_result.prb, 9 : i32 -> i23
    %512 = llhd.insert_slice %1, %511, 0 : i32, i23
    %513 = llhd.extract_slice %512, 0 : i32 -> i1
    llhd.drv %510, %513 after %20 : !llhd.sig<i1>
    %514 = llhd.const 23 : i32
    %515 = llhd.sig "515" %1 : i32
    %516 = llhd.shr %shift_opa_reversed, %515, %514 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %517 = llhd.extract_slice %516, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %518 = llhd.extract_slice %opa.prb, 8 : i32 -> i24
    %519 = llhd.insert_slice %1, %518, 0 : i32, i24
    %520 = llhd.extract_slice %519, 0 : i32 -> i1
    llhd.drv %517, %520 after %20 : !llhd.sig<i1>
    %521 = llhd.sig "521" %1 : i32
    %522 = llhd.shr %shift_left_result, %521, %514 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %523 = llhd.extract_slice %522, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %524 = llhd.extract_slice %shift_right_result.prb, 8 : i32 -> i24
    %525 = llhd.insert_slice %1, %524, 0 : i32, i24
    %526 = llhd.extract_slice %525, 0 : i32 -> i1
    llhd.drv %523, %526 after %20 : !llhd.sig<i1>
    %527 = llhd.const 24 : i32
    %528 = llhd.sig "528" %1 : i32
    %529 = llhd.shr %shift_opa_reversed, %528, %527 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %530 = llhd.extract_slice %529, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %531 = llhd.extract_slice %opa.prb, 7 : i32 -> i25
    %532 = llhd.insert_slice %1, %531, 0 : i32, i25
    %533 = llhd.extract_slice %532, 0 : i32 -> i1
    llhd.drv %530, %533 after %20 : !llhd.sig<i1>
    %534 = llhd.sig "534" %1 : i32
    %535 = llhd.shr %shift_left_result, %534, %527 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %536 = llhd.extract_slice %535, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %537 = llhd.extract_slice %shift_right_result.prb, 7 : i32 -> i25
    %538 = llhd.insert_slice %1, %537, 0 : i32, i25
    %539 = llhd.extract_slice %538, 0 : i32 -> i1
    llhd.drv %536, %539 after %20 : !llhd.sig<i1>
    %540 = llhd.const 25 : i32
    %541 = llhd.sig "541" %1 : i32
    %542 = llhd.shr %shift_opa_reversed, %541, %540 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %543 = llhd.extract_slice %542, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %544 = llhd.extract_slice %opa.prb, 6 : i32 -> i26
    %545 = llhd.insert_slice %1, %544, 0 : i32, i26
    %546 = llhd.extract_slice %545, 0 : i32 -> i1
    llhd.drv %543, %546 after %20 : !llhd.sig<i1>
    %547 = llhd.sig "547" %1 : i32
    %548 = llhd.shr %shift_left_result, %547, %540 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %549 = llhd.extract_slice %548, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %550 = llhd.extract_slice %shift_right_result.prb, 6 : i32 -> i26
    %551 = llhd.insert_slice %1, %550, 0 : i32, i26
    %552 = llhd.extract_slice %551, 0 : i32 -> i1
    llhd.drv %549, %552 after %20 : !llhd.sig<i1>
    %553 = llhd.const 26 : i32
    %554 = llhd.sig "554" %1 : i32
    %555 = llhd.shr %shift_opa_reversed, %554, %553 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %556 = llhd.extract_slice %555, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %557 = llhd.extract_slice %opa.prb, 5 : i32 -> i27
    %558 = llhd.insert_slice %1, %557, 0 : i32, i27
    %559 = llhd.extract_slice %558, 0 : i32 -> i1
    llhd.drv %556, %559 after %20 : !llhd.sig<i1>
    %560 = llhd.sig "560" %1 : i32
    %561 = llhd.shr %shift_left_result, %560, %553 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %562 = llhd.extract_slice %561, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %563 = llhd.extract_slice %shift_right_result.prb, 5 : i32 -> i27
    %564 = llhd.insert_slice %1, %563, 0 : i32, i27
    %565 = llhd.extract_slice %564, 0 : i32 -> i1
    llhd.drv %562, %565 after %20 : !llhd.sig<i1>
    %566 = llhd.const 27 : i32
    %567 = llhd.sig "567" %1 : i32
    %568 = llhd.shr %shift_opa_reversed, %567, %566 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %569 = llhd.extract_slice %568, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %570 = llhd.extract_slice %opa.prb, 4 : i32 -> i28
    %571 = llhd.insert_slice %1, %570, 0 : i32, i28
    %572 = llhd.extract_slice %571, 0 : i32 -> i1
    llhd.drv %569, %572 after %20 : !llhd.sig<i1>
    %573 = llhd.sig "573" %1 : i32
    %574 = llhd.shr %shift_left_result, %573, %566 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %575 = llhd.extract_slice %574, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %576 = llhd.extract_slice %shift_right_result.prb, 4 : i32 -> i28
    %577 = llhd.insert_slice %1, %576, 0 : i32, i28
    %578 = llhd.extract_slice %577, 0 : i32 -> i1
    llhd.drv %575, %578 after %20 : !llhd.sig<i1>
    %579 = llhd.const 28 : i32
    %580 = llhd.sig "580" %1 : i32
    %581 = llhd.shr %shift_opa_reversed, %580, %579 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %582 = llhd.extract_slice %581, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %583 = llhd.extract_slice %opa.prb, 3 : i32 -> i29
    %584 = llhd.insert_slice %1, %583, 0 : i32, i29
    %585 = llhd.extract_slice %584, 0 : i32 -> i1
    llhd.drv %582, %585 after %20 : !llhd.sig<i1>
    %586 = llhd.sig "586" %1 : i32
    %587 = llhd.shr %shift_left_result, %586, %579 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %588 = llhd.extract_slice %587, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %589 = llhd.extract_slice %shift_right_result.prb, 3 : i32 -> i29
    %590 = llhd.insert_slice %1, %589, 0 : i32, i29
    %591 = llhd.extract_slice %590, 0 : i32 -> i1
    llhd.drv %588, %591 after %20 : !llhd.sig<i1>
    %592 = llhd.const 29 : i32
    %593 = llhd.sig "593" %1 : i32
    %594 = llhd.shr %shift_opa_reversed, %593, %592 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %595 = llhd.extract_slice %594, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %596 = llhd.extract_slice %opa.prb, 2 : i32 -> i30
    %597 = llhd.insert_slice %1, %596, 0 : i32, i30
    %598 = llhd.extract_slice %597, 0 : i32 -> i1
    llhd.drv %595, %598 after %20 : !llhd.sig<i1>
    %599 = llhd.sig "599" %1 : i32
    %600 = llhd.shr %shift_left_result, %599, %592 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %601 = llhd.extract_slice %600, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %602 = llhd.extract_slice %shift_right_result.prb, 2 : i32 -> i30
    %603 = llhd.insert_slice %1, %602, 0 : i32, i30
    %604 = llhd.extract_slice %603, 0 : i32 -> i1
    llhd.drv %601, %604 after %20 : !llhd.sig<i1>
    %605 = llhd.const 30 : i32
    %606 = llhd.sig "606" %1 : i32
    %607 = llhd.shr %shift_opa_reversed, %606, %605 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %608 = llhd.extract_slice %607, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %609 = llhd.extract_slice %opa.prb, 1 : i32 -> i31
    %610 = llhd.insert_slice %1, %609, 0 : i32, i31
    %611 = llhd.extract_slice %610, 0 : i32 -> i1
    llhd.drv %608, %611 after %20 : !llhd.sig<i1>
    %612 = llhd.sig "612" %1 : i32
    %613 = llhd.shr %shift_left_result, %612, %605 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %614 = llhd.extract_slice %613, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %615 = llhd.extract_slice %shift_right_result.prb, 1 : i32 -> i31
    %616 = llhd.insert_slice %1, %615, 0 : i32, i31
    %617 = llhd.extract_slice %616, 0 : i32 -> i1
    llhd.drv %614, %617 after %20 : !llhd.sig<i1>
    %618 = llhd.const 31 : i32
    %619 = llhd.sig "619" %1 : i32
    %620 = llhd.shr %shift_opa_reversed, %619, %618 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %621 = llhd.extract_slice %620, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %622 = llhd.extract_slice %opa.prb, 0 : i32 -> i1
    llhd.drv %621, %622 after %20 : !llhd.sig<i1>
    %623 = llhd.sig "623" %1 : i32
    %624 = llhd.shr %shift_left_result, %623, %618 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %625 = llhd.extract_slice %624, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %626 = llhd.extract_slice %shift_right_result.prb, 0 : i32 -> i1
    llhd.drv %625, %626 after %20 : !llhd.sig<i1>
    llhd.inst "inst2" @snitch.param1.always_ff.12501.1(%clk_i, %rst_i, %pc_d) -> (%pc_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst3" @snitch.param1.always_ff.12525.1(%clk_i, %rst_i, %wfi_d) -> (%wfi_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst4" @snitch.param1.always_ff.12549.1(%clk_i, %rst_i, %sb_d) -> (%sb_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst5" @snitch.param1.always_ff.12573.1(%clk_i, %rst_i, %fcsr_d) -> (%fcsr_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (!llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>)
    llhd.inst "inst6" @snitch.param1.always_comb.12607.1(%stall) -> (%core_events_o) : (!llhd.sig<i1>) -> (!llhd.sig<tuple<i1, i1, i1, i1>>)
    llhd.inst "inst7" @snitch.param1.always_comb.12929.1(%acc_pid_i, %rd, %stall, %sb_q, %is_load, %lsu_rd, %retire_load, %retire_acc, %acc_register_rd) -> (%sb_d) : (!llhd.sig<i5>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst8" @snitch.param1.always_comb.13188.1(%zero_lsb, %pc_q, %wfi_q, %consec_pc, %alu_result, %stall, %next_pc) -> (%pc_d) : (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i2>) -> (!llhd.sig<i32>)
    llhd.inst "inst9" @snitch.param1.always_comb.22810.1(%inst_data_i, %wake_up_sync_i, %wfi_q, %uimm, %valid_instr, %csr_rvalue) -> (%acc_qvalid_o, %illegal_inst, %zero_lsb, %wfi_d, %is_load, %is_store, %is_signed, %ls_size, %ls_amo, %alu_op, %opa_select, %opb_select, %write_rd, %uses_rd, %next_pc, %rd_select, %rd_bypass, %is_branch, %csr_en, %acc_register_rd) : (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i2>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst10" @snitch.param1.always_comb.23058.1(%hart_id_i, %inst_data_i, %fpu_status_i, %alu_result, %csr_en, %fcsr_q) -> (%csr_rvalue, %fcsr_d) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<tuple<i1, i1, i1, i1, i1>>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (!llhd.sig<i32>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>)
    llhd.inst "inst11" @snitch.param1.always_comb.23203.1(%uimm, %jimm, %rs1, %gpr_rdata, %opa_select) -> (%opa) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i5>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>) -> (!llhd.sig<i32>)
    llhd.inst "inst12" @snitch.param1.always_comb.23314.1(%pc_q, %iimm, %simm, %gpr_rdata, %opb_select, %csr_rvalue) -> (%opb) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst13" @snitch.param1.always_comb.24030.1(%opa, %opb, %adder_result, %alu_op, %shift_right_result, %shift_left_result) -> (%alu_result, %shift_left, %shift_arithmetic, %alu_opa, %alu_opb) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i33>, !llhd.sig<i4>, !llhd.sig<i32>, !llhd.sig<i32>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i33>, !llhd.sig<i33>)
    llhd.inst "inst14" @snitch.param1.always_comb.24258.1(%consec_pc, %alu_result, %rd_select, %rd_bypass) -> (%alu_writeback) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i2>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst15" @snitch.param1.always_comb.24550.1(%acc_pdata_i, %acc_pid_i, %acc_pvalid_i, %rd, %ld_result, %lsu_pvalid, %lsu_rd, %retire_i, %alu_writeback) -> (%acc_pready_o, %gpr_waddr, %gpr_wdata, %gpr_we, %lsu_pready, %retire_load, %retire_acc) : (!llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i1>, !llhd.sig<!llhd.array<1xi5>>, !llhd.sig<!llhd.array<1xi32>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @snitch_tb.always.27127.0(%clk_i: !llhd.sig<i1>, %data_qvalid_o: !llhd.sig<i1>, %data_qready_i: !llhd.sig<i1>, %data_pvalid_i: !llhd.sig<i1>, %data_pready_o: !llhd.sig<i1>) -> (%data_resp_pending: !llhd.sig<i32> ) {
    br ^init
^init:
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i.prb1 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %clk_i.prb, %0 : i1
    %2 = llhd.neq %clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %data_pvalid_i.prb = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %3 = llhd.neq %data_pvalid_i.prb, %0 : i1
    %data_pready_o.prb = llhd.prb %data_pready_o : !llhd.sig<i1>
    %4 = llhd.neq %data_pready_o.prb, %0 : i1
    %5 = llhd.and %3, %4 : i1
    %6 = llhd.neq %5, %0 : i1
    %data_resp_pending.prb = llhd.prb %data_resp_pending : !llhd.sig<i32>
    %7 = llhd.const 1 : i32
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    cond_br %6, ^if_true, ^if_exit
^if_exit:
    %data_qvalid_o.prb = llhd.prb %data_qvalid_o : !llhd.sig<i1>
    %9 = llhd.neq %data_qvalid_o.prb, %0 : i1
    %data_qready_i.prb = llhd.prb %data_qready_i : !llhd.sig<i1>
    %10 = llhd.neq %data_qready_i.prb, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = llhd.neq %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    %13 = subi %data_resp_pending.prb, %7 : i32
    llhd.drv %data_resp_pending, %13 after %8 : !llhd.sig<i32>
    br ^if_exit
^if_true1:
    %14 = addi %data_resp_pending.prb, %7 : i32
    llhd.drv %data_resp_pending, %14 after %8 : !llhd.sig<i32>
    br ^init
}

llhd.proc @snitch_tb.initial.27237.0() -> (%clk_i: !llhd.sig<i1> , %rst_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 1 : i1
    %2 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_i, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %1 after %3 : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.const #llhd.time<3ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %4 after %5 : !llhd.sig<i1>
    %6 = llhd.const #llhd.time<4ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_i, %4 after %6 : !llhd.sig<i1>
    %7 = llhd.const #llhd.time<5ns, 0d, 0e> : !llhd.time
    llhd.wait  for %7, ^8
^8:
    %9 = llhd.const 1000000 : i32
    br ^loop_body(%9, %9 : i32, i32)
^loop_body(%10: i32, %11: i32):
    %12 = llhd.const 0 : i32
    %13 = llhd.neq %10, %12 : i32
    %14 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %13, ^loop_continue, ^loop_exit
^15:
    br ^loop_body(%10, %11 : i32, i32)
^loop_exit:
    llhd.wait  for %14, ^16
^loop_continue:
    %17 = llhd.const 1 : i1
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %clk_i, %17 after %18 : !llhd.sig<i1>
    llhd.wait  for %14, ^19
^16:
    llhd.halt
^19:
    %20 = llhd.const 0 : i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %clk_i, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %22, ^15
}

llhd.entity @snitch_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %rst_i = llhd.sig "rst_i" %0 : i1
    %1 = llhd.const 0 : i32
    %inst_addr_o = llhd.sig "inst_addr_o" %1 : i32
    %inst_data_i = llhd.sig "inst_data_i" %1 : i32
    %inst_valid_o = llhd.sig "inst_valid_o" %0 : i1
    %inst_ready_i = llhd.sig "inst_ready_i" %0 : i1
    %data_qaddr_o = llhd.sig "data_qaddr_o" %1 : i32
    %data_qwrite_o = llhd.sig "data_qwrite_o" %0 : i1
    %2 = llhd.const 0 : i4
    %data_qamo_o = llhd.sig "data_qamo_o" %2 : i4
    %3 = llhd.const 0 : i64
    %data_qdata_o = llhd.sig "data_qdata_o" %3 : i64
    %4 = llhd.const 0 : i8
    %data_qstrb_o = llhd.sig "data_qstrb_o" %4 : i8
    %data_qvalid_o = llhd.sig "data_qvalid_o" %0 : i1
    %data_qready_i = llhd.sig "data_qready_i" %0 : i1
    %data_pdata_i = llhd.sig "data_pdata_i" %3 : i64
    %data_perror_i = llhd.sig "data_perror_i" %0 : i1
    %data_pvalid_i = llhd.sig "data_pvalid_i" %0 : i1
    %data_pready_o = llhd.sig "data_pready_o" %0 : i1
    %5 = llhd.array %1, %1, %1, %1, %1, %1, %1, %1, %1, %1, %1, %1, %1, %1, %1, %1 : !llhd.array<16xi32>
    %PROGRAM = llhd.sig "PROGRAM" %5 : !llhd.array<16xi32>
    %data_resp_pending = llhd.sig "data_resp_pending" %1 : i32
    %6 = llhd.const 1048577811 : i32
    %7 = llhd.const 1050515 : i32
    %8 = llhd.const 1555 : i32
    %9 = llhd.const 3405649335 : i32
    %10 = llhd.const 16123571 : i32
    %11 = llhd.const 14000163 : i32
    %12 = llhd.const 4294379283 : i32
    %13 = llhd.const 493075 : i32
    %14 = llhd.const 427923 : i32
    %15 = llhd.const 4261877475 : i32
    %16 = llhd.const 273678451 : i32
    %17 = llhd.const 4292866159 : i32
    %18 = llhd.const 32871 : i32
    %19 = llhd.array %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %1, %1, %1 : !llhd.array<16xi32>
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %PROGRAM, %19 after %20 : !llhd.sig<!llhd.array<16xi32>>
    %PROGRAM.prb = llhd.prb %PROGRAM : !llhd.sig<!llhd.array<16xi32>>
    %inst_addr_o.prb = llhd.prb %inst_addr_o : !llhd.sig<i32>
    %21 = llhd.const 65536 : i32
    %22 = subi %inst_addr_o.prb, %21 : i32
    %23 = llhd.const 4 : i32
    %24 = divi_unsigned %22, %23 : i32
    %25 = llhd.array_uniform %1 : !llhd.array<16xi32>
    %26 = llhd.shr %PROGRAM.prb, %25, %24 : (!llhd.array<16xi32>, !llhd.array<16xi32>, i32) -> !llhd.array<16xi32>
    %27 = llhd.extract_element %26, 0 : !llhd.array<16xi32> -> i32
    llhd.drv %inst_data_i, %27 after %20 : !llhd.sig<i32>
    %28 = llhd.const 1 : i1
    llhd.drv %inst_ready_i, %28 after %20 : !llhd.sig<i1>
    llhd.drv %data_qready_i, %28 after %20 : !llhd.sig<i1>
    %29 = llhd.const 3735931568 : i64
    llhd.drv %data_pdata_i, %29 after %20 : !llhd.sig<i64>
    llhd.drv %data_perror_i, %0 after %20 : !llhd.sig<i1>
    %data_resp_pending.prb = llhd.prb %data_resp_pending : !llhd.sig<i32>
    %30 = cmpi "sgt", %data_resp_pending.prb, %1 : i32
    llhd.drv %data_pvalid_i, %30 after %20 : !llhd.sig<i1>
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %31 = llhd.sig "31" %0 : i1
    llhd.drv %31, %clk_i.prb after %20 : !llhd.sig<i1>
    %rst_i.prb = llhd.prb %rst_i : !llhd.sig<i1>
    %32 = llhd.sig "32" %0 : i1
    llhd.drv %32, %rst_i.prb after %20 : !llhd.sig<i1>
    %33 = llhd.const 66 : i32
    %34 = llhd.sig "34" %1 : i32
    llhd.drv %34, %33 after %20 : !llhd.sig<i32>
    %inst_data_i.prb = llhd.prb %inst_data_i : !llhd.sig<i32>
    %35 = llhd.sig "35" %1 : i32
    llhd.drv %35, %inst_data_i.prb after %20 : !llhd.sig<i32>
    %inst_ready_i.prb = llhd.prb %inst_ready_i : !llhd.sig<i1>
    %36 = llhd.sig "36" %0 : i1
    llhd.drv %36, %inst_ready_i.prb after %20 : !llhd.sig<i1>
    %i_snitch.acc_qready_i.default = llhd.sig "i_snitch.acc_qready_i.default" %0 : i1
    %i_snitch.acc_pdata_i.default = llhd.sig "i_snitch.acc_pdata_i.default" %3 : i64
    %37 = llhd.const 0 : i5
    %i_snitch.acc_pid_i.default = llhd.sig "i_snitch.acc_pid_i.default" %37 : i5
    %i_snitch.acc_perror_i.default = llhd.sig "i_snitch.acc_perror_i.default" %0 : i1
    %i_snitch.acc_pvalid_i.default = llhd.sig "i_snitch.acc_pvalid_i.default" %0 : i1
    %data_qready_i.prb = llhd.prb %data_qready_i : !llhd.sig<i1>
    %38 = llhd.sig "38" %0 : i1
    llhd.drv %38, %data_qready_i.prb after %20 : !llhd.sig<i1>
    %data_pdata_i.prb = llhd.prb %data_pdata_i : !llhd.sig<i64>
    %39 = llhd.sig "39" %3 : i64
    llhd.drv %39, %data_pdata_i.prb after %20 : !llhd.sig<i64>
    %data_perror_i.prb = llhd.prb %data_perror_i : !llhd.sig<i1>
    %40 = llhd.sig "40" %0 : i1
    llhd.drv %40, %data_perror_i.prb after %20 : !llhd.sig<i1>
    %data_pvalid_i.prb = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %41 = llhd.sig "41" %0 : i1
    llhd.drv %41, %data_pvalid_i.prb after %20 : !llhd.sig<i1>
    %i_snitch.wake_up_sync_i.default = llhd.sig "i_snitch.wake_up_sync_i.default" %0 : i1
    %42 = llhd.tuple %0, %0, %0, %0, %0 : tuple<i1, i1, i1, i1, i1>
    %i_snitch.fpu_status_i.default = llhd.sig "i_snitch.fpu_status_i.default" %42 : tuple<i1, i1, i1, i1, i1>
    %i_snitch.acc_qaddr_o.default = llhd.sig "i_snitch.acc_qaddr_o.default" %1 : i32
    %i_snitch.acc_qid_o.default = llhd.sig "i_snitch.acc_qid_o.default" %37 : i5
    %i_snitch.acc_qdata_op_o.default = llhd.sig "i_snitch.acc_qdata_op_o.default" %1 : i32
    %i_snitch.acc_qdata_arga_o.default = llhd.sig "i_snitch.acc_qdata_arga_o.default" %3 : i64
    %i_snitch.acc_qdata_argb_o.default = llhd.sig "i_snitch.acc_qdata_argb_o.default" %3 : i64
    %i_snitch.acc_qdata_argc_o.default = llhd.sig "i_snitch.acc_qdata_argc_o.default" %3 : i64
    %i_snitch.acc_qvalid_o.default = llhd.sig "i_snitch.acc_qvalid_o.default" %0 : i1
    %i_snitch.acc_pready_o.default = llhd.sig "i_snitch.acc_pready_o.default" %0 : i1
    %43 = llhd.const 0 : i3
    %i_snitch.fpu_rnd_mode_o.default = llhd.sig "i_snitch.fpu_rnd_mode_o.default" %43 : i3
    %44 = llhd.tuple %0, %0, %0, %0 : tuple<i1, i1, i1, i1>
    %i_snitch.core_events_o.default = llhd.sig "i_snitch.core_events_o.default" %44 : tuple<i1, i1, i1, i1>
    llhd.inst "inst" @snitch.param1(%31, %32, %34, %35, %36, %i_snitch.acc_qready_i.default, %i_snitch.acc_pdata_i.default, %i_snitch.acc_pid_i.default, %i_snitch.acc_perror_i.default, %i_snitch.acc_pvalid_i.default, %38, %39, %40, %41, %i_snitch.wake_up_sync_i.default, %i_snitch.fpu_status_i.default) -> (%inst_addr_o, %inst_valid_o, %i_snitch.acc_qaddr_o.default, %i_snitch.acc_qid_o.default, %i_snitch.acc_qdata_op_o.default, %i_snitch.acc_qdata_arga_o.default, %i_snitch.acc_qdata_argb_o.default, %i_snitch.acc_qdata_argc_o.default, %i_snitch.acc_qvalid_o.default, %i_snitch.acc_pready_o.default, %data_qaddr_o, %data_qwrite_o, %data_qamo_o, %data_qdata_o, %data_qstrb_o, %data_qvalid_o, %data_pready_o, %i_snitch.fpu_rnd_mode_o.default, %i_snitch.core_events_o.default) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i1, i1, i1, i1, i1>>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i5>, !llhd.sig<i32>, !llhd.sig<i64>, !llhd.sig<i64>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i64>, !llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<tuple<i1, i1, i1, i1>>)
    llhd.inst "inst1" @snitch_tb.always.27127.0(%clk_i, %data_qvalid_o, %data_qready_i, %data_pvalid_i, %data_pready_o) -> (%data_resp_pending) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst2" @snitch_tb.initial.27237.0() -> (%clk_i, %rst_i) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
