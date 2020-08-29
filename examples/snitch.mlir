llhd.proc @snitch_regfile.param2.always_comb.1766.2(%waddr_i: !llhd.sig<!llhd.array<1xi5>>, %we_i: !llhd.sig<i1>) -> (%we_dec: !llhd.sig<!llhd.array<1xi32>> ) {
    br ^0
^0:
    br ^body
^body:
    %1 = llhd.const 0 : i32
    %j = llhd.var %1 : i32
    br ^loop_body
^loop_body:
    %j1 = llhd.load %j : !llhd.ptr<i32>
    %2 = llhd.const 1 : i32
    %3 = cmpi "slt", %j1, %2 : i32
    cond_br %3, ^loop_continue, ^loop_exit
^check:
    llhd.wait (%waddr_i, %we_i : !llhd.sig<!llhd.array<1xi5>>, !llhd.sig<i1>), ^body
^loop_exit:
    br ^check
^loop_continue:
    %4 = llhd.const 0 : i32
    %i = llhd.var %4 : i32
    br ^loop_body1
^loop_body1:
    %i1 = llhd.load %i : !llhd.ptr<i32>
    %5 = llhd.const 32 : i32
    %6 = cmpi "slt", %i1, %5 : i32
    cond_br %6, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %j2 = llhd.load %j : !llhd.ptr<i32>
    %7 = llhd.const 1 : i32
    %8 = addi %j2, %7 : i32
    llhd.store %j, %8 : !llhd.ptr<i32>
    %j3 = llhd.load %j : !llhd.ptr<i32>
    %9 = llhd.const 0 : i32
    %10 = llhd.neq %j3, %9 : i32
    br ^loop_body
^loop_continue1:
    %11 = llhd.const 0 : i32
    %waddr_i1 = llhd.prb %waddr_i : !llhd.sig<!llhd.array<1xi5>>
    %j4 = llhd.load %j : !llhd.ptr<i32>
    %12 = llhd.const 0 : i5
    %13 = llhd.array_uniform %12 : !llhd.array<1xi5>
    %14 = llhd.shr %waddr_i1, %13, %j4 : (!llhd.array<1xi5>, !llhd.array<1xi5>, i32) -> !llhd.array<1xi5>
    %15 = llhd.extract_element %14, 0 : !llhd.array<1xi5> -> i5
    %16 = llhd.insert_slice %11, %15, 0 : i32, i5
    %i2 = llhd.load %i : !llhd.ptr<i32>
    %17 = llhd.eq %16, %i2 : i32
    cond_br %17, ^if_true, ^if_false
^if_false:
    %j7 = llhd.load %j : !llhd.ptr<i32>
    %18 = llhd.const 0 : i32
    %19 = llhd.array_uniform %18 : !llhd.array<1xi32>
    %20 = llhd.dyn_extract_element %we_dec, %j7 : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %i4 = llhd.load %i : !llhd.ptr<i32>
    %21 = llhd.const 0 : i32
    %22 = llhd.dyn_extract_slice %20, %i4 : (!llhd.sig<i32>, i32) -> !llhd.sig<i1>
    %23 = llhd.const 0 : i1
    %24 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %22, %23 after %24 : !llhd.sig<i1>
    br ^if_exit
^if_true:
    %j5 = llhd.load %j : !llhd.ptr<i32>
    %25 = llhd.const 0 : i32
    %26 = llhd.array_uniform %25 : !llhd.array<1xi32>
    %27 = llhd.dyn_extract_element %we_dec, %j5 : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %i3 = llhd.load %i : !llhd.ptr<i32>
    %28 = llhd.const 0 : i32
    %29 = llhd.dyn_extract_slice %27, %i3 : (!llhd.sig<i32>, i32) -> !llhd.sig<i1>
    %we_i1 = llhd.prb %we_i : !llhd.sig<i1>
    %j6 = llhd.load %j : !llhd.ptr<i32>
    %30 = llhd.const 0 : i1
    %31 = llhd.shr %we_i1, %30, %j6 : (i1, i1, i32) -> i1
    %32 = llhd.extract_slice %31, 0 : i1 -> i1
    %33 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %29, %32 after %33 : !llhd.sig<i1>
    br ^if_exit
^if_exit:
    %i5 = llhd.load %i : !llhd.ptr<i32>
    %34 = llhd.const 1 : i32
    %35 = addi %i5, %34 : i32
    llhd.store %i, %35 : !llhd.ptr<i32>
    %i6 = llhd.load %i : !llhd.ptr<i32>
    %36 = llhd.const 0 : i32
    %37 = llhd.neq %i6, %36 : i32
    br ^loop_body1
}

llhd.proc @snitch_regfile.param2.always_ff.1767.2(%clk_i: !llhd.sig<i1>, %wdata_i: !llhd.sig<!llhd.array<1xi32>>, %we_dec: !llhd.sig<!llhd.array<1xi32>>) -> (%mem: !llhd.sig<!llhd.array<32xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %4 = llhd.const 0 : i32
    %j = llhd.var %4 : i32
    br ^loop_body
^loop_body:
    %j1 = llhd.load %j : !llhd.ptr<i32>
    %5 = llhd.const 1 : i32
    %6 = cmpi "slt", %j1, %5 : i32
    cond_br %6, ^loop_continue, ^loop_exit
^loop_exit:
    br ^0
^loop_continue:
    %7 = llhd.const 0 : i32
    %i = llhd.var %7 : i32
    br ^loop_body1
^loop_body1:
    %i1 = llhd.load %i : !llhd.ptr<i32>
    %8 = llhd.const 32 : i32
    %9 = cmpi "slt", %i1, %8 : i32
    cond_br %9, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %10 = llhd.const 1 : i32
    %11 = llhd.const 0 : i32
    %12 = llhd.neq %10, %11 : i32
    cond_br %12, ^if_true, ^if_false
^loop_continue1:
    %we_dec1 = llhd.prb %we_dec : !llhd.sig<!llhd.array<1xi32>>
    %j2 = llhd.load %j : !llhd.ptr<i32>
    %13 = llhd.const 0 : i32
    %14 = llhd.array_uniform %13 : !llhd.array<1xi32>
    %15 = llhd.shr %we_dec1, %14, %j2 : (!llhd.array<1xi32>, !llhd.array<1xi32>, i32) -> !llhd.array<1xi32>
    %16 = llhd.extract_element %15, 0 : !llhd.array<1xi32> -> i32
    %i2 = llhd.load %i : !llhd.ptr<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.shr %16, %17, %i2 : (i32, i32, i32) -> i32
    %19 = llhd.extract_slice %18, 0 : i32 -> i1
    cond_br %19, ^if_true1, ^if_false1
^if_false:
    br ^if_exit1
^if_true:
    %20 = llhd.const 0 : i32
    %21 = llhd.const 0 : i32
    %22 = llhd.array_uniform %21 : !llhd.array<32xi32>
    %23 = llhd.dyn_extract_element %mem, %20 : (!llhd.sig<!llhd.array<32xi32>>, i32) -> !llhd.sig<i32>
    %24 = llhd.const 0 : i32
    %25 = llhd.const 0 : i1
    %26 = llhd.insert_slice %24, %25, 0 : i32, i1
    %27 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %23, %26 after %27 : !llhd.sig<i32>
    br ^if_exit1
^if_false1:
    br ^if_exit
^if_true1:
    %i3 = llhd.load %i : !llhd.ptr<i32>
    %28 = llhd.const 0 : i32
    %29 = llhd.array_uniform %28 : !llhd.array<32xi32>
    %30 = llhd.dyn_extract_element %mem, %i3 : (!llhd.sig<!llhd.array<32xi32>>, i32) -> !llhd.sig<i32>
    %wdata_i1 = llhd.prb %wdata_i : !llhd.sig<!llhd.array<1xi32>>
    %j3 = llhd.load %j : !llhd.ptr<i32>
    %31 = llhd.const 0 : i32
    %32 = llhd.array_uniform %31 : !llhd.array<1xi32>
    %33 = llhd.shr %wdata_i1, %32, %j3 : (!llhd.array<1xi32>, !llhd.array<1xi32>, i32) -> !llhd.array<1xi32>
    %34 = llhd.extract_element %33, 0 : !llhd.array<1xi32> -> i32
    %35 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %30, %34 after %35 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    %i4 = llhd.load %i : !llhd.ptr<i32>
    %36 = llhd.const 1 : i32
    %37 = addi %i4, %36 : i32
    llhd.store %i, %37 : !llhd.ptr<i32>
    %i5 = llhd.load %i : !llhd.ptr<i32>
    %38 = llhd.const 0 : i32
    %39 = llhd.neq %i5, %38 : i32
    br ^loop_body1
^if_exit1:
    %j4 = llhd.load %j : !llhd.ptr<i32>
    %40 = llhd.const 1 : i32
    %41 = addi %j4, %40 : i32
    llhd.store %j, %41 : !llhd.ptr<i32>
    %j5 = llhd.load %j : !llhd.ptr<i32>
    %42 = llhd.const 0 : i32
    %43 = llhd.neq %j5, %42 : i32
    br ^loop_body
}

llhd.entity @snitch_regfile.param2(%clk_i: !llhd.sig<i1>, %raddr_i: !llhd.sig<!llhd.array<2xi5>>, %waddr_i: !llhd.sig<!llhd.array<1xi5>>, %wdata_i: !llhd.sig<!llhd.array<1xi32>>, %we_i: !llhd.sig<i1>) -> (%rdata_o: !llhd.sig<!llhd.array<2xi32>> ) {
    %0 = llhd.const 0 : i32
    %1 = llhd.const 0 : i32
    %2 = llhd.const 0 : i32
    %3 = llhd.const 0 : i32
    %4 = llhd.const 0 : i32
    %5 = llhd.const 0 : i32
    %6 = llhd.const 0 : i32
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
    %23 = llhd.const 0 : i32
    %24 = llhd.const 0 : i32
    %25 = llhd.const 0 : i32
    %26 = llhd.const 0 : i32
    %27 = llhd.const 0 : i32
    %28 = llhd.const 0 : i32
    %29 = llhd.const 0 : i32
    %30 = llhd.const 0 : i32
    %31 = llhd.const 0 : i32
    %32 = llhd.array %0, %1, %2, %3, %4, %5, %6, %7, %8, %9, %10, %11, %12, %13, %14, %15, %16, %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31 : !llhd.array<32xi32>
    %mem = llhd.sig "mem" %32 : !llhd.array<32xi32>
    %33 = llhd.const 0 : i32
    %34 = llhd.array %33 : !llhd.array<1xi32>
    %we_dec = llhd.sig "we_dec" %34 : !llhd.array<1xi32>
    %35 = llhd.const 0 : i32
    %36 = llhd.const 0 : i32
    %37 = llhd.array_uniform %36 : !llhd.array<2xi32>
    %38 = llhd.sig "38" %37 : !llhd.array<2xi32>
    %39 = llhd.shr %rdata_o, %38, %35 : (!llhd.sig<!llhd.array<2xi32>>, !llhd.sig<!llhd.array<2xi32>>, i32) -> !llhd.sig<!llhd.array<2xi32>>
    %40 = llhd.extract_element %39, 0 : !llhd.sig<!llhd.array<2xi32>> -> !llhd.sig<i32>
    %mem1 = llhd.prb %mem : !llhd.sig<!llhd.array<32xi32>>
    %raddr_i1 = llhd.prb %raddr_i : !llhd.sig<!llhd.array<2xi5>>
    %41 = llhd.const 0 : i32
    %42 = llhd.const 0 : i5
    %43 = llhd.array_uniform %42 : !llhd.array<2xi5>
    %44 = llhd.shr %raddr_i1, %43, %41 : (!llhd.array<2xi5>, !llhd.array<2xi5>, i32) -> !llhd.array<2xi5>
    %45 = llhd.extract_element %44, 0 : !llhd.array<2xi5> -> i5
    %46 = llhd.const 0 : i32
    %47 = llhd.array_uniform %46 : !llhd.array<32xi32>
    %48 = llhd.shr %mem1, %47, %45 : (!llhd.array<32xi32>, !llhd.array<32xi32>, i5) -> !llhd.array<32xi32>
    %49 = llhd.extract_element %48, 0 : !llhd.array<32xi32> -> i32
    %50 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %40, %49 after %50 : !llhd.sig<i32>
    %51 = llhd.const 1 : i32
    %52 = llhd.const 0 : i32
    %53 = llhd.array_uniform %52 : !llhd.array<2xi32>
    %54 = llhd.sig "54" %53 : !llhd.array<2xi32>
    %55 = llhd.shr %rdata_o, %54, %51 : (!llhd.sig<!llhd.array<2xi32>>, !llhd.sig<!llhd.array<2xi32>>, i32) -> !llhd.sig<!llhd.array<2xi32>>
    %56 = llhd.extract_element %55, 0 : !llhd.sig<!llhd.array<2xi32>> -> !llhd.sig<i32>
    %mem2 = llhd.prb %mem : !llhd.sig<!llhd.array<32xi32>>
    %raddr_i2 = llhd.prb %raddr_i : !llhd.sig<!llhd.array<2xi5>>
    %57 = llhd.const 1 : i32
    %58 = llhd.const 0 : i5
    %59 = llhd.array_uniform %58 : !llhd.array<2xi5>
    %60 = llhd.shr %raddr_i2, %59, %57 : (!llhd.array<2xi5>, !llhd.array<2xi5>, i32) -> !llhd.array<2xi5>
    %61 = llhd.extract_element %60, 0 : !llhd.array<2xi5> -> i5
    %62 = llhd.const 0 : i32
    %63 = llhd.array_uniform %62 : !llhd.array<32xi32>
    %64 = llhd.shr %mem2, %63, %61 : (!llhd.array<32xi32>, !llhd.array<32xi32>, i5) -> !llhd.array<32xi32>
    %65 = llhd.extract_element %64, 0 : !llhd.array<32xi32> -> i32
    %66 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %56, %65 after %66 : !llhd.sig<i32>
    llhd.inst "inst" @snitch_regfile.param2.always_comb.1766.2(%waddr_i, %we_i) -> (%we_dec) : (!llhd.sig<!llhd.array<1xi5>>, !llhd.sig<i1>) -> (!llhd.sig<!llhd.array<1xi32>>)
    llhd.inst "inst1" @snitch_regfile.param2.always_ff.1767.2(%clk_i, %wdata_i, %we_dec) -> (%mem) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<1xi32>>, !llhd.sig<!llhd.array<1xi32>>) -> (!llhd.sig<!llhd.array<32xi32>>)
    // %67 = llhd.const 0 : i32
    // %68 = llhd.const 0 : i32
    // %69 = llhd.array %67, %68 : !llhd.array<2xi32>
    // %70 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %rdata_o, %69 after %70 : !llhd.sig<!llhd.array<2xi32>>
}

llhd.proc @fifo_v3.param6.always_comb.2398.6(%full_o: !llhd.sig<i1>, %empty_o: !llhd.sig<i1>, %data_i: !llhd.sig<tuple<i5, i1, i3, i2>>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>, %read_pointer_n: !llhd.sig<i1>, %read_pointer_q: !llhd.sig<i1>, %write_pointer_q: !llhd.sig<i1>, %status_cnt_q: !llhd.sig<i2>, %mem_q: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (%data_o: !llhd.sig<tuple<i5, i1, i3, i2>> , %gate_clock: !llhd.sig<i1> , %read_pointer_n1: !llhd.sig<i1> , %write_pointer_n: !llhd.sig<i1> , %status_cnt_n: !llhd.sig<i2> , %mem_n: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>> ) {
    br ^0
^0:
    %1 = llhd.prb %read_pointer_n1 : !llhd.sig<i1>
    %read_pointer_n.shadow = llhd.var %1 : i1
    br ^body
^body:
    %2 = llhd.prb %read_pointer_n1 : !llhd.sig<i1>
    llhd.store %read_pointer_n.shadow, %2 : !llhd.ptr<i1>
    %read_pointer_q1 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %read_pointer_q1 after %3 : !llhd.sig<i1>
    llhd.store %read_pointer_n.shadow, %read_pointer_q1 : !llhd.ptr<i1>
    %write_pointer_q1 = llhd.prb %write_pointer_q : !llhd.sig<i1>
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %write_pointer_q1 after %4 : !llhd.sig<i1>
    %status_cnt_q1 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %status_cnt_q1 after %5 : !llhd.sig<i2>
    %6 = llhd.const 1 : i32
    %7 = llhd.const 0 : i32
    %8 = llhd.eq %6, %7 : i32
    %9 = llhd.const 0 : i11
    %data_i1 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %10 = llhd.extract_element %data_i1, 3 : tuple<i5, i1, i3, i2> -> i2
    %11 = llhd.insert_slice %9, %10, 0 : i11, i2
    %data_i2 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %12 = llhd.extract_element %data_i2, 2 : tuple<i5, i1, i3, i2> -> i3
    %13 = llhd.insert_slice %11, %12, 2 : i11, i3
    %data_i3 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %14 = llhd.extract_element %data_i3, 1 : tuple<i5, i1, i3, i2> -> i1
    %15 = llhd.insert_slice %13, %14, 5 : i11, i1
    %data_i4 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %16 = llhd.extract_element %data_i4, 0 : tuple<i5, i1, i3, i2> -> i5
    %17 = llhd.insert_slice %15, %16, 6 : i11, i5
    %18 = llhd.const 0 : i11
    %mem_q1 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q2 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %19 = llhd.const 0 : i5
    %20 = llhd.const 0 : i1
    %21 = llhd.const 0 : i3
    %22 = llhd.const 0 : i2
    %23 = llhd.tuple %19, %20, %21, %22 : tuple<i5, i1, i3, i2>
    %24 = llhd.array_uniform %23 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %25 = llhd.shr %mem_q1, %24, %read_pointer_q2 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %26 = llhd.extract_element %25, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %27 = llhd.extract_element %26, 3 : tuple<i5, i1, i3, i2> -> i2
    %28 = llhd.insert_slice %18, %27, 0 : i11, i2
    %mem_q2 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q3 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %29 = llhd.const 0 : i5
    %30 = llhd.const 0 : i1
    %31 = llhd.const 0 : i3
    %32 = llhd.const 0 : i2
    %33 = llhd.tuple %29, %30, %31, %32 : tuple<i5, i1, i3, i2>
    %34 = llhd.array_uniform %33 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %35 = llhd.shr %mem_q2, %34, %read_pointer_q3 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %36 = llhd.extract_element %35, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %37 = llhd.extract_element %36, 2 : tuple<i5, i1, i3, i2> -> i3
    %38 = llhd.insert_slice %28, %37, 2 : i11, i3
    %mem_q3 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q4 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %39 = llhd.const 0 : i5
    %40 = llhd.const 0 : i1
    %41 = llhd.const 0 : i3
    %42 = llhd.const 0 : i2
    %43 = llhd.tuple %39, %40, %41, %42 : tuple<i5, i1, i3, i2>
    %44 = llhd.array_uniform %43 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %45 = llhd.shr %mem_q3, %44, %read_pointer_q4 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %46 = llhd.extract_element %45, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %47 = llhd.extract_element %46, 1 : tuple<i5, i1, i3, i2> -> i1
    %48 = llhd.insert_slice %38, %47, 5 : i11, i1
    %mem_q4 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q5 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %49 = llhd.const 0 : i5
    %50 = llhd.const 0 : i1
    %51 = llhd.const 0 : i3
    %52 = llhd.const 0 : i2
    %53 = llhd.tuple %49, %50, %51, %52 : tuple<i5, i1, i3, i2>
    %54 = llhd.array_uniform %53 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %55 = llhd.shr %mem_q4, %54, %read_pointer_q5 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %56 = llhd.extract_element %55, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %57 = llhd.extract_element %56, 0 : tuple<i5, i1, i3, i2> -> i5
    %58 = llhd.insert_slice %48, %57, 6 : i11, i5
    %59 = llhd.array %58, %17 : !llhd.array<2xi11>
    %60 = llhd.dyn_extract_element %59, %8 : (!llhd.array<2xi11>, i1) -> i11
    %61 = llhd.const 0 : i32
    %62 = llhd.const 0 : i11
    %63 = llhd.shr %60, %62, %61 : (i11, i11, i32) -> i11
    %64 = llhd.extract_slice %63, 0 : i11 -> i5
    %65 = llhd.const 1 : i32
    %66 = llhd.const 0 : i32
    %67 = llhd.eq %65, %66 : i32
    %68 = llhd.const 0 : i11
    %data_i5 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %69 = llhd.extract_element %data_i5, 3 : tuple<i5, i1, i3, i2> -> i2
    %70 = llhd.insert_slice %68, %69, 0 : i11, i2
    %data_i6 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %71 = llhd.extract_element %data_i6, 2 : tuple<i5, i1, i3, i2> -> i3
    %72 = llhd.insert_slice %70, %71, 2 : i11, i3
    %data_i7 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %73 = llhd.extract_element %data_i7, 1 : tuple<i5, i1, i3, i2> -> i1
    %74 = llhd.insert_slice %72, %73, 5 : i11, i1
    %data_i8 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %75 = llhd.extract_element %data_i8, 0 : tuple<i5, i1, i3, i2> -> i5
    %76 = llhd.insert_slice %74, %75, 6 : i11, i5
    %77 = llhd.const 0 : i11
    %mem_q5 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q6 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %78 = llhd.const 0 : i5
    %79 = llhd.const 0 : i1
    %80 = llhd.const 0 : i3
    %81 = llhd.const 0 : i2
    %82 = llhd.tuple %78, %79, %80, %81 : tuple<i5, i1, i3, i2>
    %83 = llhd.array_uniform %82 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %84 = llhd.shr %mem_q5, %83, %read_pointer_q6 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %85 = llhd.extract_element %84, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %86 = llhd.extract_element %85, 3 : tuple<i5, i1, i3, i2> -> i2
    %87 = llhd.insert_slice %77, %86, 0 : i11, i2
    %mem_q6 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q7 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %88 = llhd.const 0 : i5
    %89 = llhd.const 0 : i1
    %90 = llhd.const 0 : i3
    %91 = llhd.const 0 : i2
    %92 = llhd.tuple %88, %89, %90, %91 : tuple<i5, i1, i3, i2>
    %93 = llhd.array_uniform %92 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %94 = llhd.shr %mem_q6, %93, %read_pointer_q7 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %95 = llhd.extract_element %94, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %96 = llhd.extract_element %95, 2 : tuple<i5, i1, i3, i2> -> i3
    %97 = llhd.insert_slice %87, %96, 2 : i11, i3
    %mem_q7 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q8 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %98 = llhd.const 0 : i5
    %99 = llhd.const 0 : i1
    %100 = llhd.const 0 : i3
    %101 = llhd.const 0 : i2
    %102 = llhd.tuple %98, %99, %100, %101 : tuple<i5, i1, i3, i2>
    %103 = llhd.array_uniform %102 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %104 = llhd.shr %mem_q7, %103, %read_pointer_q8 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %105 = llhd.extract_element %104, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %106 = llhd.extract_element %105, 1 : tuple<i5, i1, i3, i2> -> i1
    %107 = llhd.insert_slice %97, %106, 5 : i11, i1
    %mem_q8 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q9 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %108 = llhd.const 0 : i5
    %109 = llhd.const 0 : i1
    %110 = llhd.const 0 : i3
    %111 = llhd.const 0 : i2
    %112 = llhd.tuple %108, %109, %110, %111 : tuple<i5, i1, i3, i2>
    %113 = llhd.array_uniform %112 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %114 = llhd.shr %mem_q8, %113, %read_pointer_q9 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %115 = llhd.extract_element %114, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %116 = llhd.extract_element %115, 0 : tuple<i5, i1, i3, i2> -> i5
    %117 = llhd.insert_slice %107, %116, 6 : i11, i5
    %118 = llhd.array %117, %76 : !llhd.array<2xi11>
    %119 = llhd.dyn_extract_element %118, %67 : (!llhd.array<2xi11>, i1) -> i11
    %120 = llhd.const 5 : i32
    %121 = llhd.const 0 : i11
    %122 = llhd.shr %119, %121, %120 : (i11, i11, i32) -> i11
    %123 = llhd.extract_slice %122, 0 : i11 -> i1
    %124 = llhd.const 1 : i32
    %125 = llhd.const 0 : i32
    %126 = llhd.eq %124, %125 : i32
    %127 = llhd.const 0 : i11
    %data_i9 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %128 = llhd.extract_element %data_i9, 3 : tuple<i5, i1, i3, i2> -> i2
    %129 = llhd.insert_slice %127, %128, 0 : i11, i2
    %data_i10 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %130 = llhd.extract_element %data_i10, 2 : tuple<i5, i1, i3, i2> -> i3
    %131 = llhd.insert_slice %129, %130, 2 : i11, i3
    %data_i11 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %132 = llhd.extract_element %data_i11, 1 : tuple<i5, i1, i3, i2> -> i1
    %133 = llhd.insert_slice %131, %132, 5 : i11, i1
    %data_i12 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %134 = llhd.extract_element %data_i12, 0 : tuple<i5, i1, i3, i2> -> i5
    %135 = llhd.insert_slice %133, %134, 6 : i11, i5
    %136 = llhd.const 0 : i11
    %mem_q9 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q10 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %137 = llhd.const 0 : i5
    %138 = llhd.const 0 : i1
    %139 = llhd.const 0 : i3
    %140 = llhd.const 0 : i2
    %141 = llhd.tuple %137, %138, %139, %140 : tuple<i5, i1, i3, i2>
    %142 = llhd.array_uniform %141 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %143 = llhd.shr %mem_q9, %142, %read_pointer_q10 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %144 = llhd.extract_element %143, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %145 = llhd.extract_element %144, 3 : tuple<i5, i1, i3, i2> -> i2
    %146 = llhd.insert_slice %136, %145, 0 : i11, i2
    %mem_q10 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q11 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %147 = llhd.const 0 : i5
    %148 = llhd.const 0 : i1
    %149 = llhd.const 0 : i3
    %150 = llhd.const 0 : i2
    %151 = llhd.tuple %147, %148, %149, %150 : tuple<i5, i1, i3, i2>
    %152 = llhd.array_uniform %151 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %153 = llhd.shr %mem_q10, %152, %read_pointer_q11 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %154 = llhd.extract_element %153, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %155 = llhd.extract_element %154, 2 : tuple<i5, i1, i3, i2> -> i3
    %156 = llhd.insert_slice %146, %155, 2 : i11, i3
    %mem_q11 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q12 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %157 = llhd.const 0 : i5
    %158 = llhd.const 0 : i1
    %159 = llhd.const 0 : i3
    %160 = llhd.const 0 : i2
    %161 = llhd.tuple %157, %158, %159, %160 : tuple<i5, i1, i3, i2>
    %162 = llhd.array_uniform %161 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %163 = llhd.shr %mem_q11, %162, %read_pointer_q12 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %164 = llhd.extract_element %163, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %165 = llhd.extract_element %164, 1 : tuple<i5, i1, i3, i2> -> i1
    %166 = llhd.insert_slice %156, %165, 5 : i11, i1
    %mem_q12 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q13 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %167 = llhd.const 0 : i5
    %168 = llhd.const 0 : i1
    %169 = llhd.const 0 : i3
    %170 = llhd.const 0 : i2
    %171 = llhd.tuple %167, %168, %169, %170 : tuple<i5, i1, i3, i2>
    %172 = llhd.array_uniform %171 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %173 = llhd.shr %mem_q12, %172, %read_pointer_q13 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %174 = llhd.extract_element %173, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %175 = llhd.extract_element %174, 0 : tuple<i5, i1, i3, i2> -> i5
    %176 = llhd.insert_slice %166, %175, 6 : i11, i5
    %177 = llhd.array %176, %135 : !llhd.array<2xi11>
    %178 = llhd.dyn_extract_element %177, %126 : (!llhd.array<2xi11>, i1) -> i11
    %179 = llhd.const 6 : i32
    %180 = llhd.const 0 : i11
    %181 = llhd.shr %178, %180, %179 : (i11, i11, i32) -> i11
    %182 = llhd.extract_slice %181, 0 : i11 -> i3
    %183 = llhd.const 1 : i32
    %184 = llhd.const 0 : i32
    %185 = llhd.eq %183, %184 : i32
    %186 = llhd.const 0 : i11
    %data_i13 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %187 = llhd.extract_element %data_i13, 3 : tuple<i5, i1, i3, i2> -> i2
    %188 = llhd.insert_slice %186, %187, 0 : i11, i2
    %data_i14 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %189 = llhd.extract_element %data_i14, 2 : tuple<i5, i1, i3, i2> -> i3
    %190 = llhd.insert_slice %188, %189, 2 : i11, i3
    %data_i15 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %191 = llhd.extract_element %data_i15, 1 : tuple<i5, i1, i3, i2> -> i1
    %192 = llhd.insert_slice %190, %191, 5 : i11, i1
    %data_i16 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %193 = llhd.extract_element %data_i16, 0 : tuple<i5, i1, i3, i2> -> i5
    %194 = llhd.insert_slice %192, %193, 6 : i11, i5
    %195 = llhd.const 0 : i11
    %mem_q13 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q14 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %196 = llhd.const 0 : i5
    %197 = llhd.const 0 : i1
    %198 = llhd.const 0 : i3
    %199 = llhd.const 0 : i2
    %200 = llhd.tuple %196, %197, %198, %199 : tuple<i5, i1, i3, i2>
    %201 = llhd.array_uniform %200 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %202 = llhd.shr %mem_q13, %201, %read_pointer_q14 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %203 = llhd.extract_element %202, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %204 = llhd.extract_element %203, 3 : tuple<i5, i1, i3, i2> -> i2
    %205 = llhd.insert_slice %195, %204, 0 : i11, i2
    %mem_q14 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q15 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %206 = llhd.const 0 : i5
    %207 = llhd.const 0 : i1
    %208 = llhd.const 0 : i3
    %209 = llhd.const 0 : i2
    %210 = llhd.tuple %206, %207, %208, %209 : tuple<i5, i1, i3, i2>
    %211 = llhd.array_uniform %210 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %212 = llhd.shr %mem_q14, %211, %read_pointer_q15 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %213 = llhd.extract_element %212, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %214 = llhd.extract_element %213, 2 : tuple<i5, i1, i3, i2> -> i3
    %215 = llhd.insert_slice %205, %214, 2 : i11, i3
    %mem_q15 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q16 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %216 = llhd.const 0 : i5
    %217 = llhd.const 0 : i1
    %218 = llhd.const 0 : i3
    %219 = llhd.const 0 : i2
    %220 = llhd.tuple %216, %217, %218, %219 : tuple<i5, i1, i3, i2>
    %221 = llhd.array_uniform %220 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %222 = llhd.shr %mem_q15, %221, %read_pointer_q16 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %223 = llhd.extract_element %222, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %224 = llhd.extract_element %223, 1 : tuple<i5, i1, i3, i2> -> i1
    %225 = llhd.insert_slice %215, %224, 5 : i11, i1
    %mem_q16 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %read_pointer_q17 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %226 = llhd.const 0 : i5
    %227 = llhd.const 0 : i1
    %228 = llhd.const 0 : i3
    %229 = llhd.const 0 : i2
    %230 = llhd.tuple %226, %227, %228, %229 : tuple<i5, i1, i3, i2>
    %231 = llhd.array_uniform %230 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %232 = llhd.shr %mem_q16, %231, %read_pointer_q17 : (!llhd.array<1xtuple<i5, i1, i3, i2>>, !llhd.array<1xtuple<i5, i1, i3, i2>>, i1) -> !llhd.array<1xtuple<i5, i1, i3, i2>>
    %233 = llhd.extract_element %232, 0 : !llhd.array<1xtuple<i5, i1, i3, i2>> -> tuple<i5, i1, i3, i2>
    %234 = llhd.extract_element %233, 0 : tuple<i5, i1, i3, i2> -> i5
    %235 = llhd.insert_slice %225, %234, 6 : i11, i5
    %236 = llhd.array %235, %194 : !llhd.array<2xi11>
    %237 = llhd.dyn_extract_element %236, %185 : (!llhd.array<2xi11>, i1) -> i11
    %238 = llhd.const 9 : i32
    %239 = llhd.const 0 : i11
    %240 = llhd.shr %237, %239, %238 : (i11, i11, i32) -> i11
    %241 = llhd.extract_slice %240, 0 : i11 -> i2
    %242 = llhd.tuple %64, %123, %182, %241 : tuple<i5, i1, i3, i2>
    %243 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_o, %242 after %243 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %mem_q17 = llhd.prb %mem_q : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %244 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %mem_n, %mem_q17 after %244 : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %245 = llhd.const 1 : i1
    %246 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %gate_clock, %245 after %246 : !llhd.sig<i1>
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %full_o1 = llhd.prb %full_o : !llhd.sig<i1>
    %247 = llhd.not %full_o1 : i1
    %248 = llhd.and %push_i1, %247 : i1
    cond_br %248, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %write_pointer_q2 = llhd.prb %write_pointer_q : !llhd.sig<i1>
    %249 = llhd.const 0 : i5
    %250 = llhd.const 0 : i1
    %251 = llhd.const 0 : i3
    %252 = llhd.const 0 : i2
    %253 = llhd.tuple %249, %250, %251, %252 : tuple<i5, i1, i3, i2>
    %254 = llhd.array_uniform %253 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %255 = llhd.dyn_extract_element %mem_n, %write_pointer_q2 : (!llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>, i1) -> !llhd.sig<tuple<i5, i1, i3, i2>>
    %data_i17 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %256 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %255, %data_i17 after %256 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %257 = llhd.const 0 : i1
    %258 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %gate_clock, %257 after %258 : !llhd.sig<i1>
    %259 = llhd.const 0 : i32
    %write_pointer_q3 = llhd.prb %write_pointer_q : !llhd.sig<i1>
    %260 = llhd.insert_slice %259, %write_pointer_q3, 0 : i32, i1
    %261 = llhd.const 1 : i32
    %262 = llhd.const 0 : i1
    %263 = llhd.const 0 : i32
    %264 = llhd.shr %261, %263, %262 : (i32, i32, i1) -> i32
    %265 = llhd.extract_slice %264, 0 : i32 -> i1
    %266 = llhd.extract_slice %265, 0 : i1 -> i1
    %267 = llhd.const 0 : i32
    %268 = llhd.not %267 : i32
    %269 = llhd.array %267, %268 : !llhd.array<2xi32>
    %270 = llhd.dyn_extract_element %269, %266 : (!llhd.array<2xi32>, i1) -> i32
    %271 = llhd.insert_slice %270, %265, 0 : i32, i1
    %272 = llhd.const 1 : i32
    %273 = subi %271, %272 : i32
    %274 = llhd.eq %260, %273 : i32
    cond_br %274, ^if_true1, ^if_false1
^check:
    llhd.wait (%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_n1, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q : !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>), ^body
^if_false1:
    %275 = llhd.const 0 : i32
    %write_pointer_q4 = llhd.prb %write_pointer_q : !llhd.sig<i1>
    %276 = llhd.insert_slice %275, %write_pointer_q4, 0 : i32, i1
    %277 = llhd.const 1 : i32
    %278 = addi %276, %277 : i32
    %279 = llhd.extract_slice %278, 0 : i32 -> i1
    %280 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %279 after %280 : !llhd.sig<i1>
    br ^if_exit1
^if_true1:
    %281 = llhd.const 0 : i1
    %282 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %281 after %282 : !llhd.sig<i1>
    br ^if_exit1
^if_exit:
    %pop_i1 = llhd.prb %pop_i : !llhd.sig<i1>
    %empty_o1 = llhd.prb %empty_o : !llhd.sig<i1>
    %283 = llhd.not %empty_o1 : i1
    %284 = llhd.and %pop_i1, %283 : i1
    cond_br %284, ^if_true2, ^if_false2
^if_false2:
    br ^if_exit2
^if_true2:
    %285 = llhd.const 0 : i32
    %read_pointer_n2 = llhd.load %read_pointer_n.shadow : !llhd.ptr<i1>
    %286 = llhd.insert_slice %285, %read_pointer_n2, 0 : i32, i1
    %287 = llhd.const 1 : i32
    %288 = llhd.const 0 : i1
    %289 = llhd.const 0 : i32
    %290 = llhd.shr %287, %289, %288 : (i32, i32, i1) -> i32
    %291 = llhd.extract_slice %290, 0 : i32 -> i1
    %292 = llhd.extract_slice %291, 0 : i1 -> i1
    %293 = llhd.const 0 : i32
    %294 = llhd.not %293 : i32
    %295 = llhd.array %293, %294 : !llhd.array<2xi32>
    %296 = llhd.dyn_extract_element %295, %292 : (!llhd.array<2xi32>, i1) -> i32
    %297 = llhd.insert_slice %296, %291, 0 : i32, i1
    %298 = llhd.const 1 : i32
    %299 = subi %297, %298 : i32
    %300 = llhd.eq %286, %299 : i32
    cond_br %300, ^if_true3, ^if_false3
^if_exit1:
    %301 = llhd.const 0 : i32
    %status_cnt_q2 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %302 = llhd.insert_slice %301, %status_cnt_q2, 0 : i32, i2
    %303 = llhd.const 1 : i32
    %304 = addi %302, %303 : i32
    %305 = llhd.extract_slice %304, 0 : i32 -> i2
    %306 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %305 after %306 : !llhd.sig<i2>
    br ^if_exit
^if_false3:
    %307 = llhd.const 0 : i32
    %read_pointer_q18 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %308 = llhd.insert_slice %307, %read_pointer_q18, 0 : i32, i1
    %309 = llhd.const 1 : i32
    %310 = addi %308, %309 : i32
    %311 = llhd.extract_slice %310, 0 : i32 -> i1
    %312 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %311 after %312 : !llhd.sig<i1>
    llhd.store %read_pointer_n.shadow, %311 : !llhd.ptr<i1>
    br ^if_exit3
^if_true3:
    %313 = llhd.const 0 : i1
    %314 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %313 after %314 : !llhd.sig<i1>
    llhd.store %read_pointer_n.shadow, %313 : !llhd.ptr<i1>
    br ^if_exit3
^if_exit2:
    %push_i2 = llhd.prb %push_i : !llhd.sig<i1>
    %pop_i2 = llhd.prb %pop_i : !llhd.sig<i1>
    %315 = llhd.and %push_i2, %pop_i2 : i1
    %full_o2 = llhd.prb %full_o : !llhd.sig<i1>
    %316 = llhd.not %full_o2 : i1
    %317 = llhd.and %315, %316 : i1
    %empty_o2 = llhd.prb %empty_o : !llhd.sig<i1>
    %318 = llhd.not %empty_o2 : i1
    %319 = llhd.and %317, %318 : i1
    cond_br %319, ^if_true4, ^if_false4
^if_false4:
    br ^if_exit4
^if_true4:
    %status_cnt_q4 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %320 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %status_cnt_q4 after %320 : !llhd.sig<i2>
    br ^if_exit4
^if_exit3:
    %321 = llhd.const 0 : i32
    %status_cnt_q3 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %322 = llhd.insert_slice %321, %status_cnt_q3, 0 : i32, i2
    %323 = llhd.const 1 : i32
    %324 = subi %322, %323 : i32
    %325 = llhd.extract_slice %324, 0 : i32 -> i2
    %326 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %325 after %326 : !llhd.sig<i2>
    br ^if_exit2
^if_exit4:
    %327 = llhd.const 0 : i1
    %328 = llhd.const 0 : i32
    %status_cnt_q5 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %329 = llhd.insert_slice %328, %status_cnt_q5, 0 : i32, i2
    %330 = llhd.const 0 : i32
    %331 = llhd.eq %329, %330 : i32
    %332 = llhd.and %327, %331 : i1
    %push_i3 = llhd.prb %push_i : !llhd.sig<i1>
    %333 = llhd.and %332, %push_i3 : i1
    cond_br %333, ^if_true5, ^if_false5
^if_false5:
    br ^if_exit5
^if_true5:
    %data_i18 = llhd.prb %data_i : !llhd.sig<tuple<i5, i1, i3, i2>>
    %334 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_o, %data_i18 after %334 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %pop_i3 = llhd.prb %pop_i : !llhd.sig<i1>
    cond_br %pop_i3, ^if_true6, ^if_false6
^if_false6:
    br ^if_exit6
^if_true6:
    %status_cnt_q6 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %335 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %status_cnt_n, %status_cnt_q6 after %335 : !llhd.sig<i2>
    %read_pointer_q19 = llhd.prb %read_pointer_q : !llhd.sig<i1>
    %336 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %read_pointer_n1, %read_pointer_q19 after %336 : !llhd.sig<i1>
    llhd.store %read_pointer_n.shadow, %read_pointer_q19 : !llhd.ptr<i1>
    %write_pointer_q5 = llhd.prb %write_pointer_q : !llhd.sig<i1>
    %337 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_pointer_n, %write_pointer_q5 after %337 : !llhd.sig<i1>
    br ^if_exit6
^if_exit5:
    br ^check
^if_exit6:
    br ^if_exit5
}

llhd.proc @fifo_v3.param6.always_ff.2399.6(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %read_pointer_n: !llhd.sig<i1>, %write_pointer_n: !llhd.sig<i1>, %status_cnt_n: !llhd.sig<i2>) -> (%read_pointer_q: !llhd.sig<i1> , %write_pointer_q: !llhd.sig<i1> , %status_cnt_q: !llhd.sig<i2> ) {
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
    %8 = llhd.const 0 : i1
    %9 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %read_pointer_q, %8 after %9 : !llhd.sig<i1>
    %10 = llhd.const 0 : i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %write_pointer_q, %10 after %11 : !llhd.sig<i1>
    %12 = llhd.const 0 : i2
    %13 = llhd.const 0 : i1
    %14 = llhd.insert_slice %12, %13, 0 : i2, i1
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %status_cnt_q, %14 after %15 : !llhd.sig<i2>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    %read_pointer_n1 = llhd.prb %read_pointer_n : !llhd.sig<i1>
    %16 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %read_pointer_q, %read_pointer_n1 after %16 : !llhd.sig<i1>
    %write_pointer_n1 = llhd.prb %write_pointer_n : !llhd.sig<i1>
    %17 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %write_pointer_q, %write_pointer_n1 after %17 : !llhd.sig<i1>
    %status_cnt_n1 = llhd.prb %status_cnt_n : !llhd.sig<i2>
    %18 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %status_cnt_q, %status_cnt_n1 after %18 : !llhd.sig<i2>
    br ^if_exit1
^if_true1:
    %19 = llhd.const 0 : i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %read_pointer_q, %19 after %20 : !llhd.sig<i1>
    %21 = llhd.const 0 : i1
    %22 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %write_pointer_q, %21 after %22 : !llhd.sig<i1>
    %23 = llhd.const 0 : i2
    %24 = llhd.const 0 : i1
    %25 = llhd.insert_slice %23, %24, 0 : i2, i1
    %26 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %status_cnt_q, %25 after %26 : !llhd.sig<i2>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @fifo_v3.param6.always_ff.2400.6(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %gate_clock: !llhd.sig<i1>, %mem_n: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (%mem_q: !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>> ) {
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
    %9 = llhd.const 0 : i11
    %10 = llhd.const 0 : i1
    %11 = llhd.insert_slice %9, %10, 0 : i11, i1
    %12 = llhd.const 0 : i32
    %13 = llhd.const 0 : i11
    %14 = llhd.shr %11, %13, %12 : (i11, i11, i32) -> i11
    %15 = llhd.extract_slice %14, 0 : i11 -> i11
    %16 = llhd.const 0 : i32
    %17 = llhd.const 0 : i11
    %18 = llhd.shr %15, %17, %16 : (i11, i11, i32) -> i11
    %19 = llhd.extract_slice %18, 0 : i11 -> i5
    %20 = llhd.const 0 : i11
    %21 = llhd.const 0 : i1
    %22 = llhd.insert_slice %20, %21, 0 : i11, i1
    %23 = llhd.const 0 : i32
    %24 = llhd.const 0 : i11
    %25 = llhd.shr %22, %24, %23 : (i11, i11, i32) -> i11
    %26 = llhd.extract_slice %25, 0 : i11 -> i11
    %27 = llhd.const 5 : i32
    %28 = llhd.const 0 : i11
    %29 = llhd.shr %26, %28, %27 : (i11, i11, i32) -> i11
    %30 = llhd.extract_slice %29, 0 : i11 -> i1
    %31 = llhd.const 0 : i11
    %32 = llhd.const 0 : i1
    %33 = llhd.insert_slice %31, %32, 0 : i11, i1
    %34 = llhd.const 0 : i32
    %35 = llhd.const 0 : i11
    %36 = llhd.shr %33, %35, %34 : (i11, i11, i32) -> i11
    %37 = llhd.extract_slice %36, 0 : i11 -> i11
    %38 = llhd.const 6 : i32
    %39 = llhd.const 0 : i11
    %40 = llhd.shr %37, %39, %38 : (i11, i11, i32) -> i11
    %41 = llhd.extract_slice %40, 0 : i11 -> i3
    %42 = llhd.const 0 : i11
    %43 = llhd.const 0 : i1
    %44 = llhd.insert_slice %42, %43, 0 : i11, i1
    %45 = llhd.const 0 : i32
    %46 = llhd.const 0 : i11
    %47 = llhd.shr %44, %46, %45 : (i11, i11, i32) -> i11
    %48 = llhd.extract_slice %47, 0 : i11 -> i11
    %49 = llhd.const 9 : i32
    %50 = llhd.const 0 : i11
    %51 = llhd.shr %48, %50, %49 : (i11, i11, i32) -> i11
    %52 = llhd.extract_slice %51, 0 : i11 -> i2
    %53 = llhd.tuple %19, %30, %41, %52 : tuple<i5, i1, i3, i2>
    %54 = llhd.array %53 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %55 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %mem_q, %54 after %55 : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %mem_n1 = llhd.prb %mem_n : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    %56 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %mem_q, %mem_n1 after %56 : !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @fifo_v3.param6.initial.2401.6() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @fifo_v3.param6(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %testmode_i: !llhd.sig<i1>, %data_i: !llhd.sig<tuple<i5, i1, i3, i2>>, %push_i: !llhd.sig<i1>, %pop_i: !llhd.sig<i1>) -> (%full_o: !llhd.sig<i1> , %empty_o: !llhd.sig<i1> , %usage_o: !llhd.sig<i1> , %data_o: !llhd.sig<tuple<i5, i1, i3, i2>> ) {
    %0 = llhd.const 0 : i1
    %gate_clock = llhd.sig "gate_clock" %0 : i1
    %1 = llhd.const 0 : i1
    %read_pointer_n = llhd.sig "read_pointer_n" %1 : i1
    %2 = llhd.const 0 : i1
    %read_pointer_q = llhd.sig "read_pointer_q" %2 : i1
    %3 = llhd.const 0 : i1
    %write_pointer_n = llhd.sig "write_pointer_n" %3 : i1
    %4 = llhd.const 0 : i1
    %write_pointer_q = llhd.sig "write_pointer_q" %4 : i1
    %5 = llhd.const 0 : i2
    %status_cnt_n = llhd.sig "status_cnt_n" %5 : i2
    %6 = llhd.const 0 : i2
    %status_cnt_q = llhd.sig "status_cnt_q" %6 : i2
    %7 = llhd.const 0 : i5
    %8 = llhd.const 0 : i1
    %9 = llhd.const 0 : i3
    %10 = llhd.const 0 : i2
    %11 = llhd.tuple %7, %8, %9, %10 : tuple<i5, i1, i3, i2>
    %12 = llhd.array %11 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %mem_n = llhd.sig "mem_n" %12 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %13 = llhd.const 0 : i5
    %14 = llhd.const 0 : i1
    %15 = llhd.const 0 : i3
    %16 = llhd.const 0 : i2
    %17 = llhd.tuple %13, %14, %15, %16 : tuple<i5, i1, i3, i2>
    %18 = llhd.array %17 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %mem_q = llhd.sig "mem_q" %18 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %status_cnt_q1 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %19 = llhd.const 0 : i1
    %20 = llhd.const 0 : i2
    %21 = llhd.shr %status_cnt_q1, %20, %19 : (i2, i2, i1) -> i2
    %22 = llhd.extract_slice %21, 0 : i2 -> i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %usage_o, %22 after %23 : !llhd.sig<i1>
    %status_cnt_q2 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %24 = llhd.const 1 : i32
    %25 = llhd.const 0 : i1
    %26 = llhd.const 0 : i32
    %27 = llhd.shr %24, %26, %25 : (i32, i32, i1) -> i32
    %28 = llhd.extract_slice %27, 0 : i32 -> i2
    %29 = llhd.eq %status_cnt_q2, %28 : i2
    %30 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %full_o, %29 after %30 : !llhd.sig<i1>
    %31 = llhd.const 0 : i32
    %status_cnt_q3 = llhd.prb %status_cnt_q : !llhd.sig<i2>
    %32 = llhd.insert_slice %31, %status_cnt_q3, 0 : i32, i2
    %33 = llhd.const 0 : i32
    %34 = llhd.eq %32, %33 : i32
    %35 = llhd.const 0 : i1
    %push_i1 = llhd.prb %push_i : !llhd.sig<i1>
    %36 = llhd.and %35, %push_i1 : i1
    %37 = llhd.not %36 : i1
    %38 = llhd.and %34, %37 : i1
    %39 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %empty_o, %38 after %39 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param6.always_comb.2398.6(%full_o, %empty_o, %data_i, %push_i, %pop_i, %read_pointer_n, %read_pointer_q, %write_pointer_q, %status_cnt_q, %mem_q) -> (%data_o, %gate_clock, %read_pointer_n, %write_pointer_n, %status_cnt_n, %mem_n) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (!llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>)
    llhd.inst "inst1" @fifo_v3.param6.always_ff.2399.6(%clk_i, %rst_ni, %flush_i, %read_pointer_n, %write_pointer_n, %status_cnt_n) -> (%read_pointer_q, %write_pointer_q, %status_cnt_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>)
    llhd.inst "inst2" @fifo_v3.param6.always_ff.2400.6(%clk_i, %rst_ni, %gate_clock, %mem_n) -> (%mem_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>) -> (!llhd.sig<!llhd.array<1xtuple<i5, i1, i3, i2>>>)
    llhd.inst "inst3" @fifo_v3.param6.initial.2401.6() -> () : () -> ()
}

llhd.proc @snitch_lsu.param5.always_comb.2098.5(%lsu_qaddr_i: !llhd.sig<i32>, %lsu_qsize_i: !llhd.sig<i2>) -> (%data_qstrb_o: !llhd.sig<i8> ) {
    br ^0
^0:
    br ^body
^body:
    %lsu_qsize_i1 = llhd.prb %lsu_qsize_i : !llhd.sig<i2>
    %1 = llhd.const 0 : i1
    %2 = llhd.const 0 : i2
    %3 = llhd.eq %lsu_qsize_i1, %2 : i2
    %4 = llhd.or %1, %3 : i1
    cond_br %4, ^case_body, ^5
^5:
    %6 = llhd.const 0 : i1
    %7 = llhd.const 1 : i2
    %8 = llhd.eq %lsu_qsize_i1, %7 : i2
    %9 = llhd.or %6, %8 : i1
    cond_br %9, ^case_body1, ^10
^case_body:
    %11 = llhd.const 1 : i8
    %lsu_qaddr_i1 = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %12 = llhd.const 0 : i1
    %13 = llhd.const 0 : i32
    %14 = llhd.shr %lsu_qaddr_i1, %13, %12 : (i32, i32, i1) -> i32
    %15 = llhd.extract_slice %14, 0 : i32 -> i3
    %16 = llhd.const 0 : i8
    %17 = llhd.shl %11, %16, %15 : (i8, i8, i3) -> i8
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qstrb_o, %17 after %18 : !llhd.sig<i8>
    br ^case_exit
^check:
    llhd.wait (%lsu_qaddr_i, %lsu_qsize_i : !llhd.sig<i32>, !llhd.sig<i2>), ^body
^case_exit:
    br ^check
^10:
    %19 = llhd.const 0 : i1
    %20 = llhd.const 2 : i2
    %21 = llhd.eq %lsu_qsize_i1, %20 : i2
    %22 = llhd.or %19, %21 : i1
    cond_br %22, ^case_body2, ^23
^case_body1:
    %24 = llhd.const 3 : i8
    %lsu_qaddr_i2 = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %25 = llhd.const 0 : i1
    %26 = llhd.const 0 : i32
    %27 = llhd.shr %lsu_qaddr_i2, %26, %25 : (i32, i32, i1) -> i32
    %28 = llhd.extract_slice %27, 0 : i32 -> i3
    %29 = llhd.const 0 : i8
    %30 = llhd.shl %24, %29, %28 : (i8, i8, i3) -> i8
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qstrb_o, %30 after %31 : !llhd.sig<i8>
    br ^case_exit
^23:
    %32 = llhd.const 0 : i1
    %33 = llhd.const 3 : i2
    %34 = llhd.eq %lsu_qsize_i1, %33 : i2
    %35 = llhd.or %32, %34 : i1
    cond_br %35, ^case_body3, ^36
^case_body2:
    %37 = llhd.const 15 : i8
    %lsu_qaddr_i3 = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %38 = llhd.const 0 : i1
    %39 = llhd.const 0 : i32
    %40 = llhd.shr %lsu_qaddr_i3, %39, %38 : (i32, i32, i1) -> i32
    %41 = llhd.extract_slice %40, 0 : i32 -> i3
    %42 = llhd.const 0 : i8
    %43 = llhd.shl %37, %42, %41 : (i8, i8, i3) -> i8
    %44 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qstrb_o, %43 after %44 : !llhd.sig<i8>
    br ^case_exit
^36:
    %45 = llhd.const 0 : i8
    %46 = llhd.const 0 : i1
    %47 = llhd.insert_slice %45, %46, 0 : i8, i1
    %48 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qstrb_o, %47 after %48 : !llhd.sig<i8>
    br ^case_exit
^case_body3:
    %49 = llhd.const 0 : i8
    %50 = llhd.const 1 : i1
    %51 = llhd.insert_slice %49, %50, 0 : i8, i1
    %52 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qstrb_o, %51 after %52 : !llhd.sig<i8>
    br ^case_exit
}

llhd.proc @snitch_lsu.param5.always_comb.2099.5(%lsu_qaddr_i: !llhd.sig<i32>, %lsu_qdata_i: !llhd.sig<i64>) -> (%data_qdata_o: !llhd.sig<i64> ) {
    br ^0
^0:
    br ^body
^body:
    %lsu_qaddr_i1 = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %1 = llhd.const 0 : i1
    %2 = llhd.const 0 : i32
    %3 = llhd.shr %lsu_qaddr_i1, %2, %1 : (i32, i32, i1) -> i32
    %4 = llhd.extract_slice %3, 0 : i32 -> i3
    %5 = llhd.const 0 : i1
    %6 = llhd.const 0 : i3
    %7 = llhd.eq %4, %6 : i3
    %8 = llhd.or %5, %7 : i1
    cond_br %8, ^case_body, ^9
^9:
    %10 = llhd.const 0 : i1
    %11 = llhd.const 1 : i3
    %12 = llhd.eq %4, %11 : i3
    %13 = llhd.or %10, %12 : i1
    cond_br %13, ^case_body1, ^14
^case_body:
    %lsu_qdata_i1 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %15 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %lsu_qdata_i1 after %15 : !llhd.sig<i64>
    br ^case_exit
^check:
    llhd.wait (%lsu_qaddr_i, %lsu_qdata_i : !llhd.sig<i32>, !llhd.sig<i64>), ^body
^case_exit:
    br ^check
^14:
    %16 = llhd.const 0 : i1
    %17 = llhd.const 2 : i3
    %18 = llhd.eq %4, %17 : i3
    %19 = llhd.or %16, %18 : i1
    cond_br %19, ^case_body2, ^20
^case_body1:
    %21 = llhd.const 0 : i64
    %lsu_qdata_i2 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %22 = llhd.const 56 : i6
    %23 = llhd.const 0 : i64
    %24 = llhd.shr %lsu_qdata_i2, %23, %22 : (i64, i64, i6) -> i64
    %25 = llhd.extract_slice %24, 0 : i64 -> i8
    %26 = llhd.insert_slice %21, %25, 0 : i64, i8
    %lsu_qdata_i3 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %27 = llhd.const 0 : i1
    %28 = llhd.const 0 : i64
    %29 = llhd.shr %lsu_qdata_i3, %28, %27 : (i64, i64, i1) -> i64
    %30 = llhd.extract_slice %29, 0 : i64 -> i56
    %31 = llhd.insert_slice %26, %30, 8 : i64, i56
    %32 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %31 after %32 : !llhd.sig<i64>
    br ^case_exit
^20:
    %33 = llhd.const 0 : i1
    %34 = llhd.const 3 : i3
    %35 = llhd.eq %4, %34 : i3
    %36 = llhd.or %33, %35 : i1
    cond_br %36, ^case_body3, ^37
^case_body2:
    %38 = llhd.const 0 : i64
    %lsu_qdata_i4 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %39 = llhd.const 48 : i6
    %40 = llhd.const 0 : i64
    %41 = llhd.shr %lsu_qdata_i4, %40, %39 : (i64, i64, i6) -> i64
    %42 = llhd.extract_slice %41, 0 : i64 -> i16
    %43 = llhd.insert_slice %38, %42, 0 : i64, i16
    %lsu_qdata_i5 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %44 = llhd.const 0 : i1
    %45 = llhd.const 0 : i64
    %46 = llhd.shr %lsu_qdata_i5, %45, %44 : (i64, i64, i1) -> i64
    %47 = llhd.extract_slice %46, 0 : i64 -> i48
    %48 = llhd.insert_slice %43, %47, 16 : i64, i48
    %49 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %48 after %49 : !llhd.sig<i64>
    br ^case_exit
^37:
    %50 = llhd.const 0 : i1
    %51 = llhd.const 4 : i3
    %52 = llhd.eq %4, %51 : i3
    %53 = llhd.or %50, %52 : i1
    cond_br %53, ^case_body4, ^54
^case_body3:
    %55 = llhd.const 0 : i64
    %lsu_qdata_i6 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %56 = llhd.const 40 : i6
    %57 = llhd.const 0 : i64
    %58 = llhd.shr %lsu_qdata_i6, %57, %56 : (i64, i64, i6) -> i64
    %59 = llhd.extract_slice %58, 0 : i64 -> i24
    %60 = llhd.insert_slice %55, %59, 0 : i64, i24
    %lsu_qdata_i7 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %61 = llhd.const 0 : i1
    %62 = llhd.const 0 : i64
    %63 = llhd.shr %lsu_qdata_i7, %62, %61 : (i64, i64, i1) -> i64
    %64 = llhd.extract_slice %63, 0 : i64 -> i40
    %65 = llhd.insert_slice %60, %64, 24 : i64, i40
    %66 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %65 after %66 : !llhd.sig<i64>
    br ^case_exit
^54:
    %67 = llhd.const 0 : i1
    %68 = llhd.const 5 : i3
    %69 = llhd.eq %4, %68 : i3
    %70 = llhd.or %67, %69 : i1
    cond_br %70, ^case_body5, ^71
^case_body4:
    %72 = llhd.const 0 : i64
    %lsu_qdata_i8 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %73 = llhd.const 32 : i6
    %74 = llhd.const 0 : i64
    %75 = llhd.shr %lsu_qdata_i8, %74, %73 : (i64, i64, i6) -> i64
    %76 = llhd.extract_slice %75, 0 : i64 -> i32
    %77 = llhd.insert_slice %72, %76, 0 : i64, i32
    %lsu_qdata_i9 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %78 = llhd.const 0 : i1
    %79 = llhd.const 0 : i64
    %80 = llhd.shr %lsu_qdata_i9, %79, %78 : (i64, i64, i1) -> i64
    %81 = llhd.extract_slice %80, 0 : i64 -> i32
    %82 = llhd.insert_slice %77, %81, 32 : i64, i32
    %83 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %82 after %83 : !llhd.sig<i64>
    br ^case_exit
^71:
    %84 = llhd.const 0 : i1
    %85 = llhd.const 6 : i3
    %86 = llhd.eq %4, %85 : i3
    %87 = llhd.or %84, %86 : i1
    cond_br %87, ^case_body6, ^88
^case_body5:
    %89 = llhd.const 0 : i64
    %lsu_qdata_i10 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %90 = llhd.const 24 : i5
    %91 = llhd.const 0 : i64
    %92 = llhd.shr %lsu_qdata_i10, %91, %90 : (i64, i64, i5) -> i64
    %93 = llhd.extract_slice %92, 0 : i64 -> i40
    %94 = llhd.insert_slice %89, %93, 0 : i64, i40
    %lsu_qdata_i11 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %95 = llhd.const 0 : i1
    %96 = llhd.const 0 : i64
    %97 = llhd.shr %lsu_qdata_i11, %96, %95 : (i64, i64, i1) -> i64
    %98 = llhd.extract_slice %97, 0 : i64 -> i24
    %99 = llhd.insert_slice %94, %98, 40 : i64, i24
    %100 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %99 after %100 : !llhd.sig<i64>
    br ^case_exit
^88:
    %101 = llhd.const 0 : i1
    %102 = llhd.const 7 : i3
    %103 = llhd.eq %4, %102 : i3
    %104 = llhd.or %101, %103 : i1
    cond_br %104, ^case_body7, ^105
^case_body6:
    %106 = llhd.const 0 : i64
    %lsu_qdata_i12 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %107 = llhd.const 16 : i5
    %108 = llhd.const 0 : i64
    %109 = llhd.shr %lsu_qdata_i12, %108, %107 : (i64, i64, i5) -> i64
    %110 = llhd.extract_slice %109, 0 : i64 -> i48
    %111 = llhd.insert_slice %106, %110, 0 : i64, i48
    %lsu_qdata_i13 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %112 = llhd.const 0 : i1
    %113 = llhd.const 0 : i64
    %114 = llhd.shr %lsu_qdata_i13, %113, %112 : (i64, i64, i1) -> i64
    %115 = llhd.extract_slice %114, 0 : i64 -> i16
    %116 = llhd.insert_slice %111, %115, 48 : i64, i16
    %117 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %116 after %117 : !llhd.sig<i64>
    br ^case_exit
^105:
    %lsu_qdata_i16 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %118 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %lsu_qdata_i16 after %118 : !llhd.sig<i64>
    br ^case_exit
^case_body7:
    %119 = llhd.const 0 : i64
    %lsu_qdata_i14 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %120 = llhd.const 8 : i4
    %121 = llhd.const 0 : i64
    %122 = llhd.shr %lsu_qdata_i14, %121, %120 : (i64, i64, i4) -> i64
    %123 = llhd.extract_slice %122, 0 : i64 -> i56
    %124 = llhd.insert_slice %119, %123, 0 : i64, i56
    %lsu_qdata_i15 = llhd.prb %lsu_qdata_i : !llhd.sig<i64>
    %125 = llhd.const 0 : i1
    %126 = llhd.const 0 : i64
    %127 = llhd.shr %lsu_qdata_i15, %126, %125 : (i64, i64, i1) -> i64
    %128 = llhd.extract_slice %127, 0 : i64 -> i8
    %129 = llhd.insert_slice %124, %128, 56 : i64, i8
    %130 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qdata_o, %129 after %130 : !llhd.sig<i64>
    br ^case_exit
}

llhd.proc @snitch_lsu.param5.always_comb.2105.5(%laq_out: !llhd.sig<tuple<i5, i1, i3, i2>>, %shifted_data: !llhd.sig<i64>) -> (%ld_result: !llhd.sig<i64> ) {
    br ^0
^0:
    br ^body
^body:
    %laq_out1 = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %1 = llhd.extract_element %laq_out1, 3 : tuple<i5, i1, i3, i2> -> i2
    %2 = llhd.const 0 : i1
    %3 = llhd.const 0 : i2
    %4 = llhd.eq %1, %3 : i2
    %5 = llhd.or %2, %4 : i1
    cond_br %5, ^case_body, ^6
^6:
    %7 = llhd.const 0 : i1
    %8 = llhd.const 1 : i2
    %9 = llhd.eq %1, %8 : i2
    %10 = llhd.or %7, %9 : i1
    cond_br %10, ^case_body1, ^11
^case_body:
    %12 = llhd.const 0 : i64
    %shifted_data1 = llhd.prb %shifted_data : !llhd.sig<i64>
    %13 = llhd.const 0 : i1
    %14 = llhd.const 0 : i64
    %15 = llhd.shr %shifted_data1, %14, %13 : (i64, i64, i1) -> i64
    %16 = llhd.extract_slice %15, 0 : i64 -> i8
    %17 = llhd.insert_slice %12, %16, 0 : i64, i8
    %18 = llhd.const 0 : i1
    %shifted_data2 = llhd.prb %shifted_data : !llhd.sig<i64>
    %19 = llhd.const 7 : i32
    %20 = llhd.const 0 : i64
    %21 = llhd.shr %shifted_data2, %20, %19 : (i64, i64, i32) -> i64
    %22 = llhd.extract_slice %21, 0 : i64 -> i1
    %laq_out2 = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %23 = llhd.extract_element %laq_out2, 1 : tuple<i5, i1, i3, i2> -> i1
    %24 = llhd.and %22, %23 : i1
    %25 = llhd.insert_slice %18, %24, 0 : i1, i1
    %26 = llhd.const 0 : i56
    %27 = llhd.insert_slice %26, %25, 0 : i56, i1
    %28 = llhd.insert_slice %27, %25, 1 : i56, i1
    %29 = llhd.insert_slice %28, %25, 2 : i56, i1
    %30 = llhd.insert_slice %29, %25, 3 : i56, i1
    %31 = llhd.insert_slice %30, %25, 4 : i56, i1
    %32 = llhd.insert_slice %31, %25, 5 : i56, i1
    %33 = llhd.insert_slice %32, %25, 6 : i56, i1
    %34 = llhd.insert_slice %33, %25, 7 : i56, i1
    %35 = llhd.insert_slice %34, %25, 8 : i56, i1
    %36 = llhd.insert_slice %35, %25, 9 : i56, i1
    %37 = llhd.insert_slice %36, %25, 10 : i56, i1
    %38 = llhd.insert_slice %37, %25, 11 : i56, i1
    %39 = llhd.insert_slice %38, %25, 12 : i56, i1
    %40 = llhd.insert_slice %39, %25, 13 : i56, i1
    %41 = llhd.insert_slice %40, %25, 14 : i56, i1
    %42 = llhd.insert_slice %41, %25, 15 : i56, i1
    %43 = llhd.insert_slice %42, %25, 16 : i56, i1
    %44 = llhd.insert_slice %43, %25, 17 : i56, i1
    %45 = llhd.insert_slice %44, %25, 18 : i56, i1
    %46 = llhd.insert_slice %45, %25, 19 : i56, i1
    %47 = llhd.insert_slice %46, %25, 20 : i56, i1
    %48 = llhd.insert_slice %47, %25, 21 : i56, i1
    %49 = llhd.insert_slice %48, %25, 22 : i56, i1
    %50 = llhd.insert_slice %49, %25, 23 : i56, i1
    %51 = llhd.insert_slice %50, %25, 24 : i56, i1
    %52 = llhd.insert_slice %51, %25, 25 : i56, i1
    %53 = llhd.insert_slice %52, %25, 26 : i56, i1
    %54 = llhd.insert_slice %53, %25, 27 : i56, i1
    %55 = llhd.insert_slice %54, %25, 28 : i56, i1
    %56 = llhd.insert_slice %55, %25, 29 : i56, i1
    %57 = llhd.insert_slice %56, %25, 30 : i56, i1
    %58 = llhd.insert_slice %57, %25, 31 : i56, i1
    %59 = llhd.insert_slice %58, %25, 32 : i56, i1
    %60 = llhd.insert_slice %59, %25, 33 : i56, i1
    %61 = llhd.insert_slice %60, %25, 34 : i56, i1
    %62 = llhd.insert_slice %61, %25, 35 : i56, i1
    %63 = llhd.insert_slice %62, %25, 36 : i56, i1
    %64 = llhd.insert_slice %63, %25, 37 : i56, i1
    %65 = llhd.insert_slice %64, %25, 38 : i56, i1
    %66 = llhd.insert_slice %65, %25, 39 : i56, i1
    %67 = llhd.insert_slice %66, %25, 40 : i56, i1
    %68 = llhd.insert_slice %67, %25, 41 : i56, i1
    %69 = llhd.insert_slice %68, %25, 42 : i56, i1
    %70 = llhd.insert_slice %69, %25, 43 : i56, i1
    %71 = llhd.insert_slice %70, %25, 44 : i56, i1
    %72 = llhd.insert_slice %71, %25, 45 : i56, i1
    %73 = llhd.insert_slice %72, %25, 46 : i56, i1
    %74 = llhd.insert_slice %73, %25, 47 : i56, i1
    %75 = llhd.insert_slice %74, %25, 48 : i56, i1
    %76 = llhd.insert_slice %75, %25, 49 : i56, i1
    %77 = llhd.insert_slice %76, %25, 50 : i56, i1
    %78 = llhd.insert_slice %77, %25, 51 : i56, i1
    %79 = llhd.insert_slice %78, %25, 52 : i56, i1
    %80 = llhd.insert_slice %79, %25, 53 : i56, i1
    %81 = llhd.insert_slice %80, %25, 54 : i56, i1
    %82 = llhd.insert_slice %81, %25, 55 : i56, i1
    %83 = llhd.insert_slice %17, %82, 8 : i64, i56
    %84 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ld_result, %83 after %84 : !llhd.sig<i64>
    br ^case_exit
^check:
    llhd.wait (%laq_out, %shifted_data : !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i64>), ^body
^case_exit:
    br ^check
^11:
    %85 = llhd.const 0 : i1
    %86 = llhd.const 2 : i2
    %87 = llhd.eq %1, %86 : i2
    %88 = llhd.or %85, %87 : i1
    cond_br %88, ^case_body2, ^89
^case_body1:
    %90 = llhd.const 0 : i64
    %shifted_data3 = llhd.prb %shifted_data : !llhd.sig<i64>
    %91 = llhd.const 0 : i1
    %92 = llhd.const 0 : i64
    %93 = llhd.shr %shifted_data3, %92, %91 : (i64, i64, i1) -> i64
    %94 = llhd.extract_slice %93, 0 : i64 -> i16
    %95 = llhd.insert_slice %90, %94, 0 : i64, i16
    %96 = llhd.const 0 : i1
    %shifted_data4 = llhd.prb %shifted_data : !llhd.sig<i64>
    %97 = llhd.const 15 : i32
    %98 = llhd.const 0 : i64
    %99 = llhd.shr %shifted_data4, %98, %97 : (i64, i64, i32) -> i64
    %100 = llhd.extract_slice %99, 0 : i64 -> i1
    %laq_out3 = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %101 = llhd.extract_element %laq_out3, 1 : tuple<i5, i1, i3, i2> -> i1
    %102 = llhd.and %100, %101 : i1
    %103 = llhd.insert_slice %96, %102, 0 : i1, i1
    %104 = llhd.const 0 : i48
    %105 = llhd.insert_slice %104, %103, 0 : i48, i1
    %106 = llhd.insert_slice %105, %103, 1 : i48, i1
    %107 = llhd.insert_slice %106, %103, 2 : i48, i1
    %108 = llhd.insert_slice %107, %103, 3 : i48, i1
    %109 = llhd.insert_slice %108, %103, 4 : i48, i1
    %110 = llhd.insert_slice %109, %103, 5 : i48, i1
    %111 = llhd.insert_slice %110, %103, 6 : i48, i1
    %112 = llhd.insert_slice %111, %103, 7 : i48, i1
    %113 = llhd.insert_slice %112, %103, 8 : i48, i1
    %114 = llhd.insert_slice %113, %103, 9 : i48, i1
    %115 = llhd.insert_slice %114, %103, 10 : i48, i1
    %116 = llhd.insert_slice %115, %103, 11 : i48, i1
    %117 = llhd.insert_slice %116, %103, 12 : i48, i1
    %118 = llhd.insert_slice %117, %103, 13 : i48, i1
    %119 = llhd.insert_slice %118, %103, 14 : i48, i1
    %120 = llhd.insert_slice %119, %103, 15 : i48, i1
    %121 = llhd.insert_slice %120, %103, 16 : i48, i1
    %122 = llhd.insert_slice %121, %103, 17 : i48, i1
    %123 = llhd.insert_slice %122, %103, 18 : i48, i1
    %124 = llhd.insert_slice %123, %103, 19 : i48, i1
    %125 = llhd.insert_slice %124, %103, 20 : i48, i1
    %126 = llhd.insert_slice %125, %103, 21 : i48, i1
    %127 = llhd.insert_slice %126, %103, 22 : i48, i1
    %128 = llhd.insert_slice %127, %103, 23 : i48, i1
    %129 = llhd.insert_slice %128, %103, 24 : i48, i1
    %130 = llhd.insert_slice %129, %103, 25 : i48, i1
    %131 = llhd.insert_slice %130, %103, 26 : i48, i1
    %132 = llhd.insert_slice %131, %103, 27 : i48, i1
    %133 = llhd.insert_slice %132, %103, 28 : i48, i1
    %134 = llhd.insert_slice %133, %103, 29 : i48, i1
    %135 = llhd.insert_slice %134, %103, 30 : i48, i1
    %136 = llhd.insert_slice %135, %103, 31 : i48, i1
    %137 = llhd.insert_slice %136, %103, 32 : i48, i1
    %138 = llhd.insert_slice %137, %103, 33 : i48, i1
    %139 = llhd.insert_slice %138, %103, 34 : i48, i1
    %140 = llhd.insert_slice %139, %103, 35 : i48, i1
    %141 = llhd.insert_slice %140, %103, 36 : i48, i1
    %142 = llhd.insert_slice %141, %103, 37 : i48, i1
    %143 = llhd.insert_slice %142, %103, 38 : i48, i1
    %144 = llhd.insert_slice %143, %103, 39 : i48, i1
    %145 = llhd.insert_slice %144, %103, 40 : i48, i1
    %146 = llhd.insert_slice %145, %103, 41 : i48, i1
    %147 = llhd.insert_slice %146, %103, 42 : i48, i1
    %148 = llhd.insert_slice %147, %103, 43 : i48, i1
    %149 = llhd.insert_slice %148, %103, 44 : i48, i1
    %150 = llhd.insert_slice %149, %103, 45 : i48, i1
    %151 = llhd.insert_slice %150, %103, 46 : i48, i1
    %152 = llhd.insert_slice %151, %103, 47 : i48, i1
    %153 = llhd.insert_slice %95, %152, 16 : i64, i48
    %154 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ld_result, %153 after %154 : !llhd.sig<i64>
    br ^case_exit
^89:
    %155 = llhd.const 0 : i1
    %156 = llhd.const 3 : i2
    %157 = llhd.eq %1, %156 : i2
    %158 = llhd.or %155, %157 : i1
    cond_br %158, ^case_body3, ^159
^case_body2:
    %160 = llhd.const 0 : i64
    %shifted_data5 = llhd.prb %shifted_data : !llhd.sig<i64>
    %161 = llhd.const 0 : i1
    %162 = llhd.const 0 : i64
    %163 = llhd.shr %shifted_data5, %162, %161 : (i64, i64, i1) -> i64
    %164 = llhd.extract_slice %163, 0 : i64 -> i32
    %165 = llhd.insert_slice %160, %164, 0 : i64, i32
    %166 = llhd.const 0 : i1
    %shifted_data6 = llhd.prb %shifted_data : !llhd.sig<i64>
    %167 = llhd.const 31 : i32
    %168 = llhd.const 0 : i64
    %169 = llhd.shr %shifted_data6, %168, %167 : (i64, i64, i32) -> i64
    %170 = llhd.extract_slice %169, 0 : i64 -> i1
    %171 = llhd.const 0 : i32
    %172 = llhd.extract_slice %171, 0 : i32 -> i1
    %173 = llhd.or %170, %172 : i1
    %laq_out4 = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %174 = llhd.extract_element %laq_out4, 1 : tuple<i5, i1, i3, i2> -> i1
    %175 = llhd.and %173, %174 : i1
    %176 = llhd.insert_slice %166, %175, 0 : i1, i1
    %177 = llhd.const 0 : i32
    %178 = llhd.insert_slice %177, %176, 0 : i32, i1
    %179 = llhd.insert_slice %178, %176, 1 : i32, i1
    %180 = llhd.insert_slice %179, %176, 2 : i32, i1
    %181 = llhd.insert_slice %180, %176, 3 : i32, i1
    %182 = llhd.insert_slice %181, %176, 4 : i32, i1
    %183 = llhd.insert_slice %182, %176, 5 : i32, i1
    %184 = llhd.insert_slice %183, %176, 6 : i32, i1
    %185 = llhd.insert_slice %184, %176, 7 : i32, i1
    %186 = llhd.insert_slice %185, %176, 8 : i32, i1
    %187 = llhd.insert_slice %186, %176, 9 : i32, i1
    %188 = llhd.insert_slice %187, %176, 10 : i32, i1
    %189 = llhd.insert_slice %188, %176, 11 : i32, i1
    %190 = llhd.insert_slice %189, %176, 12 : i32, i1
    %191 = llhd.insert_slice %190, %176, 13 : i32, i1
    %192 = llhd.insert_slice %191, %176, 14 : i32, i1
    %193 = llhd.insert_slice %192, %176, 15 : i32, i1
    %194 = llhd.insert_slice %193, %176, 16 : i32, i1
    %195 = llhd.insert_slice %194, %176, 17 : i32, i1
    %196 = llhd.insert_slice %195, %176, 18 : i32, i1
    %197 = llhd.insert_slice %196, %176, 19 : i32, i1
    %198 = llhd.insert_slice %197, %176, 20 : i32, i1
    %199 = llhd.insert_slice %198, %176, 21 : i32, i1
    %200 = llhd.insert_slice %199, %176, 22 : i32, i1
    %201 = llhd.insert_slice %200, %176, 23 : i32, i1
    %202 = llhd.insert_slice %201, %176, 24 : i32, i1
    %203 = llhd.insert_slice %202, %176, 25 : i32, i1
    %204 = llhd.insert_slice %203, %176, 26 : i32, i1
    %205 = llhd.insert_slice %204, %176, 27 : i32, i1
    %206 = llhd.insert_slice %205, %176, 28 : i32, i1
    %207 = llhd.insert_slice %206, %176, 29 : i32, i1
    %208 = llhd.insert_slice %207, %176, 30 : i32, i1
    %209 = llhd.insert_slice %208, %176, 31 : i32, i1
    %210 = llhd.insert_slice %165, %209, 32 : i64, i32
    %211 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ld_result, %210 after %211 : !llhd.sig<i64>
    br ^case_exit
^159:
    %shifted_data8 = llhd.prb %shifted_data : !llhd.sig<i64>
    %212 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ld_result, %shifted_data8 after %212 : !llhd.sig<i64>
    br ^case_exit
^case_body3:
    %shifted_data7 = llhd.prb %shifted_data : !llhd.sig<i64>
    %213 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ld_result, %shifted_data7 after %213 : !llhd.sig<i64>
    br ^case_exit
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
    %6 = llhd.const 0 : i5
    %7 = llhd.const 0 : i1
    %8 = llhd.const 0 : i3
    %9 = llhd.const 0 : i2
    %10 = llhd.tuple %6, %7, %8, %9 : tuple<i5, i1, i3, i2>
    %laq_out = llhd.sig "laq_out" %10 : tuple<i5, i1, i3, i2>
    %11 = llhd.const 0 : i1
    %laq_full = llhd.sig "laq_full" %11 : i1
    %12 = llhd.const 0 : i1
    %laq_push = llhd.sig "laq_push" %12 : i1
    %13 = llhd.const 0 : i64
    %shifted_data = llhd.sig "shifted_data" %13 : i64
    %lsu_qtag_i1 = llhd.prb %lsu_qtag_i : !llhd.sig<i5>
    %lsu_qsigned1 = llhd.prb %lsu_qsigned : !llhd.sig<i1>
    %lsu_qaddr_i1 = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %14 = llhd.const 0 : i1
    %15 = llhd.const 0 : i32
    %16 = llhd.shr %lsu_qaddr_i1, %15, %14 : (i32, i32, i1) -> i32
    %17 = llhd.extract_slice %16, 0 : i32 -> i3
    %lsu_qsize_i1 = llhd.prb %lsu_qsize_i : !llhd.sig<i2>
    %18 = llhd.tuple %lsu_qtag_i1, %lsu_qsigned1, %17, %lsu_qsize_i1 : tuple<i5, i1, i3, i2>
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %laq_in, %18 after %19 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %lsu_qvalid_i1 = llhd.prb %lsu_qvalid_i : !llhd.sig<i1>
    %lsu_qwrite1 = llhd.prb %lsu_qwrite : !llhd.sig<i1>
    %laq_full1 = llhd.prb %laq_full : !llhd.sig<i1>
    %20 = llhd.not %laq_full1 : i1
    %21 = llhd.or %lsu_qwrite1, %20 : i1
    %22 = llhd.and %lsu_qvalid_i1, %21 : i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qvalid_o, %22 after %23 : !llhd.sig<i1>
    %lsu_qwrite2 = llhd.prb %lsu_qwrite : !llhd.sig<i1>
    %24 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qwrite_o, %lsu_qwrite2 after %24 : !llhd.sig<i1>
    %25 = llhd.const 0 : i32
    %26 = llhd.const 0 : i3
    %27 = llhd.insert_slice %25, %26, 0 : i32, i3
    %lsu_qaddr_i2 = llhd.prb %lsu_qaddr_i : !llhd.sig<i32>
    %28 = llhd.const 3 : i2
    %29 = llhd.const 0 : i32
    %30 = llhd.shr %lsu_qaddr_i2, %29, %28 : (i32, i32, i2) -> i32
    %31 = llhd.extract_slice %30, 0 : i32 -> i29
    %32 = llhd.insert_slice %27, %31, 3 : i32, i29
    %33 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qaddr_o, %32 after %33 : !llhd.sig<i32>
    %lsu_qamo_i1 = llhd.prb %lsu_qamo_i : !llhd.sig<i4>
    %34 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qamo_o, %lsu_qamo_i1 after %34 : !llhd.sig<i4>
    %data_qvalid_o1 = llhd.prb %data_qvalid_o : !llhd.sig<i1>
    %data_qready_i1 = llhd.prb %data_qready_i : !llhd.sig<i1>
    %35 = llhd.not %data_qready_i1 : i1
    %36 = llhd.and %data_qvalid_o1, %35 : i1
    %37 = llhd.not %36 : i1
    %laq_full2 = llhd.prb %laq_full : !llhd.sig<i1>
    %38 = llhd.not %laq_full2 : i1
    %39 = llhd.and %37, %38 : i1
    %40 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_qready_o, %39 after %40 : !llhd.sig<i1>
    %data_qready_i2 = llhd.prb %data_qready_i : !llhd.sig<i1>
    %data_qvalid_o2 = llhd.prb %data_qvalid_o : !llhd.sig<i1>
    %41 = llhd.and %data_qready_i2, %data_qvalid_o2 : i1
    %laq_full3 = llhd.prb %laq_full : !llhd.sig<i1>
    %42 = llhd.not %laq_full3 : i1
    %43 = llhd.and %41, %42 : i1
    %44 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %laq_push, %43 after %44 : !llhd.sig<i1>
    %data_pdata_i1 = llhd.prb %data_pdata_i : !llhd.sig<i64>
    %45 = llhd.const 0 : i6
    %46 = llhd.const 0 : i3
    %47 = llhd.insert_slice %45, %46, 0 : i6, i3
    %laq_out1 = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %48 = llhd.extract_element %laq_out1, 2 : tuple<i5, i1, i3, i2> -> i3
    %49 = llhd.insert_slice %47, %48, 3 : i6, i3
    %50 = llhd.const 0 : i64
    %51 = llhd.shr %data_pdata_i1, %50, %49 : (i64, i64, i6) -> i64
    %52 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shifted_data, %51 after %52 : !llhd.sig<i64>
    %data_perror_i1 = llhd.prb %data_perror_i : !llhd.sig<i1>
    %53 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_perror_o, %data_perror_i1 after %53 : !llhd.sig<i1>
    %ld_result1 = llhd.prb %ld_result : !llhd.sig<i64>
    %54 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_pdata_o, %ld_result1 after %54 : !llhd.sig<i64>
    %laq_out2 = llhd.prb %laq_out : !llhd.sig<tuple<i5, i1, i3, i2>>
    %55 = llhd.extract_element %laq_out2, 0 : tuple<i5, i1, i3, i2> -> i5
    %56 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_ptag_o, %55 after %56 : !llhd.sig<i5>
    %data_pvalid_i1 = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %57 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_pvalid_o, %data_pvalid_i1 after %57 : !llhd.sig<i1>
    %lsu_pready_i1 = llhd.prb %lsu_pready_i : !llhd.sig<i1>
    %58 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_pready_o, %lsu_pready_i1 after %58 : !llhd.sig<i1>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %59 = llhd.const 0 : i1
    %60 = llhd.sig "60" %59 : i1
    %61 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %60, %clk_i1 after %61 : !llhd.sig<i1>
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %62 = llhd.not %rst_i1 : i1
    %63 = llhd.const 0 : i1
    %64 = llhd.sig "64" %63 : i1
    %65 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %64, %62 after %65 : !llhd.sig<i1>
    %66 = llhd.const 0 : i1
    %67 = llhd.const 0 : i1
    %68 = llhd.sig "68" %67 : i1
    %69 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %68, %66 after %69 : !llhd.sig<i1>
    %70 = llhd.const 0 : i1
    %71 = llhd.const 0 : i1
    %72 = llhd.sig "72" %71 : i1
    %73 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %72, %70 after %73 : !llhd.sig<i1>
    %74 = llhd.const 0 : i1
    %75 = llhd.sig "75" %74 : i1
    %76 = llhd.const 0 : i1
    %77 = llhd.sig "77" %76 : i1
    %laq_in1 = llhd.prb %laq_in : !llhd.sig<tuple<i5, i1, i3, i2>>
    %78 = llhd.const 0 : i5
    %79 = llhd.const 0 : i1
    %80 = llhd.const 0 : i3
    %81 = llhd.const 0 : i2
    %82 = llhd.tuple %78, %79, %80, %81 : tuple<i5, i1, i3, i2>
    %83 = llhd.sig "83" %82 : tuple<i5, i1, i3, i2>
    %84 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %83, %laq_in1 after %84 : !llhd.sig<tuple<i5, i1, i3, i2>>
    %laq_push1 = llhd.prb %laq_push : !llhd.sig<i1>
    %85 = llhd.const 0 : i1
    %86 = llhd.sig "86" %85 : i1
    %87 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %86, %laq_push1 after %87 : !llhd.sig<i1>
    %data_pvalid_i2 = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %data_pready_o1 = llhd.prb %data_pready_o : !llhd.sig<i1>
    %88 = llhd.and %data_pvalid_i2, %data_pready_o1 : i1
    %89 = llhd.const 0 : i1
    %90 = llhd.sig "90" %89 : i1
    %91 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %90, %88 after %91 : !llhd.sig<i1>
    llhd.inst "inst" @fifo_v3.param6(%60, %64, %68, %72, %83, %86, %90) -> (%laq_full, %75, %77, %laq_out) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i5, i1, i3, i2>>)
    llhd.inst "inst1" @snitch_lsu.param5.always_comb.2098.5(%lsu_qaddr_i, %lsu_qsize_i) -> (%data_qstrb_o) : (!llhd.sig<i32>, !llhd.sig<i2>) -> (!llhd.sig<i8>)
    llhd.inst "inst2" @snitch_lsu.param5.always_comb.2099.5(%lsu_qaddr_i, %lsu_qdata_i) -> (%data_qdata_o) : (!llhd.sig<i32>, !llhd.sig<i64>) -> (!llhd.sig<i64>)
    llhd.inst "inst3" @snitch_lsu.param5.always_comb.2105.5(%laq_out, %shifted_data) -> (%ld_result) : (!llhd.sig<tuple<i5, i1, i3, i2>>, !llhd.sig<i64>) -> (!llhd.sig<i64>)
}

llhd.proc @snitch.param1.always_ff.568.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %pc_d: !llhd.sig<i32>) -> (%pc_q: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %4 = llhd.const 65536 : i32
    %pc_d1 = llhd.prb %pc_d : !llhd.sig<i32>
    %5 = llhd.array %pc_d1, %4 : !llhd.array<2xi32>
    %6 = llhd.dyn_extract_element %5, %rst_i1 : (!llhd.array<2xi32>, i1) -> i32
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %pc_q, %6 after %7 : !llhd.sig<i32>
    br ^0
}

llhd.proc @snitch.param1.always_ff.569.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %wfi_d: !llhd.sig<i1>) -> (%wfi_q: !llhd.sig<i1> ) {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %wfi_d1 = llhd.prb %wfi_d : !llhd.sig<i1>
    %5 = llhd.array %wfi_d1, %4 : !llhd.array<2xi1>
    %6 = llhd.dyn_extract_element %5, %rst_i1 : (!llhd.array<2xi1>, i1) -> i1
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %wfi_q, %6 after %7 : !llhd.sig<i1>
    br ^0
}

llhd.proc @snitch.param1.always_ff.570.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %sb_d: !llhd.sig<i32>) -> (%sb_q: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %4 = llhd.const 0 : i32
    %sb_d1 = llhd.prb %sb_d : !llhd.sig<i32>
    %5 = llhd.array %sb_d1, %4 : !llhd.array<2xi32>
    %6 = llhd.dyn_extract_element %5, %rst_i1 : (!llhd.array<2xi32>, i1) -> i32
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %sb_q, %6 after %7 : !llhd.sig<i32>
    br ^0
}

llhd.proc @snitch.param1.always_ff.571.1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %fcsr_d: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (%fcsr_q: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> ) {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %4 = llhd.const 0 : i8
    %5 = llhd.const 0 : i8
    %6 = llhd.const 0 : i5
    %fcsr_d1 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %7 = llhd.extract_element %fcsr_d1, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %8 = llhd.extract_element %7, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %9 = llhd.insert_slice %6, %8, 0 : i5, i1
    %fcsr_d2 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %10 = llhd.extract_element %fcsr_d2, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %11 = llhd.extract_element %10, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %12 = llhd.insert_slice %9, %11, 1 : i5, i1
    %fcsr_d3 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %13 = llhd.extract_element %fcsr_d3, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %14 = llhd.extract_element %13, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %15 = llhd.insert_slice %12, %14, 2 : i5, i1
    %fcsr_d4 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %16 = llhd.extract_element %fcsr_d4, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %17 = llhd.extract_element %16, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %18 = llhd.insert_slice %15, %17, 3 : i5, i1
    %fcsr_d5 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %19 = llhd.extract_element %fcsr_d5, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %20 = llhd.extract_element %19, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %21 = llhd.insert_slice %18, %20, 4 : i5, i1
    %22 = llhd.insert_slice %5, %21, 0 : i8, i5
    %fcsr_d6 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %23 = llhd.extract_element %fcsr_d6, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %24 = llhd.insert_slice %22, %23, 5 : i8, i3
    %25 = llhd.array %24, %4 : !llhd.array<2xi8>
    %26 = llhd.dyn_extract_element %25, %rst_i1 : (!llhd.array<2xi8>, i1) -> i8
    %27 = llhd.const 0 : i32
    %28 = llhd.const 0 : i8
    %29 = llhd.shr %26, %28, %27 : (i8, i8, i32) -> i8
    %30 = llhd.extract_slice %29, 0 : i8 -> i3
    %rst_i2 = llhd.prb %rst_i : !llhd.sig<i1>
    %31 = llhd.const 0 : i8
    %32 = llhd.const 0 : i8
    %33 = llhd.const 0 : i5
    %fcsr_d7 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %34 = llhd.extract_element %fcsr_d7, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %35 = llhd.extract_element %34, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %36 = llhd.insert_slice %33, %35, 0 : i5, i1
    %fcsr_d8 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %37 = llhd.extract_element %fcsr_d8, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %38 = llhd.extract_element %37, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %39 = llhd.insert_slice %36, %38, 1 : i5, i1
    %fcsr_d9 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %40 = llhd.extract_element %fcsr_d9, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %41 = llhd.extract_element %40, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %42 = llhd.insert_slice %39, %41, 2 : i5, i1
    %fcsr_d10 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %43 = llhd.extract_element %fcsr_d10, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %44 = llhd.extract_element %43, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %45 = llhd.insert_slice %42, %44, 3 : i5, i1
    %fcsr_d11 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %46 = llhd.extract_element %fcsr_d11, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %47 = llhd.extract_element %46, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %48 = llhd.insert_slice %45, %47, 4 : i5, i1
    %49 = llhd.insert_slice %32, %48, 0 : i8, i5
    %fcsr_d12 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %50 = llhd.extract_element %fcsr_d12, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %51 = llhd.insert_slice %49, %50, 5 : i8, i3
    %52 = llhd.array %51, %31 : !llhd.array<2xi8>
    %53 = llhd.dyn_extract_element %52, %rst_i2 : (!llhd.array<2xi8>, i1) -> i8
    %54 = llhd.const 3 : i32
    %55 = llhd.const 0 : i8
    %56 = llhd.shr %53, %55, %54 : (i8, i8, i32) -> i8
    %57 = llhd.extract_slice %56, 0 : i8 -> i5
    %58 = llhd.const 0 : i32
    %59 = llhd.const 0 : i5
    %60 = llhd.shr %57, %59, %58 : (i5, i5, i32) -> i5
    %61 = llhd.extract_slice %60, 0 : i5 -> i1
    %rst_i3 = llhd.prb %rst_i : !llhd.sig<i1>
    %62 = llhd.const 0 : i8
    %63 = llhd.const 0 : i8
    %64 = llhd.const 0 : i5
    %fcsr_d13 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %65 = llhd.extract_element %fcsr_d13, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %66 = llhd.extract_element %65, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %67 = llhd.insert_slice %64, %66, 0 : i5, i1
    %fcsr_d14 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %68 = llhd.extract_element %fcsr_d14, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %69 = llhd.extract_element %68, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %70 = llhd.insert_slice %67, %69, 1 : i5, i1
    %fcsr_d15 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %71 = llhd.extract_element %fcsr_d15, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %72 = llhd.extract_element %71, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %73 = llhd.insert_slice %70, %72, 2 : i5, i1
    %fcsr_d16 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %74 = llhd.extract_element %fcsr_d16, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %75 = llhd.extract_element %74, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %76 = llhd.insert_slice %73, %75, 3 : i5, i1
    %fcsr_d17 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %77 = llhd.extract_element %fcsr_d17, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %78 = llhd.extract_element %77, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %79 = llhd.insert_slice %76, %78, 4 : i5, i1
    %80 = llhd.insert_slice %63, %79, 0 : i8, i5
    %fcsr_d18 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %81 = llhd.extract_element %fcsr_d18, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %82 = llhd.insert_slice %80, %81, 5 : i8, i3
    %83 = llhd.array %82, %62 : !llhd.array<2xi8>
    %84 = llhd.dyn_extract_element %83, %rst_i3 : (!llhd.array<2xi8>, i1) -> i8
    %85 = llhd.const 3 : i32
    %86 = llhd.const 0 : i8
    %87 = llhd.shr %84, %86, %85 : (i8, i8, i32) -> i8
    %88 = llhd.extract_slice %87, 0 : i8 -> i5
    %89 = llhd.const 1 : i32
    %90 = llhd.const 0 : i5
    %91 = llhd.shr %88, %90, %89 : (i5, i5, i32) -> i5
    %92 = llhd.extract_slice %91, 0 : i5 -> i1
    %rst_i4 = llhd.prb %rst_i : !llhd.sig<i1>
    %93 = llhd.const 0 : i8
    %94 = llhd.const 0 : i8
    %95 = llhd.const 0 : i5
    %fcsr_d19 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %96 = llhd.extract_element %fcsr_d19, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %97 = llhd.extract_element %96, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %98 = llhd.insert_slice %95, %97, 0 : i5, i1
    %fcsr_d20 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %99 = llhd.extract_element %fcsr_d20, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %100 = llhd.extract_element %99, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %101 = llhd.insert_slice %98, %100, 1 : i5, i1
    %fcsr_d21 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %102 = llhd.extract_element %fcsr_d21, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %103 = llhd.extract_element %102, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %104 = llhd.insert_slice %101, %103, 2 : i5, i1
    %fcsr_d22 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %105 = llhd.extract_element %fcsr_d22, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %106 = llhd.extract_element %105, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %107 = llhd.insert_slice %104, %106, 3 : i5, i1
    %fcsr_d23 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %108 = llhd.extract_element %fcsr_d23, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %109 = llhd.extract_element %108, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %110 = llhd.insert_slice %107, %109, 4 : i5, i1
    %111 = llhd.insert_slice %94, %110, 0 : i8, i5
    %fcsr_d24 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %112 = llhd.extract_element %fcsr_d24, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %113 = llhd.insert_slice %111, %112, 5 : i8, i3
    %114 = llhd.array %113, %93 : !llhd.array<2xi8>
    %115 = llhd.dyn_extract_element %114, %rst_i4 : (!llhd.array<2xi8>, i1) -> i8
    %116 = llhd.const 3 : i32
    %117 = llhd.const 0 : i8
    %118 = llhd.shr %115, %117, %116 : (i8, i8, i32) -> i8
    %119 = llhd.extract_slice %118, 0 : i8 -> i5
    %120 = llhd.const 2 : i32
    %121 = llhd.const 0 : i5
    %122 = llhd.shr %119, %121, %120 : (i5, i5, i32) -> i5
    %123 = llhd.extract_slice %122, 0 : i5 -> i1
    %rst_i5 = llhd.prb %rst_i : !llhd.sig<i1>
    %124 = llhd.const 0 : i8
    %125 = llhd.const 0 : i8
    %126 = llhd.const 0 : i5
    %fcsr_d25 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %127 = llhd.extract_element %fcsr_d25, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %128 = llhd.extract_element %127, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %129 = llhd.insert_slice %126, %128, 0 : i5, i1
    %fcsr_d26 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %130 = llhd.extract_element %fcsr_d26, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %131 = llhd.extract_element %130, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %132 = llhd.insert_slice %129, %131, 1 : i5, i1
    %fcsr_d27 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %133 = llhd.extract_element %fcsr_d27, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %134 = llhd.extract_element %133, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %135 = llhd.insert_slice %132, %134, 2 : i5, i1
    %fcsr_d28 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %136 = llhd.extract_element %fcsr_d28, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %137 = llhd.extract_element %136, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %138 = llhd.insert_slice %135, %137, 3 : i5, i1
    %fcsr_d29 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %139 = llhd.extract_element %fcsr_d29, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %140 = llhd.extract_element %139, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %141 = llhd.insert_slice %138, %140, 4 : i5, i1
    %142 = llhd.insert_slice %125, %141, 0 : i8, i5
    %fcsr_d30 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %143 = llhd.extract_element %fcsr_d30, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %144 = llhd.insert_slice %142, %143, 5 : i8, i3
    %145 = llhd.array %144, %124 : !llhd.array<2xi8>
    %146 = llhd.dyn_extract_element %145, %rst_i5 : (!llhd.array<2xi8>, i1) -> i8
    %147 = llhd.const 3 : i32
    %148 = llhd.const 0 : i8
    %149 = llhd.shr %146, %148, %147 : (i8, i8, i32) -> i8
    %150 = llhd.extract_slice %149, 0 : i8 -> i5
    %151 = llhd.const 3 : i32
    %152 = llhd.const 0 : i5
    %153 = llhd.shr %150, %152, %151 : (i5, i5, i32) -> i5
    %154 = llhd.extract_slice %153, 0 : i5 -> i1
    %rst_i6 = llhd.prb %rst_i : !llhd.sig<i1>
    %155 = llhd.const 0 : i8
    %156 = llhd.const 0 : i8
    %157 = llhd.const 0 : i5
    %fcsr_d31 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %158 = llhd.extract_element %fcsr_d31, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %159 = llhd.extract_element %158, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %160 = llhd.insert_slice %157, %159, 0 : i5, i1
    %fcsr_d32 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %161 = llhd.extract_element %fcsr_d32, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %162 = llhd.extract_element %161, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %163 = llhd.insert_slice %160, %162, 1 : i5, i1
    %fcsr_d33 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %164 = llhd.extract_element %fcsr_d33, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %165 = llhd.extract_element %164, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %166 = llhd.insert_slice %163, %165, 2 : i5, i1
    %fcsr_d34 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %167 = llhd.extract_element %fcsr_d34, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %168 = llhd.extract_element %167, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %169 = llhd.insert_slice %166, %168, 3 : i5, i1
    %fcsr_d35 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %170 = llhd.extract_element %fcsr_d35, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %171 = llhd.extract_element %170, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %172 = llhd.insert_slice %169, %171, 4 : i5, i1
    %173 = llhd.insert_slice %156, %172, 0 : i8, i5
    %fcsr_d36 = llhd.prb %fcsr_d : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %174 = llhd.extract_element %fcsr_d36, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %175 = llhd.insert_slice %173, %174, 5 : i8, i3
    %176 = llhd.array %175, %155 : !llhd.array<2xi8>
    %177 = llhd.dyn_extract_element %176, %rst_i6 : (!llhd.array<2xi8>, i1) -> i8
    %178 = llhd.const 3 : i32
    %179 = llhd.const 0 : i8
    %180 = llhd.shr %177, %179, %178 : (i8, i8, i32) -> i8
    %181 = llhd.extract_slice %180, 0 : i8 -> i5
    %182 = llhd.const 4 : i32
    %183 = llhd.const 0 : i5
    %184 = llhd.shr %181, %183, %182 : (i5, i5, i32) -> i5
    %185 = llhd.extract_slice %184, 0 : i5 -> i1
    %186 = llhd.tuple %61, %92, %123, %154, %185 : tuple<i1, i1, i1, i1, i1>
    %187 = llhd.tuple %30, %186 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %188 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %fcsr_q, %187 after %188 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    br ^0
}

llhd.proc @snitch.param1.always_comb.572.1(%stall: !llhd.sig<i1>) -> (%core_events_o: !llhd.sig<tuple<i1, i1, i1, i1>> ) {
    br ^0
^0:
    br ^body
^body:
    %1 = llhd.const 0 : i4
    %2 = llhd.const 0 : i1
    %3 = llhd.insert_slice %1, %2, 0 : i4, i1
    %4 = llhd.const 0 : i32
    %5 = llhd.const 0 : i4
    %6 = llhd.shr %3, %5, %4 : (i4, i4, i32) -> i4
    %7 = llhd.extract_slice %6, 0 : i4 -> i1
    %8 = llhd.const 0 : i4
    %9 = llhd.const 0 : i1
    %10 = llhd.insert_slice %8, %9, 0 : i4, i1
    %11 = llhd.const 1 : i32
    %12 = llhd.const 0 : i4
    %13 = llhd.shr %10, %12, %11 : (i4, i4, i32) -> i4
    %14 = llhd.extract_slice %13, 0 : i4 -> i1
    %15 = llhd.const 0 : i4
    %16 = llhd.const 0 : i1
    %17 = llhd.insert_slice %15, %16, 0 : i4, i1
    %18 = llhd.const 2 : i32
    %19 = llhd.const 0 : i4
    %20 = llhd.shr %17, %19, %18 : (i4, i4, i32) -> i4
    %21 = llhd.extract_slice %20, 0 : i4 -> i1
    %22 = llhd.const 0 : i4
    %23 = llhd.const 0 : i1
    %24 = llhd.insert_slice %22, %23, 0 : i4, i1
    %25 = llhd.const 3 : i32
    %26 = llhd.const 0 : i4
    %27 = llhd.shr %24, %26, %25 : (i4, i4, i32) -> i4
    %28 = llhd.extract_slice %27, 0 : i4 -> i1
    %29 = llhd.tuple %7, %14, %21, %28 : tuple<i1, i1, i1, i1>
    %30 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %core_events_o, %29 after %30 : !llhd.sig<tuple<i1, i1, i1, i1>>
    %31 = llhd.extract_element %core_events_o, 3 : !llhd.sig<tuple<i1, i1, i1, i1>> -> !llhd.sig<i1>
    %stall1 = llhd.prb %stall : !llhd.sig<i1>
    %32 = llhd.not %stall1 : i1
    %33 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %31, %32 after %33 : !llhd.sig<i1>
    br ^check
^check:
    llhd.wait (%stall : !llhd.sig<i1>), ^body
}

llhd.proc @snitch.param1.always_comb.590.1(%acc_pid_i: !llhd.sig<i5>, %rd: !llhd.sig<i5>, %stall: !llhd.sig<i1>, %sb_q: !llhd.sig<i32>, %is_load: !llhd.sig<i1>, %lsu_rd: !llhd.sig<i5>, %retire_load: !llhd.sig<i1>, %retire_acc: !llhd.sig<i1>, %acc_register_rd: !llhd.sig<i1>) -> (%sb_d: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^body
^body:
    %sb_q1 = llhd.prb %sb_q : !llhd.sig<i32>
    %1 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %sb_d, %sb_q1 after %1 : !llhd.sig<i32>
    %retire_load1 = llhd.prb %retire_load : !llhd.sig<i1>
    cond_br %retire_load1, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %lsu_rd1 = llhd.prb %lsu_rd : !llhd.sig<i5>
    %2 = llhd.const 0 : i32
    %3 = llhd.dyn_extract_slice %sb_d, %lsu_rd1 : (!llhd.sig<i32>, i5) -> !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %4 after %5 : !llhd.sig<i1>
    br ^if_exit
^check:
    llhd.wait (%acc_pid_i, %rd, %stall, %sb_q, %is_load, %lsu_rd, %retire_load, %retire_acc, %acc_register_rd : !llhd.sig<i5>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>), ^body
^if_exit:
    %is_load1 = llhd.prb %is_load : !llhd.sig<i1>
    %acc_register_rd1 = llhd.prb %acc_register_rd : !llhd.sig<i1>
    %6 = llhd.or %is_load1, %acc_register_rd1 : i1
    %stall1 = llhd.prb %stall : !llhd.sig<i1>
    %7 = llhd.not %stall1 : i1
    %8 = llhd.and %6, %7 : i1
    cond_br %8, ^if_true1, ^if_false1
^if_false1:
    br ^if_exit1
^if_true1:
    %rd1 = llhd.prb %rd : !llhd.sig<i5>
    %9 = llhd.const 0 : i32
    %10 = llhd.dyn_extract_slice %sb_d, %rd1 : (!llhd.sig<i32>, i5) -> !llhd.sig<i1>
    %11 = llhd.const 1 : i1
    %12 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %10, %11 after %12 : !llhd.sig<i1>
    br ^if_exit1
^if_exit1:
    %retire_acc1 = llhd.prb %retire_acc : !llhd.sig<i1>
    cond_br %retire_acc1, ^if_true2, ^if_false2
^if_false2:
    br ^if_exit2
^if_true2:
    %acc_pid_i1 = llhd.prb %acc_pid_i : !llhd.sig<i5>
    %13 = llhd.const 0 : i1
    %14 = llhd.const 0 : i5
    %15 = llhd.shr %acc_pid_i1, %14, %13 : (i5, i5, i1) -> i5
    %16 = llhd.extract_slice %15, 0 : i5 -> i5
    %17 = llhd.const 0 : i32
    %18 = llhd.dyn_extract_slice %sb_d, %16 : (!llhd.sig<i32>, i5) -> !llhd.sig<i1>
    %19 = llhd.const 0 : i1
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %18, %19 after %20 : !llhd.sig<i1>
    br ^if_exit2
^if_exit2:
    %21 = llhd.const 0 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.dyn_extract_slice %sb_d, %21 : (!llhd.sig<i32>, i32) -> !llhd.sig<i1>
    %24 = llhd.const 0 : i1
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %23, %24 after %25 : !llhd.sig<i1>
    br ^check
}

llhd.proc @snitch.param1.always_comb.600.1(%zero_lsb: !llhd.sig<i1>, %pc_q: !llhd.sig<i32>, %wfi_q: !llhd.sig<i1>, %consec_pc: !llhd.sig<i32>, %alu_result: !llhd.sig<i32>, %stall: !llhd.sig<i1>, %next_pc: !llhd.sig<i2>) -> (%pc_d: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^body
^body:
    %pc_q1 = llhd.prb %pc_q : !llhd.sig<i32>
    %1 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %pc_d, %pc_q1 after %1 : !llhd.sig<i32>
    %stall1 = llhd.prb %stall : !llhd.sig<i1>
    %2 = llhd.not %stall1 : i1
    %wfi_q1 = llhd.prb %wfi_q : !llhd.sig<i1>
    %3 = llhd.not %wfi_q1 : i1
    %4 = llhd.and %2, %3 : i1
    cond_br %4, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %next_pc1 = llhd.prb %next_pc : !llhd.sig<i2>
    %5 = llhd.const 0 : i1
    %6 = llhd.const 0 : i2
    %7 = llhd.const 3 : i2
    %8 = llhd.and %next_pc1, %7 : i2
    %9 = llhd.and %6, %7 : i2
    %10 = llhd.eq %8, %9 : i2
    %11 = llhd.or %5, %10 : i1
    cond_br %11, ^case_body, ^12
^check:
    llhd.wait (%zero_lsb, %pc_q, %wfi_q, %consec_pc, %alu_result, %stall, %next_pc : !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i2>), ^body
^12:
    %13 = llhd.const 0 : i1
    %14 = llhd.const 1 : i2
    %15 = llhd.const 3 : i2
    %16 = llhd.and %next_pc1, %15 : i2
    %17 = llhd.and %14, %15 : i2
    %18 = llhd.eq %16, %17 : i2
    %19 = llhd.or %13, %18 : i1
    cond_br %19, ^case_body1, ^20
^case_body:
    %consec_pc1 = llhd.prb %consec_pc : !llhd.sig<i32>
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %pc_d, %consec_pc1 after %21 : !llhd.sig<i32>
    br ^case_exit
^if_exit:
    br ^check
^case_exit:
    br ^if_exit
^20:
    %22 = llhd.const 0 : i1
    %23 = llhd.const 2 : i2
    %24 = llhd.const 3 : i2
    %25 = llhd.and %next_pc1, %24 : i2
    %26 = llhd.and %23, %24 : i2
    %27 = llhd.eq %25, %26 : i2
    %28 = llhd.or %22, %27 : i1
    cond_br %28, ^case_body2, ^29
^case_body1:
    %alu_result1 = llhd.prb %alu_result : !llhd.sig<i32>
    %30 = llhd.const 0 : i32
    %zero_lsb1 = llhd.prb %zero_lsb : !llhd.sig<i1>
    %31 = llhd.not %zero_lsb1 : i1
    %32 = llhd.insert_slice %30, %31, 0 : i32, i1
    %33 = llhd.const 0 : i1
    %34 = llhd.const 1 : i1
    %35 = llhd.insert_slice %33, %34, 0 : i1, i1
    %36 = llhd.const 0 : i31
    %37 = llhd.insert_slice %36, %35, 0 : i31, i1
    %38 = llhd.insert_slice %37, %35, 1 : i31, i1
    %39 = llhd.insert_slice %38, %35, 2 : i31, i1
    %40 = llhd.insert_slice %39, %35, 3 : i31, i1
    %41 = llhd.insert_slice %40, %35, 4 : i31, i1
    %42 = llhd.insert_slice %41, %35, 5 : i31, i1
    %43 = llhd.insert_slice %42, %35, 6 : i31, i1
    %44 = llhd.insert_slice %43, %35, 7 : i31, i1
    %45 = llhd.insert_slice %44, %35, 8 : i31, i1
    %46 = llhd.insert_slice %45, %35, 9 : i31, i1
    %47 = llhd.insert_slice %46, %35, 10 : i31, i1
    %48 = llhd.insert_slice %47, %35, 11 : i31, i1
    %49 = llhd.insert_slice %48, %35, 12 : i31, i1
    %50 = llhd.insert_slice %49, %35, 13 : i31, i1
    %51 = llhd.insert_slice %50, %35, 14 : i31, i1
    %52 = llhd.insert_slice %51, %35, 15 : i31, i1
    %53 = llhd.insert_slice %52, %35, 16 : i31, i1
    %54 = llhd.insert_slice %53, %35, 17 : i31, i1
    %55 = llhd.insert_slice %54, %35, 18 : i31, i1
    %56 = llhd.insert_slice %55, %35, 19 : i31, i1
    %57 = llhd.insert_slice %56, %35, 20 : i31, i1
    %58 = llhd.insert_slice %57, %35, 21 : i31, i1
    %59 = llhd.insert_slice %58, %35, 22 : i31, i1
    %60 = llhd.insert_slice %59, %35, 23 : i31, i1
    %61 = llhd.insert_slice %60, %35, 24 : i31, i1
    %62 = llhd.insert_slice %61, %35, 25 : i31, i1
    %63 = llhd.insert_slice %62, %35, 26 : i31, i1
    %64 = llhd.insert_slice %63, %35, 27 : i31, i1
    %65 = llhd.insert_slice %64, %35, 28 : i31, i1
    %66 = llhd.insert_slice %65, %35, 29 : i31, i1
    %67 = llhd.insert_slice %66, %35, 30 : i31, i1
    %68 = llhd.insert_slice %32, %67, 1 : i32, i31
    %69 = llhd.and %alu_result1, %68 : i32
    %70 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %pc_d, %69 after %70 : !llhd.sig<i32>
    br ^case_exit
^29:
    br ^case_exit
^case_body2:
    %71 = llhd.const 65536 : i32
    %72 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %pc_d, %71 after %72 : !llhd.sig<i32>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.604.1(%inst_data_i: !llhd.sig<i32>, %wake_up_sync_i: !llhd.sig<i1>, %illegal_inst: !llhd.sig<i1>, %wfi_q: !llhd.sig<i1>, %uimm: !llhd.sig<i32>, %valid_instr: !llhd.sig<i1>, %write_rd: !llhd.sig<i1>, %csr_rvalue: !llhd.sig<i32>) -> (%acc_qvalid_o: !llhd.sig<i1> , %illegal_inst1: !llhd.sig<i1> , %zero_lsb: !llhd.sig<i1> , %wfi_d: !llhd.sig<i1> , %is_load: !llhd.sig<i1> , %is_store: !llhd.sig<i1> , %is_signed: !llhd.sig<i1> , %ls_size: !llhd.sig<i2> , %ls_amo: !llhd.sig<i4> , %alu_op: !llhd.sig<i4> , %opa_select: !llhd.sig<i4> , %opb_select: !llhd.sig<i4> , %write_rd1: !llhd.sig<i1> , %uses_rd: !llhd.sig<i1> , %next_pc: !llhd.sig<i2> , %rd_select: !llhd.sig<i2> , %rd_bypass: !llhd.sig<i32> , %is_branch: !llhd.sig<i1> , %csr_en: !llhd.sig<i1> , %acc_register_rd: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.prb %write_rd1 : !llhd.sig<i1>
    %write_rd.shadow = llhd.var %1 : i1
    %2 = llhd.prb %illegal_inst1 : !llhd.sig<i1>
    %illegal_inst.shadow = llhd.var %2 : i1
    br ^body
^body:
    %3 = llhd.prb %write_rd1 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3 : !llhd.ptr<i1>
    %4 = llhd.prb %illegal_inst1 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %4 : !llhd.ptr<i1>
    %5 = llhd.const 0 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %5 after %6 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %5 : !llhd.ptr<i1>
    %7 = llhd.const 0 : i4
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %7 after %8 : !llhd.sig<i4>
    %9 = llhd.const 0 : i4
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %9 after %10 : !llhd.sig<i4>
    %11 = llhd.const 0 : i4
    %12 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %11 after %12 : !llhd.sig<i4>
    %13 = llhd.const 0 : i2
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %next_pc, %13 after %14 : !llhd.sig<i2>
    %15 = llhd.const 0 : i2
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %15 after %16 : !llhd.sig<i2>
    %17 = llhd.const 1 : i1
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %17 after %18 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %17 : !llhd.ptr<i1>
    %write_rd2 = llhd.load %write_rd.shadow : !llhd.ptr<i1>
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %write_rd2 after %19 : !llhd.sig<i1>
    %20 = llhd.const 0 : i32
    %21 = llhd.const 0 : i1
    %22 = llhd.insert_slice %20, %21, 0 : i32, i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %22 after %23 : !llhd.sig<i32>
    %24 = llhd.const 0 : i1
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %zero_lsb, %24 after %25 : !llhd.sig<i1>
    %26 = llhd.const 0 : i1
    %27 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %26 after %27 : !llhd.sig<i1>
    %28 = llhd.const 0 : i1
    %29 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %28 after %29 : !llhd.sig<i1>
    %30 = llhd.const 0 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_store, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const 0 : i1
    %33 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %32 after %33 : !llhd.sig<i1>
    %34 = llhd.const 0 : i2
    %35 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %34 after %35 : !llhd.sig<i2>
    %36 = llhd.const 0 : i4
    %37 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %36 after %37 : !llhd.sig<i4>
    %38 = llhd.const 0 : i1
    %39 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %38 after %39 : !llhd.sig<i1>
    %40 = llhd.const 0 : i1
    %41 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %40 after %41 : !llhd.sig<i1>
    %42 = llhd.const 0 : i1
    %43 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %42 after %43 : !llhd.sig<i1>
    %wake_up_sync_i1 = llhd.prb %wake_up_sync_i : !llhd.sig<i1>
    %44 = llhd.const 0 : i1
    %wfi_q1 = llhd.prb %wfi_q : !llhd.sig<i1>
    %45 = llhd.array %wfi_q1, %44 : !llhd.array<2xi1>
    %46 = llhd.dyn_extract_element %45, %wake_up_sync_i1 : (!llhd.array<2xi1>, i1) -> i1
    %47 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %wfi_d, %46 after %47 : !llhd.sig<i1>
    %inst_data_i1 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %48 = llhd.const 0 : i1
    %49 = llhd.const 51 : i32
    %50 = llhd.const 4261441663 : i32
    %51 = llhd.and %inst_data_i1, %50 : i32
    %52 = llhd.and %49, %50 : i32
    %53 = llhd.eq %51, %52 : i32
    %54 = llhd.or %48, %53 : i1
    cond_br %54, ^case_body, ^55
^55:
    %56 = llhd.const 0 : i1
    %57 = llhd.const 19 : i32
    %58 = llhd.const 28799 : i32
    %59 = llhd.and %inst_data_i1, %58 : i32
    %60 = llhd.and %57, %58 : i32
    %61 = llhd.eq %59, %60 : i32
    %62 = llhd.or %56, %61 : i1
    cond_br %62, ^case_body1, ^63
^case_body:
    %64 = llhd.const 1 : i4
    %65 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %64 after %65 : !llhd.sig<i4>
    %66 = llhd.const 1 : i4
    %67 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %66 after %67 : !llhd.sig<i4>
    br ^case_exit
^check:
    llhd.wait (%inst_data_i, %wake_up_sync_i, %illegal_inst1, %wfi_q, %uimm, %valid_instr, %write_rd1, %csr_rvalue : !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>), ^body
^case_exit:
    %illegal_inst2 = llhd.load %illegal_inst.shadow : !llhd.ptr<i1>
    cond_br %illegal_inst2, ^if_true, ^if_false
^if_false:
    br ^if_exit61
^if_true:
    %68 = llhd.const 0 : i1
    %69 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %68 after %69 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %68 : !llhd.ptr<i1>
    %70 = llhd.const 0 : i1
    %71 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %70 after %71 : !llhd.sig<i1>
    %72 = llhd.const 2 : i2
    %73 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %next_pc, %72 after %73 : !llhd.sig<i2>
    br ^if_exit61
^63:
    %74 = llhd.const 0 : i1
    %75 = llhd.const 1073741875 : i32
    %76 = llhd.const 4261441663 : i32
    %77 = llhd.and %inst_data_i1, %76 : i32
    %78 = llhd.and %75, %76 : i32
    %79 = llhd.eq %77, %78 : i32
    %80 = llhd.or %74, %79 : i1
    cond_br %80, ^case_body2, ^81
^case_body1:
    %82 = llhd.const 1 : i4
    %83 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %82 after %83 : !llhd.sig<i4>
    %84 = llhd.const 2 : i4
    %85 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %84 after %85 : !llhd.sig<i4>
    br ^case_exit
^81:
    %86 = llhd.const 0 : i1
    %87 = llhd.const 16435 : i32
    %88 = llhd.const 4261441663 : i32
    %89 = llhd.and %inst_data_i1, %88 : i32
    %90 = llhd.and %87, %88 : i32
    %91 = llhd.eq %89, %90 : i32
    %92 = llhd.or %86, %91 : i1
    cond_br %92, ^case_body3, ^93
^case_body2:
    %94 = llhd.const 1 : i4
    %95 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %94 after %95 : !llhd.sig<i4>
    %96 = llhd.const 1 : i4
    %97 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %96 after %97 : !llhd.sig<i4>
    %98 = llhd.const 1 : i4
    %99 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %98 after %99 : !llhd.sig<i4>
    br ^case_exit
^93:
    %100 = llhd.const 0 : i1
    %101 = llhd.const 16403 : i32
    %102 = llhd.const 28799 : i32
    %103 = llhd.and %inst_data_i1, %102 : i32
    %104 = llhd.and %101, %102 : i32
    %105 = llhd.eq %103, %104 : i32
    %106 = llhd.or %100, %105 : i1
    cond_br %106, ^case_body4, ^107
^case_body3:
    %108 = llhd.const 1 : i4
    %109 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %108 after %109 : !llhd.sig<i4>
    %110 = llhd.const 1 : i4
    %111 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %110 after %111 : !llhd.sig<i4>
    %112 = llhd.const 7 : i4
    %113 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %112 after %113 : !llhd.sig<i4>
    br ^case_exit
^107:
    %114 = llhd.const 0 : i1
    %115 = llhd.const 24627 : i32
    %116 = llhd.const 4261441663 : i32
    %117 = llhd.and %inst_data_i1, %116 : i32
    %118 = llhd.and %115, %116 : i32
    %119 = llhd.eq %117, %118 : i32
    %120 = llhd.or %114, %119 : i1
    cond_br %120, ^case_body5, ^121
^case_body4:
    %122 = llhd.const 7 : i4
    %123 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %122 after %123 : !llhd.sig<i4>
    %124 = llhd.const 1 : i4
    %125 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %124 after %125 : !llhd.sig<i4>
    %126 = llhd.const 2 : i4
    %127 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %126 after %127 : !llhd.sig<i4>
    br ^case_exit
^121:
    %128 = llhd.const 0 : i1
    %129 = llhd.const 24595 : i32
    %130 = llhd.const 28799 : i32
    %131 = llhd.and %inst_data_i1, %130 : i32
    %132 = llhd.and %129, %130 : i32
    %133 = llhd.eq %131, %132 : i32
    %134 = llhd.or %128, %133 : i1
    cond_br %134, ^case_body6, ^135
^case_body5:
    %136 = llhd.const 1 : i4
    %137 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %136 after %137 : !llhd.sig<i4>
    %138 = llhd.const 1 : i4
    %139 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %138 after %139 : !llhd.sig<i4>
    %140 = llhd.const 8 : i4
    %141 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %140 after %141 : !llhd.sig<i4>
    br ^case_exit
^135:
    %142 = llhd.const 0 : i1
    %143 = llhd.const 28723 : i32
    %144 = llhd.const 4261441663 : i32
    %145 = llhd.and %inst_data_i1, %144 : i32
    %146 = llhd.and %143, %144 : i32
    %147 = llhd.eq %145, %146 : i32
    %148 = llhd.or %142, %147 : i1
    cond_br %148, ^case_body7, ^149
^case_body6:
    %150 = llhd.const 8 : i4
    %151 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %150 after %151 : !llhd.sig<i4>
    %152 = llhd.const 1 : i4
    %153 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %152 after %153 : !llhd.sig<i4>
    %154 = llhd.const 2 : i4
    %155 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %154 after %155 : !llhd.sig<i4>
    br ^case_exit
^149:
    %156 = llhd.const 0 : i1
    %157 = llhd.const 28691 : i32
    %158 = llhd.const 28799 : i32
    %159 = llhd.and %inst_data_i1, %158 : i32
    %160 = llhd.and %157, %158 : i32
    %161 = llhd.eq %159, %160 : i32
    %162 = llhd.or %156, %161 : i1
    cond_br %162, ^case_body8, ^163
^case_body7:
    %164 = llhd.const 9 : i4
    %165 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %164 after %165 : !llhd.sig<i4>
    %166 = llhd.const 1 : i4
    %167 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %166 after %167 : !llhd.sig<i4>
    %168 = llhd.const 1 : i4
    %169 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %168 after %169 : !llhd.sig<i4>
    br ^case_exit
^163:
    %170 = llhd.const 0 : i1
    %171 = llhd.const 8243 : i32
    %172 = llhd.const 4261441663 : i32
    %173 = llhd.and %inst_data_i1, %172 : i32
    %174 = llhd.and %171, %172 : i32
    %175 = llhd.eq %173, %174 : i32
    %176 = llhd.or %170, %175 : i1
    cond_br %176, ^case_body9, ^177
^case_body8:
    %178 = llhd.const 9 : i4
    %179 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %178 after %179 : !llhd.sig<i4>
    %180 = llhd.const 1 : i4
    %181 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %180 after %181 : !llhd.sig<i4>
    %182 = llhd.const 2 : i4
    %183 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %182 after %183 : !llhd.sig<i4>
    br ^case_exit
^177:
    %184 = llhd.const 0 : i1
    %185 = llhd.const 8211 : i32
    %186 = llhd.const 28799 : i32
    %187 = llhd.and %inst_data_i1, %186 : i32
    %188 = llhd.and %185, %186 : i32
    %189 = llhd.eq %187, %188 : i32
    %190 = llhd.or %184, %189 : i1
    cond_br %190, ^case_body10, ^191
^case_body9:
    %192 = llhd.const 2 : i4
    %193 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %192 after %193 : !llhd.sig<i4>
    %194 = llhd.const 1 : i4
    %195 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %194 after %195 : !llhd.sig<i4>
    %196 = llhd.const 1 : i4
    %197 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %196 after %197 : !llhd.sig<i4>
    br ^case_exit
^191:
    %198 = llhd.const 0 : i1
    %199 = llhd.const 12339 : i32
    %200 = llhd.const 4261441663 : i32
    %201 = llhd.and %inst_data_i1, %200 : i32
    %202 = llhd.and %199, %200 : i32
    %203 = llhd.eq %201, %202 : i32
    %204 = llhd.or %198, %203 : i1
    cond_br %204, ^case_body11, ^205
^case_body10:
    %206 = llhd.const 2 : i4
    %207 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %206 after %207 : !llhd.sig<i4>
    %208 = llhd.const 1 : i4
    %209 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %208 after %209 : !llhd.sig<i4>
    %210 = llhd.const 2 : i4
    %211 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %210 after %211 : !llhd.sig<i4>
    br ^case_exit
^205:
    %212 = llhd.const 0 : i1
    %213 = llhd.const 12307 : i32
    %214 = llhd.const 28799 : i32
    %215 = llhd.and %inst_data_i1, %214 : i32
    %216 = llhd.and %213, %214 : i32
    %217 = llhd.eq %215, %216 : i32
    %218 = llhd.or %212, %217 : i1
    cond_br %218, ^case_body12, ^219
^case_body11:
    %220 = llhd.const 3 : i4
    %221 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %220 after %221 : !llhd.sig<i4>
    %222 = llhd.const 1 : i4
    %223 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %222 after %223 : !llhd.sig<i4>
    %224 = llhd.const 1 : i4
    %225 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %224 after %225 : !llhd.sig<i4>
    br ^case_exit
^219:
    %226 = llhd.const 0 : i1
    %227 = llhd.const 4147 : i32
    %228 = llhd.const 4261441663 : i32
    %229 = llhd.and %inst_data_i1, %228 : i32
    %230 = llhd.and %227, %228 : i32
    %231 = llhd.eq %229, %230 : i32
    %232 = llhd.or %226, %231 : i1
    cond_br %232, ^case_body13, ^233
^case_body12:
    %234 = llhd.const 3 : i4
    %235 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %234 after %235 : !llhd.sig<i4>
    %236 = llhd.const 1 : i4
    %237 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %236 after %237 : !llhd.sig<i4>
    %238 = llhd.const 2 : i4
    %239 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %238 after %239 : !llhd.sig<i4>
    br ^case_exit
^233:
    %240 = llhd.const 0 : i1
    %241 = llhd.const 20531 : i32
    %242 = llhd.const 4261441663 : i32
    %243 = llhd.and %inst_data_i1, %242 : i32
    %244 = llhd.and %241, %242 : i32
    %245 = llhd.eq %243, %244 : i32
    %246 = llhd.or %240, %245 : i1
    cond_br %246, ^case_body14, ^247
^case_body13:
    %248 = llhd.const 4 : i4
    %249 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %248 after %249 : !llhd.sig<i4>
    %250 = llhd.const 1 : i4
    %251 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %250 after %251 : !llhd.sig<i4>
    %252 = llhd.const 1 : i4
    %253 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %252 after %253 : !llhd.sig<i4>
    br ^case_exit
^247:
    %254 = llhd.const 0 : i1
    %255 = llhd.const 1073762355 : i32
    %256 = llhd.const 4261441663 : i32
    %257 = llhd.and %inst_data_i1, %256 : i32
    %258 = llhd.and %255, %256 : i32
    %259 = llhd.eq %257, %258 : i32
    %260 = llhd.or %254, %259 : i1
    cond_br %260, ^case_body15, ^261
^case_body14:
    %262 = llhd.const 5 : i4
    %263 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %262 after %263 : !llhd.sig<i4>
    %264 = llhd.const 1 : i4
    %265 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %264 after %265 : !llhd.sig<i4>
    %266 = llhd.const 1 : i4
    %267 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %266 after %267 : !llhd.sig<i4>
    br ^case_exit
^261:
    %268 = llhd.const 0 : i1
    %269 = llhd.const 4115 : i32
    %270 = llhd.const 4227887231 : i32
    %271 = llhd.and %inst_data_i1, %270 : i32
    %272 = llhd.and %269, %270 : i32
    %273 = llhd.eq %271, %272 : i32
    %274 = llhd.or %268, %273 : i1
    cond_br %274, ^case_body16, ^275
^case_body15:
    %276 = llhd.const 6 : i4
    %277 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %276 after %277 : !llhd.sig<i4>
    %278 = llhd.const 1 : i4
    %279 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %278 after %279 : !llhd.sig<i4>
    %280 = llhd.const 1 : i4
    %281 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %280 after %281 : !llhd.sig<i4>
    br ^case_exit
^275:
    %282 = llhd.const 0 : i1
    %283 = llhd.const 20499 : i32
    %284 = llhd.const 4227887231 : i32
    %285 = llhd.and %inst_data_i1, %284 : i32
    %286 = llhd.and %283, %284 : i32
    %287 = llhd.eq %285, %286 : i32
    %288 = llhd.or %282, %287 : i1
    cond_br %288, ^case_body17, ^289
^case_body16:
    %290 = llhd.const 4 : i4
    %291 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %290 after %291 : !llhd.sig<i4>
    %292 = llhd.const 1 : i4
    %293 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %292 after %293 : !llhd.sig<i4>
    %294 = llhd.const 2 : i4
    %295 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %294 after %295 : !llhd.sig<i4>
    br ^case_exit
^289:
    %296 = llhd.const 0 : i1
    %297 = llhd.const 1073762323 : i32
    %298 = llhd.const 4227887231 : i32
    %299 = llhd.and %inst_data_i1, %298 : i32
    %300 = llhd.and %297, %298 : i32
    %301 = llhd.eq %299, %300 : i32
    %302 = llhd.or %296, %301 : i1
    cond_br %302, ^case_body18, ^303
^case_body17:
    %304 = llhd.const 5 : i4
    %305 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %304 after %305 : !llhd.sig<i4>
    %306 = llhd.const 1 : i4
    %307 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %306 after %307 : !llhd.sig<i4>
    %308 = llhd.const 2 : i4
    %309 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %308 after %309 : !llhd.sig<i4>
    br ^case_exit
^303:
    %310 = llhd.const 0 : i1
    %311 = llhd.const 55 : i32
    %312 = llhd.const 127 : i32
    %313 = llhd.and %inst_data_i1, %312 : i32
    %314 = llhd.and %311, %312 : i32
    %315 = llhd.eq %313, %314 : i32
    %316 = llhd.or %310, %315 : i1
    cond_br %316, ^case_body19, ^317
^case_body18:
    %318 = llhd.const 6 : i4
    %319 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %318 after %319 : !llhd.sig<i4>
    %320 = llhd.const 1 : i4
    %321 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %320 after %321 : !llhd.sig<i4>
    %322 = llhd.const 2 : i4
    %323 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %322 after %323 : !llhd.sig<i4>
    br ^case_exit
^317:
    %324 = llhd.const 0 : i1
    %325 = llhd.const 23 : i32
    %326 = llhd.const 127 : i32
    %327 = llhd.and %inst_data_i1, %326 : i32
    %328 = llhd.and %325, %326 : i32
    %329 = llhd.eq %327, %328 : i32
    %330 = llhd.or %324, %329 : i1
    cond_br %330, ^case_body20, ^331
^case_body19:
    %332 = llhd.const 0 : i4
    %333 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %332 after %333 : !llhd.sig<i4>
    %334 = llhd.const 0 : i4
    %335 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %334 after %335 : !llhd.sig<i4>
    %336 = llhd.const 2 : i2
    %337 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %336 after %337 : !llhd.sig<i2>
    %uimm1 = llhd.prb %uimm : !llhd.sig<i32>
    %338 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %uimm1 after %338 : !llhd.sig<i32>
    br ^case_exit
^331:
    %339 = llhd.const 0 : i1
    %340 = llhd.const 111 : i32
    %341 = llhd.const 127 : i32
    %342 = llhd.and %inst_data_i1, %341 : i32
    %343 = llhd.and %340, %341 : i32
    %344 = llhd.eq %342, %343 : i32
    %345 = llhd.or %339, %344 : i1
    cond_br %345, ^case_body21, ^346
^case_body20:
    %347 = llhd.const 3 : i4
    %348 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %347 after %348 : !llhd.sig<i4>
    %349 = llhd.const 7 : i4
    %350 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %349 after %350 : !llhd.sig<i4>
    br ^case_exit
^346:
    %351 = llhd.const 0 : i1
    %352 = llhd.const 103 : i32
    %353 = llhd.const 28799 : i32
    %354 = llhd.and %inst_data_i1, %353 : i32
    %355 = llhd.and %352, %353 : i32
    %356 = llhd.eq %354, %355 : i32
    %357 = llhd.or %351, %356 : i1
    cond_br %357, ^case_body22, ^358
^case_body21:
    %359 = llhd.const 1 : i2
    %360 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %359 after %360 : !llhd.sig<i2>
    %361 = llhd.const 4 : i4
    %362 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %361 after %362 : !llhd.sig<i4>
    %363 = llhd.const 7 : i4
    %364 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %363 after %364 : !llhd.sig<i4>
    %365 = llhd.const 1 : i2
    %366 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %next_pc, %365 after %366 : !llhd.sig<i2>
    br ^case_exit
^358:
    %367 = llhd.const 0 : i1
    %368 = llhd.const 99 : i32
    %369 = llhd.const 28799 : i32
    %370 = llhd.and %inst_data_i1, %369 : i32
    %371 = llhd.and %368, %369 : i32
    %372 = llhd.eq %370, %371 : i32
    %373 = llhd.or %367, %372 : i1
    cond_br %373, ^case_body23, ^374
^case_body22:
    %375 = llhd.const 1 : i2
    %376 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %375 after %376 : !llhd.sig<i2>
    %377 = llhd.const 1 : i4
    %378 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %377 after %378 : !llhd.sig<i4>
    %379 = llhd.const 2 : i4
    %380 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %379 after %380 : !llhd.sig<i4>
    %381 = llhd.const 1 : i2
    %382 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %next_pc, %381 after %382 : !llhd.sig<i2>
    %383 = llhd.const 1 : i1
    %384 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %zero_lsb, %383 after %384 : !llhd.sig<i1>
    br ^case_exit
^374:
    %385 = llhd.const 0 : i1
    %386 = llhd.const 4195 : i32
    %387 = llhd.const 28799 : i32
    %388 = llhd.and %inst_data_i1, %387 : i32
    %389 = llhd.and %386, %387 : i32
    %390 = llhd.eq %388, %389 : i32
    %391 = llhd.or %385, %390 : i1
    cond_br %391, ^case_body24, ^392
^case_body23:
    %393 = llhd.const 1 : i1
    %394 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %393 after %394 : !llhd.sig<i1>
    %395 = llhd.const 0 : i1
    %396 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %395 after %396 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %395 : !llhd.ptr<i1>
    %397 = llhd.const 11 : i4
    %398 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %397 after %398 : !llhd.sig<i4>
    %399 = llhd.const 1 : i4
    %400 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %399 after %400 : !llhd.sig<i4>
    %401 = llhd.const 1 : i4
    %402 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %401 after %402 : !llhd.sig<i4>
    br ^case_exit
^392:
    %403 = llhd.const 0 : i1
    %404 = llhd.const 16483 : i32
    %405 = llhd.const 28799 : i32
    %406 = llhd.and %inst_data_i1, %405 : i32
    %407 = llhd.and %404, %405 : i32
    %408 = llhd.eq %406, %407 : i32
    %409 = llhd.or %403, %408 : i1
    cond_br %409, ^case_body25, ^410
^case_body24:
    %411 = llhd.const 1 : i1
    %412 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %411 after %412 : !llhd.sig<i1>
    %413 = llhd.const 0 : i1
    %414 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %413 after %414 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %413 : !llhd.ptr<i1>
    %415 = llhd.const 12 : i4
    %416 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %415 after %416 : !llhd.sig<i4>
    %417 = llhd.const 1 : i4
    %418 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %417 after %418 : !llhd.sig<i4>
    %419 = llhd.const 1 : i4
    %420 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %419 after %420 : !llhd.sig<i4>
    br ^case_exit
^410:
    %421 = llhd.const 0 : i1
    %422 = llhd.const 24675 : i32
    %423 = llhd.const 28799 : i32
    %424 = llhd.and %inst_data_i1, %423 : i32
    %425 = llhd.and %422, %423 : i32
    %426 = llhd.eq %424, %425 : i32
    %427 = llhd.or %421, %426 : i1
    cond_br %427, ^case_body26, ^428
^case_body25:
    %429 = llhd.const 1 : i1
    %430 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %429 after %430 : !llhd.sig<i1>
    %431 = llhd.const 0 : i1
    %432 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %431 after %432 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %431 : !llhd.ptr<i1>
    %433 = llhd.const 2 : i4
    %434 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %433 after %434 : !llhd.sig<i4>
    %435 = llhd.const 1 : i4
    %436 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %435 after %436 : !llhd.sig<i4>
    %437 = llhd.const 1 : i4
    %438 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %437 after %438 : !llhd.sig<i4>
    br ^case_exit
^428:
    %439 = llhd.const 0 : i1
    %440 = llhd.const 20579 : i32
    %441 = llhd.const 28799 : i32
    %442 = llhd.and %inst_data_i1, %441 : i32
    %443 = llhd.and %440, %441 : i32
    %444 = llhd.eq %442, %443 : i32
    %445 = llhd.or %439, %444 : i1
    cond_br %445, ^case_body27, ^446
^case_body26:
    %447 = llhd.const 1 : i1
    %448 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %447 after %448 : !llhd.sig<i1>
    %449 = llhd.const 0 : i1
    %450 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %449 after %450 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %449 : !llhd.ptr<i1>
    %451 = llhd.const 3 : i4
    %452 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %451 after %452 : !llhd.sig<i4>
    %453 = llhd.const 1 : i4
    %454 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %453 after %454 : !llhd.sig<i4>
    %455 = llhd.const 1 : i4
    %456 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %455 after %456 : !llhd.sig<i4>
    br ^case_exit
^446:
    %457 = llhd.const 0 : i1
    %458 = llhd.const 28771 : i32
    %459 = llhd.const 28799 : i32
    %460 = llhd.and %inst_data_i1, %459 : i32
    %461 = llhd.and %458, %459 : i32
    %462 = llhd.eq %460, %461 : i32
    %463 = llhd.or %457, %462 : i1
    cond_br %463, ^case_body28, ^464
^case_body27:
    %465 = llhd.const 1 : i1
    %466 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %465 after %466 : !llhd.sig<i1>
    %467 = llhd.const 0 : i1
    %468 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %467 after %468 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %467 : !llhd.ptr<i1>
    %469 = llhd.const 13 : i4
    %470 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %469 after %470 : !llhd.sig<i4>
    %471 = llhd.const 1 : i4
    %472 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %471 after %472 : !llhd.sig<i4>
    %473 = llhd.const 1 : i4
    %474 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %473 after %474 : !llhd.sig<i4>
    br ^case_exit
^464:
    %475 = llhd.const 0 : i1
    %476 = llhd.const 35 : i32
    %477 = llhd.const 28799 : i32
    %478 = llhd.and %inst_data_i1, %477 : i32
    %479 = llhd.and %476, %477 : i32
    %480 = llhd.eq %478, %479 : i32
    %481 = llhd.or %475, %480 : i1
    cond_br %481, ^case_body29, ^482
^case_body28:
    %483 = llhd.const 1 : i1
    %484 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_branch, %483 after %484 : !llhd.sig<i1>
    %485 = llhd.const 0 : i1
    %486 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %485 after %486 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %485 : !llhd.ptr<i1>
    %487 = llhd.const 14 : i4
    %488 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %487 after %488 : !llhd.sig<i4>
    %489 = llhd.const 1 : i4
    %490 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %489 after %490 : !llhd.sig<i4>
    %491 = llhd.const 1 : i4
    %492 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %491 after %492 : !llhd.sig<i4>
    br ^case_exit
^482:
    %493 = llhd.const 0 : i1
    %494 = llhd.const 4131 : i32
    %495 = llhd.const 28799 : i32
    %496 = llhd.and %inst_data_i1, %495 : i32
    %497 = llhd.and %494, %495 : i32
    %498 = llhd.eq %496, %497 : i32
    %499 = llhd.or %493, %498 : i1
    cond_br %499, ^case_body30, ^500
^case_body29:
    %501 = llhd.const 0 : i1
    %502 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %501 after %502 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %501 : !llhd.ptr<i1>
    %503 = llhd.const 1 : i1
    %504 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_store, %503 after %504 : !llhd.sig<i1>
    %505 = llhd.const 1 : i4
    %506 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %505 after %506 : !llhd.sig<i4>
    %507 = llhd.const 5 : i4
    %508 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %507 after %508 : !llhd.sig<i4>
    br ^case_exit
^500:
    %509 = llhd.const 0 : i1
    %510 = llhd.const 8227 : i32
    %511 = llhd.const 28799 : i32
    %512 = llhd.and %inst_data_i1, %511 : i32
    %513 = llhd.and %510, %511 : i32
    %514 = llhd.eq %512, %513 : i32
    %515 = llhd.or %509, %514 : i1
    cond_br %515, ^case_body31, ^516
^case_body30:
    %517 = llhd.const 0 : i1
    %518 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %517 after %518 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %517 : !llhd.ptr<i1>
    %519 = llhd.const 1 : i1
    %520 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_store, %519 after %520 : !llhd.sig<i1>
    %521 = llhd.const 1 : i2
    %522 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %521 after %522 : !llhd.sig<i2>
    %523 = llhd.const 1 : i4
    %524 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %523 after %524 : !llhd.sig<i4>
    %525 = llhd.const 5 : i4
    %526 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %525 after %526 : !llhd.sig<i4>
    br ^case_exit
^516:
    %527 = llhd.const 0 : i1
    %528 = llhd.const 3 : i32
    %529 = llhd.const 28799 : i32
    %530 = llhd.and %inst_data_i1, %529 : i32
    %531 = llhd.and %528, %529 : i32
    %532 = llhd.eq %530, %531 : i32
    %533 = llhd.or %527, %532 : i1
    cond_br %533, ^case_body32, ^534
^case_body31:
    %535 = llhd.const 0 : i1
    %536 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %535 after %536 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %535 : !llhd.ptr<i1>
    %537 = llhd.const 1 : i1
    %538 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_store, %537 after %538 : !llhd.sig<i1>
    %539 = llhd.const 2 : i2
    %540 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %539 after %540 : !llhd.sig<i2>
    %541 = llhd.const 1 : i4
    %542 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %541 after %542 : !llhd.sig<i4>
    %543 = llhd.const 5 : i4
    %544 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %543 after %544 : !llhd.sig<i4>
    br ^case_exit
^534:
    %545 = llhd.const 0 : i1
    %546 = llhd.const 4099 : i32
    %547 = llhd.const 28799 : i32
    %548 = llhd.and %inst_data_i1, %547 : i32
    %549 = llhd.and %546, %547 : i32
    %550 = llhd.eq %548, %549 : i32
    %551 = llhd.or %545, %550 : i1
    cond_br %551, ^case_body33, ^552
^case_body32:
    %553 = llhd.const 0 : i1
    %554 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %553 after %554 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %553 : !llhd.ptr<i1>
    %555 = llhd.const 1 : i1
    %556 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %555 after %556 : !llhd.sig<i1>
    %557 = llhd.const 1 : i1
    %558 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %557 after %558 : !llhd.sig<i1>
    %559 = llhd.const 1 : i1
    %560 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %559 after %560 : !llhd.sig<i1>
    %561 = llhd.const 1 : i4
    %562 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %561 after %562 : !llhd.sig<i4>
    %563 = llhd.const 2 : i4
    %564 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %563 after %564 : !llhd.sig<i4>
    br ^case_exit
^552:
    %565 = llhd.const 0 : i1
    %566 = llhd.const 8195 : i32
    %567 = llhd.const 28799 : i32
    %568 = llhd.and %inst_data_i1, %567 : i32
    %569 = llhd.and %566, %567 : i32
    %570 = llhd.eq %568, %569 : i32
    %571 = llhd.or %565, %570 : i1
    cond_br %571, ^case_body34, ^572
^case_body33:
    %573 = llhd.const 0 : i1
    %574 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %573 after %574 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %573 : !llhd.ptr<i1>
    %575 = llhd.const 1 : i1
    %576 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %575 after %576 : !llhd.sig<i1>
    %577 = llhd.const 1 : i1
    %578 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %577 after %578 : !llhd.sig<i1>
    %579 = llhd.const 1 : i1
    %580 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %579 after %580 : !llhd.sig<i1>
    %581 = llhd.const 1 : i2
    %582 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %581 after %582 : !llhd.sig<i2>
    %583 = llhd.const 1 : i4
    %584 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %583 after %584 : !llhd.sig<i4>
    %585 = llhd.const 2 : i4
    %586 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %585 after %586 : !llhd.sig<i4>
    br ^case_exit
^572:
    %587 = llhd.const 0 : i1
    %588 = llhd.const 16387 : i32
    %589 = llhd.const 28799 : i32
    %590 = llhd.and %inst_data_i1, %589 : i32
    %591 = llhd.and %588, %589 : i32
    %592 = llhd.eq %590, %591 : i32
    %593 = llhd.or %587, %592 : i1
    cond_br %593, ^case_body35, ^594
^case_body34:
    %595 = llhd.const 0 : i1
    %596 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %595 after %596 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %595 : !llhd.ptr<i1>
    %597 = llhd.const 1 : i1
    %598 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %597 after %598 : !llhd.sig<i1>
    %599 = llhd.const 1 : i1
    %600 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %599 after %600 : !llhd.sig<i1>
    %601 = llhd.const 1 : i1
    %602 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %601 after %602 : !llhd.sig<i1>
    %603 = llhd.const 2 : i2
    %604 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %603 after %604 : !llhd.sig<i2>
    %605 = llhd.const 1 : i4
    %606 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %605 after %606 : !llhd.sig<i4>
    %607 = llhd.const 2 : i4
    %608 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %607 after %608 : !llhd.sig<i4>
    br ^case_exit
^594:
    %609 = llhd.const 0 : i1
    %610 = llhd.const 20483 : i32
    %611 = llhd.const 28799 : i32
    %612 = llhd.and %inst_data_i1, %611 : i32
    %613 = llhd.and %610, %611 : i32
    %614 = llhd.eq %612, %613 : i32
    %615 = llhd.or %609, %614 : i1
    cond_br %615, ^case_body36, ^616
^case_body35:
    %617 = llhd.const 0 : i1
    %618 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %617 after %618 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %617 : !llhd.ptr<i1>
    %619 = llhd.const 1 : i1
    %620 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %619 after %620 : !llhd.sig<i1>
    %621 = llhd.const 1 : i1
    %622 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %621 after %622 : !llhd.sig<i1>
    %623 = llhd.const 1 : i4
    %624 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %623 after %624 : !llhd.sig<i4>
    %625 = llhd.const 2 : i4
    %626 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %625 after %626 : !llhd.sig<i4>
    br ^case_exit
^616:
    %627 = llhd.const 0 : i1
    %628 = llhd.const 4211 : i32
    %629 = llhd.const 28799 : i32
    %630 = llhd.and %inst_data_i1, %629 : i32
    %631 = llhd.and %628, %629 : i32
    %632 = llhd.eq %630, %631 : i32
    %633 = llhd.or %627, %632 : i1
    cond_br %633, ^case_body37, ^634
^case_body36:
    %635 = llhd.const 0 : i1
    %636 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %635 after %636 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %635 : !llhd.ptr<i1>
    %637 = llhd.const 1 : i1
    %638 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %637 after %638 : !llhd.sig<i1>
    %639 = llhd.const 1 : i1
    %640 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %639 after %640 : !llhd.sig<i1>
    %641 = llhd.const 1 : i2
    %642 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %641 after %642 : !llhd.sig<i2>
    %643 = llhd.const 1 : i4
    %644 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %643 after %644 : !llhd.sig<i4>
    %645 = llhd.const 2 : i4
    %646 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %645 after %646 : !llhd.sig<i4>
    br ^case_exit
^634:
    %647 = llhd.const 0 : i1
    %648 = llhd.const 20595 : i32
    %649 = llhd.const 28799 : i32
    %650 = llhd.and %inst_data_i1, %649 : i32
    %651 = llhd.and %648, %649 : i32
    %652 = llhd.eq %650, %651 : i32
    %653 = llhd.or %647, %652 : i1
    cond_br %653, ^case_body38, ^654
^case_body37:
    %655 = llhd.const 1 : i4
    %656 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %655 after %656 : !llhd.sig<i4>
    %657 = llhd.const 0 : i4
    %658 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %657 after %658 : !llhd.sig<i4>
    %659 = llhd.const 2 : i2
    %660 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %659 after %660 : !llhd.sig<i2>
    %csr_rvalue1 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %661 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %csr_rvalue1 after %661 : !llhd.sig<i32>
    %662 = llhd.const 1 : i1
    %663 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %662 after %663 : !llhd.sig<i1>
    br ^case_exit
^654:
    %664 = llhd.const 0 : i1
    %665 = llhd.const 8307 : i32
    %666 = llhd.const 28799 : i32
    %667 = llhd.and %inst_data_i1, %666 : i32
    %668 = llhd.and %665, %666 : i32
    %669 = llhd.eq %667, %668 : i32
    %670 = llhd.or %664, %669 : i1
    cond_br %670, ^case_body39, ^671
^case_body38:
    %672 = llhd.const 9 : i4
    %673 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %672 after %673 : !llhd.sig<i4>
    %674 = llhd.const 0 : i4
    %675 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %674 after %675 : !llhd.sig<i4>
    %676 = llhd.const 2 : i2
    %677 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %676 after %677 : !llhd.sig<i2>
    %csr_rvalue2 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %678 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %csr_rvalue2 after %678 : !llhd.sig<i32>
    %679 = llhd.const 1 : i1
    %680 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %679 after %680 : !llhd.sig<i1>
    br ^case_exit
^671:
    %681 = llhd.const 0 : i1
    %682 = llhd.const 24691 : i32
    %683 = llhd.const 28799 : i32
    %684 = llhd.and %inst_data_i1, %683 : i32
    %685 = llhd.and %682, %683 : i32
    %686 = llhd.eq %684, %685 : i32
    %687 = llhd.or %681, %686 : i1
    cond_br %687, ^case_body40, ^688
^case_body39:
    %689 = llhd.const 8 : i4
    %690 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %689 after %690 : !llhd.sig<i4>
    %691 = llhd.const 1 : i4
    %692 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %691 after %692 : !llhd.sig<i4>
    %693 = llhd.const 8 : i4
    %694 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %693 after %694 : !llhd.sig<i4>
    %695 = llhd.const 2 : i2
    %696 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %695 after %696 : !llhd.sig<i2>
    %csr_rvalue3 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %697 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %csr_rvalue3 after %697 : !llhd.sig<i32>
    %698 = llhd.const 1 : i1
    %699 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %698 after %699 : !llhd.sig<i1>
    br ^case_exit
^688:
    %700 = llhd.const 0 : i1
    %701 = llhd.const 12403 : i32
    %702 = llhd.const 28799 : i32
    %703 = llhd.and %inst_data_i1, %702 : i32
    %704 = llhd.and %701, %702 : i32
    %705 = llhd.eq %703, %704 : i32
    %706 = llhd.or %700, %705 : i1
    cond_br %706, ^case_body41, ^707
^case_body40:
    %inst_data_i2 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %708 = llhd.const 20 : i5
    %709 = llhd.const 0 : i32
    %710 = llhd.shr %inst_data_i2, %709, %708 : (i32, i32, i5) -> i32
    %711 = llhd.extract_slice %710, 0 : i32 -> i12
    %712 = llhd.const 1984 : i12
    %713 = llhd.neq %711, %712 : i12
    cond_br %713, ^if_true1, ^if_false1
^if_false1:
    %714 = llhd.const 0 : i1
    %715 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %714 after %715 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %714 : !llhd.ptr<i1>
    %valid_instr1 = llhd.prb %valid_instr : !llhd.sig<i1>
    %716 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr1 after %716 : !llhd.sig<i1>
    br ^if_exit
^if_true1:
    %717 = llhd.const 8 : i4
    %718 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %717 after %718 : !llhd.sig<i4>
    %719 = llhd.const 9 : i4
    %720 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %719 after %720 : !llhd.sig<i4>
    %721 = llhd.const 8 : i4
    %722 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %721 after %722 : !llhd.sig<i4>
    %723 = llhd.const 2 : i2
    %724 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %723 after %724 : !llhd.sig<i2>
    %csr_rvalue4 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %725 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %csr_rvalue4 after %725 : !llhd.sig<i32>
    %726 = llhd.const 1 : i1
    %727 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %726 after %727 : !llhd.sig<i1>
    br ^if_exit
^707:
    %728 = llhd.const 0 : i1
    %729 = llhd.const 28787 : i32
    %730 = llhd.const 28799 : i32
    %731 = llhd.and %inst_data_i1, %730 : i32
    %732 = llhd.and %729, %730 : i32
    %733 = llhd.eq %731, %732 : i32
    %734 = llhd.or %728, %733 : i1
    cond_br %734, ^case_body42, ^735
^case_body41:
    %736 = llhd.const 10 : i4
    %737 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %736 after %737 : !llhd.sig<i4>
    %738 = llhd.const 1 : i4
    %739 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %738 after %739 : !llhd.sig<i4>
    %740 = llhd.const 8 : i4
    %741 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %740 after %741 : !llhd.sig<i4>
    %742 = llhd.const 2 : i2
    %743 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %742 after %743 : !llhd.sig<i2>
    %csr_rvalue5 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %744 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %csr_rvalue5 after %744 : !llhd.sig<i32>
    %745 = llhd.const 1 : i1
    %746 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %745 after %746 : !llhd.sig<i1>
    br ^case_exit
^if_exit:
    br ^case_exit
^735:
    %747 = llhd.const 0 : i1
    %748 = llhd.const 115 : i32
    %749 = llhd.const 4294967295 : i32
    %750 = llhd.and %inst_data_i1, %749 : i32
    %751 = llhd.and %748, %749 : i32
    %752 = llhd.eq %750, %751 : i32
    %753 = llhd.or %747, %752 : i1
    %754 = llhd.const 1048691 : i32
    %755 = llhd.const 4294967295 : i32
    %756 = llhd.and %inst_data_i1, %755 : i32
    %757 = llhd.and %754, %755 : i32
    %758 = llhd.eq %756, %757 : i32
    %759 = llhd.or %753, %758 : i1
    cond_br %759, ^case_body43, ^760
^case_body42:
    %inst_data_i3 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %761 = llhd.const 20 : i5
    %762 = llhd.const 0 : i32
    %763 = llhd.shr %inst_data_i3, %762, %761 : (i32, i32, i5) -> i32
    %764 = llhd.extract_slice %763, 0 : i32 -> i12
    %765 = llhd.const 1984 : i12
    %766 = llhd.neq %764, %765 : i12
    cond_br %766, ^if_true2, ^if_false2
^if_false2:
    %767 = llhd.const 0 : i1
    %768 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %767 after %768 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %767 : !llhd.ptr<i1>
    %valid_instr2 = llhd.prb %valid_instr : !llhd.sig<i1>
    %769 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr2 after %769 : !llhd.sig<i1>
    br ^if_exit1
^if_true2:
    %770 = llhd.const 10 : i4
    %771 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %770 after %771 : !llhd.sig<i4>
    %772 = llhd.const 9 : i4
    %773 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %772 after %773 : !llhd.sig<i4>
    %774 = llhd.const 8 : i4
    %775 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %774 after %775 : !llhd.sig<i4>
    %776 = llhd.const 2 : i2
    %777 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_select, %776 after %777 : !llhd.sig<i2>
    %csr_rvalue6 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %778 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd_bypass, %csr_rvalue6 after %778 : !llhd.sig<i32>
    %779 = llhd.const 1 : i1
    %780 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_en, %779 after %780 : !llhd.sig<i1>
    br ^if_exit1
^760:
    %781 = llhd.const 0 : i1
    %782 = llhd.const 15 : i32
    %783 = llhd.const 28799 : i32
    %784 = llhd.and %inst_data_i1, %783 : i32
    %785 = llhd.and %782, %783 : i32
    %786 = llhd.eq %784, %785 : i32
    %787 = llhd.or %781, %786 : i1
    cond_br %787, ^case_body44, ^788
^case_body43:
    %789 = llhd.const 0 : i1
    %790 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %789 after %790 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %789 : !llhd.ptr<i1>
    br ^case_exit
^if_exit1:
    br ^case_exit
^788:
    %791 = llhd.const 0 : i1
    %792 = llhd.const 273678451 : i32
    %793 = llhd.const 4294967295 : i32
    %794 = llhd.and %inst_data_i1, %793 : i32
    %795 = llhd.and %792, %793 : i32
    %796 = llhd.eq %794, %795 : i32
    %797 = llhd.or %791, %796 : i1
    cond_br %797, ^case_body45, ^798
^case_body44:
    %799 = llhd.const 0 : i1
    %800 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %799 after %800 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %799 : !llhd.ptr<i1>
    br ^case_exit
^798:
    %801 = llhd.const 0 : i1
    %802 = llhd.const 8239 : i32
    %803 = llhd.const 4160778367 : i32
    %804 = llhd.and %inst_data_i1, %803 : i32
    %805 = llhd.and %802, %803 : i32
    %806 = llhd.eq %804, %805 : i32
    %807 = llhd.or %801, %806 : i1
    cond_br %807, ^case_body46, ^808
^case_body45:
    %809 = llhd.const 1 : i1
    %810 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %wfi_d, %809 after %810 : !llhd.sig<i1>
    br ^case_exit
^808:
    %811 = llhd.const 0 : i1
    %812 = llhd.const 536879151 : i32
    %813 = llhd.const 4160778367 : i32
    %814 = llhd.and %inst_data_i1, %813 : i32
    %815 = llhd.and %812, %813 : i32
    %816 = llhd.eq %814, %815 : i32
    %817 = llhd.or %811, %816 : i1
    cond_br %817, ^case_body47, ^818
^case_body46:
    %819 = llhd.const 15 : i4
    %820 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %819 after %820 : !llhd.sig<i4>
    %821 = llhd.const 0 : i1
    %822 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %821 after %822 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %821 : !llhd.ptr<i1>
    %823 = llhd.const 1 : i1
    %824 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %823 after %824 : !llhd.sig<i1>
    %825 = llhd.const 1 : i1
    %826 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %825 after %826 : !llhd.sig<i1>
    %827 = llhd.const 1 : i1
    %828 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %827 after %828 : !llhd.sig<i1>
    %829 = llhd.const 2 : i2
    %830 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %829 after %830 : !llhd.sig<i2>
    %831 = llhd.const 2 : i4
    %832 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %831 after %832 : !llhd.sig<i4>
    %833 = llhd.const 1 : i4
    %834 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %833 after %834 : !llhd.sig<i4>
    %835 = llhd.const 1 : i4
    %836 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %835 after %836 : !llhd.sig<i4>
    br ^case_exit
^818:
    %837 = llhd.const 0 : i1
    %838 = llhd.const 1073750063 : i32
    %839 = llhd.const 4160778367 : i32
    %840 = llhd.and %inst_data_i1, %839 : i32
    %841 = llhd.and %838, %839 : i32
    %842 = llhd.eq %840, %841 : i32
    %843 = llhd.or %837, %842 : i1
    cond_br %843, ^case_body48, ^844
^case_body47:
    %845 = llhd.const 15 : i4
    %846 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %845 after %846 : !llhd.sig<i4>
    %847 = llhd.const 0 : i1
    %848 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %847 after %848 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %847 : !llhd.ptr<i1>
    %849 = llhd.const 1 : i1
    %850 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %849 after %850 : !llhd.sig<i1>
    %851 = llhd.const 1 : i1
    %852 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %851 after %852 : !llhd.sig<i1>
    %853 = llhd.const 1 : i1
    %854 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %853 after %854 : !llhd.sig<i1>
    %855 = llhd.const 2 : i2
    %856 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %855 after %856 : !llhd.sig<i2>
    %857 = llhd.const 5 : i4
    %858 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %857 after %858 : !llhd.sig<i4>
    %859 = llhd.const 1 : i4
    %860 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %859 after %860 : !llhd.sig<i4>
    %861 = llhd.const 1 : i4
    %862 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %861 after %862 : !llhd.sig<i4>
    br ^case_exit
^844:
    %863 = llhd.const 0 : i1
    %864 = llhd.const 1610620975 : i32
    %865 = llhd.const 4160778367 : i32
    %866 = llhd.and %inst_data_i1, %865 : i32
    %867 = llhd.and %864, %865 : i32
    %868 = llhd.eq %866, %867 : i32
    %869 = llhd.or %863, %868 : i1
    cond_br %869, ^case_body49, ^870
^case_body48:
    %871 = llhd.const 15 : i4
    %872 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %871 after %872 : !llhd.sig<i4>
    %873 = llhd.const 0 : i1
    %874 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %873 after %874 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %873 : !llhd.ptr<i1>
    %875 = llhd.const 1 : i1
    %876 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %875 after %876 : !llhd.sig<i1>
    %877 = llhd.const 1 : i1
    %878 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %877 after %878 : !llhd.sig<i1>
    %879 = llhd.const 1 : i1
    %880 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %879 after %880 : !llhd.sig<i1>
    %881 = llhd.const 2 : i2
    %882 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %881 after %882 : !llhd.sig<i2>
    %883 = llhd.const 4 : i4
    %884 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %883 after %884 : !llhd.sig<i4>
    %885 = llhd.const 1 : i4
    %886 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %885 after %886 : !llhd.sig<i4>
    %887 = llhd.const 1 : i4
    %888 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %887 after %888 : !llhd.sig<i4>
    br ^case_exit
^870:
    %889 = llhd.const 0 : i1
    %890 = llhd.const 2147491887 : i32
    %891 = llhd.const 4160778367 : i32
    %892 = llhd.and %inst_data_i1, %891 : i32
    %893 = llhd.and %890, %891 : i32
    %894 = llhd.eq %892, %893 : i32
    %895 = llhd.or %889, %894 : i1
    cond_br %895, ^case_body50, ^896
^case_body49:
    %897 = llhd.const 15 : i4
    %898 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %897 after %898 : !llhd.sig<i4>
    %899 = llhd.const 0 : i1
    %900 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %899 after %900 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %899 : !llhd.ptr<i1>
    %901 = llhd.const 1 : i1
    %902 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %901 after %902 : !llhd.sig<i1>
    %903 = llhd.const 1 : i1
    %904 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %903 after %904 : !llhd.sig<i1>
    %905 = llhd.const 1 : i1
    %906 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %905 after %906 : !llhd.sig<i1>
    %907 = llhd.const 2 : i2
    %908 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %907 after %908 : !llhd.sig<i2>
    %909 = llhd.const 3 : i4
    %910 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %909 after %910 : !llhd.sig<i4>
    %911 = llhd.const 1 : i4
    %912 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %911 after %912 : !llhd.sig<i4>
    %913 = llhd.const 1 : i4
    %914 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %913 after %914 : !llhd.sig<i4>
    br ^case_exit
^896:
    %915 = llhd.const 0 : i1
    %916 = llhd.const 2684362799 : i32
    %917 = llhd.const 4160778367 : i32
    %918 = llhd.and %inst_data_i1, %917 : i32
    %919 = llhd.and %916, %917 : i32
    %920 = llhd.eq %918, %919 : i32
    %921 = llhd.or %915, %920 : i1
    cond_br %921, ^case_body51, ^922
^case_body50:
    %923 = llhd.const 15 : i4
    %924 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %923 after %924 : !llhd.sig<i4>
    %925 = llhd.const 0 : i1
    %926 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %925 after %926 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %925 : !llhd.ptr<i1>
    %927 = llhd.const 1 : i1
    %928 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %927 after %928 : !llhd.sig<i1>
    %929 = llhd.const 1 : i1
    %930 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %929 after %930 : !llhd.sig<i1>
    %931 = llhd.const 1 : i1
    %932 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %931 after %932 : !llhd.sig<i1>
    %933 = llhd.const 2 : i2
    %934 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %933 after %934 : !llhd.sig<i2>
    %935 = llhd.const 9 : i4
    %936 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %935 after %936 : !llhd.sig<i4>
    %937 = llhd.const 1 : i4
    %938 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %937 after %938 : !llhd.sig<i4>
    %939 = llhd.const 1 : i4
    %940 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %939 after %940 : !llhd.sig<i4>
    br ^case_exit
^922:
    %941 = llhd.const 0 : i1
    %942 = llhd.const 3221233711 : i32
    %943 = llhd.const 4160778367 : i32
    %944 = llhd.and %inst_data_i1, %943 : i32
    %945 = llhd.and %942, %943 : i32
    %946 = llhd.eq %944, %945 : i32
    %947 = llhd.or %941, %946 : i1
    cond_br %947, ^case_body52, ^948
^case_body51:
    %949 = llhd.const 15 : i4
    %950 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %949 after %950 : !llhd.sig<i4>
    %951 = llhd.const 0 : i1
    %952 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %951 after %952 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %951 : !llhd.ptr<i1>
    %953 = llhd.const 1 : i1
    %954 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %953 after %954 : !llhd.sig<i1>
    %955 = llhd.const 1 : i1
    %956 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %955 after %956 : !llhd.sig<i1>
    %957 = llhd.const 1 : i1
    %958 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %957 after %958 : !llhd.sig<i1>
    %959 = llhd.const 2 : i2
    %960 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %959 after %960 : !llhd.sig<i2>
    %961 = llhd.const 6 : i4
    %962 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %961 after %962 : !llhd.sig<i4>
    %963 = llhd.const 1 : i4
    %964 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %963 after %964 : !llhd.sig<i4>
    %965 = llhd.const 1 : i4
    %966 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %965 after %966 : !llhd.sig<i4>
    br ^case_exit
^948:
    %967 = llhd.const 0 : i1
    %968 = llhd.const 3758104623 : i32
    %969 = llhd.const 4160778367 : i32
    %970 = llhd.and %inst_data_i1, %969 : i32
    %971 = llhd.and %968, %969 : i32
    %972 = llhd.eq %970, %971 : i32
    %973 = llhd.or %967, %972 : i1
    cond_br %973, ^case_body53, ^974
^case_body52:
    %975 = llhd.const 15 : i4
    %976 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %975 after %976 : !llhd.sig<i4>
    %977 = llhd.const 0 : i1
    %978 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %977 after %978 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %977 : !llhd.ptr<i1>
    %979 = llhd.const 1 : i1
    %980 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %979 after %980 : !llhd.sig<i1>
    %981 = llhd.const 1 : i1
    %982 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %981 after %982 : !llhd.sig<i1>
    %983 = llhd.const 1 : i1
    %984 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %983 after %984 : !llhd.sig<i1>
    %985 = llhd.const 2 : i2
    %986 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %985 after %986 : !llhd.sig<i2>
    %987 = llhd.const 9 : i4
    %988 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %987 after %988 : !llhd.sig<i4>
    %989 = llhd.const 1 : i4
    %990 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %989 after %990 : !llhd.sig<i4>
    %991 = llhd.const 1 : i4
    %992 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %991 after %992 : !llhd.sig<i4>
    br ^case_exit
^974:
    %993 = llhd.const 0 : i1
    %994 = llhd.const 134225967 : i32
    %995 = llhd.const 4160778367 : i32
    %996 = llhd.and %inst_data_i1, %995 : i32
    %997 = llhd.and %994, %995 : i32
    %998 = llhd.eq %996, %997 : i32
    %999 = llhd.or %993, %998 : i1
    cond_br %999, ^case_body54, ^1000
^case_body53:
    %1001 = llhd.const 15 : i4
    %1002 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %1001 after %1002 : !llhd.sig<i4>
    %1003 = llhd.const 0 : i1
    %1004 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1003 after %1004 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1003 : !llhd.ptr<i1>
    %1005 = llhd.const 1 : i1
    %1006 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %1005 after %1006 : !llhd.sig<i1>
    %1007 = llhd.const 1 : i1
    %1008 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %1007 after %1008 : !llhd.sig<i1>
    %1009 = llhd.const 1 : i1
    %1010 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %1009 after %1010 : !llhd.sig<i1>
    %1011 = llhd.const 2 : i2
    %1012 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %1011 after %1012 : !llhd.sig<i2>
    %1013 = llhd.const 7 : i4
    %1014 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %1013 after %1014 : !llhd.sig<i4>
    %1015 = llhd.const 1 : i4
    %1016 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %1015 after %1016 : !llhd.sig<i4>
    %1017 = llhd.const 1 : i4
    %1018 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %1017 after %1018 : !llhd.sig<i4>
    br ^case_exit
^1000:
    %1019 = llhd.const 0 : i1
    %1020 = llhd.const 268443695 : i32
    %1021 = llhd.const 4193284223 : i32
    %1022 = llhd.and %inst_data_i1, %1021 : i32
    %1023 = llhd.and %1020, %1021 : i32
    %1024 = llhd.eq %1022, %1023 : i32
    %1025 = llhd.or %1019, %1024 : i1
    cond_br %1025, ^case_body55, ^1026
^case_body54:
    %1027 = llhd.const 15 : i4
    %1028 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %1027 after %1028 : !llhd.sig<i4>
    %1029 = llhd.const 0 : i1
    %1030 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1029 after %1030 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1029 : !llhd.ptr<i1>
    %1031 = llhd.const 1 : i1
    %1032 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %1031 after %1032 : !llhd.sig<i1>
    %1033 = llhd.const 1 : i1
    %1034 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %1033 after %1034 : !llhd.sig<i1>
    %1035 = llhd.const 1 : i1
    %1036 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %1035 after %1036 : !llhd.sig<i1>
    %1037 = llhd.const 2 : i2
    %1038 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %1037 after %1038 : !llhd.sig<i2>
    %1039 = llhd.const 1 : i4
    %1040 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %1039 after %1040 : !llhd.sig<i4>
    %1041 = llhd.const 1 : i4
    %1042 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %1041 after %1042 : !llhd.sig<i4>
    %1043 = llhd.const 1 : i4
    %1044 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %1043 after %1044 : !llhd.sig<i4>
    br ^case_exit
^1026:
    %1045 = llhd.const 0 : i1
    %1046 = llhd.const 402661423 : i32
    %1047 = llhd.const 4160778367 : i32
    %1048 = llhd.and %inst_data_i1, %1047 : i32
    %1049 = llhd.and %1046, %1047 : i32
    %1050 = llhd.eq %1048, %1049 : i32
    %1051 = llhd.or %1045, %1050 : i1
    cond_br %1051, ^case_body56, ^1052
^case_body55:
    %1053 = llhd.const 15 : i4
    %1054 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %1053 after %1054 : !llhd.sig<i4>
    %1055 = llhd.const 0 : i1
    %1056 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1055 after %1056 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1055 : !llhd.ptr<i1>
    %1057 = llhd.const 1 : i1
    %1058 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %1057 after %1058 : !llhd.sig<i1>
    %1059 = llhd.const 1 : i1
    %1060 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %1059 after %1060 : !llhd.sig<i1>
    %1061 = llhd.const 1 : i1
    %1062 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %1061 after %1062 : !llhd.sig<i1>
    %1063 = llhd.const 2 : i2
    %1064 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %1063 after %1064 : !llhd.sig<i2>
    %1065 = llhd.const 10 : i4
    %1066 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %1065 after %1066 : !llhd.sig<i4>
    %1067 = llhd.const 1 : i4
    %1068 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %1067 after %1068 : !llhd.sig<i4>
    %1069 = llhd.const 1 : i4
    %1070 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %1069 after %1070 : !llhd.sig<i4>
    br ^case_exit
^1052:
    %1071 = llhd.const 0 : i1
    %1072 = llhd.const 33554483 : i32
    %1073 = llhd.const 4261441663 : i32
    %1074 = llhd.and %inst_data_i1, %1073 : i32
    %1075 = llhd.and %1072, %1073 : i32
    %1076 = llhd.eq %1074, %1075 : i32
    %1077 = llhd.or %1071, %1076 : i1
    %1078 = llhd.const 33558579 : i32
    %1079 = llhd.const 4261441663 : i32
    %1080 = llhd.and %inst_data_i1, %1079 : i32
    %1081 = llhd.and %1078, %1079 : i32
    %1082 = llhd.eq %1080, %1081 : i32
    %1083 = llhd.or %1077, %1082 : i1
    %1084 = llhd.const 33562675 : i32
    %1085 = llhd.const 4261441663 : i32
    %1086 = llhd.and %inst_data_i1, %1085 : i32
    %1087 = llhd.and %1084, %1085 : i32
    %1088 = llhd.eq %1086, %1087 : i32
    %1089 = llhd.or %1083, %1088 : i1
    %1090 = llhd.const 33566771 : i32
    %1091 = llhd.const 4261441663 : i32
    %1092 = llhd.and %inst_data_i1, %1091 : i32
    %1093 = llhd.and %1090, %1091 : i32
    %1094 = llhd.eq %1092, %1093 : i32
    %1095 = llhd.or %1089, %1094 : i1
    %1096 = llhd.const 33570867 : i32
    %1097 = llhd.const 4261441663 : i32
    %1098 = llhd.and %inst_data_i1, %1097 : i32
    %1099 = llhd.and %1096, %1097 : i32
    %1100 = llhd.eq %1098, %1099 : i32
    %1101 = llhd.or %1095, %1100 : i1
    %1102 = llhd.const 33574963 : i32
    %1103 = llhd.const 4261441663 : i32
    %1104 = llhd.and %inst_data_i1, %1103 : i32
    %1105 = llhd.and %1102, %1103 : i32
    %1106 = llhd.eq %1104, %1105 : i32
    %1107 = llhd.or %1101, %1106 : i1
    %1108 = llhd.const 33579059 : i32
    %1109 = llhd.const 4261441663 : i32
    %1110 = llhd.and %inst_data_i1, %1109 : i32
    %1111 = llhd.and %1108, %1109 : i32
    %1112 = llhd.eq %1110, %1111 : i32
    %1113 = llhd.or %1107, %1112 : i1
    %1114 = llhd.const 33583155 : i32
    %1115 = llhd.const 4261441663 : i32
    %1116 = llhd.and %inst_data_i1, %1115 : i32
    %1117 = llhd.and %1114, %1115 : i32
    %1118 = llhd.eq %1116, %1117 : i32
    %1119 = llhd.or %1113, %1118 : i1
    %1120 = llhd.const 33554491 : i32
    %1121 = llhd.const 4261441663 : i32
    %1122 = llhd.and %inst_data_i1, %1121 : i32
    %1123 = llhd.and %1120, %1121 : i32
    %1124 = llhd.eq %1122, %1123 : i32
    %1125 = llhd.or %1119, %1124 : i1
    %1126 = llhd.const 33570875 : i32
    %1127 = llhd.const 4261441663 : i32
    %1128 = llhd.and %inst_data_i1, %1127 : i32
    %1129 = llhd.and %1126, %1127 : i32
    %1130 = llhd.eq %1128, %1129 : i32
    %1131 = llhd.or %1125, %1130 : i1
    %1132 = llhd.const 33574971 : i32
    %1133 = llhd.const 4261441663 : i32
    %1134 = llhd.and %inst_data_i1, %1133 : i32
    %1135 = llhd.and %1132, %1133 : i32
    %1136 = llhd.eq %1134, %1135 : i32
    %1137 = llhd.or %1131, %1136 : i1
    %1138 = llhd.const 33579067 : i32
    %1139 = llhd.const 4261441663 : i32
    %1140 = llhd.and %inst_data_i1, %1139 : i32
    %1141 = llhd.and %1138, %1139 : i32
    %1142 = llhd.eq %1140, %1141 : i32
    %1143 = llhd.or %1137, %1142 : i1
    %1144 = llhd.const 33583163 : i32
    %1145 = llhd.const 4261441663 : i32
    %1146 = llhd.and %inst_data_i1, %1145 : i32
    %1147 = llhd.and %1144, %1145 : i32
    %1148 = llhd.eq %1146, %1147 : i32
    %1149 = llhd.or %1143, %1148 : i1
    cond_br %1149, ^case_body57, ^1150
^case_body56:
    %1151 = llhd.const 15 : i4
    %1152 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_op, %1151 after %1152 : !llhd.sig<i4>
    %1153 = llhd.const 0 : i1
    %1154 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1153 after %1154 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1153 : !llhd.ptr<i1>
    %1155 = llhd.const 1 : i1
    %1156 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %1155 after %1156 : !llhd.sig<i1>
    %1157 = llhd.const 1 : i1
    %1158 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_load, %1157 after %1158 : !llhd.sig<i1>
    %1159 = llhd.const 1 : i1
    %1160 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %is_signed, %1159 after %1160 : !llhd.sig<i1>
    %1161 = llhd.const 2 : i2
    %1162 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_size, %1161 after %1162 : !llhd.sig<i2>
    %1163 = llhd.const 11 : i4
    %1164 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ls_amo, %1163 after %1164 : !llhd.sig<i4>
    %1165 = llhd.const 1 : i4
    %1166 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %1165 after %1166 : !llhd.sig<i4>
    %1167 = llhd.const 1 : i4
    %1168 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %1167 after %1168 : !llhd.sig<i4>
    br ^case_exit
^1150:
    %1169 = llhd.const 0 : i1
    %1170 = llhd.const 83 : i32
    %1171 = llhd.const 4261412991 : i32
    %1172 = llhd.and %inst_data_i1, %1171 : i32
    %1173 = llhd.and %1170, %1171 : i32
    %1174 = llhd.eq %1172, %1173 : i32
    %1175 = llhd.or %1169, %1174 : i1
    %1176 = llhd.const 134217811 : i32
    %1177 = llhd.const 4261412991 : i32
    %1178 = llhd.and %inst_data_i1, %1177 : i32
    %1179 = llhd.and %1176, %1177 : i32
    %1180 = llhd.eq %1178, %1179 : i32
    %1181 = llhd.or %1175, %1180 : i1
    %1182 = llhd.const 268435539 : i32
    %1183 = llhd.const 4261412991 : i32
    %1184 = llhd.and %inst_data_i1, %1183 : i32
    %1185 = llhd.and %1182, %1183 : i32
    %1186 = llhd.eq %1184, %1185 : i32
    %1187 = llhd.or %1181, %1186 : i1
    %1188 = llhd.const 402653267 : i32
    %1189 = llhd.const 4261412991 : i32
    %1190 = llhd.and %inst_data_i1, %1189 : i32
    %1191 = llhd.and %1188, %1189 : i32
    %1192 = llhd.eq %1190, %1191 : i32
    %1193 = llhd.or %1187, %1192 : i1
    %1194 = llhd.const 536870995 : i32
    %1195 = llhd.const 4261441663 : i32
    %1196 = llhd.and %inst_data_i1, %1195 : i32
    %1197 = llhd.and %1194, %1195 : i32
    %1198 = llhd.eq %1196, %1197 : i32
    %1199 = llhd.or %1193, %1198 : i1
    %1200 = llhd.const 536875091 : i32
    %1201 = llhd.const 4261441663 : i32
    %1202 = llhd.and %inst_data_i1, %1201 : i32
    %1203 = llhd.and %1200, %1201 : i32
    %1204 = llhd.eq %1202, %1203 : i32
    %1205 = llhd.or %1199, %1204 : i1
    %1206 = llhd.const 536879187 : i32
    %1207 = llhd.const 4261441663 : i32
    %1208 = llhd.and %inst_data_i1, %1207 : i32
    %1209 = llhd.and %1206, %1207 : i32
    %1210 = llhd.eq %1208, %1209 : i32
    %1211 = llhd.or %1205, %1210 : i1
    %1212 = llhd.const 671088723 : i32
    %1213 = llhd.const 4261441663 : i32
    %1214 = llhd.and %inst_data_i1, %1213 : i32
    %1215 = llhd.and %1212, %1213 : i32
    %1216 = llhd.eq %1214, %1215 : i32
    %1217 = llhd.or %1211, %1216 : i1
    %1218 = llhd.const 671092819 : i32
    %1219 = llhd.const 4261441663 : i32
    %1220 = llhd.and %inst_data_i1, %1219 : i32
    %1221 = llhd.and %1218, %1219 : i32
    %1222 = llhd.eq %1220, %1221 : i32
    %1223 = llhd.or %1217, %1222 : i1
    %1224 = llhd.const 1476395091 : i32
    %1225 = llhd.const 4293918847 : i32
    %1226 = llhd.and %inst_data_i1, %1225 : i32
    %1227 = llhd.and %1224, %1225 : i32
    %1228 = llhd.eq %1226, %1227 : i32
    %1229 = llhd.or %1223, %1228 : i1
    %1230 = llhd.const 67 : i32
    %1231 = llhd.const 100663423 : i32
    %1232 = llhd.and %inst_data_i1, %1231 : i32
    %1233 = llhd.and %1230, %1231 : i32
    %1234 = llhd.eq %1232, %1233 : i32
    %1235 = llhd.or %1229, %1234 : i1
    %1236 = llhd.const 71 : i32
    %1237 = llhd.const 100663423 : i32
    %1238 = llhd.and %inst_data_i1, %1237 : i32
    %1239 = llhd.and %1236, %1237 : i32
    %1240 = llhd.eq %1238, %1239 : i32
    %1241 = llhd.or %1235, %1240 : i1
    %1242 = llhd.const 75 : i32
    %1243 = llhd.const 100663423 : i32
    %1244 = llhd.and %inst_data_i1, %1243 : i32
    %1245 = llhd.and %1242, %1243 : i32
    %1246 = llhd.eq %1244, %1245 : i32
    %1247 = llhd.or %1241, %1246 : i1
    %1248 = llhd.const 79 : i32
    %1249 = llhd.const 100663423 : i32
    %1250 = llhd.and %inst_data_i1, %1249 : i32
    %1251 = llhd.and %1248, %1249 : i32
    %1252 = llhd.eq %1250, %1251 : i32
    %1253 = llhd.or %1247, %1252 : i1
    cond_br %1253, ^case_body58, ^1254
^case_body57:
    %1255 = llhd.const 0 : i1
    %1256 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1255 after %1256 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1255 : !llhd.ptr<i1>
    %1257 = llhd.const 1 : i1
    %1258 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %1257 after %1258 : !llhd.sig<i1>
    %valid_instr3 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1259 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr3 after %1259 : !llhd.sig<i1>
    %1260 = llhd.const 1 : i4
    %1261 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %1260 after %1261 : !llhd.sig<i4>
    %1262 = llhd.const 1 : i4
    %1263 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %1262 after %1263 : !llhd.sig<i4>
    %1264 = llhd.const 1 : i1
    %1265 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %1264 after %1265 : !llhd.sig<i1>
    br ^case_exit
^1254:
    %1266 = llhd.const 0 : i1
    %1267 = llhd.const 2181038131 : i32
    %1268 = llhd.const 4261441663 : i32
    %1269 = llhd.and %inst_data_i1, %1268 : i32
    %1270 = llhd.and %1267, %1268 : i32
    %1271 = llhd.eq %1269, %1270 : i32
    %1272 = llhd.or %1266, %1271 : i1
    %1273 = llhd.const 2181054515 : i32
    %1274 = llhd.const 4261441663 : i32
    %1275 = llhd.and %inst_data_i1, %1274 : i32
    %1276 = llhd.and %1273, %1274 : i32
    %1277 = llhd.eq %1275, %1276 : i32
    %1278 = llhd.or %1272, %1277 : i1
    %1279 = llhd.const 2214592563 : i32
    %1280 = llhd.const 4261441663 : i32
    %1281 = llhd.and %inst_data_i1, %1280 : i32
    %1282 = llhd.and %1279, %1280 : i32
    %1283 = llhd.eq %1281, %1282 : i32
    %1284 = llhd.or %1278, %1283 : i1
    %1285 = llhd.const 2214608947 : i32
    %1286 = llhd.const 4261441663 : i32
    %1287 = llhd.and %inst_data_i1, %1286 : i32
    %1288 = llhd.and %1285, %1286 : i32
    %1289 = llhd.eq %1287, %1288 : i32
    %1290 = llhd.or %1284, %1289 : i1
    %1291 = llhd.const 2248146995 : i32
    %1292 = llhd.const 4261441663 : i32
    %1293 = llhd.and %inst_data_i1, %1292 : i32
    %1294 = llhd.and %1291, %1292 : i32
    %1295 = llhd.eq %1293, %1294 : i32
    %1296 = llhd.or %1290, %1295 : i1
    %1297 = llhd.const 2248163379 : i32
    %1298 = llhd.const 4261441663 : i32
    %1299 = llhd.and %inst_data_i1, %1298 : i32
    %1300 = llhd.and %1297, %1298 : i32
    %1301 = llhd.eq %1299, %1300 : i32
    %1302 = llhd.or %1296, %1301 : i1
    %1303 = llhd.const 2281701427 : i32
    %1304 = llhd.const 4261441663 : i32
    %1305 = llhd.and %inst_data_i1, %1304 : i32
    %1306 = llhd.and %1303, %1304 : i32
    %1307 = llhd.eq %1305, %1306 : i32
    %1308 = llhd.or %1302, %1307 : i1
    %1309 = llhd.const 2281717811 : i32
    %1310 = llhd.const 4261441663 : i32
    %1311 = llhd.and %inst_data_i1, %1310 : i32
    %1312 = llhd.and %1309, %1310 : i32
    %1313 = llhd.eq %1311, %1312 : i32
    %1314 = llhd.or %1308, %1313 : i1
    %1315 = llhd.const 2315255859 : i32
    %1316 = llhd.const 4261441663 : i32
    %1317 = llhd.and %inst_data_i1, %1316 : i32
    %1318 = llhd.and %1315, %1316 : i32
    %1319 = llhd.eq %1317, %1318 : i32
    %1320 = llhd.or %1314, %1319 : i1
    %1321 = llhd.const 2315272243 : i32
    %1322 = llhd.const 4261441663 : i32
    %1323 = llhd.and %inst_data_i1, %1322 : i32
    %1324 = llhd.and %1321, %1322 : i32
    %1325 = llhd.eq %1323, %1324 : i32
    %1326 = llhd.or %1320, %1325 : i1
    %1327 = llhd.const 2348810291 : i32
    %1328 = llhd.const 4261441663 : i32
    %1329 = llhd.and %inst_data_i1, %1328 : i32
    %1330 = llhd.and %1327, %1328 : i32
    %1331 = llhd.eq %1329, %1330 : i32
    %1332 = llhd.or %1326, %1331 : i1
    %1333 = llhd.const 2348826675 : i32
    %1334 = llhd.const 4261441663 : i32
    %1335 = llhd.and %inst_data_i1, %1334 : i32
    %1336 = llhd.and %1333, %1334 : i32
    %1337 = llhd.eq %1335, %1336 : i32
    %1338 = llhd.or %1332, %1337 : i1
    %1339 = llhd.const 2382364723 : i32
    %1340 = llhd.const 4293947519 : i32
    %1341 = llhd.and %inst_data_i1, %1340 : i32
    %1342 = llhd.and %1339, %1340 : i32
    %1343 = llhd.eq %1341, %1342 : i32
    %1344 = llhd.or %1338, %1343 : i1
    %1345 = llhd.const 2415919155 : i32
    %1346 = llhd.const 4261441663 : i32
    %1347 = llhd.and %inst_data_i1, %1346 : i32
    %1348 = llhd.and %1345, %1346 : i32
    %1349 = llhd.eq %1347, %1348 : i32
    %1350 = llhd.or %1344, %1349 : i1
    %1351 = llhd.const 2415935539 : i32
    %1352 = llhd.const 4261441663 : i32
    %1353 = llhd.and %inst_data_i1, %1352 : i32
    %1354 = llhd.and %1351, %1352 : i32
    %1355 = llhd.eq %1353, %1354 : i32
    %1356 = llhd.or %1350, %1355 : i1
    %1357 = llhd.const 2449473587 : i32
    %1358 = llhd.const 4261441663 : i32
    %1359 = llhd.and %inst_data_i1, %1358 : i32
    %1360 = llhd.and %1357, %1358 : i32
    %1361 = llhd.eq %1359, %1360 : i32
    %1362 = llhd.or %1356, %1361 : i1
    %1363 = llhd.const 2449489971 : i32
    %1364 = llhd.const 4261441663 : i32
    %1365 = llhd.and %inst_data_i1, %1364 : i32
    %1366 = llhd.and %1363, %1364 : i32
    %1367 = llhd.eq %1365, %1366 : i32
    %1368 = llhd.or %1362, %1367 : i1
    %1369 = llhd.const 2583691315 : i32
    %1370 = llhd.const 4261441663 : i32
    %1371 = llhd.and %inst_data_i1, %1370 : i32
    %1372 = llhd.and %1369, %1370 : i32
    %1373 = llhd.eq %1371, %1372 : i32
    %1374 = llhd.or %1368, %1373 : i1
    %1375 = llhd.const 2583707699 : i32
    %1376 = llhd.const 4261441663 : i32
    %1377 = llhd.and %inst_data_i1, %1376 : i32
    %1378 = llhd.and %1375, %1376 : i32
    %1379 = llhd.eq %1377, %1378 : i32
    %1380 = llhd.or %1374, %1379 : i1
    %1381 = llhd.const 2617245747 : i32
    %1382 = llhd.const 4261441663 : i32
    %1383 = llhd.and %inst_data_i1, %1382 : i32
    %1384 = llhd.and %1381, %1382 : i32
    %1385 = llhd.eq %1383, %1384 : i32
    %1386 = llhd.or %1380, %1385 : i1
    %1387 = llhd.const 2617262131 : i32
    %1388 = llhd.const 4261441663 : i32
    %1389 = llhd.and %inst_data_i1, %1388 : i32
    %1390 = llhd.and %1387, %1388 : i32
    %1391 = llhd.eq %1389, %1390 : i32
    %1392 = llhd.or %1386, %1391 : i1
    %1393 = llhd.const 2650800179 : i32
    %1394 = llhd.const 4261441663 : i32
    %1395 = llhd.and %inst_data_i1, %1394 : i32
    %1396 = llhd.and %1393, %1394 : i32
    %1397 = llhd.eq %1395, %1396 : i32
    %1398 = llhd.or %1392, %1397 : i1
    %1399 = llhd.const 2650816563 : i32
    %1400 = llhd.const 4261441663 : i32
    %1401 = llhd.and %inst_data_i1, %1400 : i32
    %1402 = llhd.and %1399, %1400 : i32
    %1403 = llhd.eq %1401, %1402 : i32
    %1404 = llhd.or %1398, %1403 : i1
    %1405 = llhd.const 2952790067 : i32
    %1406 = llhd.const 4261441663 : i32
    %1407 = llhd.and %inst_data_i1, %1406 : i32
    %1408 = llhd.and %1405, %1406 : i32
    %1409 = llhd.eq %1407, %1408 : i32
    %1410 = llhd.or %1404, %1409 : i1
    %1411 = llhd.const 3019898931 : i32
    %1412 = llhd.const 4261441663 : i32
    %1413 = llhd.and %inst_data_i1, %1412 : i32
    %1414 = llhd.and %1411, %1412 : i32
    %1415 = llhd.eq %1413, %1414 : i32
    %1416 = llhd.or %1410, %1415 : i1
    cond_br %1416, ^case_body59, ^1417
^case_body58:
    %1418 = llhd.const 1 : i1
    cond_br %1418, ^if_true3, ^if_false3
^if_false3:
    %1419 = llhd.const 1 : i1
    %1420 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1419 after %1420 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1419 : !llhd.ptr<i1>
    br ^if_exit2
^if_true3:
    %1421 = llhd.const 0 : i1
    %1422 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1421 after %1422 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1421 : !llhd.ptr<i1>
    %valid_instr4 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1423 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr4 after %1423 : !llhd.sig<i1>
    br ^if_exit2
^1417:
    %1424 = llhd.const 0 : i1
    %1425 = llhd.const 33554515 : i32
    %1426 = llhd.const 4261412991 : i32
    %1427 = llhd.and %inst_data_i1, %1426 : i32
    %1428 = llhd.and %1425, %1426 : i32
    %1429 = llhd.eq %1427, %1428 : i32
    %1430 = llhd.or %1424, %1429 : i1
    %1431 = llhd.const 167772243 : i32
    %1432 = llhd.const 4261412991 : i32
    %1433 = llhd.and %inst_data_i1, %1432 : i32
    %1434 = llhd.and %1431, %1432 : i32
    %1435 = llhd.eq %1433, %1434 : i32
    %1436 = llhd.or %1430, %1435 : i1
    %1437 = llhd.const 301989971 : i32
    %1438 = llhd.const 4261412991 : i32
    %1439 = llhd.and %inst_data_i1, %1438 : i32
    %1440 = llhd.and %1437, %1438 : i32
    %1441 = llhd.eq %1439, %1440 : i32
    %1442 = llhd.or %1436, %1441 : i1
    %1443 = llhd.const 436207699 : i32
    %1444 = llhd.const 4261412991 : i32
    %1445 = llhd.and %inst_data_i1, %1444 : i32
    %1446 = llhd.and %1443, %1444 : i32
    %1447 = llhd.eq %1445, %1446 : i32
    %1448 = llhd.or %1442, %1447 : i1
    %1449 = llhd.const 570425427 : i32
    %1450 = llhd.const 4261441663 : i32
    %1451 = llhd.and %inst_data_i1, %1450 : i32
    %1452 = llhd.and %1449, %1450 : i32
    %1453 = llhd.eq %1451, %1452 : i32
    %1454 = llhd.or %1448, %1453 : i1
    %1455 = llhd.const 570429523 : i32
    %1456 = llhd.const 4261441663 : i32
    %1457 = llhd.and %inst_data_i1, %1456 : i32
    %1458 = llhd.and %1455, %1456 : i32
    %1459 = llhd.eq %1457, %1458 : i32
    %1460 = llhd.or %1454, %1459 : i1
    %1461 = llhd.const 570433619 : i32
    %1462 = llhd.const 4261441663 : i32
    %1463 = llhd.and %inst_data_i1, %1462 : i32
    %1464 = llhd.and %1461, %1462 : i32
    %1465 = llhd.eq %1463, %1464 : i32
    %1466 = llhd.or %1460, %1465 : i1
    %1467 = llhd.const 704643155 : i32
    %1468 = llhd.const 4261441663 : i32
    %1469 = llhd.and %inst_data_i1, %1468 : i32
    %1470 = llhd.and %1467, %1468 : i32
    %1471 = llhd.eq %1469, %1470 : i32
    %1472 = llhd.or %1466, %1471 : i1
    %1473 = llhd.const 704647251 : i32
    %1474 = llhd.const 4261441663 : i32
    %1475 = llhd.and %inst_data_i1, %1474 : i32
    %1476 = llhd.and %1473, %1474 : i32
    %1477 = llhd.eq %1475, %1476 : i32
    %1478 = llhd.or %1472, %1477 : i1
    %1479 = llhd.const 1509949523 : i32
    %1480 = llhd.const 4293918847 : i32
    %1481 = llhd.and %inst_data_i1, %1480 : i32
    %1482 = llhd.and %1479, %1480 : i32
    %1483 = llhd.eq %1481, %1482 : i32
    %1484 = llhd.or %1478, %1483 : i1
    %1485 = llhd.const 33554499 : i32
    %1486 = llhd.const 100663423 : i32
    %1487 = llhd.and %inst_data_i1, %1486 : i32
    %1488 = llhd.and %1485, %1486 : i32
    %1489 = llhd.eq %1487, %1488 : i32
    %1490 = llhd.or %1484, %1489 : i1
    %1491 = llhd.const 33554503 : i32
    %1492 = llhd.const 100663423 : i32
    %1493 = llhd.and %inst_data_i1, %1492 : i32
    %1494 = llhd.and %1491, %1492 : i32
    %1495 = llhd.eq %1493, %1494 : i32
    %1496 = llhd.or %1490, %1495 : i1
    %1497 = llhd.const 33554507 : i32
    %1498 = llhd.const 100663423 : i32
    %1499 = llhd.and %inst_data_i1, %1498 : i32
    %1500 = llhd.and %1497, %1498 : i32
    %1501 = llhd.eq %1499, %1500 : i32
    %1502 = llhd.or %1496, %1501 : i1
    %1503 = llhd.const 33554511 : i32
    %1504 = llhd.const 100663423 : i32
    %1505 = llhd.and %inst_data_i1, %1504 : i32
    %1506 = llhd.and %1503, %1504 : i32
    %1507 = llhd.eq %1505, %1506 : i32
    %1508 = llhd.or %1502, %1507 : i1
    cond_br %1508, ^case_body60, ^1509
^case_body59:
    %1510 = llhd.const 1 : i1
    %1511 = llhd.const 1 : i1
    %1512 = llhd.and %1510, %1511 : i1
    %1513 = llhd.const 1 : i1
    %1514 = llhd.and %1512, %1513 : i1
    cond_br %1514, ^if_true4, ^if_false4
^if_exit2:
    br ^case_exit
^if_false4:
    %1515 = llhd.const 1 : i1
    %1516 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1515 after %1516 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1515 : !llhd.ptr<i1>
    br ^if_exit3
^if_true4:
    %1517 = llhd.const 0 : i1
    %1518 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1517 after %1518 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1517 : !llhd.ptr<i1>
    %valid_instr5 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1519 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr5 after %1519 : !llhd.sig<i1>
    br ^if_exit3
^1509:
    %1520 = llhd.const 0 : i1
    %1521 = llhd.const 1074790483 : i32
    %1522 = llhd.const 4293918847 : i32
    %1523 = llhd.and %inst_data_i1, %1522 : i32
    %1524 = llhd.and %1521, %1522 : i32
    %1525 = llhd.eq %1523, %1524 : i32
    %1526 = llhd.or %1520, %1525 : i1
    %1527 = llhd.const 1107296339 : i32
    %1528 = llhd.const 4293918847 : i32
    %1529 = llhd.and %inst_data_i1, %1528 : i32
    %1530 = llhd.and %1527, %1528 : i32
    %1531 = llhd.eq %1529, %1530 : i32
    %1532 = llhd.or %1526, %1531 : i1
    cond_br %1532, ^case_body61, ^1533
^case_body60:
    %1534 = llhd.const 1 : i1
    cond_br %1534, ^if_true5, ^if_false5
^if_exit3:
    br ^case_exit
^if_false5:
    %1535 = llhd.const 1 : i1
    %1536 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1535 after %1536 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1535 : !llhd.ptr<i1>
    br ^if_exit4
^if_true5:
    %1537 = llhd.const 0 : i1
    %1538 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1537 after %1538 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1537 : !llhd.ptr<i1>
    %valid_instr6 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1539 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr6 after %1539 : !llhd.sig<i1>
    br ^if_exit4
^1533:
    %1540 = llhd.const 0 : i1
    %1541 = llhd.const 67108947 : i32
    %1542 = llhd.const 4261412991 : i32
    %1543 = llhd.and %inst_data_i1, %1542 : i32
    %1544 = llhd.and %1541, %1542 : i32
    %1545 = llhd.eq %1543, %1544 : i32
    %1546 = llhd.or %1540, %1545 : i1
    %1547 = llhd.const 201326675 : i32
    %1548 = llhd.const 4261412991 : i32
    %1549 = llhd.and %inst_data_i1, %1548 : i32
    %1550 = llhd.and %1547, %1548 : i32
    %1551 = llhd.eq %1549, %1550 : i32
    %1552 = llhd.or %1546, %1551 : i1
    %1553 = llhd.const 335544403 : i32
    %1554 = llhd.const 4261412991 : i32
    %1555 = llhd.and %inst_data_i1, %1554 : i32
    %1556 = llhd.and %1553, %1554 : i32
    %1557 = llhd.eq %1555, %1556 : i32
    %1558 = llhd.or %1552, %1557 : i1
    %1559 = llhd.const 469762131 : i32
    %1560 = llhd.const 4261412991 : i32
    %1561 = llhd.and %inst_data_i1, %1560 : i32
    %1562 = llhd.and %1559, %1560 : i32
    %1563 = llhd.eq %1561, %1562 : i32
    %1564 = llhd.or %1558, %1563 : i1
    %1565 = llhd.const 1543503955 : i32
    %1566 = llhd.const 4293918847 : i32
    %1567 = llhd.and %inst_data_i1, %1566 : i32
    %1568 = llhd.and %1565, %1566 : i32
    %1569 = llhd.eq %1567, %1568 : i32
    %1570 = llhd.or %1564, %1569 : i1
    %1571 = llhd.const 67108931 : i32
    %1572 = llhd.const 100663423 : i32
    %1573 = llhd.and %inst_data_i1, %1572 : i32
    %1574 = llhd.and %1571, %1572 : i32
    %1575 = llhd.eq %1573, %1574 : i32
    %1576 = llhd.or %1570, %1575 : i1
    %1577 = llhd.const 67108935 : i32
    %1578 = llhd.const 100663423 : i32
    %1579 = llhd.and %inst_data_i1, %1578 : i32
    %1580 = llhd.and %1577, %1578 : i32
    %1581 = llhd.eq %1579, %1580 : i32
    %1582 = llhd.or %1576, %1581 : i1
    %1583 = llhd.const 67108939 : i32
    %1584 = llhd.const 100663423 : i32
    %1585 = llhd.and %inst_data_i1, %1584 : i32
    %1586 = llhd.and %1583, %1584 : i32
    %1587 = llhd.eq %1585, %1586 : i32
    %1588 = llhd.or %1582, %1587 : i1
    %1589 = llhd.const 67108943 : i32
    %1590 = llhd.const 100663423 : i32
    %1591 = llhd.and %inst_data_i1, %1590 : i32
    %1592 = llhd.and %1589, %1590 : i32
    %1593 = llhd.eq %1591, %1592 : i32
    %1594 = llhd.or %1588, %1593 : i1
    cond_br %1594, ^case_body62, ^1595
^case_body61:
    %1596 = llhd.const 1 : i1
    %1597 = llhd.const 1 : i1
    %1598 = llhd.and %1596, %1597 : i1
    cond_br %1598, ^if_true6, ^if_false6
^if_exit4:
    br ^case_exit
^if_false6:
    %1599 = llhd.const 1 : i1
    %1600 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1599 after %1600 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1599 : !llhd.ptr<i1>
    br ^if_exit5
^if_true6:
    %1601 = llhd.const 0 : i1
    %1602 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1601 after %1602 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1601 : !llhd.ptr<i1>
    %valid_instr7 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1603 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr7 after %1603 : !llhd.sig<i1>
    br ^if_exit5
^1595:
    %1604 = llhd.const 0 : i1
    %1605 = llhd.const 603979859 : i32
    %1606 = llhd.const 4261441663 : i32
    %1607 = llhd.and %inst_data_i1, %1606 : i32
    %1608 = llhd.and %1605, %1606 : i32
    %1609 = llhd.eq %1607, %1608 : i32
    %1610 = llhd.or %1604, %1609 : i1
    %1611 = llhd.const 603983955 : i32
    %1612 = llhd.const 4261441663 : i32
    %1613 = llhd.and %inst_data_i1, %1612 : i32
    %1614 = llhd.and %1611, %1612 : i32
    %1615 = llhd.eq %1613, %1614 : i32
    %1616 = llhd.or %1610, %1615 : i1
    %1617 = llhd.const 603988051 : i32
    %1618 = llhd.const 4261441663 : i32
    %1619 = llhd.and %inst_data_i1, %1618 : i32
    %1620 = llhd.and %1617, %1618 : i32
    %1621 = llhd.eq %1619, %1620 : i32
    %1622 = llhd.or %1616, %1621 : i1
    %1623 = llhd.const 738197587 : i32
    %1624 = llhd.const 4261441663 : i32
    %1625 = llhd.and %inst_data_i1, %1624 : i32
    %1626 = llhd.and %1623, %1624 : i32
    %1627 = llhd.eq %1625, %1626 : i32
    %1628 = llhd.or %1622, %1627 : i1
    %1629 = llhd.const 738201683 : i32
    %1630 = llhd.const 4261441663 : i32
    %1631 = llhd.and %inst_data_i1, %1630 : i32
    %1632 = llhd.and %1629, %1630 : i32
    %1633 = llhd.eq %1631, %1632 : i32
    %1634 = llhd.or %1628, %1633 : i1
    cond_br %1634, ^case_body63, ^1635
^case_body62:
    %1636 = llhd.const 0 : i1
    %1637 = llhd.const 0 : i1
    %inst_data_i4 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1638 = llhd.const 12 : i4
    %1639 = llhd.const 0 : i32
    %1640 = llhd.shr %inst_data_i4, %1639, %1638 : (i32, i32, i4) -> i32
    %1641 = llhd.extract_slice %1640, 0 : i32 -> i3
    %1642 = llhd.const 0 : i3
    %1643 = cmpi "uge", %1641, %1642 : i3
    %inst_data_i5 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1644 = llhd.const 12 : i4
    %1645 = llhd.const 0 : i32
    %1646 = llhd.shr %inst_data_i5, %1645, %1644 : (i32, i32, i4) -> i32
    %1647 = llhd.extract_slice %1646, 0 : i32 -> i3
    %1648 = llhd.const 4 : i3
    %1649 = cmpi "ule", %1647, %1648 : i3
    %1650 = llhd.and %1643, %1649 : i1
    %1651 = llhd.or %1637, %1650 : i1
    %inst_data_i6 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1652 = llhd.const 12 : i4
    %1653 = llhd.const 0 : i32
    %1654 = llhd.shr %inst_data_i6, %1653, %1652 : (i32, i32, i4) -> i32
    %1655 = llhd.extract_slice %1654, 0 : i32 -> i3
    %1656 = llhd.const 7 : i3
    %1657 = llhd.eq %1655, %1656 : i3
    %1658 = llhd.or %1651, %1657 : i1
    %1659 = llhd.and %1636, %1658 : i1
    %1660 = llhd.const 0 : i1
    %inst_data_i7 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1661 = llhd.const 12 : i4
    %1662 = llhd.const 0 : i32
    %1663 = llhd.shr %inst_data_i7, %1662, %1661 : (i32, i32, i4) -> i32
    %1664 = llhd.extract_slice %1663, 0 : i32 -> i3
    %1665 = llhd.const 5 : i3
    %1666 = llhd.eq %1664, %1665 : i3
    %1667 = llhd.and %1660, %1666 : i1
    %1668 = llhd.or %1659, %1667 : i1
    cond_br %1668, ^if_true7, ^if_false7
^if_exit5:
    br ^case_exit
^if_false7:
    %1669 = llhd.const 1 : i1
    %1670 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1669 after %1670 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1669 : !llhd.ptr<i1>
    br ^if_exit6
^if_true7:
    %1671 = llhd.const 0 : i1
    %1672 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1671 after %1672 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1671 : !llhd.ptr<i1>
    %valid_instr8 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1673 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr8 after %1673 : !llhd.sig<i1>
    br ^if_exit6
^1635:
    %1674 = llhd.const 0 : i1
    %1675 = llhd.const 1075839059 : i32
    %1676 = llhd.const 4293947519 : i32
    %1677 = llhd.and %inst_data_i1, %1676 : i32
    %1678 = llhd.and %1675, %1676 : i32
    %1679 = llhd.eq %1677, %1678 : i32
    %1680 = llhd.or %1674, %1679 : i1
    %1681 = llhd.const 1140850771 : i32
    %1682 = llhd.const 4293918847 : i32
    %1683 = llhd.and %inst_data_i1, %1682 : i32
    %1684 = llhd.and %1681, %1682 : i32
    %1685 = llhd.eq %1683, %1684 : i32
    %1686 = llhd.or %1680, %1685 : i1
    cond_br %1686, ^case_body64, ^1687
^case_body63:
    %1688 = llhd.const 0 : i1
    cond_br %1688, ^if_true8, ^if_false8
^if_exit6:
    br ^case_exit
^if_false8:
    %1689 = llhd.const 1 : i1
    %1690 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1689 after %1690 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1689 : !llhd.ptr<i1>
    br ^if_exit7
^if_true8:
    %1691 = llhd.const 0 : i1
    %1692 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1691 after %1692 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1691 : !llhd.ptr<i1>
    %valid_instr9 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1693 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr9 after %1693 : !llhd.sig<i1>
    br ^if_exit7
^1687:
    %1694 = llhd.const 0 : i1
    %1695 = llhd.const 1109393491 : i32
    %1696 = llhd.const 4293947519 : i32
    %1697 = llhd.and %inst_data_i1, %1696 : i32
    %1698 = llhd.and %1695, %1696 : i32
    %1699 = llhd.eq %1697, %1698 : i32
    %1700 = llhd.or %1694, %1699 : i1
    %1701 = llhd.const 1141899347 : i32
    %1702 = llhd.const 4293918847 : i32
    %1703 = llhd.and %inst_data_i1, %1702 : i32
    %1704 = llhd.and %1701, %1702 : i32
    %1705 = llhd.eq %1703, %1704 : i32
    %1706 = llhd.or %1700, %1705 : i1
    cond_br %1706, ^case_body65, ^1707
^case_body64:
    %1708 = llhd.const 1 : i1
    cond_br %1708, ^if_true9, ^if_false9
^if_exit7:
    br ^case_exit
^if_false9:
    %1709 = llhd.const 1 : i1
    %1710 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1709 after %1710 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1709 : !llhd.ptr<i1>
    br ^if_exit8
^if_true9:
    %1711 = llhd.const 0 : i1
    %1712 = llhd.const 0 : i1
    %inst_data_i8 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1713 = llhd.const 12 : i4
    %1714 = llhd.const 0 : i32
    %1715 = llhd.shr %inst_data_i8, %1714, %1713 : (i32, i32, i4) -> i32
    %1716 = llhd.extract_slice %1715, 0 : i32 -> i3
    %1717 = llhd.const 0 : i3
    %1718 = cmpi "uge", %1716, %1717 : i3
    %inst_data_i9 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1719 = llhd.const 12 : i4
    %1720 = llhd.const 0 : i32
    %1721 = llhd.shr %inst_data_i9, %1720, %1719 : (i32, i32, i4) -> i32
    %1722 = llhd.extract_slice %1721, 0 : i32 -> i3
    %1723 = llhd.const 4 : i3
    %1724 = cmpi "ule", %1722, %1723 : i3
    %1725 = llhd.and %1718, %1724 : i1
    %1726 = llhd.or %1712, %1725 : i1
    %inst_data_i10 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1727 = llhd.const 12 : i4
    %1728 = llhd.const 0 : i32
    %1729 = llhd.shr %inst_data_i10, %1728, %1727 : (i32, i32, i4) -> i32
    %1730 = llhd.extract_slice %1729, 0 : i32 -> i3
    %1731 = llhd.const 7 : i3
    %1732 = llhd.eq %1730, %1731 : i3
    %1733 = llhd.or %1726, %1732 : i1
    %1734 = llhd.and %1711, %1733 : i1
    %1735 = llhd.const 0 : i1
    %inst_data_i11 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1736 = llhd.const 12 : i4
    %1737 = llhd.const 0 : i32
    %1738 = llhd.shr %inst_data_i11, %1737, %1736 : (i32, i32, i4) -> i32
    %1739 = llhd.extract_slice %1738, 0 : i32 -> i3
    %1740 = llhd.const 5 : i3
    %1741 = llhd.eq %1739, %1740 : i3
    %1742 = llhd.and %1735, %1741 : i1
    %1743 = llhd.or %1734, %1742 : i1
    cond_br %1743, ^if_true10, ^if_false10
^1707:
    %1744 = llhd.const 0 : i1
    %1745 = llhd.const 2181046323 : i32
    %1746 = llhd.const 4261441663 : i32
    %1747 = llhd.and %inst_data_i1, %1746 : i32
    %1748 = llhd.and %1745, %1746 : i32
    %1749 = llhd.eq %1747, %1748 : i32
    %1750 = llhd.or %1744, %1749 : i1
    %1751 = llhd.const 2181062707 : i32
    %1752 = llhd.const 4261441663 : i32
    %1753 = llhd.and %inst_data_i1, %1752 : i32
    %1754 = llhd.and %1751, %1752 : i32
    %1755 = llhd.eq %1753, %1754 : i32
    %1756 = llhd.or %1750, %1755 : i1
    %1757 = llhd.const 2214600755 : i32
    %1758 = llhd.const 4261441663 : i32
    %1759 = llhd.and %inst_data_i1, %1758 : i32
    %1760 = llhd.and %1757, %1758 : i32
    %1761 = llhd.eq %1759, %1760 : i32
    %1762 = llhd.or %1756, %1761 : i1
    %1763 = llhd.const 2214617139 : i32
    %1764 = llhd.const 4261441663 : i32
    %1765 = llhd.and %inst_data_i1, %1764 : i32
    %1766 = llhd.and %1763, %1764 : i32
    %1767 = llhd.eq %1765, %1766 : i32
    %1768 = llhd.or %1762, %1767 : i1
    %1769 = llhd.const 2248155187 : i32
    %1770 = llhd.const 4261441663 : i32
    %1771 = llhd.and %inst_data_i1, %1770 : i32
    %1772 = llhd.and %1769, %1770 : i32
    %1773 = llhd.eq %1771, %1772 : i32
    %1774 = llhd.or %1768, %1773 : i1
    %1775 = llhd.const 2248171571 : i32
    %1776 = llhd.const 4261441663 : i32
    %1777 = llhd.and %inst_data_i1, %1776 : i32
    %1778 = llhd.and %1775, %1776 : i32
    %1779 = llhd.eq %1777, %1778 : i32
    %1780 = llhd.or %1774, %1779 : i1
    %1781 = llhd.const 2281709619 : i32
    %1782 = llhd.const 4261441663 : i32
    %1783 = llhd.and %inst_data_i1, %1782 : i32
    %1784 = llhd.and %1781, %1782 : i32
    %1785 = llhd.eq %1783, %1784 : i32
    %1786 = llhd.or %1780, %1785 : i1
    %1787 = llhd.const 2281726003 : i32
    %1788 = llhd.const 4261441663 : i32
    %1789 = llhd.and %inst_data_i1, %1788 : i32
    %1790 = llhd.and %1787, %1788 : i32
    %1791 = llhd.eq %1789, %1790 : i32
    %1792 = llhd.or %1786, %1791 : i1
    %1793 = llhd.const 2315264051 : i32
    %1794 = llhd.const 4261441663 : i32
    %1795 = llhd.and %inst_data_i1, %1794 : i32
    %1796 = llhd.and %1793, %1794 : i32
    %1797 = llhd.eq %1795, %1796 : i32
    %1798 = llhd.or %1792, %1797 : i1
    %1799 = llhd.const 2315280435 : i32
    %1800 = llhd.const 4261441663 : i32
    %1801 = llhd.and %inst_data_i1, %1800 : i32
    %1802 = llhd.and %1799, %1800 : i32
    %1803 = llhd.eq %1801, %1802 : i32
    %1804 = llhd.or %1798, %1803 : i1
    %1805 = llhd.const 2348818483 : i32
    %1806 = llhd.const 4261441663 : i32
    %1807 = llhd.and %inst_data_i1, %1806 : i32
    %1808 = llhd.and %1805, %1806 : i32
    %1809 = llhd.eq %1807, %1808 : i32
    %1810 = llhd.or %1804, %1809 : i1
    %1811 = llhd.const 2348834867 : i32
    %1812 = llhd.const 4261441663 : i32
    %1813 = llhd.and %inst_data_i1, %1812 : i32
    %1814 = llhd.and %1811, %1812 : i32
    %1815 = llhd.eq %1813, %1814 : i32
    %1816 = llhd.or %1810, %1815 : i1
    %1817 = llhd.const 2382372915 : i32
    %1818 = llhd.const 4293947519 : i32
    %1819 = llhd.and %inst_data_i1, %1818 : i32
    %1820 = llhd.and %1817, %1818 : i32
    %1821 = llhd.eq %1819, %1820 : i32
    %1822 = llhd.or %1816, %1821 : i1
    %1823 = llhd.const 2415927347 : i32
    %1824 = llhd.const 4261441663 : i32
    %1825 = llhd.and %inst_data_i1, %1824 : i32
    %1826 = llhd.and %1823, %1824 : i32
    %1827 = llhd.eq %1825, %1826 : i32
    %1828 = llhd.or %1822, %1827 : i1
    %1829 = llhd.const 2415943731 : i32
    %1830 = llhd.const 4261441663 : i32
    %1831 = llhd.and %inst_data_i1, %1830 : i32
    %1832 = llhd.and %1829, %1830 : i32
    %1833 = llhd.eq %1831, %1832 : i32
    %1834 = llhd.or %1828, %1833 : i1
    %1835 = llhd.const 2449481779 : i32
    %1836 = llhd.const 4261441663 : i32
    %1837 = llhd.and %inst_data_i1, %1836 : i32
    %1838 = llhd.and %1835, %1836 : i32
    %1839 = llhd.eq %1837, %1838 : i32
    %1840 = llhd.or %1834, %1839 : i1
    %1841 = llhd.const 2449498163 : i32
    %1842 = llhd.const 4261441663 : i32
    %1843 = llhd.and %inst_data_i1, %1842 : i32
    %1844 = llhd.and %1841, %1842 : i32
    %1845 = llhd.eq %1843, %1844 : i32
    %1846 = llhd.or %1840, %1845 : i1
    %1847 = llhd.const 2583699507 : i32
    %1848 = llhd.const 4261441663 : i32
    %1849 = llhd.and %inst_data_i1, %1848 : i32
    %1850 = llhd.and %1847, %1848 : i32
    %1851 = llhd.eq %1849, %1850 : i32
    %1852 = llhd.or %1846, %1851 : i1
    %1853 = llhd.const 2583715891 : i32
    %1854 = llhd.const 4261441663 : i32
    %1855 = llhd.and %inst_data_i1, %1854 : i32
    %1856 = llhd.and %1853, %1854 : i32
    %1857 = llhd.eq %1855, %1856 : i32
    %1858 = llhd.or %1852, %1857 : i1
    %1859 = llhd.const 2617253939 : i32
    %1860 = llhd.const 4261441663 : i32
    %1861 = llhd.and %inst_data_i1, %1860 : i32
    %1862 = llhd.and %1859, %1860 : i32
    %1863 = llhd.eq %1861, %1862 : i32
    %1864 = llhd.or %1858, %1863 : i1
    %1865 = llhd.const 2617270323 : i32
    %1866 = llhd.const 4261441663 : i32
    %1867 = llhd.and %inst_data_i1, %1866 : i32
    %1868 = llhd.and %1865, %1866 : i32
    %1869 = llhd.eq %1867, %1868 : i32
    %1870 = llhd.or %1864, %1869 : i1
    %1871 = llhd.const 2650808371 : i32
    %1872 = llhd.const 4261441663 : i32
    %1873 = llhd.and %inst_data_i1, %1872 : i32
    %1874 = llhd.and %1871, %1872 : i32
    %1875 = llhd.eq %1873, %1874 : i32
    %1876 = llhd.or %1870, %1875 : i1
    %1877 = llhd.const 2650824755 : i32
    %1878 = llhd.const 4261441663 : i32
    %1879 = llhd.and %inst_data_i1, %1878 : i32
    %1880 = llhd.and %1877, %1878 : i32
    %1881 = llhd.eq %1879, %1880 : i32
    %1882 = llhd.or %1876, %1881 : i1
    %1883 = llhd.const 2952798259 : i32
    %1884 = llhd.const 4261441663 : i32
    %1885 = llhd.and %inst_data_i1, %1884 : i32
    %1886 = llhd.and %1883, %1884 : i32
    %1887 = llhd.eq %1885, %1886 : i32
    %1888 = llhd.or %1882, %1887 : i1
    cond_br %1888, ^case_body66, ^1889
^case_body65:
    %1890 = llhd.const 1 : i1
    cond_br %1890, ^if_true11, ^if_false11
^if_false10:
    %1891 = llhd.const 1 : i1
    %1892 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1891 after %1892 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1891 : !llhd.ptr<i1>
    br ^if_exit9
^if_true10:
    %1893 = llhd.const 0 : i1
    %1894 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1893 after %1894 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1893 : !llhd.ptr<i1>
    %valid_instr10 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1895 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr10 after %1895 : !llhd.sig<i1>
    br ^if_exit9
^if_exit8:
    br ^case_exit
^if_exit9:
    br ^if_exit8
^if_false11:
    %1896 = llhd.const 1 : i1
    %1897 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1896 after %1897 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1896 : !llhd.ptr<i1>
    br ^if_exit10
^if_true11:
    %1898 = llhd.const 0 : i1
    %1899 = llhd.const 0 : i1
    %inst_data_i12 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1900 = llhd.const 12 : i4
    %1901 = llhd.const 0 : i32
    %1902 = llhd.shr %inst_data_i12, %1901, %1900 : (i32, i32, i4) -> i32
    %1903 = llhd.extract_slice %1902, 0 : i32 -> i3
    %1904 = llhd.const 0 : i3
    %1905 = cmpi "uge", %1903, %1904 : i3
    %inst_data_i13 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1906 = llhd.const 12 : i4
    %1907 = llhd.const 0 : i32
    %1908 = llhd.shr %inst_data_i13, %1907, %1906 : (i32, i32, i4) -> i32
    %1909 = llhd.extract_slice %1908, 0 : i32 -> i3
    %1910 = llhd.const 4 : i3
    %1911 = cmpi "ule", %1909, %1910 : i3
    %1912 = llhd.and %1905, %1911 : i1
    %1913 = llhd.or %1899, %1912 : i1
    %inst_data_i14 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1914 = llhd.const 12 : i4
    %1915 = llhd.const 0 : i32
    %1916 = llhd.shr %inst_data_i14, %1915, %1914 : (i32, i32, i4) -> i32
    %1917 = llhd.extract_slice %1916, 0 : i32 -> i3
    %1918 = llhd.const 7 : i3
    %1919 = llhd.eq %1917, %1918 : i3
    %1920 = llhd.or %1913, %1919 : i1
    %1921 = llhd.and %1898, %1920 : i1
    %1922 = llhd.const 0 : i1
    %inst_data_i15 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %1923 = llhd.const 12 : i4
    %1924 = llhd.const 0 : i32
    %1925 = llhd.shr %inst_data_i15, %1924, %1923 : (i32, i32, i4) -> i32
    %1926 = llhd.extract_slice %1925, 0 : i32 -> i3
    %1927 = llhd.const 5 : i3
    %1928 = llhd.eq %1926, %1927 : i3
    %1929 = llhd.and %1922, %1928 : i1
    %1930 = llhd.or %1921, %1929 : i1
    cond_br %1930, ^if_true12, ^if_false12
^1889:
    %1931 = llhd.const 0 : i1
    %1932 = llhd.const 2556428339 : i32
    %1933 = llhd.const 4293947519 : i32
    %1934 = llhd.and %inst_data_i1, %1933 : i32
    %1935 = llhd.and %1932, %1933 : i32
    %1936 = llhd.eq %1934, %1935 : i32
    %1937 = llhd.or %1931, %1936 : i1
    %1938 = llhd.const 2556444723 : i32
    %1939 = llhd.const 4293947519 : i32
    %1940 = llhd.and %inst_data_i1, %1939 : i32
    %1941 = llhd.and %1938, %1939 : i32
    %1942 = llhd.eq %1940, %1941 : i32
    %1943 = llhd.or %1937, %1942 : i1
    %1944 = llhd.const 2554339379 : i32
    %1945 = llhd.const 4293947519 : i32
    %1946 = llhd.and %inst_data_i1, %1945 : i32
    %1947 = llhd.and %1944, %1945 : i32
    %1948 = llhd.eq %1946, %1947 : i32
    %1949 = llhd.or %1943, %1948 : i1
    %1950 = llhd.const 2554355763 : i32
    %1951 = llhd.const 4293947519 : i32
    %1952 = llhd.and %inst_data_i1, %1951 : i32
    %1953 = llhd.and %1950, %1951 : i32
    %1954 = llhd.eq %1952, %1953 : i32
    %1955 = llhd.or %1949, %1954 : i1
    %1956 = llhd.const 2952814643 : i32
    %1957 = llhd.const 4261441663 : i32
    %1958 = llhd.and %inst_data_i1, %1957 : i32
    %1959 = llhd.and %1956, %1957 : i32
    %1960 = llhd.eq %1958, %1959 : i32
    %1961 = llhd.or %1955, %1960 : i1
    %1962 = llhd.const 3019907123 : i32
    %1963 = llhd.const 4261441663 : i32
    %1964 = llhd.and %inst_data_i1, %1963 : i32
    %1965 = llhd.and %1962, %1963 : i32
    %1966 = llhd.eq %1964, %1965 : i32
    %1967 = llhd.or %1961, %1966 : i1
    %1968 = llhd.const 3019923507 : i32
    %1969 = llhd.const 4261441663 : i32
    %1970 = llhd.and %inst_data_i1, %1969 : i32
    %1971 = llhd.and %1968, %1969 : i32
    %1972 = llhd.eq %1970, %1971 : i32
    %1973 = llhd.or %1967, %1972 : i1
    cond_br %1973, ^case_body67, ^1974
^case_body66:
    %1975 = llhd.const 1 : i1
    %1976 = llhd.const 0 : i1
    %1977 = llhd.and %1975, %1976 : i1
    %1978 = llhd.const 1 : i1
    %1979 = llhd.and %1977, %1978 : i1
    cond_br %1979, ^if_true13, ^if_false13
^if_false12:
    %1980 = llhd.const 1 : i1
    %1981 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1980 after %1981 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1980 : !llhd.ptr<i1>
    br ^if_exit11
^if_true12:
    %1982 = llhd.const 0 : i1
    %1983 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1982 after %1983 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1982 : !llhd.ptr<i1>
    %valid_instr11 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1984 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr11 after %1984 : !llhd.sig<i1>
    br ^if_exit11
^if_exit10:
    br ^case_exit
^if_exit11:
    br ^if_exit10
^if_false13:
    %1985 = llhd.const 1 : i1
    %1986 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %1985 after %1986 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %1985 : !llhd.ptr<i1>
    br ^if_exit12
^if_true13:
    %1987 = llhd.const 0 : i1
    %1988 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %1987 after %1988 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %1987 : !llhd.ptr<i1>
    %valid_instr12 = llhd.prb %valid_instr : !llhd.sig<i1>
    %1989 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr12 after %1989 : !llhd.sig<i1>
    br ^if_exit12
^1974:
    %1990 = llhd.const 0 : i1
    %1991 = llhd.const 603996243 : i32
    %1992 = llhd.const 4261441663 : i32
    %1993 = llhd.and %inst_data_i1, %1992 : i32
    %1994 = llhd.and %1991, %1992 : i32
    %1995 = llhd.eq %1993, %1994 : i32
    %1996 = llhd.or %1990, %1995 : i1
    %1997 = llhd.const 604000339 : i32
    %1998 = llhd.const 4261441663 : i32
    %1999 = llhd.and %inst_data_i1, %1998 : i32
    %2000 = llhd.and %1997, %1998 : i32
    %2001 = llhd.eq %1999, %2000 : i32
    %2002 = llhd.or %1996, %2001 : i1
    %2003 = llhd.const 604004435 : i32
    %2004 = llhd.const 4261441663 : i32
    %2005 = llhd.and %inst_data_i1, %2004 : i32
    %2006 = llhd.and %2003, %2004 : i32
    %2007 = llhd.eq %2005, %2006 : i32
    %2008 = llhd.or %2002, %2007 : i1
    %2009 = llhd.const 738213971 : i32
    %2010 = llhd.const 4261441663 : i32
    %2011 = llhd.and %inst_data_i1, %2010 : i32
    %2012 = llhd.and %2009, %2010 : i32
    %2013 = llhd.eq %2011, %2012 : i32
    %2014 = llhd.or %2008, %2013 : i1
    %2015 = llhd.const 738218067 : i32
    %2016 = llhd.const 4261441663 : i32
    %2017 = llhd.and %inst_data_i1, %2016 : i32
    %2018 = llhd.and %2015, %2016 : i32
    %2019 = llhd.eq %2017, %2018 : i32
    %2020 = llhd.or %2014, %2019 : i1
    cond_br %2020, ^case_body68, ^2021
^case_body67:
    %2022 = llhd.const 1 : i1
    %2023 = llhd.const 0 : i1
    %2024 = llhd.and %2022, %2023 : i1
    %2025 = llhd.const 1 : i1
    %2026 = llhd.and %2024, %2025 : i1
    %2027 = llhd.const 1 : i1
    %2028 = llhd.and %2026, %2027 : i1
    cond_br %2028, ^if_true14, ^if_false14
^if_exit12:
    br ^case_exit
^if_false14:
    %2029 = llhd.const 1 : i1
    %2030 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2029 after %2030 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2029 : !llhd.ptr<i1>
    br ^if_exit13
^if_true14:
    %2031 = llhd.const 0 : i1
    %2032 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2031 after %2032 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2031 : !llhd.ptr<i1>
    %valid_instr13 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2033 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr13 after %2033 : !llhd.sig<i1>
    br ^if_exit13
^2021:
    %2034 = llhd.const 0 : i1
    %2035 = llhd.const 1080033363 : i32
    %2036 = llhd.const 4293947519 : i32
    %2037 = llhd.and %inst_data_i1, %2036 : i32
    %2038 = llhd.and %2035, %2036 : i32
    %2039 = llhd.eq %2037, %2038 : i32
    %2040 = llhd.or %2034, %2039 : i1
    cond_br %2040, ^case_body69, ^2041
^case_body68:
    %2042 = llhd.const 0 : i1
    cond_br %2042, ^if_true15, ^if_false15
^if_exit13:
    br ^case_exit
^if_false15:
    %2043 = llhd.const 1 : i1
    %2044 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2043 after %2044 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2043 : !llhd.ptr<i1>
    br ^if_exit14
^if_true15:
    %2045 = llhd.const 0 : i1
    %2046 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2045 after %2046 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2045 : !llhd.ptr<i1>
    %valid_instr14 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2047 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr14 after %2047 : !llhd.sig<i1>
    br ^if_exit14
^2041:
    %2048 = llhd.const 0 : i1
    %2049 = llhd.const 1113587795 : i32
    %2050 = llhd.const 4293947519 : i32
    %2051 = llhd.and %inst_data_i1, %2050 : i32
    %2052 = llhd.and %2049, %2050 : i32
    %2053 = llhd.eq %2051, %2052 : i32
    %2054 = llhd.or %2048, %2053 : i1
    cond_br %2054, ^case_body70, ^2055
^case_body69:
    %2056 = llhd.const 1 : i1
    %2057 = llhd.const 0 : i1
    %2058 = llhd.and %2056, %2057 : i1
    cond_br %2058, ^if_true16, ^if_false16
^if_exit14:
    br ^case_exit
^if_false16:
    %2059 = llhd.const 1 : i1
    %2060 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2059 after %2060 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2059 : !llhd.ptr<i1>
    br ^if_exit15
^if_true16:
    %2061 = llhd.const 0 : i1
    %2062 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2061 after %2062 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2061 : !llhd.ptr<i1>
    %valid_instr15 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2063 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr15 after %2063 : !llhd.sig<i1>
    br ^if_exit15
^2055:
    %2064 = llhd.const 0 : i1
    %2065 = llhd.const 1147142227 : i32
    %2066 = llhd.const 4293918847 : i32
    %2067 = llhd.and %inst_data_i1, %2066 : i32
    %2068 = llhd.and %2065, %2066 : i32
    %2069 = llhd.eq %2067, %2068 : i32
    %2070 = llhd.or %2064, %2069 : i1
    %2071 = llhd.const 1142968403 : i32
    %2072 = llhd.const 4293947519 : i32
    %2073 = llhd.and %inst_data_i1, %2072 : i32
    %2074 = llhd.and %2071, %2072 : i32
    %2075 = llhd.eq %2073, %2074 : i32
    %2076 = llhd.or %2070, %2075 : i1
    cond_br %2076, ^case_body71, ^2077
^case_body70:
    %2078 = llhd.const 1 : i1
    %2079 = llhd.const 0 : i1
    %2080 = llhd.and %2078, %2079 : i1
    cond_br %2080, ^if_true17, ^if_false17
^if_exit15:
    br ^case_exit
^if_false17:
    %2081 = llhd.const 1 : i1
    %2082 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2081 after %2082 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2081 : !llhd.ptr<i1>
    br ^if_exit16
^if_true17:
    %2083 = llhd.const 0 : i1
    %2084 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2083 after %2084 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2083 : !llhd.ptr<i1>
    %valid_instr16 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2085 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr16 after %2085 : !llhd.sig<i1>
    br ^if_exit16
^2077:
    %2086 = llhd.const 0 : i1
    %2087 = llhd.const 2181042227 : i32
    %2088 = llhd.const 4261441663 : i32
    %2089 = llhd.and %inst_data_i1, %2088 : i32
    %2090 = llhd.and %2087, %2088 : i32
    %2091 = llhd.eq %2089, %2090 : i32
    %2092 = llhd.or %2086, %2091 : i1
    %2093 = llhd.const 2181058611 : i32
    %2094 = llhd.const 4261441663 : i32
    %2095 = llhd.and %inst_data_i1, %2094 : i32
    %2096 = llhd.and %2093, %2094 : i32
    %2097 = llhd.eq %2095, %2096 : i32
    %2098 = llhd.or %2092, %2097 : i1
    %2099 = llhd.const 2214596659 : i32
    %2100 = llhd.const 4261441663 : i32
    %2101 = llhd.and %inst_data_i1, %2100 : i32
    %2102 = llhd.and %2099, %2100 : i32
    %2103 = llhd.eq %2101, %2102 : i32
    %2104 = llhd.or %2098, %2103 : i1
    %2105 = llhd.const 2214613043 : i32
    %2106 = llhd.const 4261441663 : i32
    %2107 = llhd.and %inst_data_i1, %2106 : i32
    %2108 = llhd.and %2105, %2106 : i32
    %2109 = llhd.eq %2107, %2108 : i32
    %2110 = llhd.or %2104, %2109 : i1
    %2111 = llhd.const 2248151091 : i32
    %2112 = llhd.const 4261441663 : i32
    %2113 = llhd.and %inst_data_i1, %2112 : i32
    %2114 = llhd.and %2111, %2112 : i32
    %2115 = llhd.eq %2113, %2114 : i32
    %2116 = llhd.or %2110, %2115 : i1
    %2117 = llhd.const 2248167475 : i32
    %2118 = llhd.const 4261441663 : i32
    %2119 = llhd.and %inst_data_i1, %2118 : i32
    %2120 = llhd.and %2117, %2118 : i32
    %2121 = llhd.eq %2119, %2120 : i32
    %2122 = llhd.or %2116, %2121 : i1
    %2123 = llhd.const 2281705523 : i32
    %2124 = llhd.const 4261441663 : i32
    %2125 = llhd.and %inst_data_i1, %2124 : i32
    %2126 = llhd.and %2123, %2124 : i32
    %2127 = llhd.eq %2125, %2126 : i32
    %2128 = llhd.or %2122, %2127 : i1
    %2129 = llhd.const 2281721907 : i32
    %2130 = llhd.const 4261441663 : i32
    %2131 = llhd.and %inst_data_i1, %2130 : i32
    %2132 = llhd.and %2129, %2130 : i32
    %2133 = llhd.eq %2131, %2132 : i32
    %2134 = llhd.or %2128, %2133 : i1
    %2135 = llhd.const 2315259955 : i32
    %2136 = llhd.const 4261441663 : i32
    %2137 = llhd.and %inst_data_i1, %2136 : i32
    %2138 = llhd.and %2135, %2136 : i32
    %2139 = llhd.eq %2137, %2138 : i32
    %2140 = llhd.or %2134, %2139 : i1
    %2141 = llhd.const 2315276339 : i32
    %2142 = llhd.const 4261441663 : i32
    %2143 = llhd.and %inst_data_i1, %2142 : i32
    %2144 = llhd.and %2141, %2142 : i32
    %2145 = llhd.eq %2143, %2144 : i32
    %2146 = llhd.or %2140, %2145 : i1
    %2147 = llhd.const 2348814387 : i32
    %2148 = llhd.const 4261441663 : i32
    %2149 = llhd.and %inst_data_i1, %2148 : i32
    %2150 = llhd.and %2147, %2148 : i32
    %2151 = llhd.eq %2149, %2150 : i32
    %2152 = llhd.or %2146, %2151 : i1
    %2153 = llhd.const 2348830771 : i32
    %2154 = llhd.const 4261441663 : i32
    %2155 = llhd.and %inst_data_i1, %2154 : i32
    %2156 = llhd.and %2153, %2154 : i32
    %2157 = llhd.eq %2155, %2156 : i32
    %2158 = llhd.or %2152, %2157 : i1
    %2159 = llhd.const 2382368819 : i32
    %2160 = llhd.const 4293947519 : i32
    %2161 = llhd.and %inst_data_i1, %2160 : i32
    %2162 = llhd.and %2159, %2160 : i32
    %2163 = llhd.eq %2161, %2162 : i32
    %2164 = llhd.or %2158, %2163 : i1
    %2165 = llhd.const 2415923251 : i32
    %2166 = llhd.const 4261441663 : i32
    %2167 = llhd.and %inst_data_i1, %2166 : i32
    %2168 = llhd.and %2165, %2166 : i32
    %2169 = llhd.eq %2167, %2168 : i32
    %2170 = llhd.or %2164, %2169 : i1
    %2171 = llhd.const 2415939635 : i32
    %2172 = llhd.const 4261441663 : i32
    %2173 = llhd.and %inst_data_i1, %2172 : i32
    %2174 = llhd.and %2171, %2172 : i32
    %2175 = llhd.eq %2173, %2174 : i32
    %2176 = llhd.or %2170, %2175 : i1
    %2177 = llhd.const 2449477683 : i32
    %2178 = llhd.const 4261441663 : i32
    %2179 = llhd.and %inst_data_i1, %2178 : i32
    %2180 = llhd.and %2177, %2178 : i32
    %2181 = llhd.eq %2179, %2180 : i32
    %2182 = llhd.or %2176, %2181 : i1
    %2183 = llhd.const 2449494067 : i32
    %2184 = llhd.const 4261441663 : i32
    %2185 = llhd.and %inst_data_i1, %2184 : i32
    %2186 = llhd.and %2183, %2184 : i32
    %2187 = llhd.eq %2185, %2186 : i32
    %2188 = llhd.or %2182, %2187 : i1
    %2189 = llhd.const 2583695411 : i32
    %2190 = llhd.const 4261441663 : i32
    %2191 = llhd.and %inst_data_i1, %2190 : i32
    %2192 = llhd.and %2189, %2190 : i32
    %2193 = llhd.eq %2191, %2192 : i32
    %2194 = llhd.or %2188, %2193 : i1
    %2195 = llhd.const 2583711795 : i32
    %2196 = llhd.const 4261441663 : i32
    %2197 = llhd.and %inst_data_i1, %2196 : i32
    %2198 = llhd.and %2195, %2196 : i32
    %2199 = llhd.eq %2197, %2198 : i32
    %2200 = llhd.or %2194, %2199 : i1
    %2201 = llhd.const 2617249843 : i32
    %2202 = llhd.const 4261441663 : i32
    %2203 = llhd.and %inst_data_i1, %2202 : i32
    %2204 = llhd.and %2201, %2202 : i32
    %2205 = llhd.eq %2203, %2204 : i32
    %2206 = llhd.or %2200, %2205 : i1
    %2207 = llhd.const 2617266227 : i32
    %2208 = llhd.const 4261441663 : i32
    %2209 = llhd.and %inst_data_i1, %2208 : i32
    %2210 = llhd.and %2207, %2208 : i32
    %2211 = llhd.eq %2209, %2210 : i32
    %2212 = llhd.or %2206, %2211 : i1
    %2213 = llhd.const 2650804275 : i32
    %2214 = llhd.const 4261441663 : i32
    %2215 = llhd.and %inst_data_i1, %2214 : i32
    %2216 = llhd.and %2213, %2214 : i32
    %2217 = llhd.eq %2215, %2216 : i32
    %2218 = llhd.or %2212, %2217 : i1
    %2219 = llhd.const 2650820659 : i32
    %2220 = llhd.const 4261441663 : i32
    %2221 = llhd.and %inst_data_i1, %2220 : i32
    %2222 = llhd.and %2219, %2220 : i32
    %2223 = llhd.eq %2221, %2222 : i32
    %2224 = llhd.or %2218, %2223 : i1
    %2225 = llhd.const 2952794163 : i32
    %2226 = llhd.const 4261441663 : i32
    %2227 = llhd.and %inst_data_i1, %2226 : i32
    %2228 = llhd.and %2225, %2226 : i32
    %2229 = llhd.eq %2227, %2228 : i32
    %2230 = llhd.or %2224, %2229 : i1
    cond_br %2230, ^case_body72, ^2231
^case_body71:
    %2232 = llhd.const 0 : i1
    %2233 = llhd.const 0 : i1
    %2234 = llhd.and %2232, %2233 : i1
    cond_br %2234, ^if_true18, ^if_false18
^if_exit16:
    br ^case_exit
^if_false18:
    %2235 = llhd.const 1 : i1
    %2236 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2235 after %2236 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2235 : !llhd.ptr<i1>
    br ^if_exit17
^if_true18:
    %2237 = llhd.const 0 : i1
    %2238 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2237 after %2238 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2237 : !llhd.ptr<i1>
    %valid_instr17 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2239 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr17 after %2239 : !llhd.sig<i1>
    br ^if_exit17
^2231:
    %2240 = llhd.const 0 : i1
    %2241 = llhd.const 2555379763 : i32
    %2242 = llhd.const 4293947519 : i32
    %2243 = llhd.and %inst_data_i1, %2242 : i32
    %2244 = llhd.and %2241, %2242 : i32
    %2245 = llhd.eq %2243, %2244 : i32
    %2246 = llhd.or %2240, %2245 : i1
    %2247 = llhd.const 2555396147 : i32
    %2248 = llhd.const 4293947519 : i32
    %2249 = llhd.and %inst_data_i1, %2248 : i32
    %2250 = llhd.and %2247, %2248 : i32
    %2251 = llhd.eq %2249, %2250 : i32
    %2252 = llhd.or %2246, %2251 : i1
    %2253 = llhd.const 2554335283 : i32
    %2254 = llhd.const 4293947519 : i32
    %2255 = llhd.and %inst_data_i1, %2254 : i32
    %2256 = llhd.and %2253, %2254 : i32
    %2257 = llhd.eq %2255, %2256 : i32
    %2258 = llhd.or %2252, %2257 : i1
    %2259 = llhd.const 2554351667 : i32
    %2260 = llhd.const 4293947519 : i32
    %2261 = llhd.and %inst_data_i1, %2260 : i32
    %2262 = llhd.and %2259, %2260 : i32
    %2263 = llhd.eq %2261, %2262 : i32
    %2264 = llhd.or %2258, %2263 : i1
    %2265 = llhd.const 2952810547 : i32
    %2266 = llhd.const 4261441663 : i32
    %2267 = llhd.and %inst_data_i1, %2266 : i32
    %2268 = llhd.and %2265, %2266 : i32
    %2269 = llhd.eq %2267, %2268 : i32
    %2270 = llhd.or %2264, %2269 : i1
    %2271 = llhd.const 3019903027 : i32
    %2272 = llhd.const 4261441663 : i32
    %2273 = llhd.and %inst_data_i1, %2272 : i32
    %2274 = llhd.and %2271, %2272 : i32
    %2275 = llhd.eq %2273, %2274 : i32
    %2276 = llhd.or %2270, %2275 : i1
    %2277 = llhd.const 3019919411 : i32
    %2278 = llhd.const 4261441663 : i32
    %2279 = llhd.and %inst_data_i1, %2278 : i32
    %2280 = llhd.and %2277, %2278 : i32
    %2281 = llhd.eq %2279, %2280 : i32
    %2282 = llhd.or %2276, %2281 : i1
    cond_br %2282, ^case_body73, ^2283
^case_body72:
    %2284 = llhd.const 1 : i1
    %2285 = llhd.const 0 : i1
    %2286 = llhd.and %2284, %2285 : i1
    %2287 = llhd.const 1 : i1
    %2288 = llhd.and %2286, %2287 : i1
    cond_br %2288, ^if_true19, ^if_false19
^if_exit17:
    br ^case_exit
^if_false19:
    %2289 = llhd.const 1 : i1
    %2290 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2289 after %2290 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2289 : !llhd.ptr<i1>
    br ^if_exit18
^if_true19:
    %2291 = llhd.const 0 : i1
    %2292 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2291 after %2292 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2291 : !llhd.ptr<i1>
    %valid_instr18 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2293 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr18 after %2293 : !llhd.sig<i1>
    br ^if_exit18
^2283:
    %2294 = llhd.const 0 : i1
    %2295 = llhd.const 2555387955 : i32
    %2296 = llhd.const 4293947519 : i32
    %2297 = llhd.and %inst_data_i1, %2296 : i32
    %2298 = llhd.and %2295, %2296 : i32
    %2299 = llhd.eq %2297, %2298 : i32
    %2300 = llhd.or %2294, %2299 : i1
    %2301 = llhd.const 2555404339 : i32
    %2302 = llhd.const 4293947519 : i32
    %2303 = llhd.and %inst_data_i1, %2302 : i32
    %2304 = llhd.and %2301, %2302 : i32
    %2305 = llhd.eq %2303, %2304 : i32
    %2306 = llhd.or %2300, %2305 : i1
    %2307 = llhd.const 2556432435 : i32
    %2308 = llhd.const 4293947519 : i32
    %2309 = llhd.and %inst_data_i1, %2308 : i32
    %2310 = llhd.and %2307, %2308 : i32
    %2311 = llhd.eq %2309, %2310 : i32
    %2312 = llhd.or %2306, %2311 : i1
    %2313 = llhd.const 2556448819 : i32
    %2314 = llhd.const 4293947519 : i32
    %2315 = llhd.and %inst_data_i1, %2314 : i32
    %2316 = llhd.and %2313, %2314 : i32
    %2317 = llhd.eq %2315, %2316 : i32
    %2318 = llhd.or %2312, %2317 : i1
    cond_br %2318, ^case_body74, ^2319
^case_body73:
    %2320 = llhd.const 1 : i1
    %2321 = llhd.const 0 : i1
    %2322 = llhd.and %2320, %2321 : i1
    %2323 = llhd.const 1 : i1
    %2324 = llhd.and %2322, %2323 : i1
    %2325 = llhd.const 1 : i1
    %2326 = llhd.and %2324, %2325 : i1
    cond_br %2326, ^if_true20, ^if_false20
^if_exit18:
    br ^case_exit
^if_false20:
    %2327 = llhd.const 1 : i1
    %2328 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2327 after %2328 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2327 : !llhd.ptr<i1>
    br ^if_exit19
^if_true20:
    %2329 = llhd.const 0 : i1
    %2330 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2329 after %2330 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2329 : !llhd.ptr<i1>
    %valid_instr19 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2331 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr19 after %2331 : !llhd.sig<i1>
    br ^if_exit19
^2319:
    %2332 = llhd.const 0 : i1
    %2333 = llhd.const 100663379 : i32
    %2334 = llhd.const 4261412991 : i32
    %2335 = llhd.and %inst_data_i1, %2334 : i32
    %2336 = llhd.and %2333, %2334 : i32
    %2337 = llhd.eq %2335, %2336 : i32
    %2338 = llhd.or %2332, %2337 : i1
    %2339 = llhd.const 234881107 : i32
    %2340 = llhd.const 4261412991 : i32
    %2341 = llhd.and %inst_data_i1, %2340 : i32
    %2342 = llhd.and %2339, %2340 : i32
    %2343 = llhd.eq %2341, %2342 : i32
    %2344 = llhd.or %2338, %2343 : i1
    %2345 = llhd.const 369098835 : i32
    %2346 = llhd.const 4261412991 : i32
    %2347 = llhd.and %inst_data_i1, %2346 : i32
    %2348 = llhd.and %2345, %2346 : i32
    %2349 = llhd.eq %2347, %2348 : i32
    %2350 = llhd.or %2344, %2349 : i1
    %2351 = llhd.const 503316563 : i32
    %2352 = llhd.const 4261412991 : i32
    %2353 = llhd.and %inst_data_i1, %2352 : i32
    %2354 = llhd.and %2351, %2352 : i32
    %2355 = llhd.eq %2353, %2354 : i32
    %2356 = llhd.or %2350, %2355 : i1
    %2357 = llhd.const 637534291 : i32
    %2358 = llhd.const 4261441663 : i32
    %2359 = llhd.and %inst_data_i1, %2358 : i32
    %2360 = llhd.and %2357, %2358 : i32
    %2361 = llhd.eq %2359, %2360 : i32
    %2362 = llhd.or %2356, %2361 : i1
    %2363 = llhd.const 637538387 : i32
    %2364 = llhd.const 4261441663 : i32
    %2365 = llhd.and %inst_data_i1, %2364 : i32
    %2366 = llhd.and %2363, %2364 : i32
    %2367 = llhd.eq %2365, %2366 : i32
    %2368 = llhd.or %2362, %2367 : i1
    %2369 = llhd.const 637542483 : i32
    %2370 = llhd.const 4261441663 : i32
    %2371 = llhd.and %inst_data_i1, %2370 : i32
    %2372 = llhd.and %2369, %2370 : i32
    %2373 = llhd.eq %2371, %2372 : i32
    %2374 = llhd.or %2368, %2373 : i1
    %2375 = llhd.const 771752019 : i32
    %2376 = llhd.const 4261441663 : i32
    %2377 = llhd.and %inst_data_i1, %2376 : i32
    %2378 = llhd.and %2375, %2376 : i32
    %2379 = llhd.eq %2377, %2378 : i32
    %2380 = llhd.or %2374, %2379 : i1
    %2381 = llhd.const 771756115 : i32
    %2382 = llhd.const 4261441663 : i32
    %2383 = llhd.and %inst_data_i1, %2382 : i32
    %2384 = llhd.and %2381, %2382 : i32
    %2385 = llhd.eq %2383, %2384 : i32
    %2386 = llhd.or %2380, %2385 : i1
    %2387 = llhd.const 1577058387 : i32
    %2388 = llhd.const 4293918847 : i32
    %2389 = llhd.and %inst_data_i1, %2388 : i32
    %2390 = llhd.and %2387, %2388 : i32
    %2391 = llhd.eq %2389, %2390 : i32
    %2392 = llhd.or %2386, %2391 : i1
    %2393 = llhd.const 100663363 : i32
    %2394 = llhd.const 100663423 : i32
    %2395 = llhd.and %inst_data_i1, %2394 : i32
    %2396 = llhd.and %2393, %2394 : i32
    %2397 = llhd.eq %2395, %2396 : i32
    %2398 = llhd.or %2392, %2397 : i1
    %2399 = llhd.const 100663367 : i32
    %2400 = llhd.const 100663423 : i32
    %2401 = llhd.and %inst_data_i1, %2400 : i32
    %2402 = llhd.and %2399, %2400 : i32
    %2403 = llhd.eq %2401, %2402 : i32
    %2404 = llhd.or %2398, %2403 : i1
    %2405 = llhd.const 100663371 : i32
    %2406 = llhd.const 100663423 : i32
    %2407 = llhd.and %inst_data_i1, %2406 : i32
    %2408 = llhd.and %2405, %2406 : i32
    %2409 = llhd.eq %2407, %2408 : i32
    %2410 = llhd.or %2404, %2409 : i1
    %2411 = llhd.const 100663375 : i32
    %2412 = llhd.const 100663423 : i32
    %2413 = llhd.and %inst_data_i1, %2412 : i32
    %2414 = llhd.and %2411, %2412 : i32
    %2415 = llhd.eq %2413, %2414 : i32
    %2416 = llhd.or %2410, %2415 : i1
    cond_br %2416, ^case_body75, ^2417
^case_body74:
    %2418 = llhd.const 1 : i1
    %2419 = llhd.const 0 : i1
    %2420 = llhd.and %2418, %2419 : i1
    %2421 = llhd.const 0 : i1
    %2422 = llhd.and %2420, %2421 : i1
    %2423 = llhd.const 1 : i1
    %2424 = llhd.and %2422, %2423 : i1
    cond_br %2424, ^if_true21, ^if_false21
^if_exit19:
    br ^case_exit
^if_false21:
    %2425 = llhd.const 1 : i1
    %2426 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2425 after %2426 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2425 : !llhd.ptr<i1>
    br ^if_exit20
^if_true21:
    %2427 = llhd.const 0 : i1
    %2428 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2427 after %2428 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2427 : !llhd.ptr<i1>
    %valid_instr20 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2429 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr20 after %2429 : !llhd.sig<i1>
    br ^if_exit20
^2417:
    %2430 = llhd.const 0 : i1
    %2431 = llhd.const 1076887635 : i32
    %2432 = llhd.const 4293947519 : i32
    %2433 = llhd.and %inst_data_i1, %2432 : i32
    %2434 = llhd.and %2431, %2432 : i32
    %2435 = llhd.eq %2433, %2434 : i32
    %2436 = llhd.or %2430, %2435 : i1
    %2437 = llhd.const 1174405203 : i32
    %2438 = llhd.const 4293918847 : i32
    %2439 = llhd.and %inst_data_i1, %2438 : i32
    %2440 = llhd.and %2437, %2438 : i32
    %2441 = llhd.eq %2439, %2440 : i32
    %2442 = llhd.or %2436, %2441 : i1
    cond_br %2442, ^case_body76, ^2443
^case_body75:
    %2444 = llhd.const 0 : i1
    cond_br %2444, ^if_true22, ^if_false22
^if_exit20:
    br ^case_exit
^if_false22:
    %2445 = llhd.const 1 : i1
    %2446 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2445 after %2446 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2445 : !llhd.ptr<i1>
    br ^if_exit21
^if_true22:
    %2447 = llhd.const 0 : i1
    %2448 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2447 after %2448 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2447 : !llhd.ptr<i1>
    %valid_instr21 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2449 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr21 after %2449 : !llhd.sig<i1>
    br ^if_exit21
^2443:
    %2450 = llhd.const 0 : i1
    %2451 = llhd.const 1110442067 : i32
    %2452 = llhd.const 4293947519 : i32
    %2453 = llhd.and %inst_data_i1, %2452 : i32
    %2454 = llhd.and %2451, %2452 : i32
    %2455 = llhd.eq %2453, %2454 : i32
    %2456 = llhd.or %2450, %2455 : i1
    %2457 = llhd.const 1175453779 : i32
    %2458 = llhd.const 4293918847 : i32
    %2459 = llhd.and %inst_data_i1, %2458 : i32
    %2460 = llhd.and %2457, %2458 : i32
    %2461 = llhd.eq %2459, %2460 : i32
    %2462 = llhd.or %2456, %2461 : i1
    cond_br %2462, ^case_body77, ^2463
^case_body76:
    %2464 = llhd.const 1 : i1
    %2465 = llhd.const 0 : i1
    %2466 = llhd.and %2464, %2465 : i1
    cond_br %2466, ^if_true23, ^if_false23
^if_exit21:
    br ^case_exit
^if_false23:
    %2467 = llhd.const 1 : i1
    %2468 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2467 after %2468 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2467 : !llhd.ptr<i1>
    br ^if_exit22
^if_true23:
    %2469 = llhd.const 0 : i1
    %2470 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2469 after %2470 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2469 : !llhd.ptr<i1>
    %valid_instr22 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2471 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr22 after %2471 : !llhd.sig<i1>
    br ^if_exit22
^2463:
    %2472 = llhd.const 0 : i1
    %2473 = llhd.const 1143996499 : i32
    %2474 = llhd.const 4293947519 : i32
    %2475 = llhd.and %inst_data_i1, %2474 : i32
    %2476 = llhd.and %2473, %2474 : i32
    %2477 = llhd.eq %2475, %2476 : i32
    %2478 = llhd.or %2472, %2477 : i1
    %2479 = llhd.const 1176502355 : i32
    %2480 = llhd.const 4293918847 : i32
    %2481 = llhd.and %inst_data_i1, %2480 : i32
    %2482 = llhd.and %2479, %2480 : i32
    %2483 = llhd.eq %2481, %2482 : i32
    %2484 = llhd.or %2478, %2483 : i1
    cond_br %2484, ^case_body78, ^2485
^case_body77:
    %2486 = llhd.const 1 : i1
    %2487 = llhd.const 0 : i1
    %2488 = llhd.and %2486, %2487 : i1
    cond_br %2488, ^if_true24, ^if_false24
^if_exit22:
    br ^case_exit
^if_false24:
    %2489 = llhd.const 1 : i1
    %2490 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2489 after %2490 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2489 : !llhd.ptr<i1>
    br ^if_exit23
^if_true24:
    %2491 = llhd.const 0 : i1
    %2492 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2491 after %2492 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2491 : !llhd.ptr<i1>
    %valid_instr23 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2493 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr23 after %2493 : !llhd.sig<i1>
    br ^if_exit23
^2485:
    %2494 = llhd.const 0 : i1
    %2495 = llhd.const 1144016979 : i32
    %2496 = llhd.const 4293947519 : i32
    %2497 = llhd.and %inst_data_i1, %2496 : i32
    %2498 = llhd.and %2495, %2496 : i32
    %2499 = llhd.eq %2497, %2498 : i32
    %2500 = llhd.or %2494, %2499 : i1
    %2501 = llhd.const 1180696659 : i32
    %2502 = llhd.const 4293918847 : i32
    %2503 = llhd.and %inst_data_i1, %2502 : i32
    %2504 = llhd.and %2501, %2502 : i32
    %2505 = llhd.eq %2503, %2504 : i32
    %2506 = llhd.or %2500, %2505 : i1
    cond_br %2506, ^case_body79, ^2507
^case_body78:
    %2508 = llhd.const 0 : i1
    %2509 = llhd.const 0 : i1
    %2510 = llhd.and %2508, %2509 : i1
    cond_br %2510, ^if_true25, ^if_false25
^if_exit23:
    br ^case_exit
^if_false25:
    %2511 = llhd.const 1 : i1
    %2512 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2511 after %2512 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2511 : !llhd.ptr<i1>
    br ^if_exit24
^if_true25:
    %2513 = llhd.const 0 : i1
    %2514 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2513 after %2514 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2513 : !llhd.ptr<i1>
    %valid_instr24 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2515 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr24 after %2515 : !llhd.sig<i1>
    br ^if_exit24
^2507:
    %2516 = llhd.const 0 : i1
    %2517 = llhd.const 2181050419 : i32
    %2518 = llhd.const 4261441663 : i32
    %2519 = llhd.and %inst_data_i1, %2518 : i32
    %2520 = llhd.and %2517, %2518 : i32
    %2521 = llhd.eq %2519, %2520 : i32
    %2522 = llhd.or %2516, %2521 : i1
    %2523 = llhd.const 2181066803 : i32
    %2524 = llhd.const 4261441663 : i32
    %2525 = llhd.and %inst_data_i1, %2524 : i32
    %2526 = llhd.and %2523, %2524 : i32
    %2527 = llhd.eq %2525, %2526 : i32
    %2528 = llhd.or %2522, %2527 : i1
    %2529 = llhd.const 2214604851 : i32
    %2530 = llhd.const 4261441663 : i32
    %2531 = llhd.and %inst_data_i1, %2530 : i32
    %2532 = llhd.and %2529, %2530 : i32
    %2533 = llhd.eq %2531, %2532 : i32
    %2534 = llhd.or %2528, %2533 : i1
    %2535 = llhd.const 2214621235 : i32
    %2536 = llhd.const 4261441663 : i32
    %2537 = llhd.and %inst_data_i1, %2536 : i32
    %2538 = llhd.and %2535, %2536 : i32
    %2539 = llhd.eq %2537, %2538 : i32
    %2540 = llhd.or %2534, %2539 : i1
    %2541 = llhd.const 2248159283 : i32
    %2542 = llhd.const 4261441663 : i32
    %2543 = llhd.and %inst_data_i1, %2542 : i32
    %2544 = llhd.and %2541, %2542 : i32
    %2545 = llhd.eq %2543, %2544 : i32
    %2546 = llhd.or %2540, %2545 : i1
    %2547 = llhd.const 2248175667 : i32
    %2548 = llhd.const 4261441663 : i32
    %2549 = llhd.and %inst_data_i1, %2548 : i32
    %2550 = llhd.and %2547, %2548 : i32
    %2551 = llhd.eq %2549, %2550 : i32
    %2552 = llhd.or %2546, %2551 : i1
    %2553 = llhd.const 2281713715 : i32
    %2554 = llhd.const 4261441663 : i32
    %2555 = llhd.and %inst_data_i1, %2554 : i32
    %2556 = llhd.and %2553, %2554 : i32
    %2557 = llhd.eq %2555, %2556 : i32
    %2558 = llhd.or %2552, %2557 : i1
    %2559 = llhd.const 2281730099 : i32
    %2560 = llhd.const 4261441663 : i32
    %2561 = llhd.and %inst_data_i1, %2560 : i32
    %2562 = llhd.and %2559, %2560 : i32
    %2563 = llhd.eq %2561, %2562 : i32
    %2564 = llhd.or %2558, %2563 : i1
    %2565 = llhd.const 2315268147 : i32
    %2566 = llhd.const 4261441663 : i32
    %2567 = llhd.and %inst_data_i1, %2566 : i32
    %2568 = llhd.and %2565, %2566 : i32
    %2569 = llhd.eq %2567, %2568 : i32
    %2570 = llhd.or %2564, %2569 : i1
    %2571 = llhd.const 2315284531 : i32
    %2572 = llhd.const 4261441663 : i32
    %2573 = llhd.and %inst_data_i1, %2572 : i32
    %2574 = llhd.and %2571, %2572 : i32
    %2575 = llhd.eq %2573, %2574 : i32
    %2576 = llhd.or %2570, %2575 : i1
    %2577 = llhd.const 2348822579 : i32
    %2578 = llhd.const 4261441663 : i32
    %2579 = llhd.and %inst_data_i1, %2578 : i32
    %2580 = llhd.and %2577, %2578 : i32
    %2581 = llhd.eq %2579, %2580 : i32
    %2582 = llhd.or %2576, %2581 : i1
    %2583 = llhd.const 2348838963 : i32
    %2584 = llhd.const 4261441663 : i32
    %2585 = llhd.and %inst_data_i1, %2584 : i32
    %2586 = llhd.and %2583, %2584 : i32
    %2587 = llhd.eq %2585, %2586 : i32
    %2588 = llhd.or %2582, %2587 : i1
    %2589 = llhd.const 2382377011 : i32
    %2590 = llhd.const 4293947519 : i32
    %2591 = llhd.and %inst_data_i1, %2590 : i32
    %2592 = llhd.and %2589, %2590 : i32
    %2593 = llhd.eq %2591, %2592 : i32
    %2594 = llhd.or %2588, %2593 : i1
    %2595 = llhd.const 2415931443 : i32
    %2596 = llhd.const 4261441663 : i32
    %2597 = llhd.and %inst_data_i1, %2596 : i32
    %2598 = llhd.and %2595, %2596 : i32
    %2599 = llhd.eq %2597, %2598 : i32
    %2600 = llhd.or %2594, %2599 : i1
    %2601 = llhd.const 2415947827 : i32
    %2602 = llhd.const 4261441663 : i32
    %2603 = llhd.and %inst_data_i1, %2602 : i32
    %2604 = llhd.and %2601, %2602 : i32
    %2605 = llhd.eq %2603, %2604 : i32
    %2606 = llhd.or %2600, %2605 : i1
    %2607 = llhd.const 2449485875 : i32
    %2608 = llhd.const 4261441663 : i32
    %2609 = llhd.and %inst_data_i1, %2608 : i32
    %2610 = llhd.and %2607, %2608 : i32
    %2611 = llhd.eq %2609, %2610 : i32
    %2612 = llhd.or %2606, %2611 : i1
    %2613 = llhd.const 2449502259 : i32
    %2614 = llhd.const 4261441663 : i32
    %2615 = llhd.and %inst_data_i1, %2614 : i32
    %2616 = llhd.and %2613, %2614 : i32
    %2617 = llhd.eq %2615, %2616 : i32
    %2618 = llhd.or %2612, %2617 : i1
    %2619 = llhd.const 2583703603 : i32
    %2620 = llhd.const 4261441663 : i32
    %2621 = llhd.and %inst_data_i1, %2620 : i32
    %2622 = llhd.and %2619, %2620 : i32
    %2623 = llhd.eq %2621, %2622 : i32
    %2624 = llhd.or %2618, %2623 : i1
    %2625 = llhd.const 2583719987 : i32
    %2626 = llhd.const 4261441663 : i32
    %2627 = llhd.and %inst_data_i1, %2626 : i32
    %2628 = llhd.and %2625, %2626 : i32
    %2629 = llhd.eq %2627, %2628 : i32
    %2630 = llhd.or %2624, %2629 : i1
    %2631 = llhd.const 2617258035 : i32
    %2632 = llhd.const 4261441663 : i32
    %2633 = llhd.and %inst_data_i1, %2632 : i32
    %2634 = llhd.and %2631, %2632 : i32
    %2635 = llhd.eq %2633, %2634 : i32
    %2636 = llhd.or %2630, %2635 : i1
    %2637 = llhd.const 2617274419 : i32
    %2638 = llhd.const 4261441663 : i32
    %2639 = llhd.and %inst_data_i1, %2638 : i32
    %2640 = llhd.and %2637, %2638 : i32
    %2641 = llhd.eq %2639, %2640 : i32
    %2642 = llhd.or %2636, %2641 : i1
    %2643 = llhd.const 2650812467 : i32
    %2644 = llhd.const 4261441663 : i32
    %2645 = llhd.and %inst_data_i1, %2644 : i32
    %2646 = llhd.and %2643, %2644 : i32
    %2647 = llhd.eq %2645, %2646 : i32
    %2648 = llhd.or %2642, %2647 : i1
    %2649 = llhd.const 2650828851 : i32
    %2650 = llhd.const 4261441663 : i32
    %2651 = llhd.and %inst_data_i1, %2650 : i32
    %2652 = llhd.and %2649, %2650 : i32
    %2653 = llhd.eq %2651, %2652 : i32
    %2654 = llhd.or %2648, %2653 : i1
    cond_br %2654, ^case_body80, ^2655
^case_body79:
    %2656 = llhd.const 1 : i1
    %2657 = llhd.const 1 : i1
    %2658 = llhd.and %2656, %2657 : i1
    cond_br %2658, ^if_true26, ^if_false26
^if_exit24:
    br ^case_exit
^if_false26:
    %2659 = llhd.const 1 : i1
    %2660 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2659 after %2660 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2659 : !llhd.ptr<i1>
    br ^if_exit25
^if_true26:
    %2661 = llhd.const 0 : i1
    %2662 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2661 after %2662 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2661 : !llhd.ptr<i1>
    %valid_instr25 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2663 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr25 after %2663 : !llhd.sig<i1>
    br ^if_exit25
^2655:
    %2664 = llhd.const 0 : i1
    %2665 = llhd.const 2952802355 : i32
    %2666 = llhd.const 4261441663 : i32
    %2667 = llhd.and %inst_data_i1, %2666 : i32
    %2668 = llhd.and %2665, %2666 : i32
    %2669 = llhd.eq %2667, %2668 : i32
    %2670 = llhd.or %2664, %2669 : i1
    %2671 = llhd.const 2952818739 : i32
    %2672 = llhd.const 4261441663 : i32
    %2673 = llhd.and %inst_data_i1, %2672 : i32
    %2674 = llhd.and %2671, %2672 : i32
    %2675 = llhd.eq %2673, %2674 : i32
    %2676 = llhd.or %2670, %2675 : i1
    cond_br %2676, ^case_body81, ^2677
^case_body80:
    %2678 = llhd.const 1 : i1
    %2679 = llhd.const 0 : i1
    %2680 = llhd.and %2678, %2679 : i1
    %2681 = llhd.const 8 : i32
    %2682 = llhd.const 16 : i32
    %2683 = cmpi "sge", %2681, %2682 : i32
    %2684 = llhd.and %2680, %2683 : i1
    cond_br %2684, ^if_true27, ^if_false27
^if_exit25:
    br ^case_exit
^if_false27:
    %2685 = llhd.const 1 : i1
    %2686 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2685 after %2686 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2685 : !llhd.ptr<i1>
    br ^if_exit26
^if_true27:
    %2687 = llhd.const 0 : i1
    %2688 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2687 after %2688 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2687 : !llhd.ptr<i1>
    %valid_instr26 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2689 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr26 after %2689 : !llhd.sig<i1>
    br ^if_exit26
^2677:
    %2690 = llhd.const 0 : i1
    %2691 = llhd.const 2557476915 : i32
    %2692 = llhd.const 4293947519 : i32
    %2693 = llhd.and %inst_data_i1, %2692 : i32
    %2694 = llhd.and %2691, %2692 : i32
    %2695 = llhd.eq %2693, %2694 : i32
    %2696 = llhd.or %2690, %2695 : i1
    %2697 = llhd.const 2557493299 : i32
    %2698 = llhd.const 4293947519 : i32
    %2699 = llhd.and %inst_data_i1, %2698 : i32
    %2700 = llhd.and %2697, %2698 : i32
    %2701 = llhd.eq %2699, %2700 : i32
    %2702 = llhd.or %2696, %2701 : i1
    %2703 = llhd.const 2554343475 : i32
    %2704 = llhd.const 4293947519 : i32
    %2705 = llhd.and %inst_data_i1, %2704 : i32
    %2706 = llhd.and %2703, %2704 : i32
    %2707 = llhd.eq %2705, %2706 : i32
    %2708 = llhd.or %2702, %2707 : i1
    %2709 = llhd.const 2554359859 : i32
    %2710 = llhd.const 4293947519 : i32
    %2711 = llhd.and %inst_data_i1, %2710 : i32
    %2712 = llhd.and %2709, %2710 : i32
    %2713 = llhd.eq %2711, %2712 : i32
    %2714 = llhd.or %2708, %2713 : i1
    cond_br %2714, ^case_body82, ^2715
^case_body81:
    %2716 = llhd.const 1 : i1
    %2717 = llhd.const 0 : i1
    %2718 = llhd.and %2716, %2717 : i1
    %2719 = llhd.const 1 : i1
    %2720 = llhd.and %2718, %2719 : i1
    cond_br %2720, ^if_true28, ^if_false28
^if_exit26:
    br ^case_exit
^if_false28:
    %2721 = llhd.const 1 : i1
    %2722 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2721 after %2722 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2721 : !llhd.ptr<i1>
    br ^if_exit27
^if_true28:
    %2723 = llhd.const 0 : i1
    %2724 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2723 after %2724 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2723 : !llhd.ptr<i1>
    %valid_instr27 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2725 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr27 after %2725 : !llhd.sig<i1>
    br ^if_exit27
^2715:
    %2726 = llhd.const 0 : i1
    %2727 = llhd.const 2986356787 : i32
    %2728 = llhd.const 4261441663 : i32
    %2729 = llhd.and %inst_data_i1, %2728 : i32
    %2730 = llhd.and %2727, %2728 : i32
    %2731 = llhd.eq %2729, %2730 : i32
    %2732 = llhd.or %2726, %2731 : i1
    %2733 = llhd.const 2986373171 : i32
    %2734 = llhd.const 4261441663 : i32
    %2735 = llhd.and %inst_data_i1, %2734 : i32
    %2736 = llhd.and %2733, %2734 : i32
    %2737 = llhd.eq %2735, %2736 : i32
    %2738 = llhd.or %2732, %2737 : i1
    %2739 = llhd.const 3019911219 : i32
    %2740 = llhd.const 4261441663 : i32
    %2741 = llhd.and %inst_data_i1, %2740 : i32
    %2742 = llhd.and %2739, %2740 : i32
    %2743 = llhd.eq %2741, %2742 : i32
    %2744 = llhd.or %2738, %2743 : i1
    %2745 = llhd.const 3019927603 : i32
    %2746 = llhd.const 4261441663 : i32
    %2747 = llhd.and %inst_data_i1, %2746 : i32
    %2748 = llhd.and %2745, %2746 : i32
    %2749 = llhd.eq %2747, %2748 : i32
    %2750 = llhd.or %2744, %2749 : i1
    %2751 = llhd.const 3053465651 : i32
    %2752 = llhd.const 4261441663 : i32
    %2753 = llhd.and %inst_data_i1, %2752 : i32
    %2754 = llhd.and %2751, %2752 : i32
    %2755 = llhd.eq %2753, %2754 : i32
    %2756 = llhd.or %2750, %2755 : i1
    %2757 = llhd.const 3053482035 : i32
    %2758 = llhd.const 4261441663 : i32
    %2759 = llhd.and %inst_data_i1, %2758 : i32
    %2760 = llhd.and %2757, %2758 : i32
    %2761 = llhd.eq %2759, %2760 : i32
    %2762 = llhd.or %2756, %2761 : i1
    cond_br %2762, ^case_body83, ^2763
^case_body82:
    %2764 = llhd.const 1 : i1
    %2765 = llhd.const 0 : i1
    %2766 = llhd.and %2764, %2765 : i1
    %2767 = llhd.const 1 : i1
    %2768 = llhd.and %2766, %2767 : i1
    %2769 = llhd.const 8 : i32
    %2770 = llhd.const 64 : i32
    %2771 = cmpi "sge", %2769, %2770 : i32
    %2772 = llhd.and %2768, %2771 : i1
    cond_br %2772, ^if_true29, ^if_false29
^if_exit27:
    br ^case_exit
^if_false29:
    %2773 = llhd.const 1 : i1
    %2774 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2773 after %2774 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2773 : !llhd.ptr<i1>
    br ^if_exit28
^if_true29:
    %2775 = llhd.const 0 : i1
    %2776 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2775 after %2776 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2775 : !llhd.ptr<i1>
    %valid_instr28 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2777 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr28 after %2777 : !llhd.sig<i1>
    br ^if_exit28
^2763:
    %2778 = llhd.const 0 : i1
    %2779 = llhd.const 2557485107 : i32
    %2780 = llhd.const 4293947519 : i32
    %2781 = llhd.and %inst_data_i1, %2780 : i32
    %2782 = llhd.and %2779, %2780 : i32
    %2783 = llhd.eq %2781, %2782 : i32
    %2784 = llhd.or %2778, %2783 : i1
    %2785 = llhd.const 2557501491 : i32
    %2786 = llhd.const 4293947519 : i32
    %2787 = llhd.and %inst_data_i1, %2786 : i32
    %2788 = llhd.and %2785, %2786 : i32
    %2789 = llhd.eq %2787, %2788 : i32
    %2790 = llhd.or %2784, %2789 : i1
    %2791 = llhd.const 2556440627 : i32
    %2792 = llhd.const 4293947519 : i32
    %2793 = llhd.and %inst_data_i1, %2792 : i32
    %2794 = llhd.and %2791, %2792 : i32
    %2795 = llhd.eq %2793, %2794 : i32
    %2796 = llhd.or %2790, %2795 : i1
    %2797 = llhd.const 2556457011 : i32
    %2798 = llhd.const 4293947519 : i32
    %2799 = llhd.and %inst_data_i1, %2798 : i32
    %2800 = llhd.and %2797, %2798 : i32
    %2801 = llhd.eq %2799, %2800 : i32
    %2802 = llhd.or %2796, %2801 : i1
    cond_br %2802, ^case_body84, ^2803
^case_body83:
    %2804 = llhd.const 1 : i1
    %2805 = llhd.const 0 : i1
    %2806 = llhd.and %2804, %2805 : i1
    %2807 = llhd.const 1 : i1
    %2808 = llhd.and %2806, %2807 : i1
    cond_br %2808, ^if_true30, ^if_false30
^if_exit28:
    br ^case_exit
^if_false30:
    %2809 = llhd.const 1 : i1
    %2810 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2809 after %2810 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2809 : !llhd.ptr<i1>
    br ^if_exit29
^if_true30:
    %2811 = llhd.const 0 : i1
    %2812 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2811 after %2812 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2811 : !llhd.ptr<i1>
    %valid_instr29 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2813 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr29 after %2813 : !llhd.sig<i1>
    br ^if_exit29
^2803:
    %2814 = llhd.const 0 : i1
    %2815 = llhd.const 2557481011 : i32
    %2816 = llhd.const 4293947519 : i32
    %2817 = llhd.and %inst_data_i1, %2816 : i32
    %2818 = llhd.and %2815, %2816 : i32
    %2819 = llhd.eq %2817, %2818 : i32
    %2820 = llhd.or %2814, %2819 : i1
    %2821 = llhd.const 2557497395 : i32
    %2822 = llhd.const 4293947519 : i32
    %2823 = llhd.and %inst_data_i1, %2822 : i32
    %2824 = llhd.and %2821, %2822 : i32
    %2825 = llhd.eq %2823, %2824 : i32
    %2826 = llhd.or %2820, %2825 : i1
    %2827 = llhd.const 2555392051 : i32
    %2828 = llhd.const 4293947519 : i32
    %2829 = llhd.and %inst_data_i1, %2828 : i32
    %2830 = llhd.and %2827, %2828 : i32
    %2831 = llhd.eq %2829, %2830 : i32
    %2832 = llhd.or %2826, %2831 : i1
    %2833 = llhd.const 2555408435 : i32
    %2834 = llhd.const 4293947519 : i32
    %2835 = llhd.and %inst_data_i1, %2834 : i32
    %2836 = llhd.and %2833, %2834 : i32
    %2837 = llhd.eq %2835, %2836 : i32
    %2838 = llhd.or %2832, %2837 : i1
    cond_br %2838, ^case_body85, ^2839
^case_body84:
    %2840 = llhd.const 1 : i1
    %2841 = llhd.const 0 : i1
    %2842 = llhd.and %2840, %2841 : i1
    %2843 = llhd.const 0 : i1
    %2844 = llhd.and %2842, %2843 : i1
    %2845 = llhd.const 8 : i32
    %2846 = llhd.const 32 : i32
    %2847 = cmpi "sge", %2845, %2846 : i32
    %2848 = llhd.and %2844, %2847 : i1
    cond_br %2848, ^if_true31, ^if_false31
^if_exit29:
    br ^case_exit
^if_false31:
    %2849 = llhd.const 1 : i1
    %2850 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2849 after %2850 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2849 : !llhd.ptr<i1>
    br ^if_exit30
^if_true31:
    %2851 = llhd.const 0 : i1
    %2852 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2851 after %2852 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2851 : !llhd.ptr<i1>
    %valid_instr30 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2853 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr30 after %2853 : !llhd.sig<i1>
    br ^if_exit30
^2839:
    %2854 = llhd.const 0 : i1
    %2855 = llhd.const 2684354643 : i32
    %2856 = llhd.const 4261441663 : i32
    %2857 = llhd.and %inst_data_i1, %2856 : i32
    %2858 = llhd.and %2855, %2856 : i32
    %2859 = llhd.eq %2857, %2858 : i32
    %2860 = llhd.or %2854, %2859 : i1
    %2861 = llhd.const 2684358739 : i32
    %2862 = llhd.const 4261441663 : i32
    %2863 = llhd.and %inst_data_i1, %2862 : i32
    %2864 = llhd.and %2861, %2862 : i32
    %2865 = llhd.eq %2863, %2864 : i32
    %2866 = llhd.or %2860, %2865 : i1
    %2867 = llhd.const 2684362835 : i32
    %2868 = llhd.const 4261441663 : i32
    %2869 = llhd.and %inst_data_i1, %2868 : i32
    %2870 = llhd.and %2867, %2868 : i32
    %2871 = llhd.eq %2869, %2870 : i32
    %2872 = llhd.or %2866, %2871 : i1
    %2873 = llhd.const 3758100563 : i32
    %2874 = llhd.const 4293947519 : i32
    %2875 = llhd.and %inst_data_i1, %2874 : i32
    %2876 = llhd.and %2873, %2874 : i32
    %2877 = llhd.eq %2875, %2876 : i32
    %2878 = llhd.or %2872, %2877 : i1
    %2879 = llhd.const 3221225555 : i32
    %2880 = llhd.const 4293918847 : i32
    %2881 = llhd.and %inst_data_i1, %2880 : i32
    %2882 = llhd.and %2879, %2880 : i32
    %2883 = llhd.eq %2881, %2882 : i32
    %2884 = llhd.or %2878, %2883 : i1
    %2885 = llhd.const 3222274131 : i32
    %2886 = llhd.const 4293918847 : i32
    %2887 = llhd.and %inst_data_i1, %2886 : i32
    %2888 = llhd.and %2885, %2886 : i32
    %2889 = llhd.eq %2887, %2888 : i32
    %2890 = llhd.or %2884, %2889 : i1
    %2891 = llhd.const 3758096467 : i32
    %2892 = llhd.const 4293947519 : i32
    %2893 = llhd.and %inst_data_i1, %2892 : i32
    %2894 = llhd.and %2891, %2892 : i32
    %2895 = llhd.eq %2893, %2894 : i32
    %2896 = llhd.or %2890, %2895 : i1
    cond_br %2896, ^case_body86, ^2897
^case_body85:
    %2898 = llhd.const 1 : i1
    %2899 = llhd.const 0 : i1
    %2900 = llhd.and %2898, %2899 : i1
    %2901 = llhd.const 0 : i1
    %2902 = llhd.and %2900, %2901 : i1
    %2903 = llhd.const 8 : i32
    %2904 = llhd.const 32 : i32
    %2905 = cmpi "sge", %2903, %2904 : i32
    %2906 = llhd.and %2902, %2905 : i1
    cond_br %2906, ^if_true32, ^if_false32
^if_exit30:
    br ^case_exit
^if_false32:
    %2907 = llhd.const 1 : i1
    %2908 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2907 after %2908 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2907 : !llhd.ptr<i1>
    br ^if_exit31
^if_true32:
    %2909 = llhd.const 0 : i1
    %2910 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2909 after %2910 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2909 : !llhd.ptr<i1>
    %valid_instr31 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2911 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr31 after %2911 : !llhd.sig<i1>
    br ^if_exit31
^2897:
    %2912 = llhd.const 0 : i1
    %2913 = llhd.const 2684354611 : i32
    %2914 = llhd.const 4261441663 : i32
    %2915 = llhd.and %inst_data_i1, %2914 : i32
    %2916 = llhd.and %2913, %2914 : i32
    %2917 = llhd.eq %2915, %2916 : i32
    %2918 = llhd.or %2912, %2917 : i1
    %2919 = llhd.const 2684370995 : i32
    %2920 = llhd.const 4261441663 : i32
    %2921 = llhd.and %inst_data_i1, %2920 : i32
    %2922 = llhd.and %2919, %2920 : i32
    %2923 = llhd.eq %2921, %2922 : i32
    %2924 = llhd.or %2918, %2923 : i1
    %2925 = llhd.const 2717909043 : i32
    %2926 = llhd.const 4261441663 : i32
    %2927 = llhd.and %inst_data_i1, %2926 : i32
    %2928 = llhd.and %2925, %2926 : i32
    %2929 = llhd.eq %2927, %2928 : i32
    %2930 = llhd.or %2924, %2929 : i1
    %2931 = llhd.const 2717925427 : i32
    %2932 = llhd.const 4261441663 : i32
    %2933 = llhd.and %inst_data_i1, %2932 : i32
    %2934 = llhd.and %2931, %2932 : i32
    %2935 = llhd.eq %2933, %2934 : i32
    %2936 = llhd.or %2930, %2935 : i1
    %2937 = llhd.const 2751463475 : i32
    %2938 = llhd.const 4261441663 : i32
    %2939 = llhd.and %inst_data_i1, %2938 : i32
    %2940 = llhd.and %2937, %2938 : i32
    %2941 = llhd.eq %2939, %2940 : i32
    %2942 = llhd.or %2936, %2941 : i1
    %2943 = llhd.const 2751479859 : i32
    %2944 = llhd.const 4261441663 : i32
    %2945 = llhd.and %inst_data_i1, %2944 : i32
    %2946 = llhd.and %2943, %2944 : i32
    %2947 = llhd.eq %2945, %2946 : i32
    %2948 = llhd.or %2942, %2947 : i1
    %2949 = llhd.const 2785017907 : i32
    %2950 = llhd.const 4261441663 : i32
    %2951 = llhd.and %inst_data_i1, %2950 : i32
    %2952 = llhd.and %2949, %2950 : i32
    %2953 = llhd.eq %2951, %2952 : i32
    %2954 = llhd.or %2948, %2953 : i1
    %2955 = llhd.const 2785034291 : i32
    %2956 = llhd.const 4261441663 : i32
    %2957 = llhd.and %inst_data_i1, %2956 : i32
    %2958 = llhd.and %2955, %2956 : i32
    %2959 = llhd.eq %2957, %2958 : i32
    %2960 = llhd.or %2954, %2959 : i1
    %2961 = llhd.const 2818572339 : i32
    %2962 = llhd.const 4261441663 : i32
    %2963 = llhd.and %inst_data_i1, %2962 : i32
    %2964 = llhd.and %2961, %2962 : i32
    %2965 = llhd.eq %2963, %2964 : i32
    %2966 = llhd.or %2960, %2965 : i1
    %2967 = llhd.const 2818588723 : i32
    %2968 = llhd.const 4261441663 : i32
    %2969 = llhd.and %inst_data_i1, %2968 : i32
    %2970 = llhd.and %2967, %2968 : i32
    %2971 = llhd.eq %2969, %2970 : i32
    %2972 = llhd.or %2966, %2971 : i1
    %2973 = llhd.const 2852126771 : i32
    %2974 = llhd.const 4261441663 : i32
    %2975 = llhd.and %inst_data_i1, %2974 : i32
    %2976 = llhd.and %2973, %2974 : i32
    %2977 = llhd.eq %2975, %2976 : i32
    %2978 = llhd.or %2972, %2977 : i1
    %2979 = llhd.const 2852143155 : i32
    %2980 = llhd.const 4261441663 : i32
    %2981 = llhd.and %inst_data_i1, %2980 : i32
    %2982 = llhd.and %2979, %2980 : i32
    %2983 = llhd.eq %2981, %2982 : i32
    %2984 = llhd.or %2978, %2983 : i1
    %2985 = llhd.const 2551185459 : i32
    %2986 = llhd.const 4293947519 : i32
    %2987 = llhd.and %inst_data_i1, %2986 : i32
    %2988 = llhd.and %2985, %2986 : i32
    %2989 = llhd.eq %2987, %2988 : i32
    %2990 = llhd.or %2984, %2989 : i1
    cond_br %2990, ^case_body87, ^2991
^case_body86:
    %2992 = llhd.const 1 : i1
    cond_br %2992, ^if_true33, ^if_false33
^if_exit31:
    br ^case_exit
^if_false33:
    %2993 = llhd.const 1 : i1
    %2994 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %2993 after %2994 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %2993 : !llhd.ptr<i1>
    br ^if_exit32
^if_true33:
    %2995 = llhd.const 0 : i1
    %2996 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %2995 after %2996 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %2995 : !llhd.ptr<i1>
    %2997 = llhd.const 1 : i1
    %2998 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %2997 after %2998 : !llhd.sig<i1>
    %valid_instr32 = llhd.prb %valid_instr : !llhd.sig<i1>
    %2999 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr32 after %2999 : !llhd.sig<i1>
    %3000 = llhd.const 1 : i1
    %3001 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %3000 after %3001 : !llhd.sig<i1>
    br ^if_exit32
^2991:
    %3002 = llhd.const 0 : i1
    %3003 = llhd.const 2717909075 : i32
    %3004 = llhd.const 4261441663 : i32
    %3005 = llhd.and %inst_data_i1, %3004 : i32
    %3006 = llhd.and %3003, %3004 : i32
    %3007 = llhd.eq %3005, %3006 : i32
    %3008 = llhd.or %3002, %3007 : i1
    %3009 = llhd.const 2717913171 : i32
    %3010 = llhd.const 4261441663 : i32
    %3011 = llhd.and %inst_data_i1, %3010 : i32
    %3012 = llhd.and %3009, %3010 : i32
    %3013 = llhd.eq %3011, %3012 : i32
    %3014 = llhd.or %3008, %3013 : i1
    %3015 = llhd.const 2717917267 : i32
    %3016 = llhd.const 4261441663 : i32
    %3017 = llhd.and %inst_data_i1, %3016 : i32
    %3018 = llhd.and %3015, %3016 : i32
    %3019 = llhd.eq %3017, %3018 : i32
    %3020 = llhd.or %3014, %3019 : i1
    %3021 = llhd.const 3791654995 : i32
    %3022 = llhd.const 4293947519 : i32
    %3023 = llhd.and %inst_data_i1, %3022 : i32
    %3024 = llhd.and %3021, %3022 : i32
    %3025 = llhd.eq %3023, %3024 : i32
    %3026 = llhd.or %3020, %3025 : i1
    %3027 = llhd.const 3254779987 : i32
    %3028 = llhd.const 4293918847 : i32
    %3029 = llhd.and %inst_data_i1, %3028 : i32
    %3030 = llhd.and %3027, %3028 : i32
    %3031 = llhd.eq %3029, %3030 : i32
    %3032 = llhd.or %3026, %3031 : i1
    %3033 = llhd.const 3255828563 : i32
    %3034 = llhd.const 4293918847 : i32
    %3035 = llhd.and %inst_data_i1, %3034 : i32
    %3036 = llhd.and %3033, %3034 : i32
    %3037 = llhd.eq %3035, %3036 : i32
    %3038 = llhd.or %3032, %3037 : i1
    cond_br %3038, ^case_body88, ^3039
^case_body87:
    %3040 = llhd.const 1 : i1
    %3041 = llhd.const 1 : i1
    %3042 = llhd.and %3040, %3041 : i1
    %3043 = llhd.const 8 : i32
    %3044 = llhd.const 64 : i32
    %3045 = cmpi "sge", %3043, %3044 : i32
    %3046 = llhd.and %3042, %3045 : i1
    cond_br %3046, ^if_true34, ^if_false34
^if_exit32:
    br ^case_exit
^if_false34:
    %3047 = llhd.const 1 : i1
    %3048 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3047 after %3048 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3047 : !llhd.ptr<i1>
    br ^if_exit33
^if_true34:
    %3049 = llhd.const 0 : i1
    %3050 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3049 after %3050 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3049 : !llhd.ptr<i1>
    %valid_instr33 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3051 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr33 after %3051 : !llhd.sig<i1>
    br ^if_exit33
^3039:
    %3052 = llhd.const 0 : i1
    %3053 = llhd.const 2751463507 : i32
    %3054 = llhd.const 4261441663 : i32
    %3055 = llhd.and %inst_data_i1, %3054 : i32
    %3056 = llhd.and %3053, %3054 : i32
    %3057 = llhd.eq %3055, %3056 : i32
    %3058 = llhd.or %3052, %3057 : i1
    %3059 = llhd.const 2751467603 : i32
    %3060 = llhd.const 4261441663 : i32
    %3061 = llhd.and %inst_data_i1, %3060 : i32
    %3062 = llhd.and %3059, %3060 : i32
    %3063 = llhd.eq %3061, %3062 : i32
    %3064 = llhd.or %3058, %3063 : i1
    %3065 = llhd.const 2751471699 : i32
    %3066 = llhd.const 4261441663 : i32
    %3067 = llhd.and %inst_data_i1, %3066 : i32
    %3068 = llhd.and %3065, %3066 : i32
    %3069 = llhd.eq %3067, %3068 : i32
    %3070 = llhd.or %3064, %3069 : i1
    %3071 = llhd.const 3825209427 : i32
    %3072 = llhd.const 4293947519 : i32
    %3073 = llhd.and %inst_data_i1, %3072 : i32
    %3074 = llhd.and %3071, %3072 : i32
    %3075 = llhd.eq %3073, %3074 : i32
    %3076 = llhd.or %3070, %3075 : i1
    %3077 = llhd.const 3288334419 : i32
    %3078 = llhd.const 4293918847 : i32
    %3079 = llhd.and %inst_data_i1, %3078 : i32
    %3080 = llhd.and %3077, %3078 : i32
    %3081 = llhd.eq %3079, %3080 : i32
    %3082 = llhd.or %3076, %3081 : i1
    %3083 = llhd.const 3289382995 : i32
    %3084 = llhd.const 4293918847 : i32
    %3085 = llhd.and %inst_data_i1, %3084 : i32
    %3086 = llhd.and %3083, %3084 : i32
    %3087 = llhd.eq %3085, %3086 : i32
    %3088 = llhd.or %3082, %3087 : i1
    %3089 = llhd.const 3825205331 : i32
    %3090 = llhd.const 4293947519 : i32
    %3091 = llhd.and %inst_data_i1, %3090 : i32
    %3092 = llhd.and %3089, %3090 : i32
    %3093 = llhd.eq %3091, %3092 : i32
    %3094 = llhd.or %3088, %3093 : i1
    cond_br %3094, ^case_body89, ^3095
^case_body88:
    %3096 = llhd.const 1 : i1
    cond_br %3096, ^if_true35, ^if_false35
^if_exit33:
    br ^case_exit
^if_false35:
    %3097 = llhd.const 1 : i1
    %3098 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3097 after %3098 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3097 : !llhd.ptr<i1>
    br ^if_exit34
^if_true35:
    %3099 = llhd.const 0 : i1
    %3100 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3099 after %3100 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3099 : !llhd.ptr<i1>
    %3101 = llhd.const 1 : i1
    %3102 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %3101 after %3102 : !llhd.sig<i1>
    %valid_instr34 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3103 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr34 after %3103 : !llhd.sig<i1>
    %3104 = llhd.const 1 : i1
    %3105 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %3104 after %3105 : !llhd.sig<i1>
    br ^if_exit34
^3095:
    %3106 = llhd.const 0 : i1
    %3107 = llhd.const 2684362803 : i32
    %3108 = llhd.const 4261441663 : i32
    %3109 = llhd.and %inst_data_i1, %3108 : i32
    %3110 = llhd.and %3107, %3108 : i32
    %3111 = llhd.eq %3109, %3110 : i32
    %3112 = llhd.or %3106, %3111 : i1
    %3113 = llhd.const 2684379187 : i32
    %3114 = llhd.const 4261441663 : i32
    %3115 = llhd.and %inst_data_i1, %3114 : i32
    %3116 = llhd.and %3113, %3114 : i32
    %3117 = llhd.eq %3115, %3116 : i32
    %3118 = llhd.or %3112, %3117 : i1
    %3119 = llhd.const 2717917235 : i32
    %3120 = llhd.const 4261441663 : i32
    %3121 = llhd.and %inst_data_i1, %3120 : i32
    %3122 = llhd.and %3119, %3120 : i32
    %3123 = llhd.eq %3121, %3122 : i32
    %3124 = llhd.or %3118, %3123 : i1
    %3125 = llhd.const 2717933619 : i32
    %3126 = llhd.const 4261441663 : i32
    %3127 = llhd.and %inst_data_i1, %3126 : i32
    %3128 = llhd.and %3125, %3126 : i32
    %3129 = llhd.eq %3127, %3128 : i32
    %3130 = llhd.or %3124, %3129 : i1
    %3131 = llhd.const 2751471667 : i32
    %3132 = llhd.const 4261441663 : i32
    %3133 = llhd.and %inst_data_i1, %3132 : i32
    %3134 = llhd.and %3131, %3132 : i32
    %3135 = llhd.eq %3133, %3134 : i32
    %3136 = llhd.or %3130, %3135 : i1
    %3137 = llhd.const 2751488051 : i32
    %3138 = llhd.const 4261441663 : i32
    %3139 = llhd.and %inst_data_i1, %3138 : i32
    %3140 = llhd.and %3137, %3138 : i32
    %3141 = llhd.eq %3139, %3140 : i32
    %3142 = llhd.or %3136, %3141 : i1
    %3143 = llhd.const 2785026099 : i32
    %3144 = llhd.const 4261441663 : i32
    %3145 = llhd.and %inst_data_i1, %3144 : i32
    %3146 = llhd.and %3143, %3144 : i32
    %3147 = llhd.eq %3145, %3146 : i32
    %3148 = llhd.or %3142, %3147 : i1
    %3149 = llhd.const 2785042483 : i32
    %3150 = llhd.const 4261441663 : i32
    %3151 = llhd.and %inst_data_i1, %3150 : i32
    %3152 = llhd.and %3149, %3150 : i32
    %3153 = llhd.eq %3151, %3152 : i32
    %3154 = llhd.or %3148, %3153 : i1
    %3155 = llhd.const 2818580531 : i32
    %3156 = llhd.const 4261441663 : i32
    %3157 = llhd.and %inst_data_i1, %3156 : i32
    %3158 = llhd.and %3155, %3156 : i32
    %3159 = llhd.eq %3157, %3158 : i32
    %3160 = llhd.or %3154, %3159 : i1
    %3161 = llhd.const 2818596915 : i32
    %3162 = llhd.const 4261441663 : i32
    %3163 = llhd.and %inst_data_i1, %3162 : i32
    %3164 = llhd.and %3161, %3162 : i32
    %3165 = llhd.eq %3163, %3164 : i32
    %3166 = llhd.or %3160, %3165 : i1
    %3167 = llhd.const 2852134963 : i32
    %3168 = llhd.const 4261441663 : i32
    %3169 = llhd.and %inst_data_i1, %3168 : i32
    %3170 = llhd.and %3167, %3168 : i32
    %3171 = llhd.eq %3169, %3170 : i32
    %3172 = llhd.or %3166, %3171 : i1
    %3173 = llhd.const 2852151347 : i32
    %3174 = llhd.const 4261441663 : i32
    %3175 = llhd.and %inst_data_i1, %3174 : i32
    %3176 = llhd.and %3173, %3174 : i32
    %3177 = llhd.eq %3175, %3176 : i32
    %3178 = llhd.or %3172, %3177 : i1
    %3179 = llhd.const 2551193651 : i32
    %3180 = llhd.const 4293947519 : i32
    %3181 = llhd.and %inst_data_i1, %3180 : i32
    %3182 = llhd.and %3179, %3180 : i32
    %3183 = llhd.eq %3181, %3182 : i32
    %3184 = llhd.or %3178, %3183 : i1
    cond_br %3184, ^case_body90, ^3185
^case_body89:
    %3186 = llhd.const 0 : i1
    %3187 = llhd.const 0 : i1
    %inst_data_i16 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %3188 = llhd.const 12 : i4
    %3189 = llhd.const 0 : i32
    %3190 = llhd.shr %inst_data_i16, %3189, %3188 : (i32, i32, i4) -> i32
    %3191 = llhd.extract_slice %3190, 0 : i32 -> i3
    %3192 = llhd.const 0 : i3
    %3193 = cmpi "uge", %3191, %3192 : i3
    %inst_data_i17 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %3194 = llhd.const 12 : i4
    %3195 = llhd.const 0 : i32
    %3196 = llhd.shr %inst_data_i17, %3195, %3194 : (i32, i32, i4) -> i32
    %3197 = llhd.extract_slice %3196, 0 : i32 -> i3
    %3198 = llhd.const 4 : i3
    %3199 = cmpi "ule", %3197, %3198 : i3
    %3200 = llhd.and %3193, %3199 : i1
    %3201 = llhd.or %3187, %3200 : i1
    %inst_data_i18 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %3202 = llhd.const 12 : i4
    %3203 = llhd.const 0 : i32
    %3204 = llhd.shr %inst_data_i18, %3203, %3202 : (i32, i32, i4) -> i32
    %3205 = llhd.extract_slice %3204, 0 : i32 -> i3
    %3206 = llhd.const 7 : i3
    %3207 = llhd.eq %3205, %3206 : i3
    %3208 = llhd.or %3201, %3207 : i1
    %3209 = llhd.and %3186, %3208 : i1
    %3210 = llhd.const 0 : i1
    %inst_data_i19 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %3211 = llhd.const 12 : i4
    %3212 = llhd.const 0 : i32
    %3213 = llhd.shr %inst_data_i19, %3212, %3211 : (i32, i32, i4) -> i32
    %3214 = llhd.extract_slice %3213, 0 : i32 -> i3
    %3215 = llhd.const 5 : i3
    %3216 = llhd.eq %3214, %3215 : i3
    %3217 = llhd.and %3210, %3216 : i1
    %3218 = llhd.or %3209, %3217 : i1
    cond_br %3218, ^if_true36, ^if_false36
^if_exit34:
    br ^case_exit
^if_false36:
    %3219 = llhd.const 1 : i1
    %3220 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3219 after %3220 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3219 : !llhd.ptr<i1>
    br ^if_exit35
^if_true36:
    %3221 = llhd.const 0 : i1
    %3222 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3221 after %3222 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3221 : !llhd.ptr<i1>
    %3223 = llhd.const 1 : i1
    %3224 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %3223 after %3224 : !llhd.sig<i1>
    %valid_instr35 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3225 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr35 after %3225 : !llhd.sig<i1>
    %3226 = llhd.const 1 : i1
    %3227 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %3226 after %3227 : !llhd.sig<i1>
    br ^if_exit35
^3185:
    %3228 = llhd.const 0 : i1
    %3229 = llhd.const 2550145075 : i32
    %3230 = llhd.const 4293947519 : i32
    %3231 = llhd.and %inst_data_i1, %3230 : i32
    %3232 = llhd.and %3229, %3230 : i32
    %3233 = llhd.eq %3231, %3232 : i32
    %3234 = llhd.or %3228, %3233 : i1
    %3235 = llhd.const 2552242227 : i32
    %3236 = llhd.const 4293947519 : i32
    %3237 = llhd.and %inst_data_i1, %3236 : i32
    %3238 = llhd.and %3235, %3236 : i32
    %3239 = llhd.eq %3237, %3238 : i32
    %3240 = llhd.or %3234, %3239 : i1
    %3241 = llhd.const 2552258611 : i32
    %3242 = llhd.const 4293947519 : i32
    %3243 = llhd.and %inst_data_i1, %3242 : i32
    %3244 = llhd.and %3241, %3242 : i32
    %3245 = llhd.eq %3243, %3244 : i32
    %3246 = llhd.or %3240, %3245 : i1
    cond_br %3246, ^case_body91, ^3247
^case_body90:
    %3248 = llhd.const 1 : i1
    %3249 = llhd.const 0 : i1
    %3250 = llhd.and %3248, %3249 : i1
    %3251 = llhd.const 8 : i32
    %3252 = llhd.const 32 : i32
    %3253 = cmpi "sge", %3251, %3252 : i32
    %3254 = llhd.and %3250, %3253 : i1
    cond_br %3254, ^if_true37, ^if_false37
^if_exit35:
    br ^case_exit
^if_false37:
    %3255 = llhd.const 1 : i1
    %3256 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3255 after %3256 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3255 : !llhd.ptr<i1>
    br ^if_exit36
^if_true37:
    %3257 = llhd.const 0 : i1
    %3258 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3257 after %3258 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3257 : !llhd.ptr<i1>
    %valid_instr36 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3259 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr36 after %3259 : !llhd.sig<i1>
    br ^if_exit36
^3247:
    %3260 = llhd.const 0 : i1
    %3261 = llhd.const 2751479891 : i32
    %3262 = llhd.const 4261441663 : i32
    %3263 = llhd.and %inst_data_i1, %3262 : i32
    %3264 = llhd.and %3261, %3262 : i32
    %3265 = llhd.eq %3263, %3264 : i32
    %3266 = llhd.or %3260, %3265 : i1
    %3267 = llhd.const 2751483987 : i32
    %3268 = llhd.const 4261441663 : i32
    %3269 = llhd.and %inst_data_i1, %3268 : i32
    %3270 = llhd.and %3267, %3268 : i32
    %3271 = llhd.eq %3269, %3270 : i32
    %3272 = llhd.or %3266, %3271 : i1
    %3273 = llhd.const 2751488083 : i32
    %3274 = llhd.const 4261441663 : i32
    %3275 = llhd.and %inst_data_i1, %3274 : i32
    %3276 = llhd.and %3273, %3274 : i32
    %3277 = llhd.eq %3275, %3276 : i32
    %3278 = llhd.or %3272, %3277 : i1
    %3279 = llhd.const 3825225811 : i32
    %3280 = llhd.const 4293947519 : i32
    %3281 = llhd.and %inst_data_i1, %3280 : i32
    %3282 = llhd.and %3279, %3280 : i32
    %3283 = llhd.eq %3281, %3282 : i32
    %3284 = llhd.or %3278, %3283 : i1
    %3285 = llhd.const 3825221715 : i32
    %3286 = llhd.const 4293947519 : i32
    %3287 = llhd.and %inst_data_i1, %3286 : i32
    %3288 = llhd.and %3285, %3286 : i32
    %3289 = llhd.eq %3287, %3288 : i32
    %3290 = llhd.or %3284, %3289 : i1
    cond_br %3290, ^case_body92, ^3291
^case_body91:
    %3292 = llhd.const 1 : i1
    %3293 = llhd.const 0 : i1
    %3294 = llhd.and %3292, %3293 : i1
    %3295 = llhd.const 8 : i32
    %3296 = llhd.const 32 : i32
    %3297 = cmpi "sge", %3295, %3296 : i32
    %3298 = llhd.and %3294, %3297 : i1
    %3299 = llhd.const 1 : i1
    %3300 = llhd.not %3299 : i1
    %3301 = llhd.and %3298, %3300 : i1
    cond_br %3301, ^if_true38, ^if_false38
^if_exit36:
    br ^case_exit
^if_false38:
    %3302 = llhd.const 1 : i1
    %3303 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3302 after %3303 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3302 : !llhd.ptr<i1>
    br ^if_exit37
^if_true38:
    %3304 = llhd.const 0 : i1
    %3305 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3304 after %3305 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3304 : !llhd.ptr<i1>
    %valid_instr37 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3306 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr37 after %3306 : !llhd.sig<i1>
    br ^if_exit37
^3291:
    %3307 = llhd.const 0 : i1
    %3308 = llhd.const 2684358707 : i32
    %3309 = llhd.const 4261441663 : i32
    %3310 = llhd.and %inst_data_i1, %3309 : i32
    %3311 = llhd.and %3308, %3309 : i32
    %3312 = llhd.eq %3310, %3311 : i32
    %3313 = llhd.or %3307, %3312 : i1
    %3314 = llhd.const 2684375091 : i32
    %3315 = llhd.const 4261441663 : i32
    %3316 = llhd.and %inst_data_i1, %3315 : i32
    %3317 = llhd.and %3314, %3315 : i32
    %3318 = llhd.eq %3316, %3317 : i32
    %3319 = llhd.or %3313, %3318 : i1
    %3320 = llhd.const 2717913139 : i32
    %3321 = llhd.const 4261441663 : i32
    %3322 = llhd.and %inst_data_i1, %3321 : i32
    %3323 = llhd.and %3320, %3321 : i32
    %3324 = llhd.eq %3322, %3323 : i32
    %3325 = llhd.or %3319, %3324 : i1
    %3326 = llhd.const 2717929523 : i32
    %3327 = llhd.const 4261441663 : i32
    %3328 = llhd.and %inst_data_i1, %3327 : i32
    %3329 = llhd.and %3326, %3327 : i32
    %3330 = llhd.eq %3328, %3329 : i32
    %3331 = llhd.or %3325, %3330 : i1
    %3332 = llhd.const 2751467571 : i32
    %3333 = llhd.const 4261441663 : i32
    %3334 = llhd.and %inst_data_i1, %3333 : i32
    %3335 = llhd.and %3332, %3333 : i32
    %3336 = llhd.eq %3334, %3335 : i32
    %3337 = llhd.or %3331, %3336 : i1
    %3338 = llhd.const 2751483955 : i32
    %3339 = llhd.const 4261441663 : i32
    %3340 = llhd.and %inst_data_i1, %3339 : i32
    %3341 = llhd.and %3338, %3339 : i32
    %3342 = llhd.eq %3340, %3341 : i32
    %3343 = llhd.or %3337, %3342 : i1
    %3344 = llhd.const 2785022003 : i32
    %3345 = llhd.const 4261441663 : i32
    %3346 = llhd.and %inst_data_i1, %3345 : i32
    %3347 = llhd.and %3344, %3345 : i32
    %3348 = llhd.eq %3346, %3347 : i32
    %3349 = llhd.or %3343, %3348 : i1
    %3350 = llhd.const 2785038387 : i32
    %3351 = llhd.const 4261441663 : i32
    %3352 = llhd.and %inst_data_i1, %3351 : i32
    %3353 = llhd.and %3350, %3351 : i32
    %3354 = llhd.eq %3352, %3353 : i32
    %3355 = llhd.or %3349, %3354 : i1
    %3356 = llhd.const 2818576435 : i32
    %3357 = llhd.const 4261441663 : i32
    %3358 = llhd.and %inst_data_i1, %3357 : i32
    %3359 = llhd.and %3356, %3357 : i32
    %3360 = llhd.eq %3358, %3359 : i32
    %3361 = llhd.or %3355, %3360 : i1
    %3362 = llhd.const 2818592819 : i32
    %3363 = llhd.const 4261441663 : i32
    %3364 = llhd.and %inst_data_i1, %3363 : i32
    %3365 = llhd.and %3362, %3363 : i32
    %3366 = llhd.eq %3364, %3365 : i32
    %3367 = llhd.or %3361, %3366 : i1
    %3368 = llhd.const 2852130867 : i32
    %3369 = llhd.const 4261441663 : i32
    %3370 = llhd.and %inst_data_i1, %3369 : i32
    %3371 = llhd.and %3368, %3369 : i32
    %3372 = llhd.eq %3370, %3371 : i32
    %3373 = llhd.or %3367, %3372 : i1
    %3374 = llhd.const 2852147251 : i32
    %3375 = llhd.const 4261441663 : i32
    %3376 = llhd.and %inst_data_i1, %3375 : i32
    %3377 = llhd.and %3374, %3375 : i32
    %3378 = llhd.eq %3376, %3377 : i32
    %3379 = llhd.or %3373, %3378 : i1
    %3380 = llhd.const 2551189555 : i32
    %3381 = llhd.const 4293947519 : i32
    %3382 = llhd.and %inst_data_i1, %3381 : i32
    %3383 = llhd.and %3380, %3381 : i32
    %3384 = llhd.eq %3382, %3383 : i32
    %3385 = llhd.or %3379, %3384 : i1
    cond_br %3385, ^case_body93, ^3386
^case_body92:
    %3387 = llhd.const 0 : i1
    cond_br %3387, ^if_true39, ^if_false39
^if_exit37:
    br ^case_exit
^if_false39:
    %3388 = llhd.const 1 : i1
    %3389 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3388 after %3389 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3388 : !llhd.ptr<i1>
    br ^if_exit38
^if_true39:
    %3390 = llhd.const 0 : i1
    %3391 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3390 after %3391 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3390 : !llhd.ptr<i1>
    %3392 = llhd.const 1 : i1
    %3393 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %3392 after %3393 : !llhd.sig<i1>
    %valid_instr38 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3394 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr38 after %3394 : !llhd.sig<i1>
    %3395 = llhd.const 1 : i1
    %3396 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %3395 after %3396 : !llhd.sig<i1>
    br ^if_exit38
^3386:
    %3397 = llhd.const 0 : i1
    %3398 = llhd.const 2550140979 : i32
    %3399 = llhd.const 4293947519 : i32
    %3400 = llhd.and %inst_data_i1, %3399 : i32
    %3401 = llhd.and %3398, %3399 : i32
    %3402 = llhd.eq %3400, %3401 : i32
    %3403 = llhd.or %3397, %3402 : i1
    %3404 = llhd.const 2552238131 : i32
    %3405 = llhd.const 4293947519 : i32
    %3406 = llhd.and %inst_data_i1, %3405 : i32
    %3407 = llhd.and %3404, %3405 : i32
    %3408 = llhd.eq %3406, %3407 : i32
    %3409 = llhd.or %3403, %3408 : i1
    %3410 = llhd.const 2552254515 : i32
    %3411 = llhd.const 4293947519 : i32
    %3412 = llhd.and %inst_data_i1, %3411 : i32
    %3413 = llhd.and %3410, %3411 : i32
    %3414 = llhd.eq %3412, %3413 : i32
    %3415 = llhd.or %3409, %3414 : i1
    cond_br %3415, ^case_body94, ^3416
^case_body93:
    %3417 = llhd.const 1 : i1
    %3418 = llhd.const 0 : i1
    %3419 = llhd.and %3417, %3418 : i1
    %3420 = llhd.const 8 : i32
    %3421 = llhd.const 32 : i32
    %3422 = cmpi "sge", %3420, %3421 : i32
    %3423 = llhd.and %3419, %3422 : i1
    cond_br %3423, ^if_true40, ^if_false40
^if_exit38:
    br ^case_exit
^if_false40:
    %3424 = llhd.const 1 : i1
    %3425 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3424 after %3425 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3424 : !llhd.ptr<i1>
    br ^if_exit39
^if_true40:
    %3426 = llhd.const 0 : i1
    %3427 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3426 after %3427 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3426 : !llhd.ptr<i1>
    %valid_instr39 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3428 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr39 after %3428 : !llhd.sig<i1>
    br ^if_exit39
^3416:
    %3429 = llhd.const 0 : i1
    %3430 = llhd.const 2785017939 : i32
    %3431 = llhd.const 4261441663 : i32
    %3432 = llhd.and %inst_data_i1, %3431 : i32
    %3433 = llhd.and %3430, %3431 : i32
    %3434 = llhd.eq %3432, %3433 : i32
    %3435 = llhd.or %3429, %3434 : i1
    %3436 = llhd.const 2785022035 : i32
    %3437 = llhd.const 4261441663 : i32
    %3438 = llhd.and %inst_data_i1, %3437 : i32
    %3439 = llhd.and %3436, %3437 : i32
    %3440 = llhd.eq %3438, %3439 : i32
    %3441 = llhd.or %3435, %3440 : i1
    %3442 = llhd.const 2785026131 : i32
    %3443 = llhd.const 4261441663 : i32
    %3444 = llhd.and %inst_data_i1, %3443 : i32
    %3445 = llhd.and %3442, %3443 : i32
    %3446 = llhd.eq %3444, %3445 : i32
    %3447 = llhd.or %3441, %3446 : i1
    %3448 = llhd.const 3858763859 : i32
    %3449 = llhd.const 4293947519 : i32
    %3450 = llhd.and %inst_data_i1, %3449 : i32
    %3451 = llhd.and %3448, %3449 : i32
    %3452 = llhd.eq %3450, %3451 : i32
    %3453 = llhd.or %3447, %3452 : i1
    %3454 = llhd.const 3321888851 : i32
    %3455 = llhd.const 4293918847 : i32
    %3456 = llhd.and %inst_data_i1, %3455 : i32
    %3457 = llhd.and %3454, %3455 : i32
    %3458 = llhd.eq %3456, %3457 : i32
    %3459 = llhd.or %3453, %3458 : i1
    %3460 = llhd.const 3322937427 : i32
    %3461 = llhd.const 4293918847 : i32
    %3462 = llhd.and %inst_data_i1, %3461 : i32
    %3463 = llhd.and %3460, %3461 : i32
    %3464 = llhd.eq %3462, %3463 : i32
    %3465 = llhd.or %3459, %3464 : i1
    %3466 = llhd.const 3858759763 : i32
    %3467 = llhd.const 4293947519 : i32
    %3468 = llhd.and %inst_data_i1, %3467 : i32
    %3469 = llhd.and %3466, %3467 : i32
    %3470 = llhd.eq %3468, %3469 : i32
    %3471 = llhd.or %3465, %3470 : i1
    cond_br %3471, ^case_body95, ^3472
^case_body94:
    %3473 = llhd.const 1 : i1
    %3474 = llhd.const 0 : i1
    %3475 = llhd.and %3473, %3474 : i1
    %3476 = llhd.const 8 : i32
    %3477 = llhd.const 32 : i32
    %3478 = cmpi "sge", %3476, %3477 : i32
    %3479 = llhd.and %3475, %3478 : i1
    %3480 = llhd.const 1 : i1
    %3481 = llhd.not %3480 : i1
    %3482 = llhd.and %3479, %3481 : i1
    cond_br %3482, ^if_true41, ^if_false41
^if_exit39:
    br ^case_exit
^if_false41:
    %3483 = llhd.const 1 : i1
    %3484 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3483 after %3484 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3483 : !llhd.ptr<i1>
    br ^if_exit40
^if_true41:
    %3485 = llhd.const 0 : i1
    %3486 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3485 after %3486 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3485 : !llhd.ptr<i1>
    %valid_instr40 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3487 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr40 after %3487 : !llhd.sig<i1>
    br ^if_exit40
^3472:
    %3488 = llhd.const 0 : i1
    %3489 = llhd.const 2684366899 : i32
    %3490 = llhd.const 4261441663 : i32
    %3491 = llhd.and %inst_data_i1, %3490 : i32
    %3492 = llhd.and %3489, %3490 : i32
    %3493 = llhd.eq %3491, %3492 : i32
    %3494 = llhd.or %3488, %3493 : i1
    %3495 = llhd.const 2684383283 : i32
    %3496 = llhd.const 4261441663 : i32
    %3497 = llhd.and %inst_data_i1, %3496 : i32
    %3498 = llhd.and %3495, %3496 : i32
    %3499 = llhd.eq %3497, %3498 : i32
    %3500 = llhd.or %3494, %3499 : i1
    %3501 = llhd.const 2717921331 : i32
    %3502 = llhd.const 4261441663 : i32
    %3503 = llhd.and %inst_data_i1, %3502 : i32
    %3504 = llhd.and %3501, %3502 : i32
    %3505 = llhd.eq %3503, %3504 : i32
    %3506 = llhd.or %3500, %3505 : i1
    %3507 = llhd.const 2717937715 : i32
    %3508 = llhd.const 4261441663 : i32
    %3509 = llhd.and %inst_data_i1, %3508 : i32
    %3510 = llhd.and %3507, %3508 : i32
    %3511 = llhd.eq %3509, %3510 : i32
    %3512 = llhd.or %3506, %3511 : i1
    %3513 = llhd.const 2751475763 : i32
    %3514 = llhd.const 4261441663 : i32
    %3515 = llhd.and %inst_data_i1, %3514 : i32
    %3516 = llhd.and %3513, %3514 : i32
    %3517 = llhd.eq %3515, %3516 : i32
    %3518 = llhd.or %3512, %3517 : i1
    %3519 = llhd.const 2751492147 : i32
    %3520 = llhd.const 4261441663 : i32
    %3521 = llhd.and %inst_data_i1, %3520 : i32
    %3522 = llhd.and %3519, %3520 : i32
    %3523 = llhd.eq %3521, %3522 : i32
    %3524 = llhd.or %3518, %3523 : i1
    %3525 = llhd.const 2785030195 : i32
    %3526 = llhd.const 4261441663 : i32
    %3527 = llhd.and %inst_data_i1, %3526 : i32
    %3528 = llhd.and %3525, %3526 : i32
    %3529 = llhd.eq %3527, %3528 : i32
    %3530 = llhd.or %3524, %3529 : i1
    %3531 = llhd.const 2785046579 : i32
    %3532 = llhd.const 4261441663 : i32
    %3533 = llhd.and %inst_data_i1, %3532 : i32
    %3534 = llhd.and %3531, %3532 : i32
    %3535 = llhd.eq %3533, %3534 : i32
    %3536 = llhd.or %3530, %3535 : i1
    %3537 = llhd.const 2818584627 : i32
    %3538 = llhd.const 4261441663 : i32
    %3539 = llhd.and %inst_data_i1, %3538 : i32
    %3540 = llhd.and %3537, %3538 : i32
    %3541 = llhd.eq %3539, %3540 : i32
    %3542 = llhd.or %3536, %3541 : i1
    %3543 = llhd.const 2818601011 : i32
    %3544 = llhd.const 4261441663 : i32
    %3545 = llhd.and %inst_data_i1, %3544 : i32
    %3546 = llhd.and %3543, %3544 : i32
    %3547 = llhd.eq %3545, %3546 : i32
    %3548 = llhd.or %3542, %3547 : i1
    %3549 = llhd.const 2852139059 : i32
    %3550 = llhd.const 4261441663 : i32
    %3551 = llhd.and %inst_data_i1, %3550 : i32
    %3552 = llhd.and %3549, %3550 : i32
    %3553 = llhd.eq %3551, %3552 : i32
    %3554 = llhd.or %3548, %3553 : i1
    %3555 = llhd.const 2852155443 : i32
    %3556 = llhd.const 4261441663 : i32
    %3557 = llhd.and %inst_data_i1, %3556 : i32
    %3558 = llhd.and %3555, %3556 : i32
    %3559 = llhd.eq %3557, %3558 : i32
    %3560 = llhd.or %3554, %3559 : i1
    cond_br %3560, ^case_body96, ^3561
^case_body95:
    %3562 = llhd.const 0 : i1
    cond_br %3562, ^if_true42, ^if_false42
^if_exit40:
    br ^case_exit
^if_false42:
    %3563 = llhd.const 1 : i1
    %3564 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3563 after %3564 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3563 : !llhd.ptr<i1>
    br ^if_exit41
^if_true42:
    %3565 = llhd.const 0 : i1
    %3566 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3565 after %3566 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3565 : !llhd.ptr<i1>
    %3567 = llhd.const 1 : i1
    %3568 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uses_rd, %3567 after %3568 : !llhd.sig<i1>
    %valid_instr41 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3569 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr41 after %3569 : !llhd.sig<i1>
    %3570 = llhd.const 1 : i1
    %3571 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_register_rd, %3570 after %3571 : !llhd.sig<i1>
    br ^if_exit41
^3561:
    %3572 = llhd.const 0 : i1
    %3573 = llhd.const 2550149171 : i32
    %3574 = llhd.const 4293947519 : i32
    %3575 = llhd.and %inst_data_i1, %3574 : i32
    %3576 = llhd.and %3573, %3574 : i32
    %3577 = llhd.eq %3575, %3576 : i32
    %3578 = llhd.or %3572, %3577 : i1
    %3579 = llhd.const 2551197747 : i32
    %3580 = llhd.const 4293947519 : i32
    %3581 = llhd.and %inst_data_i1, %3580 : i32
    %3582 = llhd.and %3579, %3580 : i32
    %3583 = llhd.eq %3581, %3582 : i32
    %3584 = llhd.or %3578, %3583 : i1
    %3585 = llhd.const 2552246323 : i32
    %3586 = llhd.const 4293947519 : i32
    %3587 = llhd.and %inst_data_i1, %3586 : i32
    %3588 = llhd.and %3585, %3586 : i32
    %3589 = llhd.eq %3587, %3588 : i32
    %3590 = llhd.or %3584, %3589 : i1
    %3591 = llhd.const 2552262707 : i32
    %3592 = llhd.const 4293947519 : i32
    %3593 = llhd.and %inst_data_i1, %3592 : i32
    %3594 = llhd.and %3591, %3592 : i32
    %3595 = llhd.eq %3593, %3594 : i32
    %3596 = llhd.or %3590, %3595 : i1
    cond_br %3596, ^case_body97, ^3597
^case_body96:
    %3598 = llhd.const 1 : i1
    %3599 = llhd.const 0 : i1
    %3600 = llhd.and %3598, %3599 : i1
    %3601 = llhd.const 8 : i32
    %3602 = llhd.const 16 : i32
    %3603 = cmpi "sge", %3601, %3602 : i32
    %3604 = llhd.and %3600, %3603 : i1
    cond_br %3604, ^if_true43, ^if_false43
^if_exit41:
    br ^case_exit
^if_false43:
    %3605 = llhd.const 1 : i1
    %3606 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3605 after %3606 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3605 : !llhd.ptr<i1>
    br ^if_exit42
^if_true43:
    %3607 = llhd.const 0 : i1
    %3608 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3607 after %3608 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3607 : !llhd.ptr<i1>
    %valid_instr42 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3609 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr42 after %3609 : !llhd.sig<i1>
    br ^if_exit42
^3597:
    %3610 = llhd.const 0 : i1
    %3611 = llhd.const 4026531923 : i32
    %3612 = llhd.const 4293947519 : i32
    %3613 = llhd.and %inst_data_i1, %3612 : i32
    %3614 = llhd.and %3611, %3612 : i32
    %3615 = llhd.eq %3613, %3614 : i32
    %3616 = llhd.or %3610, %3615 : i1
    %3617 = llhd.const 3489661011 : i32
    %3618 = llhd.const 4293918847 : i32
    %3619 = llhd.and %inst_data_i1, %3618 : i32
    %3620 = llhd.and %3617, %3618 : i32
    %3621 = llhd.eq %3619, %3620 : i32
    %3622 = llhd.or %3616, %3621 : i1
    %3623 = llhd.const 3490709587 : i32
    %3624 = llhd.const 4293918847 : i32
    %3625 = llhd.and %inst_data_i1, %3624 : i32
    %3626 = llhd.and %3623, %3624 : i32
    %3627 = llhd.eq %3625, %3626 : i32
    %3628 = llhd.or %3622, %3627 : i1
    cond_br %3628, ^case_body98, ^3629
^case_body97:
    %3630 = llhd.const 1 : i1
    %3631 = llhd.const 0 : i1
    %3632 = llhd.and %3630, %3631 : i1
    %3633 = llhd.const 8 : i32
    %3634 = llhd.const 16 : i32
    %3635 = cmpi "sge", %3633, %3634 : i32
    %3636 = llhd.and %3632, %3635 : i1
    %3637 = llhd.const 1 : i1
    %3638 = llhd.not %3637 : i1
    %3639 = llhd.and %3636, %3638 : i1
    cond_br %3639, ^if_true44, ^if_false44
^if_exit42:
    br ^case_exit
^if_false44:
    %3640 = llhd.const 1 : i1
    %3641 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3640 after %3641 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3640 : !llhd.ptr<i1>
    br ^if_exit43
^if_true44:
    %3642 = llhd.const 0 : i1
    %3643 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3642 after %3643 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3642 : !llhd.ptr<i1>
    %valid_instr43 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3644 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr43 after %3644 : !llhd.sig<i1>
    br ^if_exit43
^3629:
    %3645 = llhd.const 0 : i1
    %3646 = llhd.const 3523215443 : i32
    %3647 = llhd.const 4293918847 : i32
    %3648 = llhd.and %inst_data_i1, %3647 : i32
    %3649 = llhd.and %3646, %3647 : i32
    %3650 = llhd.eq %3648, %3649 : i32
    %3651 = llhd.or %3645, %3650 : i1
    %3652 = llhd.const 3524264019 : i32
    %3653 = llhd.const 4293918847 : i32
    %3654 = llhd.and %inst_data_i1, %3653 : i32
    %3655 = llhd.and %3652, %3653 : i32
    %3656 = llhd.eq %3654, %3655 : i32
    %3657 = llhd.or %3651, %3656 : i1
    cond_br %3657, ^case_body99, ^3658
^case_body98:
    %3659 = llhd.const 1 : i1
    cond_br %3659, ^if_true45, ^if_false45
^if_exit43:
    br ^case_exit
^if_false45:
    %3660 = llhd.const 1 : i1
    %3661 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3660 after %3661 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3660 : !llhd.ptr<i1>
    br ^if_exit44
^if_true45:
    %3662 = llhd.const 1 : i4
    %3663 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3662 after %3663 : !llhd.sig<i4>
    %3664 = llhd.const 0 : i1
    %3665 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3664 after %3665 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3664 : !llhd.ptr<i1>
    %valid_instr44 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3666 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr44 after %3666 : !llhd.sig<i1>
    br ^if_exit44
^3658:
    %3667 = llhd.const 0 : i1
    %3668 = llhd.const 4093640787 : i32
    %3669 = llhd.const 4293947519 : i32
    %3670 = llhd.and %inst_data_i1, %3669 : i32
    %3671 = llhd.and %3668, %3669 : i32
    %3672 = llhd.eq %3670, %3671 : i32
    %3673 = llhd.or %3667, %3672 : i1
    %3674 = llhd.const 3556769875 : i32
    %3675 = llhd.const 4293918847 : i32
    %3676 = llhd.and %inst_data_i1, %3675 : i32
    %3677 = llhd.and %3674, %3675 : i32
    %3678 = llhd.eq %3676, %3677 : i32
    %3679 = llhd.or %3673, %3678 : i1
    %3680 = llhd.const 3557818451 : i32
    %3681 = llhd.const 4293918847 : i32
    %3682 = llhd.and %inst_data_i1, %3681 : i32
    %3683 = llhd.and %3680, %3681 : i32
    %3684 = llhd.eq %3682, %3683 : i32
    %3685 = llhd.or %3679, %3684 : i1
    cond_br %3685, ^case_body100, ^3686
^case_body99:
    %3687 = llhd.const 1 : i1
    cond_br %3687, ^if_true46, ^if_false46
^if_exit44:
    br ^case_exit
^if_false46:
    %3688 = llhd.const 1 : i1
    %3689 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3688 after %3689 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3688 : !llhd.ptr<i1>
    br ^if_exit45
^if_true46:
    %3690 = llhd.const 1 : i4
    %3691 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3690 after %3691 : !llhd.sig<i4>
    %3692 = llhd.const 0 : i1
    %3693 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3692 after %3693 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3692 : !llhd.ptr<i1>
    %valid_instr45 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3694 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr45 after %3694 : !llhd.sig<i1>
    br ^if_exit45
^3686:
    %3695 = llhd.const 0 : i1
    %3696 = llhd.const 2550161459 : i32
    %3697 = llhd.const 4293947519 : i32
    %3698 = llhd.and %inst_data_i1, %3697 : i32
    %3699 = llhd.and %3696, %3697 : i32
    %3700 = llhd.eq %3698, %3699 : i32
    %3701 = llhd.or %3695, %3700 : i1
    %3702 = llhd.const 2553290803 : i32
    %3703 = llhd.const 4293947519 : i32
    %3704 = llhd.and %inst_data_i1, %3703 : i32
    %3705 = llhd.and %3702, %3703 : i32
    %3706 = llhd.eq %3704, %3705 : i32
    %3707 = llhd.or %3701, %3706 : i1
    %3708 = llhd.const 2553307187 : i32
    %3709 = llhd.const 4293947519 : i32
    %3710 = llhd.and %inst_data_i1, %3709 : i32
    %3711 = llhd.and %3708, %3709 : i32
    %3712 = llhd.eq %3710, %3711 : i32
    %3713 = llhd.or %3707, %3712 : i1
    cond_br %3713, ^case_body101, ^3714
^case_body100:
    %3715 = llhd.const 0 : i1
    cond_br %3715, ^if_true47, ^if_false47
^if_exit45:
    br ^case_exit
^if_false47:
    %3716 = llhd.const 1 : i1
    %3717 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3716 after %3717 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3716 : !llhd.ptr<i1>
    br ^if_exit46
^if_true47:
    %3718 = llhd.const 1 : i4
    %3719 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3718 after %3719 : !llhd.sig<i4>
    %3720 = llhd.const 0 : i1
    %3721 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3720 after %3721 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3720 : !llhd.ptr<i1>
    %valid_instr46 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3722 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr46 after %3722 : !llhd.sig<i1>
    br ^if_exit46
^3714:
    %3723 = llhd.const 0 : i1
    %3724 = llhd.const 4093657171 : i32
    %3725 = llhd.const 4293947519 : i32
    %3726 = llhd.and %inst_data_i1, %3725 : i32
    %3727 = llhd.and %3724, %3725 : i32
    %3728 = llhd.eq %3726, %3727 : i32
    %3729 = llhd.or %3723, %3728 : i1
    cond_br %3729, ^case_body102, ^3730
^case_body101:
    %3731 = llhd.const 1 : i1
    %3732 = llhd.const 0 : i1
    %3733 = llhd.and %3731, %3732 : i1
    %3734 = llhd.const 8 : i32
    %3735 = llhd.const 32 : i32
    %3736 = cmpi "sge", %3734, %3735 : i32
    %3737 = llhd.and %3733, %3736 : i1
    %3738 = llhd.const 1 : i1
    %3739 = llhd.not %3738 : i1
    %3740 = llhd.and %3737, %3739 : i1
    cond_br %3740, ^if_true48, ^if_false48
^if_exit46:
    br ^case_exit
^if_false48:
    %3741 = llhd.const 1 : i1
    %3742 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3741 after %3742 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3741 : !llhd.ptr<i1>
    br ^if_exit47
^if_true48:
    %3743 = llhd.const 0 : i1
    %3744 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3743 after %3744 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3743 : !llhd.ptr<i1>
    %valid_instr47 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3745 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr47 after %3745 : !llhd.sig<i1>
    br ^if_exit47
^3730:
    %3746 = llhd.const 0 : i1
    %3747 = llhd.const 2550157363 : i32
    %3748 = llhd.const 4293947519 : i32
    %3749 = llhd.and %inst_data_i1, %3748 : i32
    %3750 = llhd.and %3747, %3748 : i32
    %3751 = llhd.eq %3749, %3750 : i32
    %3752 = llhd.or %3746, %3751 : i1
    %3753 = llhd.const 2553286707 : i32
    %3754 = llhd.const 4293947519 : i32
    %3755 = llhd.and %inst_data_i1, %3754 : i32
    %3756 = llhd.and %3753, %3754 : i32
    %3757 = llhd.eq %3755, %3756 : i32
    %3758 = llhd.or %3752, %3757 : i1
    %3759 = llhd.const 2553303091 : i32
    %3760 = llhd.const 4293947519 : i32
    %3761 = llhd.and %inst_data_i1, %3760 : i32
    %3762 = llhd.and %3759, %3760 : i32
    %3763 = llhd.eq %3761, %3762 : i32
    %3764 = llhd.or %3758, %3763 : i1
    cond_br %3764, ^case_body103, ^3765
^case_body102:
    %3766 = llhd.const 0 : i1
    cond_br %3766, ^if_true49, ^if_false49
^if_exit47:
    br ^case_exit
^if_false49:
    %3767 = llhd.const 1 : i1
    %3768 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3767 after %3768 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3767 : !llhd.ptr<i1>
    br ^if_exit48
^if_true49:
    %3769 = llhd.const 1 : i4
    %3770 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3769 after %3770 : !llhd.sig<i4>
    %3771 = llhd.const 0 : i1
    %3772 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3771 after %3772 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3771 : !llhd.ptr<i1>
    %valid_instr48 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3773 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr48 after %3773 : !llhd.sig<i1>
    br ^if_exit48
^3765:
    %3774 = llhd.const 0 : i1
    %3775 = llhd.const 4127195219 : i32
    %3776 = llhd.const 4293947519 : i32
    %3777 = llhd.and %inst_data_i1, %3776 : i32
    %3778 = llhd.and %3775, %3776 : i32
    %3779 = llhd.eq %3777, %3778 : i32
    %3780 = llhd.or %3774, %3779 : i1
    %3781 = llhd.const 3590324307 : i32
    %3782 = llhd.const 4293918847 : i32
    %3783 = llhd.and %inst_data_i1, %3782 : i32
    %3784 = llhd.and %3781, %3782 : i32
    %3785 = llhd.eq %3783, %3784 : i32
    %3786 = llhd.or %3780, %3785 : i1
    %3787 = llhd.const 3591372883 : i32
    %3788 = llhd.const 4293918847 : i32
    %3789 = llhd.and %inst_data_i1, %3788 : i32
    %3790 = llhd.and %3787, %3788 : i32
    %3791 = llhd.eq %3789, %3790 : i32
    %3792 = llhd.or %3786, %3791 : i1
    cond_br %3792, ^case_body104, ^3793
^case_body103:
    %3794 = llhd.const 1 : i1
    %3795 = llhd.const 0 : i1
    %3796 = llhd.and %3794, %3795 : i1
    %3797 = llhd.const 8 : i32
    %3798 = llhd.const 32 : i32
    %3799 = cmpi "sge", %3797, %3798 : i32
    %3800 = llhd.and %3796, %3799 : i1
    %3801 = llhd.const 1 : i1
    %3802 = llhd.not %3801 : i1
    %3803 = llhd.and %3800, %3802 : i1
    cond_br %3803, ^if_true50, ^if_false50
^if_exit48:
    br ^case_exit
^if_false50:
    %3804 = llhd.const 1 : i1
    %3805 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3804 after %3805 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3804 : !llhd.ptr<i1>
    br ^if_exit49
^if_true50:
    %3806 = llhd.const 0 : i1
    %3807 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3806 after %3807 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3806 : !llhd.ptr<i1>
    %valid_instr49 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3808 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr49 after %3808 : !llhd.sig<i1>
    br ^if_exit49
^3793:
    %3809 = llhd.const 0 : i1
    %3810 = llhd.const 2550165555 : i32
    %3811 = llhd.const 4293947519 : i32
    %3812 = llhd.and %inst_data_i1, %3811 : i32
    %3813 = llhd.and %3810, %3811 : i32
    %3814 = llhd.eq %3812, %3813 : i32
    %3815 = llhd.or %3809, %3814 : i1
    %3816 = llhd.const 2553294899 : i32
    %3817 = llhd.const 4293947519 : i32
    %3818 = llhd.and %inst_data_i1, %3817 : i32
    %3819 = llhd.and %3816, %3817 : i32
    %3820 = llhd.eq %3818, %3819 : i32
    %3821 = llhd.or %3815, %3820 : i1
    %3822 = llhd.const 2553311283 : i32
    %3823 = llhd.const 4293947519 : i32
    %3824 = llhd.and %inst_data_i1, %3823 : i32
    %3825 = llhd.and %3822, %3823 : i32
    %3826 = llhd.eq %3824, %3825 : i32
    %3827 = llhd.or %3821, %3826 : i1
    cond_br %3827, ^case_body105, ^3828
^case_body104:
    %3829 = llhd.const 0 : i1
    cond_br %3829, ^if_true51, ^if_false51
^if_exit49:
    br ^case_exit
^if_false51:
    %3830 = llhd.const 1 : i1
    %3831 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3830 after %3831 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3830 : !llhd.ptr<i1>
    br ^if_exit50
^if_true51:
    %3832 = llhd.const 1 : i4
    %3833 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3832 after %3833 : !llhd.sig<i4>
    %3834 = llhd.const 0 : i1
    %3835 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3834 after %3835 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3834 : !llhd.ptr<i1>
    %valid_instr50 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3836 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr50 after %3836 : !llhd.sig<i1>
    br ^if_exit50
^3828:
    %3837 = llhd.const 0 : i1
    %3838 = llhd.const 11 : i32
    %3839 = llhd.const 127 : i32
    %3840 = llhd.and %inst_data_i1, %3839 : i32
    %3841 = llhd.and %3838, %3839 : i32
    %3842 = llhd.eq %3840, %3841 : i32
    %3843 = llhd.or %3837, %3842 : i1
    cond_br %3843, ^case_body106, ^3844
^case_body105:
    %3845 = llhd.const 1 : i1
    %3846 = llhd.const 0 : i1
    %3847 = llhd.and %3845, %3846 : i1
    %3848 = llhd.const 8 : i32
    %3849 = llhd.const 16 : i32
    %3850 = cmpi "sge", %3848, %3849 : i32
    %3851 = llhd.and %3847, %3850 : i1
    %3852 = llhd.const 1 : i1
    %3853 = llhd.not %3852 : i1
    %3854 = llhd.and %3851, %3853 : i1
    cond_br %3854, ^if_true52, ^if_false52
^if_exit50:
    br ^case_exit
^if_false52:
    %3855 = llhd.const 1 : i1
    %3856 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3855 after %3856 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3855 : !llhd.ptr<i1>
    br ^if_exit51
^if_true52:
    %3857 = llhd.const 0 : i1
    %3858 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3857 after %3858 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3857 : !llhd.ptr<i1>
    %valid_instr51 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3859 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr51 after %3859 : !llhd.sig<i1>
    br ^if_exit51
^3844:
    %3860 = llhd.const 0 : i1
    %3861 = llhd.const 8199 : i32
    %3862 = llhd.const 28799 : i32
    %3863 = llhd.and %inst_data_i1, %3862 : i32
    %3864 = llhd.and %3861, %3862 : i32
    %3865 = llhd.eq %3863, %3864 : i32
    %3866 = llhd.or %3860, %3865 : i1
    cond_br %3866, ^case_body107, ^3867
^case_body106:
    %3868 = llhd.const 1 : i1
    cond_br %3868, ^if_true53, ^if_false53
^if_exit51:
    br ^case_exit
^if_false53:
    br ^if_exit52
^if_true53:
    %3869 = llhd.const 1 : i4
    %3870 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3869 after %3870 : !llhd.sig<i4>
    br ^if_exit52
^3867:
    %3871 = llhd.const 0 : i1
    %3872 = llhd.const 8231 : i32
    %3873 = llhd.const 28799 : i32
    %3874 = llhd.and %inst_data_i1, %3873 : i32
    %3875 = llhd.and %3872, %3873 : i32
    %3876 = llhd.eq %3874, %3875 : i32
    %3877 = llhd.or %3871, %3876 : i1
    cond_br %3877, ^case_body108, ^3878
^case_body107:
    %3879 = llhd.const 1 : i1
    cond_br %3879, ^if_true54, ^if_false54
^if_exit52:
    %3880 = llhd.const 0 : i1
    %3881 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3880 after %3881 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3880 : !llhd.ptr<i1>
    %valid_instr52 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3882 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr52 after %3882 : !llhd.sig<i1>
    br ^case_exit
^if_false54:
    %3883 = llhd.const 1 : i1
    %3884 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3883 after %3884 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3883 : !llhd.ptr<i1>
    br ^if_exit53
^if_true54:
    %3885 = llhd.const 1 : i4
    %3886 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3885 after %3886 : !llhd.sig<i4>
    %3887 = llhd.const 2 : i4
    %3888 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %3887 after %3888 : !llhd.sig<i4>
    %3889 = llhd.const 0 : i1
    %3890 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3889 after %3890 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3889 : !llhd.ptr<i1>
    %valid_instr53 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3891 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr53 after %3891 : !llhd.sig<i1>
    br ^if_exit53
^3878:
    %3892 = llhd.const 0 : i1
    %3893 = llhd.const 12295 : i32
    %3894 = llhd.const 28799 : i32
    %3895 = llhd.and %inst_data_i1, %3894 : i32
    %3896 = llhd.and %3893, %3894 : i32
    %3897 = llhd.eq %3895, %3896 : i32
    %3898 = llhd.or %3892, %3897 : i1
    cond_br %3898, ^case_body109, ^3899
^case_body108:
    %3900 = llhd.const 1 : i1
    cond_br %3900, ^if_true55, ^if_false55
^if_exit53:
    br ^case_exit
^if_false55:
    %3901 = llhd.const 1 : i1
    %3902 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3901 after %3902 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3901 : !llhd.ptr<i1>
    br ^if_exit54
^if_true55:
    %3903 = llhd.const 1 : i4
    %3904 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3903 after %3904 : !llhd.sig<i4>
    %3905 = llhd.const 6 : i4
    %3906 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %3905 after %3906 : !llhd.sig<i4>
    %3907 = llhd.const 0 : i1
    %3908 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3907 after %3908 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3907 : !llhd.ptr<i1>
    %valid_instr54 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3909 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr54 after %3909 : !llhd.sig<i1>
    br ^if_exit54
^3899:
    %3910 = llhd.const 0 : i1
    %3911 = llhd.const 12327 : i32
    %3912 = llhd.const 28799 : i32
    %3913 = llhd.and %inst_data_i1, %3912 : i32
    %3914 = llhd.and %3911, %3912 : i32
    %3915 = llhd.eq %3913, %3914 : i32
    %3916 = llhd.or %3910, %3915 : i1
    cond_br %3916, ^case_body110, ^3917
^case_body109:
    %3918 = llhd.const 1 : i1
    %3919 = llhd.const 1 : i1
    %3920 = llhd.or %3918, %3919 : i1
    cond_br %3920, ^if_true56, ^if_false56
^if_exit54:
    br ^case_exit
^if_false56:
    %3921 = llhd.const 1 : i1
    %3922 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3921 after %3922 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3921 : !llhd.ptr<i1>
    br ^if_exit55
^if_true56:
    %3923 = llhd.const 1 : i4
    %3924 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3923 after %3924 : !llhd.sig<i4>
    %3925 = llhd.const 2 : i4
    %3926 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %3925 after %3926 : !llhd.sig<i4>
    %3927 = llhd.const 0 : i1
    %3928 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3927 after %3928 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3927 : !llhd.ptr<i1>
    %valid_instr55 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3929 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr55 after %3929 : !llhd.sig<i1>
    br ^if_exit55
^3917:
    %3930 = llhd.const 0 : i1
    %3931 = llhd.const 4103 : i32
    %3932 = llhd.const 28799 : i32
    %3933 = llhd.and %inst_data_i1, %3932 : i32
    %3934 = llhd.and %3931, %3932 : i32
    %3935 = llhd.eq %3933, %3934 : i32
    %3936 = llhd.or %3930, %3935 : i1
    cond_br %3936, ^case_body111, ^3937
^case_body110:
    %3938 = llhd.const 1 : i1
    %3939 = llhd.const 1 : i1
    %3940 = llhd.or %3938, %3939 : i1
    cond_br %3940, ^if_true57, ^if_false57
^if_exit55:
    br ^case_exit
^if_false57:
    %3941 = llhd.const 1 : i1
    %3942 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3941 after %3942 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3941 : !llhd.ptr<i1>
    br ^if_exit56
^if_true57:
    %3943 = llhd.const 1 : i4
    %3944 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3943 after %3944 : !llhd.sig<i4>
    %3945 = llhd.const 6 : i4
    %3946 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %3945 after %3946 : !llhd.sig<i4>
    %3947 = llhd.const 0 : i1
    %3948 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3947 after %3948 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3947 : !llhd.ptr<i1>
    %valid_instr56 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3949 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr56 after %3949 : !llhd.sig<i1>
    br ^if_exit56
^3937:
    %3950 = llhd.const 0 : i1
    %3951 = llhd.const 4135 : i32
    %3952 = llhd.const 28799 : i32
    %3953 = llhd.and %inst_data_i1, %3952 : i32
    %3954 = llhd.and %3951, %3952 : i32
    %3955 = llhd.eq %3953, %3954 : i32
    %3956 = llhd.or %3950, %3955 : i1
    cond_br %3956, ^case_body112, ^3957
^case_body111:
    %3958 = llhd.const 0 : i1
    %3959 = llhd.const 0 : i1
    %3960 = llhd.or %3958, %3959 : i1
    cond_br %3960, ^if_true58, ^if_false58
^if_exit56:
    br ^case_exit
^if_false58:
    %3961 = llhd.const 1 : i1
    %3962 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3961 after %3962 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3961 : !llhd.ptr<i1>
    br ^if_exit57
^if_true58:
    %3963 = llhd.const 1 : i4
    %3964 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3963 after %3964 : !llhd.sig<i4>
    %3965 = llhd.const 2 : i4
    %3966 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %3965 after %3966 : !llhd.sig<i4>
    %3967 = llhd.const 0 : i1
    %3968 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3967 after %3968 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3967 : !llhd.ptr<i1>
    %valid_instr57 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3969 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr57 after %3969 : !llhd.sig<i1>
    br ^if_exit57
^3957:
    %3970 = llhd.const 0 : i1
    %3971 = llhd.const 7 : i32
    %3972 = llhd.const 28799 : i32
    %3973 = llhd.and %inst_data_i1, %3972 : i32
    %3974 = llhd.and %3971, %3972 : i32
    %3975 = llhd.eq %3973, %3974 : i32
    %3976 = llhd.or %3970, %3975 : i1
    cond_br %3976, ^case_body113, ^3977
^case_body112:
    %3978 = llhd.const 0 : i1
    %3979 = llhd.const 0 : i1
    %3980 = llhd.or %3978, %3979 : i1
    cond_br %3980, ^if_true59, ^if_false59
^if_exit57:
    br ^case_exit
^if_false59:
    %3981 = llhd.const 1 : i1
    %3982 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3981 after %3982 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3981 : !llhd.ptr<i1>
    br ^if_exit58
^if_true59:
    %3983 = llhd.const 1 : i4
    %3984 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %3983 after %3984 : !llhd.sig<i4>
    %3985 = llhd.const 6 : i4
    %3986 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %3985 after %3986 : !llhd.sig<i4>
    %3987 = llhd.const 0 : i1
    %3988 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %3987 after %3988 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %3987 : !llhd.ptr<i1>
    %valid_instr58 = llhd.prb %valid_instr : !llhd.sig<i1>
    %3989 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr58 after %3989 : !llhd.sig<i1>
    br ^if_exit58
^3977:
    %3990 = llhd.const 0 : i1
    %3991 = llhd.const 39 : i32
    %3992 = llhd.const 28799 : i32
    %3993 = llhd.and %inst_data_i1, %3992 : i32
    %3994 = llhd.and %3991, %3992 : i32
    %3995 = llhd.eq %3993, %3994 : i32
    %3996 = llhd.or %3990, %3995 : i1
    cond_br %3996, ^case_body114, ^3997
^case_body113:
    %3998 = llhd.const 0 : i1
    cond_br %3998, ^if_true60, ^if_false60
^if_exit58:
    br ^case_exit
^if_false60:
    %3999 = llhd.const 1 : i1
    %4000 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %3999 after %4000 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %3999 : !llhd.ptr<i1>
    br ^if_exit59
^if_true60:
    %4001 = llhd.const 1 : i4
    %4002 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %4001 after %4002 : !llhd.sig<i4>
    %4003 = llhd.const 2 : i4
    %4004 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %4003 after %4004 : !llhd.sig<i4>
    %4005 = llhd.const 0 : i1
    %4006 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %4005 after %4006 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %4005 : !llhd.ptr<i1>
    %valid_instr59 = llhd.prb %valid_instr : !llhd.sig<i1>
    %4007 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr59 after %4007 : !llhd.sig<i1>
    br ^if_exit59
^3997:
    %4008 = llhd.const 1 : i1
    %4009 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %4008 after %4009 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %4008 : !llhd.ptr<i1>
    br ^case_exit
^case_body114:
    %4010 = llhd.const 0 : i1
    cond_br %4010, ^if_true61, ^if_false61
^if_exit59:
    br ^case_exit
^if_false61:
    %4011 = llhd.const 1 : i1
    %4012 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %illegal_inst1, %4011 after %4012 : !llhd.sig<i1>
    llhd.store %illegal_inst.shadow, %4011 : !llhd.ptr<i1>
    br ^if_exit60
^if_true61:
    %4013 = llhd.const 1 : i4
    %4014 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_select, %4013 after %4014 : !llhd.sig<i4>
    %4015 = llhd.const 6 : i4
    %4016 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_select, %4015 after %4016 : !llhd.sig<i4>
    %4017 = llhd.const 0 : i1
    %4018 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %write_rd1, %4017 after %4018 : !llhd.sig<i1>
    llhd.store %write_rd.shadow, %4017 : !llhd.ptr<i1>
    %valid_instr60 = llhd.prb %valid_instr : !llhd.sig<i1>
    %4019 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qvalid_o, %valid_instr60 after %4019 : !llhd.sig<i1>
    br ^if_exit60
^if_exit60:
    br ^case_exit
^if_exit61:
    br ^check
}

llhd.proc @snitch.param1.always_comb.605.1(%hart_id_i: !llhd.sig<i32>, %inst_data_i: !llhd.sig<i32>, %fpu_status_i: !llhd.sig<tuple<i1, i1, i1, i1, i1>>, %alu_result: !llhd.sig<i32>, %csr_en: !llhd.sig<i1>, %fcsr_q: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (%csr_rvalue: !llhd.sig<i32> , %fcsr_d: !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> ) {
    br ^0
^0:
    br ^body
^body:
    %1 = llhd.const 0 : i32
    %2 = llhd.const 0 : i1
    %3 = llhd.insert_slice %1, %2, 0 : i32, i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %3 after %4 : !llhd.sig<i32>
    %fcsr_q1 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fcsr_d, %fcsr_q1 after %5 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %6 = llhd.extract_element %fcsr_d, 1 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> -> !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %7 = llhd.const 0 : i5
    %fcsr_q2 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %8 = llhd.extract_element %fcsr_q2, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %9 = llhd.extract_element %8, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %10 = llhd.insert_slice %7, %9, 0 : i5, i1
    %fcsr_q3 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %11 = llhd.extract_element %fcsr_q3, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %12 = llhd.extract_element %11, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %13 = llhd.insert_slice %10, %12, 1 : i5, i1
    %fcsr_q4 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %14 = llhd.extract_element %fcsr_q4, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %15 = llhd.extract_element %14, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %16 = llhd.insert_slice %13, %15, 2 : i5, i1
    %fcsr_q5 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %17 = llhd.extract_element %fcsr_q5, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %18 = llhd.extract_element %17, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %19 = llhd.insert_slice %16, %18, 3 : i5, i1
    %fcsr_q6 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %20 = llhd.extract_element %fcsr_q6, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %21 = llhd.extract_element %20, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %22 = llhd.insert_slice %19, %21, 4 : i5, i1
    %23 = llhd.const 0 : i5
    %fpu_status_i1 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %24 = llhd.extract_element %fpu_status_i1, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %25 = llhd.insert_slice %23, %24, 0 : i5, i1
    %fpu_status_i2 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %26 = llhd.extract_element %fpu_status_i2, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %27 = llhd.insert_slice %25, %26, 1 : i5, i1
    %fpu_status_i3 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %28 = llhd.extract_element %fpu_status_i3, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %29 = llhd.insert_slice %27, %28, 2 : i5, i1
    %fpu_status_i4 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %30 = llhd.extract_element %fpu_status_i4, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %31 = llhd.insert_slice %29, %30, 3 : i5, i1
    %fpu_status_i5 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %32 = llhd.extract_element %fpu_status_i5, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %33 = llhd.insert_slice %31, %32, 4 : i5, i1
    %34 = llhd.or %22, %33 : i5
    %35 = llhd.const 0 : i32
    %36 = llhd.const 0 : i5
    %37 = llhd.shr %34, %36, %35 : (i5, i5, i32) -> i5
    %38 = llhd.extract_slice %37, 0 : i5 -> i1
    %39 = llhd.const 0 : i5
    %fcsr_q7 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %40 = llhd.extract_element %fcsr_q7, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %41 = llhd.extract_element %40, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %42 = llhd.insert_slice %39, %41, 0 : i5, i1
    %fcsr_q8 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %43 = llhd.extract_element %fcsr_q8, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %44 = llhd.extract_element %43, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %45 = llhd.insert_slice %42, %44, 1 : i5, i1
    %fcsr_q9 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %46 = llhd.extract_element %fcsr_q9, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %47 = llhd.extract_element %46, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %48 = llhd.insert_slice %45, %47, 2 : i5, i1
    %fcsr_q10 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %49 = llhd.extract_element %fcsr_q10, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %50 = llhd.extract_element %49, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %51 = llhd.insert_slice %48, %50, 3 : i5, i1
    %fcsr_q11 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %52 = llhd.extract_element %fcsr_q11, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %53 = llhd.extract_element %52, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %54 = llhd.insert_slice %51, %53, 4 : i5, i1
    %55 = llhd.const 0 : i5
    %fpu_status_i6 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %56 = llhd.extract_element %fpu_status_i6, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %57 = llhd.insert_slice %55, %56, 0 : i5, i1
    %fpu_status_i7 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %58 = llhd.extract_element %fpu_status_i7, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %59 = llhd.insert_slice %57, %58, 1 : i5, i1
    %fpu_status_i8 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %60 = llhd.extract_element %fpu_status_i8, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %61 = llhd.insert_slice %59, %60, 2 : i5, i1
    %fpu_status_i9 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %62 = llhd.extract_element %fpu_status_i9, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %63 = llhd.insert_slice %61, %62, 3 : i5, i1
    %fpu_status_i10 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %64 = llhd.extract_element %fpu_status_i10, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %65 = llhd.insert_slice %63, %64, 4 : i5, i1
    %66 = llhd.or %54, %65 : i5
    %67 = llhd.const 1 : i32
    %68 = llhd.const 0 : i5
    %69 = llhd.shr %66, %68, %67 : (i5, i5, i32) -> i5
    %70 = llhd.extract_slice %69, 0 : i5 -> i1
    %71 = llhd.const 0 : i5
    %fcsr_q12 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %72 = llhd.extract_element %fcsr_q12, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %73 = llhd.extract_element %72, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %74 = llhd.insert_slice %71, %73, 0 : i5, i1
    %fcsr_q13 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %75 = llhd.extract_element %fcsr_q13, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %76 = llhd.extract_element %75, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %77 = llhd.insert_slice %74, %76, 1 : i5, i1
    %fcsr_q14 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %78 = llhd.extract_element %fcsr_q14, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %79 = llhd.extract_element %78, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %80 = llhd.insert_slice %77, %79, 2 : i5, i1
    %fcsr_q15 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %81 = llhd.extract_element %fcsr_q15, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %82 = llhd.extract_element %81, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %83 = llhd.insert_slice %80, %82, 3 : i5, i1
    %fcsr_q16 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %84 = llhd.extract_element %fcsr_q16, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %85 = llhd.extract_element %84, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %86 = llhd.insert_slice %83, %85, 4 : i5, i1
    %87 = llhd.const 0 : i5
    %fpu_status_i11 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %88 = llhd.extract_element %fpu_status_i11, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %89 = llhd.insert_slice %87, %88, 0 : i5, i1
    %fpu_status_i12 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %90 = llhd.extract_element %fpu_status_i12, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %91 = llhd.insert_slice %89, %90, 1 : i5, i1
    %fpu_status_i13 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %92 = llhd.extract_element %fpu_status_i13, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %93 = llhd.insert_slice %91, %92, 2 : i5, i1
    %fpu_status_i14 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %94 = llhd.extract_element %fpu_status_i14, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %95 = llhd.insert_slice %93, %94, 3 : i5, i1
    %fpu_status_i15 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %96 = llhd.extract_element %fpu_status_i15, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %97 = llhd.insert_slice %95, %96, 4 : i5, i1
    %98 = llhd.or %86, %97 : i5
    %99 = llhd.const 2 : i32
    %100 = llhd.const 0 : i5
    %101 = llhd.shr %98, %100, %99 : (i5, i5, i32) -> i5
    %102 = llhd.extract_slice %101, 0 : i5 -> i1
    %103 = llhd.const 0 : i5
    %fcsr_q17 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %104 = llhd.extract_element %fcsr_q17, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %105 = llhd.extract_element %104, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %106 = llhd.insert_slice %103, %105, 0 : i5, i1
    %fcsr_q18 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %107 = llhd.extract_element %fcsr_q18, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %108 = llhd.extract_element %107, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %109 = llhd.insert_slice %106, %108, 1 : i5, i1
    %fcsr_q19 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %110 = llhd.extract_element %fcsr_q19, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %111 = llhd.extract_element %110, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %112 = llhd.insert_slice %109, %111, 2 : i5, i1
    %fcsr_q20 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %113 = llhd.extract_element %fcsr_q20, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %114 = llhd.extract_element %113, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %115 = llhd.insert_slice %112, %114, 3 : i5, i1
    %fcsr_q21 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %116 = llhd.extract_element %fcsr_q21, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %117 = llhd.extract_element %116, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %118 = llhd.insert_slice %115, %117, 4 : i5, i1
    %119 = llhd.const 0 : i5
    %fpu_status_i16 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %120 = llhd.extract_element %fpu_status_i16, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %121 = llhd.insert_slice %119, %120, 0 : i5, i1
    %fpu_status_i17 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %122 = llhd.extract_element %fpu_status_i17, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %123 = llhd.insert_slice %121, %122, 1 : i5, i1
    %fpu_status_i18 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %124 = llhd.extract_element %fpu_status_i18, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %125 = llhd.insert_slice %123, %124, 2 : i5, i1
    %fpu_status_i19 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %126 = llhd.extract_element %fpu_status_i19, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %127 = llhd.insert_slice %125, %126, 3 : i5, i1
    %fpu_status_i20 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %128 = llhd.extract_element %fpu_status_i20, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %129 = llhd.insert_slice %127, %128, 4 : i5, i1
    %130 = llhd.or %118, %129 : i5
    %131 = llhd.const 3 : i32
    %132 = llhd.const 0 : i5
    %133 = llhd.shr %130, %132, %131 : (i5, i5, i32) -> i5
    %134 = llhd.extract_slice %133, 0 : i5 -> i1
    %135 = llhd.const 0 : i5
    %fcsr_q22 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %136 = llhd.extract_element %fcsr_q22, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %137 = llhd.extract_element %136, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %138 = llhd.insert_slice %135, %137, 0 : i5, i1
    %fcsr_q23 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %139 = llhd.extract_element %fcsr_q23, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %140 = llhd.extract_element %139, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %141 = llhd.insert_slice %138, %140, 1 : i5, i1
    %fcsr_q24 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %142 = llhd.extract_element %fcsr_q24, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %143 = llhd.extract_element %142, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %144 = llhd.insert_slice %141, %143, 2 : i5, i1
    %fcsr_q25 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %145 = llhd.extract_element %fcsr_q25, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %146 = llhd.extract_element %145, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %147 = llhd.insert_slice %144, %146, 3 : i5, i1
    %fcsr_q26 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %148 = llhd.extract_element %fcsr_q26, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %149 = llhd.extract_element %148, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %150 = llhd.insert_slice %147, %149, 4 : i5, i1
    %151 = llhd.const 0 : i5
    %fpu_status_i21 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %152 = llhd.extract_element %fpu_status_i21, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %153 = llhd.insert_slice %151, %152, 0 : i5, i1
    %fpu_status_i22 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %154 = llhd.extract_element %fpu_status_i22, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %155 = llhd.insert_slice %153, %154, 1 : i5, i1
    %fpu_status_i23 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %156 = llhd.extract_element %fpu_status_i23, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %157 = llhd.insert_slice %155, %156, 2 : i5, i1
    %fpu_status_i24 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %158 = llhd.extract_element %fpu_status_i24, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %159 = llhd.insert_slice %157, %158, 3 : i5, i1
    %fpu_status_i25 = llhd.prb %fpu_status_i : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %160 = llhd.extract_element %fpu_status_i25, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %161 = llhd.insert_slice %159, %160, 4 : i5, i1
    %162 = llhd.or %150, %161 : i5
    %163 = llhd.const 4 : i32
    %164 = llhd.const 0 : i5
    %165 = llhd.shr %162, %164, %163 : (i5, i5, i32) -> i5
    %166 = llhd.extract_slice %165, 0 : i5 -> i1
    %167 = llhd.tuple %38, %70, %102, %134, %166 : tuple<i1, i1, i1, i1, i1>
    %168 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %6, %167 after %168 : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %csr_en1 = llhd.prb %csr_en : !llhd.sig<i1>
    cond_br %csr_en1, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %inst_data_i1 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %169 = llhd.const 20 : i5
    %170 = llhd.const 0 : i32
    %171 = llhd.shr %inst_data_i1, %170, %169 : (i32, i32, i5) -> i32
    %172 = llhd.extract_slice %171, 0 : i32 -> i12
    %173 = llhd.const 0 : i1
    %174 = llhd.const 3860 : i12
    %175 = llhd.eq %172, %174 : i12
    %176 = llhd.or %173, %175 : i1
    cond_br %176, ^case_body, ^177
^check:
    llhd.wait (%hart_id_i, %inst_data_i, %fpu_status_i, %alu_result, %csr_en, %fcsr_q : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<tuple<i1, i1, i1, i1, i1>>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>), ^body
^177:
    %178 = llhd.const 0 : i1
    %179 = llhd.const 1 : i12
    %180 = llhd.eq %172, %179 : i12
    %181 = llhd.or %178, %180 : i1
    cond_br %181, ^case_body1, ^182
^case_body:
    %hart_id_i1 = llhd.prb %hart_id_i : !llhd.sig<i32>
    %183 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %hart_id_i1 after %183 : !llhd.sig<i32>
    br ^case_exit
^if_exit:
    br ^check
^case_exit:
    br ^if_exit
^182:
    %184 = llhd.const 0 : i1
    %185 = llhd.const 2 : i12
    %186 = llhd.eq %172, %185 : i12
    %187 = llhd.or %184, %186 : i1
    cond_br %187, ^case_body2, ^188
^case_body1:
    %189 = llhd.const 0 : i32
    %190 = llhd.const 0 : i5
    %fcsr_q27 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %191 = llhd.extract_element %fcsr_q27, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %192 = llhd.extract_element %191, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %193 = llhd.insert_slice %190, %192, 0 : i5, i1
    %fcsr_q28 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %194 = llhd.extract_element %fcsr_q28, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %195 = llhd.extract_element %194, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %196 = llhd.insert_slice %193, %195, 1 : i5, i1
    %fcsr_q29 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %197 = llhd.extract_element %fcsr_q29, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %198 = llhd.extract_element %197, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %199 = llhd.insert_slice %196, %198, 2 : i5, i1
    %fcsr_q30 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %200 = llhd.extract_element %fcsr_q30, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %201 = llhd.extract_element %200, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %202 = llhd.insert_slice %199, %201, 3 : i5, i1
    %fcsr_q31 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %203 = llhd.extract_element %fcsr_q31, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %204 = llhd.extract_element %203, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %205 = llhd.insert_slice %202, %204, 4 : i5, i1
    %206 = llhd.insert_slice %189, %205, 0 : i32, i5
    %207 = llhd.const 0 : i27
    %208 = llhd.insert_slice %206, %207, 5 : i32, i27
    %209 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %208 after %209 : !llhd.sig<i32>
    %210 = llhd.extract_element %fcsr_d, 1 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> -> !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    %alu_result1 = llhd.prb %alu_result : !llhd.sig<i32>
    %211 = llhd.const 0 : i1
    %212 = llhd.const 0 : i32
    %213 = llhd.shr %alu_result1, %212, %211 : (i32, i32, i1) -> i32
    %214 = llhd.extract_slice %213, 0 : i32 -> i5
    %215 = llhd.const 0 : i32
    %216 = llhd.const 0 : i5
    %217 = llhd.shr %214, %216, %215 : (i5, i5, i32) -> i5
    %218 = llhd.extract_slice %217, 0 : i5 -> i1
    %alu_result2 = llhd.prb %alu_result : !llhd.sig<i32>
    %219 = llhd.const 0 : i1
    %220 = llhd.const 0 : i32
    %221 = llhd.shr %alu_result2, %220, %219 : (i32, i32, i1) -> i32
    %222 = llhd.extract_slice %221, 0 : i32 -> i5
    %223 = llhd.const 1 : i32
    %224 = llhd.const 0 : i5
    %225 = llhd.shr %222, %224, %223 : (i5, i5, i32) -> i5
    %226 = llhd.extract_slice %225, 0 : i5 -> i1
    %alu_result3 = llhd.prb %alu_result : !llhd.sig<i32>
    %227 = llhd.const 0 : i1
    %228 = llhd.const 0 : i32
    %229 = llhd.shr %alu_result3, %228, %227 : (i32, i32, i1) -> i32
    %230 = llhd.extract_slice %229, 0 : i32 -> i5
    %231 = llhd.const 2 : i32
    %232 = llhd.const 0 : i5
    %233 = llhd.shr %230, %232, %231 : (i5, i5, i32) -> i5
    %234 = llhd.extract_slice %233, 0 : i5 -> i1
    %alu_result4 = llhd.prb %alu_result : !llhd.sig<i32>
    %235 = llhd.const 0 : i1
    %236 = llhd.const 0 : i32
    %237 = llhd.shr %alu_result4, %236, %235 : (i32, i32, i1) -> i32
    %238 = llhd.extract_slice %237, 0 : i32 -> i5
    %239 = llhd.const 3 : i32
    %240 = llhd.const 0 : i5
    %241 = llhd.shr %238, %240, %239 : (i5, i5, i32) -> i5
    %242 = llhd.extract_slice %241, 0 : i5 -> i1
    %alu_result5 = llhd.prb %alu_result : !llhd.sig<i32>
    %243 = llhd.const 0 : i1
    %244 = llhd.const 0 : i32
    %245 = llhd.shr %alu_result5, %244, %243 : (i32, i32, i1) -> i32
    %246 = llhd.extract_slice %245, 0 : i32 -> i5
    %247 = llhd.const 4 : i32
    %248 = llhd.const 0 : i5
    %249 = llhd.shr %246, %248, %247 : (i5, i5, i32) -> i5
    %250 = llhd.extract_slice %249, 0 : i5 -> i1
    %251 = llhd.tuple %218, %226, %234, %242, %250 : tuple<i1, i1, i1, i1, i1>
    %252 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %210, %251 after %252 : !llhd.sig<tuple<i1, i1, i1, i1, i1>>
    br ^case_exit
^188:
    %253 = llhd.const 0 : i1
    %254 = llhd.const 3 : i12
    %255 = llhd.eq %172, %254 : i12
    %256 = llhd.or %253, %255 : i1
    cond_br %256, ^case_body3, ^257
^case_body2:
    %258 = llhd.const 0 : i32
    %fcsr_q32 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %259 = llhd.extract_element %fcsr_q32, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %260 = llhd.insert_slice %258, %259, 0 : i32, i3
    %261 = llhd.const 0 : i29
    %262 = llhd.insert_slice %260, %261, 3 : i32, i29
    %263 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %262 after %263 : !llhd.sig<i32>
    %264 = llhd.extract_element %fcsr_d, 0 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>> -> !llhd.sig<i3>
    %alu_result6 = llhd.prb %alu_result : !llhd.sig<i32>
    %265 = llhd.const 0 : i1
    %266 = llhd.const 0 : i32
    %267 = llhd.shr %alu_result6, %266, %265 : (i32, i32, i1) -> i32
    %268 = llhd.extract_slice %267, 0 : i32 -> i3
    %269 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %264, %268 after %269 : !llhd.sig<i3>
    br ^case_exit
^257:
    %270 = llhd.const 0 : i32
    %271 = llhd.const 0 : i1
    %272 = llhd.insert_slice %270, %271, 0 : i32, i1
    %273 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %272 after %273 : !llhd.sig<i32>
    br ^case_exit
^case_body3:
    %274 = llhd.const 0 : i32
    %275 = llhd.const 0 : i8
    %276 = llhd.const 0 : i5
    %fcsr_q33 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %277 = llhd.extract_element %fcsr_q33, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %278 = llhd.extract_element %277, 4 : tuple<i1, i1, i1, i1, i1> -> i1
    %279 = llhd.insert_slice %276, %278, 0 : i5, i1
    %fcsr_q34 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %280 = llhd.extract_element %fcsr_q34, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %281 = llhd.extract_element %280, 3 : tuple<i1, i1, i1, i1, i1> -> i1
    %282 = llhd.insert_slice %279, %281, 1 : i5, i1
    %fcsr_q35 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %283 = llhd.extract_element %fcsr_q35, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %284 = llhd.extract_element %283, 2 : tuple<i1, i1, i1, i1, i1> -> i1
    %285 = llhd.insert_slice %282, %284, 2 : i5, i1
    %fcsr_q36 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %286 = llhd.extract_element %fcsr_q36, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %287 = llhd.extract_element %286, 1 : tuple<i1, i1, i1, i1, i1> -> i1
    %288 = llhd.insert_slice %285, %287, 3 : i5, i1
    %fcsr_q37 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %289 = llhd.extract_element %fcsr_q37, 1 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> tuple<i1, i1, i1, i1, i1>
    %290 = llhd.extract_element %289, 0 : tuple<i1, i1, i1, i1, i1> -> i1
    %291 = llhd.insert_slice %288, %290, 4 : i5, i1
    %292 = llhd.insert_slice %275, %291, 0 : i8, i5
    %fcsr_q38 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %293 = llhd.extract_element %fcsr_q38, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %294 = llhd.insert_slice %292, %293, 5 : i8, i3
    %295 = llhd.insert_slice %274, %294, 0 : i32, i8
    %296 = llhd.const 0 : i24
    %297 = llhd.insert_slice %295, %296, 8 : i32, i24
    %298 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %csr_rvalue, %297 after %298 : !llhd.sig<i32>
    %alu_result7 = llhd.prb %alu_result : !llhd.sig<i32>
    %299 = llhd.const 0 : i1
    %300 = llhd.const 0 : i32
    %301 = llhd.shr %alu_result7, %300, %299 : (i32, i32, i1) -> i32
    %302 = llhd.extract_slice %301, 0 : i32 -> i8
    %303 = llhd.const 0 : i32
    %304 = llhd.const 0 : i8
    %305 = llhd.shr %302, %304, %303 : (i8, i8, i32) -> i8
    %306 = llhd.extract_slice %305, 0 : i8 -> i3
    %alu_result8 = llhd.prb %alu_result : !llhd.sig<i32>
    %307 = llhd.const 0 : i1
    %308 = llhd.const 0 : i32
    %309 = llhd.shr %alu_result8, %308, %307 : (i32, i32, i1) -> i32
    %310 = llhd.extract_slice %309, 0 : i32 -> i8
    %311 = llhd.const 3 : i32
    %312 = llhd.const 0 : i8
    %313 = llhd.shr %310, %312, %311 : (i8, i8, i32) -> i8
    %314 = llhd.extract_slice %313, 0 : i8 -> i5
    %315 = llhd.const 0 : i32
    %316 = llhd.const 0 : i5
    %317 = llhd.shr %314, %316, %315 : (i5, i5, i32) -> i5
    %318 = llhd.extract_slice %317, 0 : i5 -> i1
    %alu_result9 = llhd.prb %alu_result : !llhd.sig<i32>
    %319 = llhd.const 0 : i1
    %320 = llhd.const 0 : i32
    %321 = llhd.shr %alu_result9, %320, %319 : (i32, i32, i1) -> i32
    %322 = llhd.extract_slice %321, 0 : i32 -> i8
    %323 = llhd.const 3 : i32
    %324 = llhd.const 0 : i8
    %325 = llhd.shr %322, %324, %323 : (i8, i8, i32) -> i8
    %326 = llhd.extract_slice %325, 0 : i8 -> i5
    %327 = llhd.const 1 : i32
    %328 = llhd.const 0 : i5
    %329 = llhd.shr %326, %328, %327 : (i5, i5, i32) -> i5
    %330 = llhd.extract_slice %329, 0 : i5 -> i1
    %alu_result10 = llhd.prb %alu_result : !llhd.sig<i32>
    %331 = llhd.const 0 : i1
    %332 = llhd.const 0 : i32
    %333 = llhd.shr %alu_result10, %332, %331 : (i32, i32, i1) -> i32
    %334 = llhd.extract_slice %333, 0 : i32 -> i8
    %335 = llhd.const 3 : i32
    %336 = llhd.const 0 : i8
    %337 = llhd.shr %334, %336, %335 : (i8, i8, i32) -> i8
    %338 = llhd.extract_slice %337, 0 : i8 -> i5
    %339 = llhd.const 2 : i32
    %340 = llhd.const 0 : i5
    %341 = llhd.shr %338, %340, %339 : (i5, i5, i32) -> i5
    %342 = llhd.extract_slice %341, 0 : i5 -> i1
    %alu_result11 = llhd.prb %alu_result : !llhd.sig<i32>
    %343 = llhd.const 0 : i1
    %344 = llhd.const 0 : i32
    %345 = llhd.shr %alu_result11, %344, %343 : (i32, i32, i1) -> i32
    %346 = llhd.extract_slice %345, 0 : i32 -> i8
    %347 = llhd.const 3 : i32
    %348 = llhd.const 0 : i8
    %349 = llhd.shr %346, %348, %347 : (i8, i8, i32) -> i8
    %350 = llhd.extract_slice %349, 0 : i8 -> i5
    %351 = llhd.const 3 : i32
    %352 = llhd.const 0 : i5
    %353 = llhd.shr %350, %352, %351 : (i5, i5, i32) -> i5
    %354 = llhd.extract_slice %353, 0 : i5 -> i1
    %alu_result12 = llhd.prb %alu_result : !llhd.sig<i32>
    %355 = llhd.const 0 : i1
    %356 = llhd.const 0 : i32
    %357 = llhd.shr %alu_result12, %356, %355 : (i32, i32, i1) -> i32
    %358 = llhd.extract_slice %357, 0 : i32 -> i8
    %359 = llhd.const 3 : i32
    %360 = llhd.const 0 : i8
    %361 = llhd.shr %358, %360, %359 : (i8, i8, i32) -> i8
    %362 = llhd.extract_slice %361, 0 : i8 -> i5
    %363 = llhd.const 4 : i32
    %364 = llhd.const 0 : i5
    %365 = llhd.shr %362, %364, %363 : (i5, i5, i32) -> i5
    %366 = llhd.extract_slice %365, 0 : i5 -> i1
    %367 = llhd.tuple %318, %330, %342, %354, %366 : tuple<i1, i1, i1, i1, i1>
    %368 = llhd.tuple %306, %367 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %369 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fcsr_d, %368 after %369 : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.608.1(%uimm: !llhd.sig<i32>, %jimm: !llhd.sig<i32>, %rs1: !llhd.sig<i5>, %gpr_rdata: !llhd.sig<!llhd.array<2xi32>>, %opa_select: !llhd.sig<i4>) -> (%opa: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^body
^body:
    %opa_select1 = llhd.prb %opa_select : !llhd.sig<i4>
    %1 = llhd.const 0 : i1
    %2 = llhd.const 0 : i4
    %3 = llhd.eq %opa_select1, %2 : i4
    %4 = llhd.or %1, %3 : i1
    cond_br %4, ^case_body, ^5
^5:
    %6 = llhd.const 0 : i1
    %7 = llhd.const 1 : i4
    %8 = llhd.eq %opa_select1, %7 : i4
    %9 = llhd.or %6, %8 : i1
    cond_br %9, ^case_body1, ^10
^case_body:
    %11 = llhd.const 0 : i32
    %12 = llhd.const 0 : i1
    %13 = llhd.insert_slice %11, %12, 0 : i32, i1
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa, %13 after %14 : !llhd.sig<i32>
    br ^case_exit
^check:
    llhd.wait (%uimm, %jimm, %rs1, %gpr_rdata, %opa_select : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i5>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>), ^body
^case_exit:
    br ^check
^10:
    %15 = llhd.const 0 : i1
    %16 = llhd.const 3 : i4
    %17 = llhd.eq %opa_select1, %16 : i4
    %18 = llhd.or %15, %17 : i1
    cond_br %18, ^case_body2, ^19
^case_body1:
    %gpr_rdata1 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %20 = llhd.const 0 : i32
    %21 = llhd.const 0 : i32
    %22 = llhd.array_uniform %21 : !llhd.array<2xi32>
    %23 = llhd.shr %gpr_rdata1, %22, %20 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %24 = llhd.extract_element %23, 0 : !llhd.array<2xi32> -> i32
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa, %24 after %25 : !llhd.sig<i32>
    br ^case_exit
^19:
    %26 = llhd.const 0 : i1
    %27 = llhd.const 4 : i4
    %28 = llhd.eq %opa_select1, %27 : i4
    %29 = llhd.or %26, %28 : i1
    cond_br %29, ^case_body3, ^30
^case_body2:
    %uimm1 = llhd.prb %uimm : !llhd.sig<i32>
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa, %uimm1 after %31 : !llhd.sig<i32>
    br ^case_exit
^30:
    %32 = llhd.const 0 : i1
    %33 = llhd.const 9 : i4
    %34 = llhd.eq %opa_select1, %33 : i4
    %35 = llhd.or %32, %34 : i1
    cond_br %35, ^case_body4, ^36
^case_body3:
    %jimm1 = llhd.prb %jimm : !llhd.sig<i32>
    %37 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa, %jimm1 after %37 : !llhd.sig<i32>
    br ^case_exit
^36:
    %38 = llhd.const 0 : i32
    %39 = llhd.const 0 : i1
    %40 = llhd.insert_slice %38, %39, 0 : i32, i1
    %41 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa, %40 after %41 : !llhd.sig<i32>
    br ^case_exit
^case_body4:
    %42 = llhd.const 0 : i32
    %rs11 = llhd.prb %rs1 : !llhd.sig<i5>
    %43 = llhd.insert_slice %42, %rs11, 0 : i32, i5
    %44 = llhd.const 0 : i1
    %45 = llhd.const 0 : i1
    %46 = llhd.insert_slice %44, %45, 0 : i1, i1
    %47 = llhd.const 0 : i27
    %48 = llhd.insert_slice %47, %46, 0 : i27, i1
    %49 = llhd.insert_slice %48, %46, 1 : i27, i1
    %50 = llhd.insert_slice %49, %46, 2 : i27, i1
    %51 = llhd.insert_slice %50, %46, 3 : i27, i1
    %52 = llhd.insert_slice %51, %46, 4 : i27, i1
    %53 = llhd.insert_slice %52, %46, 5 : i27, i1
    %54 = llhd.insert_slice %53, %46, 6 : i27, i1
    %55 = llhd.insert_slice %54, %46, 7 : i27, i1
    %56 = llhd.insert_slice %55, %46, 8 : i27, i1
    %57 = llhd.insert_slice %56, %46, 9 : i27, i1
    %58 = llhd.insert_slice %57, %46, 10 : i27, i1
    %59 = llhd.insert_slice %58, %46, 11 : i27, i1
    %60 = llhd.insert_slice %59, %46, 12 : i27, i1
    %61 = llhd.insert_slice %60, %46, 13 : i27, i1
    %62 = llhd.insert_slice %61, %46, 14 : i27, i1
    %63 = llhd.insert_slice %62, %46, 15 : i27, i1
    %64 = llhd.insert_slice %63, %46, 16 : i27, i1
    %65 = llhd.insert_slice %64, %46, 17 : i27, i1
    %66 = llhd.insert_slice %65, %46, 18 : i27, i1
    %67 = llhd.insert_slice %66, %46, 19 : i27, i1
    %68 = llhd.insert_slice %67, %46, 20 : i27, i1
    %69 = llhd.insert_slice %68, %46, 21 : i27, i1
    %70 = llhd.insert_slice %69, %46, 22 : i27, i1
    %71 = llhd.insert_slice %70, %46, 23 : i27, i1
    %72 = llhd.insert_slice %71, %46, 24 : i27, i1
    %73 = llhd.insert_slice %72, %46, 25 : i27, i1
    %74 = llhd.insert_slice %73, %46, 26 : i27, i1
    %75 = llhd.insert_slice %43, %74, 5 : i32, i27
    %76 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa, %75 after %76 : !llhd.sig<i32>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.609.1(%pc_q: !llhd.sig<i32>, %iimm: !llhd.sig<i32>, %simm: !llhd.sig<i32>, %gpr_rdata: !llhd.sig<!llhd.array<2xi32>>, %opb_select: !llhd.sig<i4>, %csr_rvalue: !llhd.sig<i32>) -> (%opb: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^body
^body:
    %opb_select1 = llhd.prb %opb_select : !llhd.sig<i4>
    %1 = llhd.const 0 : i1
    %2 = llhd.const 0 : i4
    %3 = llhd.eq %opb_select1, %2 : i4
    %4 = llhd.or %1, %3 : i1
    cond_br %4, ^case_body, ^5
^5:
    %6 = llhd.const 0 : i1
    %7 = llhd.const 1 : i4
    %8 = llhd.eq %opb_select1, %7 : i4
    %9 = llhd.or %6, %8 : i1
    cond_br %9, ^case_body1, ^10
^case_body:
    %11 = llhd.const 0 : i32
    %12 = llhd.const 0 : i1
    %13 = llhd.insert_slice %11, %12, 0 : i32, i1
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %13 after %14 : !llhd.sig<i32>
    br ^case_exit
^check:
    llhd.wait (%pc_q, %iimm, %simm, %gpr_rdata, %opb_select, %csr_rvalue : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>, !llhd.sig<i32>), ^body
^case_exit:
    br ^check
^10:
    %15 = llhd.const 0 : i1
    %16 = llhd.const 2 : i4
    %17 = llhd.eq %opb_select1, %16 : i4
    %18 = llhd.or %15, %17 : i1
    cond_br %18, ^case_body2, ^19
^case_body1:
    %gpr_rdata1 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %20 = llhd.const 1 : i32
    %21 = llhd.const 0 : i32
    %22 = llhd.array_uniform %21 : !llhd.array<2xi32>
    %23 = llhd.shr %gpr_rdata1, %22, %20 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %24 = llhd.extract_element %23, 0 : !llhd.array<2xi32> -> i32
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %24 after %25 : !llhd.sig<i32>
    br ^case_exit
^19:
    %26 = llhd.const 0 : i1
    %27 = llhd.const 6 : i4
    %28 = llhd.eq %opb_select1, %27 : i4
    %29 = llhd.or %26, %28 : i1
    %30 = llhd.const 5 : i4
    %31 = llhd.eq %opb_select1, %30 : i4
    %32 = llhd.or %29, %31 : i1
    cond_br %32, ^case_body3, ^33
^case_body2:
    %iimm1 = llhd.prb %iimm : !llhd.sig<i32>
    %34 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %iimm1 after %34 : !llhd.sig<i32>
    br ^case_exit
^33:
    %35 = llhd.const 0 : i1
    %36 = llhd.const 7 : i4
    %37 = llhd.eq %opb_select1, %36 : i4
    %38 = llhd.or %35, %37 : i1
    cond_br %38, ^case_body4, ^39
^case_body3:
    %simm1 = llhd.prb %simm : !llhd.sig<i32>
    %40 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %simm1 after %40 : !llhd.sig<i32>
    br ^case_exit
^39:
    %41 = llhd.const 0 : i1
    %42 = llhd.const 8 : i4
    %43 = llhd.eq %opb_select1, %42 : i4
    %44 = llhd.or %41, %43 : i1
    cond_br %44, ^case_body5, ^45
^case_body4:
    %pc_q1 = llhd.prb %pc_q : !llhd.sig<i32>
    %46 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %pc_q1 after %46 : !llhd.sig<i32>
    br ^case_exit
^45:
    %47 = llhd.const 0 : i32
    %48 = llhd.const 0 : i1
    %49 = llhd.insert_slice %47, %48, 0 : i32, i1
    %50 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %49 after %50 : !llhd.sig<i32>
    br ^case_exit
^case_body5:
    %csr_rvalue1 = llhd.prb %csr_rvalue : !llhd.sig<i32>
    %51 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb, %csr_rvalue1 after %51 : !llhd.sig<i32>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.633.1(%opa: !llhd.sig<i32>, %opb: !llhd.sig<i32>, %adder_result: !llhd.sig<i33>, %alu_op: !llhd.sig<i4>, %shift_right_result: !llhd.sig<i32>, %shift_left_result: !llhd.sig<i32>) -> (%alu_result: !llhd.sig<i32> , %shift_left: !llhd.sig<i1> , %shift_arithmetic: !llhd.sig<i1> , %alu_opa: !llhd.sig<i33> , %alu_opb: !llhd.sig<i33> ) {
    br ^0
^0:
    br ^body
^body:
    %opa1 = llhd.prb %opa : !llhd.sig<i32>
    %1 = llhd.extract_slice %opa1, 31 : i32 -> i1
    %2 = llhd.const 0 : i33
    %3 = llhd.not %2 : i33
    %4 = llhd.array %2, %3 : !llhd.array<2xi33>
    %5 = llhd.dyn_extract_element %4, %1 : (!llhd.array<2xi33>, i1) -> i33
    %6 = llhd.insert_slice %5, %opa1, 0 : i33, i32
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opa, %6 after %7 : !llhd.sig<i33>
    %opb1 = llhd.prb %opb : !llhd.sig<i32>
    %8 = llhd.extract_slice %opb1, 31 : i32 -> i1
    %9 = llhd.const 0 : i33
    %10 = llhd.not %9 : i33
    %11 = llhd.array %9, %10 : !llhd.array<2xi33>
    %12 = llhd.dyn_extract_element %11, %8 : (!llhd.array<2xi33>, i1) -> i33
    %13 = llhd.insert_slice %12, %opb1, 0 : i33, i32
    %14 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %13 after %14 : !llhd.sig<i33>
    %adder_result1 = llhd.prb %adder_result : !llhd.sig<i33>
    %15 = llhd.const 0 : i1
    %16 = llhd.const 0 : i33
    %17 = llhd.shr %adder_result1, %16, %15 : (i33, i33, i1) -> i33
    %18 = llhd.extract_slice %17, 0 : i33 -> i32
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %18 after %19 : !llhd.sig<i32>
    %20 = llhd.const 0 : i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_left, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const 0 : i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_arithmetic, %22 after %23 : !llhd.sig<i1>
    %alu_op1 = llhd.prb %alu_op : !llhd.sig<i4>
    %24 = llhd.const 0 : i1
    %25 = llhd.const 1 : i4
    %26 = llhd.eq %alu_op1, %25 : i4
    %27 = llhd.or %24, %26 : i1
    cond_br %27, ^case_body, ^28
^28:
    %29 = llhd.const 0 : i1
    %30 = llhd.const 2 : i4
    %31 = llhd.eq %alu_op1, %30 : i4
    %32 = llhd.or %29, %31 : i1
    cond_br %32, ^case_body1, ^33
^case_body:
    %opb2 = llhd.prb %opb : !llhd.sig<i32>
    %34 = llhd.neg %opb2 : i32
    %35 = llhd.extract_slice %34, 31 : i32 -> i1
    %36 = llhd.const 0 : i33
    %37 = llhd.not %36 : i33
    %38 = llhd.array %36, %37 : !llhd.array<2xi33>
    %39 = llhd.dyn_extract_element %38, %35 : (!llhd.array<2xi33>, i1) -> i33
    %40 = llhd.insert_slice %39, %34, 0 : i33, i32
    %41 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %40 after %41 : !llhd.sig<i33>
    br ^case_exit
^check:
    llhd.wait (%opa, %opb, %adder_result, %alu_op, %shift_right_result, %shift_left_result : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i33>, !llhd.sig<i4>, !llhd.sig<i32>, !llhd.sig<i32>), ^body
^case_exit:
    br ^check
^33:
    %42 = llhd.const 0 : i1
    %43 = llhd.const 13 : i4
    %44 = llhd.eq %alu_op1, %43 : i4
    %45 = llhd.or %42, %44 : i1
    cond_br %45, ^case_body2, ^46
^case_body1:
    %opb3 = llhd.prb %opb : !llhd.sig<i32>
    %47 = llhd.neg %opb3 : i32
    %48 = llhd.extract_slice %47, 31 : i32 -> i1
    %49 = llhd.const 0 : i33
    %50 = llhd.not %49 : i33
    %51 = llhd.array %49, %50 : !llhd.array<2xi33>
    %52 = llhd.dyn_extract_element %51, %48 : (!llhd.array<2xi33>, i1) -> i33
    %53 = llhd.insert_slice %52, %47, 0 : i33, i32
    %54 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %53 after %54 : !llhd.sig<i33>
    %55 = llhd.const 0 : i32
    %56 = llhd.const 0 : i31
    %adder_result2 = llhd.prb %adder_result : !llhd.sig<i33>
    %57 = llhd.const 32 : i32
    %58 = llhd.const 0 : i33
    %59 = llhd.shr %adder_result2, %58, %57 : (i33, i33, i32) -> i33
    %60 = llhd.extract_slice %59, 0 : i33 -> i1
    %61 = llhd.insert_slice %56, %60, 0 : i31, i1
    %62 = llhd.const 0 : i30
    %63 = llhd.insert_slice %61, %62, 1 : i31, i30
    %64 = llhd.insert_slice %55, %63, 0 : i32, i31
    %65 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %64 after %65 : !llhd.sig<i32>
    br ^case_exit
^46:
    %66 = llhd.const 0 : i1
    %67 = llhd.const 3 : i4
    %68 = llhd.eq %alu_op1, %67 : i4
    %69 = llhd.or %66, %68 : i1
    cond_br %69, ^case_body3, ^70
^case_body2:
    %opb4 = llhd.prb %opb : !llhd.sig<i32>
    %71 = llhd.neg %opb4 : i32
    %72 = llhd.extract_slice %71, 31 : i32 -> i1
    %73 = llhd.const 0 : i33
    %74 = llhd.not %73 : i33
    %75 = llhd.array %73, %74 : !llhd.array<2xi33>
    %76 = llhd.dyn_extract_element %75, %72 : (!llhd.array<2xi33>, i1) -> i33
    %77 = llhd.insert_slice %76, %71, 0 : i33, i32
    %78 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %77 after %78 : !llhd.sig<i33>
    %79 = llhd.const 0 : i32
    %80 = llhd.const 0 : i31
    %adder_result3 = llhd.prb %adder_result : !llhd.sig<i33>
    %81 = llhd.const 32 : i32
    %82 = llhd.const 0 : i33
    %83 = llhd.shr %adder_result3, %82, %81 : (i33, i33, i32) -> i33
    %84 = llhd.extract_slice %83, 0 : i33 -> i1
    %85 = llhd.not %84 : i1
    %86 = llhd.insert_slice %80, %85, 0 : i31, i1
    %87 = llhd.const 0 : i30
    %88 = llhd.insert_slice %86, %87, 1 : i31, i30
    %89 = llhd.insert_slice %79, %88, 0 : i32, i31
    %90 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %89 after %90 : !llhd.sig<i32>
    br ^case_exit
^70:
    %91 = llhd.const 0 : i1
    %92 = llhd.const 14 : i4
    %93 = llhd.eq %alu_op1, %92 : i4
    %94 = llhd.or %91, %93 : i1
    cond_br %94, ^case_body4, ^95
^case_body3:
    %96 = llhd.const 0 : i33
    %opa2 = llhd.prb %opa : !llhd.sig<i32>
    %97 = llhd.insert_slice %96, %opa2, 0 : i33, i32
    %98 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opa, %97 after %98 : !llhd.sig<i33>
    %99 = llhd.const 0 : i33
    %opb5 = llhd.prb %opb : !llhd.sig<i32>
    %100 = llhd.neg %opb5 : i32
    %101 = llhd.insert_slice %99, %100, 0 : i33, i32
    %102 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %101 after %102 : !llhd.sig<i33>
    %103 = llhd.const 0 : i32
    %104 = llhd.const 0 : i31
    %adder_result4 = llhd.prb %adder_result : !llhd.sig<i33>
    %105 = llhd.const 32 : i32
    %106 = llhd.const 0 : i33
    %107 = llhd.shr %adder_result4, %106, %105 : (i33, i33, i32) -> i33
    %108 = llhd.extract_slice %107, 0 : i33 -> i1
    %109 = llhd.insert_slice %104, %108, 0 : i31, i1
    %110 = llhd.const 0 : i30
    %111 = llhd.insert_slice %109, %110, 1 : i31, i30
    %112 = llhd.insert_slice %103, %111, 0 : i32, i31
    %113 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %112 after %113 : !llhd.sig<i32>
    br ^case_exit
^95:
    %114 = llhd.const 0 : i1
    %115 = llhd.const 4 : i4
    %116 = llhd.eq %alu_op1, %115 : i4
    %117 = llhd.or %114, %116 : i1
    cond_br %117, ^case_body5, ^118
^case_body4:
    %119 = llhd.const 0 : i33
    %opa3 = llhd.prb %opa : !llhd.sig<i32>
    %120 = llhd.insert_slice %119, %opa3, 0 : i33, i32
    %121 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opa, %120 after %121 : !llhd.sig<i33>
    %122 = llhd.const 0 : i33
    %opb6 = llhd.prb %opb : !llhd.sig<i32>
    %123 = llhd.neg %opb6 : i32
    %124 = llhd.insert_slice %122, %123, 0 : i33, i32
    %125 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %124 after %125 : !llhd.sig<i33>
    %126 = llhd.const 0 : i32
    %127 = llhd.const 0 : i31
    %adder_result5 = llhd.prb %adder_result : !llhd.sig<i33>
    %128 = llhd.const 32 : i32
    %129 = llhd.const 0 : i33
    %130 = llhd.shr %adder_result5, %129, %128 : (i33, i33, i32) -> i33
    %131 = llhd.extract_slice %130, 0 : i33 -> i1
    %132 = llhd.not %131 : i1
    %133 = llhd.insert_slice %127, %132, 0 : i31, i1
    %134 = llhd.const 0 : i30
    %135 = llhd.insert_slice %133, %134, 1 : i31, i30
    %136 = llhd.insert_slice %126, %135, 0 : i32, i31
    %137 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %136 after %137 : !llhd.sig<i32>
    br ^case_exit
^118:
    %138 = llhd.const 0 : i1
    %139 = llhd.const 5 : i4
    %140 = llhd.eq %alu_op1, %139 : i4
    %141 = llhd.or %138, %140 : i1
    cond_br %141, ^case_body6, ^142
^case_body5:
    %143 = llhd.const 1 : i1
    %144 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_left, %143 after %144 : !llhd.sig<i1>
    %shift_left_result1 = llhd.prb %shift_left_result : !llhd.sig<i32>
    %145 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %shift_left_result1 after %145 : !llhd.sig<i32>
    br ^case_exit
^142:
    %146 = llhd.const 0 : i1
    %147 = llhd.const 6 : i4
    %148 = llhd.eq %alu_op1, %147 : i4
    %149 = llhd.or %146, %148 : i1
    cond_br %149, ^case_body7, ^150
^case_body6:
    %shift_right_result1 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %151 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %shift_right_result1 after %151 : !llhd.sig<i32>
    br ^case_exit
^150:
    %152 = llhd.const 0 : i1
    %153 = llhd.const 7 : i4
    %154 = llhd.eq %alu_op1, %153 : i4
    %155 = llhd.or %152, %154 : i1
    cond_br %155, ^case_body8, ^156
^case_body7:
    %157 = llhd.const 1 : i1
    %158 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_arithmetic, %157 after %158 : !llhd.sig<i1>
    %shift_right_result2 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %159 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %shift_right_result2 after %159 : !llhd.sig<i32>
    br ^case_exit
^156:
    %160 = llhd.const 0 : i1
    %161 = llhd.const 9 : i4
    %162 = llhd.eq %alu_op1, %161 : i4
    %163 = llhd.or %160, %162 : i1
    cond_br %163, ^case_body9, ^164
^case_body8:
    %opa4 = llhd.prb %opa : !llhd.sig<i32>
    %opb7 = llhd.prb %opb : !llhd.sig<i32>
    %165 = llhd.xor %opa4, %opb7 : i32
    %166 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %165 after %166 : !llhd.sig<i32>
    br ^case_exit
^164:
    %167 = llhd.const 0 : i1
    %168 = llhd.const 10 : i4
    %169 = llhd.eq %alu_op1, %168 : i4
    %170 = llhd.or %167, %169 : i1
    cond_br %170, ^case_body10, ^171
^case_body9:
    %opa5 = llhd.prb %opa : !llhd.sig<i32>
    %opb8 = llhd.prb %opb : !llhd.sig<i32>
    %172 = llhd.and %opa5, %opb8 : i32
    %173 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %172 after %173 : !llhd.sig<i32>
    br ^case_exit
^171:
    %174 = llhd.const 0 : i1
    %175 = llhd.const 8 : i4
    %176 = llhd.eq %alu_op1, %175 : i4
    %177 = llhd.or %174, %176 : i1
    cond_br %177, ^case_body11, ^178
^case_body10:
    %opa6 = llhd.prb %opa : !llhd.sig<i32>
    %179 = llhd.not %opa6 : i32
    %opb9 = llhd.prb %opb : !llhd.sig<i32>
    %180 = llhd.and %179, %opb9 : i32
    %181 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %180 after %181 : !llhd.sig<i32>
    br ^case_exit
^178:
    %182 = llhd.const 0 : i1
    %183 = llhd.const 11 : i4
    %184 = llhd.eq %alu_op1, %183 : i4
    %185 = llhd.or %182, %184 : i1
    cond_br %185, ^case_body12, ^186
^case_body11:
    %opa7 = llhd.prb %opa : !llhd.sig<i32>
    %opb10 = llhd.prb %opb : !llhd.sig<i32>
    %187 = llhd.or %opa7, %opb10 : i32
    %188 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %187 after %188 : !llhd.sig<i32>
    br ^case_exit
^186:
    %189 = llhd.const 0 : i1
    %190 = llhd.const 12 : i4
    %191 = llhd.eq %alu_op1, %190 : i4
    %192 = llhd.or %189, %191 : i1
    cond_br %192, ^case_body13, ^193
^case_body12:
    %opb11 = llhd.prb %opb : !llhd.sig<i32>
    %194 = llhd.neg %opb11 : i32
    %195 = llhd.extract_slice %194, 31 : i32 -> i1
    %196 = llhd.const 0 : i33
    %197 = llhd.not %196 : i33
    %198 = llhd.array %196, %197 : !llhd.array<2xi33>
    %199 = llhd.dyn_extract_element %198, %195 : (!llhd.array<2xi33>, i1) -> i33
    %200 = llhd.insert_slice %199, %194, 0 : i33, i32
    %201 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %200 after %201 : !llhd.sig<i33>
    %202 = llhd.const 0 : i32
    %adder_result6 = llhd.prb %adder_result : !llhd.sig<i33>
    %203 = llhd.extract_slice %adder_result6, 0 : i33 -> i1
    %204 = llhd.extract_slice %adder_result6, 1 : i33 -> i1
    %205 = llhd.or %203, %204 : i1
    %206 = llhd.extract_slice %adder_result6, 2 : i33 -> i1
    %207 = llhd.or %205, %206 : i1
    %208 = llhd.extract_slice %adder_result6, 3 : i33 -> i1
    %209 = llhd.or %207, %208 : i1
    %210 = llhd.extract_slice %adder_result6, 4 : i33 -> i1
    %211 = llhd.or %209, %210 : i1
    %212 = llhd.extract_slice %adder_result6, 5 : i33 -> i1
    %213 = llhd.or %211, %212 : i1
    %214 = llhd.extract_slice %adder_result6, 6 : i33 -> i1
    %215 = llhd.or %213, %214 : i1
    %216 = llhd.extract_slice %adder_result6, 7 : i33 -> i1
    %217 = llhd.or %215, %216 : i1
    %218 = llhd.extract_slice %adder_result6, 8 : i33 -> i1
    %219 = llhd.or %217, %218 : i1
    %220 = llhd.extract_slice %adder_result6, 9 : i33 -> i1
    %221 = llhd.or %219, %220 : i1
    %222 = llhd.extract_slice %adder_result6, 10 : i33 -> i1
    %223 = llhd.or %221, %222 : i1
    %224 = llhd.extract_slice %adder_result6, 11 : i33 -> i1
    %225 = llhd.or %223, %224 : i1
    %226 = llhd.extract_slice %adder_result6, 12 : i33 -> i1
    %227 = llhd.or %225, %226 : i1
    %228 = llhd.extract_slice %adder_result6, 13 : i33 -> i1
    %229 = llhd.or %227, %228 : i1
    %230 = llhd.extract_slice %adder_result6, 14 : i33 -> i1
    %231 = llhd.or %229, %230 : i1
    %232 = llhd.extract_slice %adder_result6, 15 : i33 -> i1
    %233 = llhd.or %231, %232 : i1
    %234 = llhd.extract_slice %adder_result6, 16 : i33 -> i1
    %235 = llhd.or %233, %234 : i1
    %236 = llhd.extract_slice %adder_result6, 17 : i33 -> i1
    %237 = llhd.or %235, %236 : i1
    %238 = llhd.extract_slice %adder_result6, 18 : i33 -> i1
    %239 = llhd.or %237, %238 : i1
    %240 = llhd.extract_slice %adder_result6, 19 : i33 -> i1
    %241 = llhd.or %239, %240 : i1
    %242 = llhd.extract_slice %adder_result6, 20 : i33 -> i1
    %243 = llhd.or %241, %242 : i1
    %244 = llhd.extract_slice %adder_result6, 21 : i33 -> i1
    %245 = llhd.or %243, %244 : i1
    %246 = llhd.extract_slice %adder_result6, 22 : i33 -> i1
    %247 = llhd.or %245, %246 : i1
    %248 = llhd.extract_slice %adder_result6, 23 : i33 -> i1
    %249 = llhd.or %247, %248 : i1
    %250 = llhd.extract_slice %adder_result6, 24 : i33 -> i1
    %251 = llhd.or %249, %250 : i1
    %252 = llhd.extract_slice %adder_result6, 25 : i33 -> i1
    %253 = llhd.or %251, %252 : i1
    %254 = llhd.extract_slice %adder_result6, 26 : i33 -> i1
    %255 = llhd.or %253, %254 : i1
    %256 = llhd.extract_slice %adder_result6, 27 : i33 -> i1
    %257 = llhd.or %255, %256 : i1
    %258 = llhd.extract_slice %adder_result6, 28 : i33 -> i1
    %259 = llhd.or %257, %258 : i1
    %260 = llhd.extract_slice %adder_result6, 29 : i33 -> i1
    %261 = llhd.or %259, %260 : i1
    %262 = llhd.extract_slice %adder_result6, 30 : i33 -> i1
    %263 = llhd.or %261, %262 : i1
    %264 = llhd.extract_slice %adder_result6, 31 : i33 -> i1
    %265 = llhd.or %263, %264 : i1
    %266 = llhd.extract_slice %adder_result6, 32 : i33 -> i1
    %267 = llhd.or %265, %266 : i1
    %268 = llhd.not %267 : i1
    %269 = llhd.insert_slice %202, %268, 0 : i32, i1
    %270 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %269 after %270 : !llhd.sig<i32>
    br ^case_exit
^193:
    %271 = llhd.const 0 : i1
    %272 = llhd.const 15 : i4
    %273 = llhd.eq %alu_op1, %272 : i4
    %274 = llhd.or %271, %273 : i1
    cond_br %274, ^case_body14, ^275
^case_body13:
    %opb12 = llhd.prb %opb : !llhd.sig<i32>
    %276 = llhd.neg %opb12 : i32
    %277 = llhd.extract_slice %276, 31 : i32 -> i1
    %278 = llhd.const 0 : i33
    %279 = llhd.not %278 : i33
    %280 = llhd.array %278, %279 : !llhd.array<2xi33>
    %281 = llhd.dyn_extract_element %280, %277 : (!llhd.array<2xi33>, i1) -> i33
    %282 = llhd.insert_slice %281, %276, 0 : i33, i32
    %283 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_opb, %282 after %283 : !llhd.sig<i33>
    %284 = llhd.const 0 : i32
    %adder_result7 = llhd.prb %adder_result : !llhd.sig<i33>
    %285 = llhd.extract_slice %adder_result7, 0 : i33 -> i1
    %286 = llhd.extract_slice %adder_result7, 1 : i33 -> i1
    %287 = llhd.or %285, %286 : i1
    %288 = llhd.extract_slice %adder_result7, 2 : i33 -> i1
    %289 = llhd.or %287, %288 : i1
    %290 = llhd.extract_slice %adder_result7, 3 : i33 -> i1
    %291 = llhd.or %289, %290 : i1
    %292 = llhd.extract_slice %adder_result7, 4 : i33 -> i1
    %293 = llhd.or %291, %292 : i1
    %294 = llhd.extract_slice %adder_result7, 5 : i33 -> i1
    %295 = llhd.or %293, %294 : i1
    %296 = llhd.extract_slice %adder_result7, 6 : i33 -> i1
    %297 = llhd.or %295, %296 : i1
    %298 = llhd.extract_slice %adder_result7, 7 : i33 -> i1
    %299 = llhd.or %297, %298 : i1
    %300 = llhd.extract_slice %adder_result7, 8 : i33 -> i1
    %301 = llhd.or %299, %300 : i1
    %302 = llhd.extract_slice %adder_result7, 9 : i33 -> i1
    %303 = llhd.or %301, %302 : i1
    %304 = llhd.extract_slice %adder_result7, 10 : i33 -> i1
    %305 = llhd.or %303, %304 : i1
    %306 = llhd.extract_slice %adder_result7, 11 : i33 -> i1
    %307 = llhd.or %305, %306 : i1
    %308 = llhd.extract_slice %adder_result7, 12 : i33 -> i1
    %309 = llhd.or %307, %308 : i1
    %310 = llhd.extract_slice %adder_result7, 13 : i33 -> i1
    %311 = llhd.or %309, %310 : i1
    %312 = llhd.extract_slice %adder_result7, 14 : i33 -> i1
    %313 = llhd.or %311, %312 : i1
    %314 = llhd.extract_slice %adder_result7, 15 : i33 -> i1
    %315 = llhd.or %313, %314 : i1
    %316 = llhd.extract_slice %adder_result7, 16 : i33 -> i1
    %317 = llhd.or %315, %316 : i1
    %318 = llhd.extract_slice %adder_result7, 17 : i33 -> i1
    %319 = llhd.or %317, %318 : i1
    %320 = llhd.extract_slice %adder_result7, 18 : i33 -> i1
    %321 = llhd.or %319, %320 : i1
    %322 = llhd.extract_slice %adder_result7, 19 : i33 -> i1
    %323 = llhd.or %321, %322 : i1
    %324 = llhd.extract_slice %adder_result7, 20 : i33 -> i1
    %325 = llhd.or %323, %324 : i1
    %326 = llhd.extract_slice %adder_result7, 21 : i33 -> i1
    %327 = llhd.or %325, %326 : i1
    %328 = llhd.extract_slice %adder_result7, 22 : i33 -> i1
    %329 = llhd.or %327, %328 : i1
    %330 = llhd.extract_slice %adder_result7, 23 : i33 -> i1
    %331 = llhd.or %329, %330 : i1
    %332 = llhd.extract_slice %adder_result7, 24 : i33 -> i1
    %333 = llhd.or %331, %332 : i1
    %334 = llhd.extract_slice %adder_result7, 25 : i33 -> i1
    %335 = llhd.or %333, %334 : i1
    %336 = llhd.extract_slice %adder_result7, 26 : i33 -> i1
    %337 = llhd.or %335, %336 : i1
    %338 = llhd.extract_slice %adder_result7, 27 : i33 -> i1
    %339 = llhd.or %337, %338 : i1
    %340 = llhd.extract_slice %adder_result7, 28 : i33 -> i1
    %341 = llhd.or %339, %340 : i1
    %342 = llhd.extract_slice %adder_result7, 29 : i33 -> i1
    %343 = llhd.or %341, %342 : i1
    %344 = llhd.extract_slice %adder_result7, 30 : i33 -> i1
    %345 = llhd.or %343, %344 : i1
    %346 = llhd.extract_slice %adder_result7, 31 : i33 -> i1
    %347 = llhd.or %345, %346 : i1
    %348 = llhd.extract_slice %adder_result7, 32 : i33 -> i1
    %349 = llhd.or %347, %348 : i1
    %350 = llhd.insert_slice %284, %349, 0 : i32, i1
    %351 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %350 after %351 : !llhd.sig<i32>
    br ^case_exit
^275:
    %adder_result8 = llhd.prb %adder_result : !llhd.sig<i33>
    %352 = llhd.const 0 : i1
    %353 = llhd.const 0 : i33
    %354 = llhd.shr %adder_result8, %353, %352 : (i33, i33, i1) -> i33
    %355 = llhd.extract_slice %354, 0 : i33 -> i32
    %356 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %355 after %356 : !llhd.sig<i32>
    br ^case_exit
^case_body14:
    %opa8 = llhd.prb %opa : !llhd.sig<i32>
    %357 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_result, %opa8 after %357 : !llhd.sig<i32>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.640.1(%consec_pc: !llhd.sig<i32>, %alu_result: !llhd.sig<i32>, %rd_select: !llhd.sig<i2>, %rd_bypass: !llhd.sig<i32>) -> (%alu_writeback: !llhd.sig<i32> ) {
    br ^0
^0:
    br ^body
^body:
    %rd_select1 = llhd.prb %rd_select : !llhd.sig<i2>
    %1 = llhd.const 0 : i1
    %2 = llhd.const 0 : i2
    %3 = llhd.const 3 : i2
    %4 = llhd.and %rd_select1, %3 : i2
    %5 = llhd.and %2, %3 : i2
    %6 = llhd.eq %4, %5 : i2
    %7 = llhd.or %1, %6 : i1
    cond_br %7, ^case_body, ^8
^8:
    %9 = llhd.const 0 : i1
    %10 = llhd.const 1 : i2
    %11 = llhd.const 3 : i2
    %12 = llhd.and %rd_select1, %11 : i2
    %13 = llhd.and %10, %11 : i2
    %14 = llhd.eq %12, %13 : i2
    %15 = llhd.or %9, %14 : i1
    cond_br %15, ^case_body1, ^16
^case_body:
    %alu_result1 = llhd.prb %alu_result : !llhd.sig<i32>
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_writeback, %alu_result1 after %17 : !llhd.sig<i32>
    br ^case_exit
^check:
    llhd.wait (%consec_pc, %alu_result, %rd_select, %rd_bypass : !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i2>, !llhd.sig<i32>), ^body
^case_exit:
    br ^check
^16:
    %18 = llhd.const 0 : i1
    %19 = llhd.const 2 : i2
    %20 = llhd.const 3 : i2
    %21 = llhd.and %rd_select1, %20 : i2
    %22 = llhd.and %19, %20 : i2
    %23 = llhd.eq %21, %22 : i2
    %24 = llhd.or %18, %23 : i1
    cond_br %24, ^case_body2, ^25
^case_body1:
    %consec_pc1 = llhd.prb %consec_pc : !llhd.sig<i32>
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_writeback, %consec_pc1 after %26 : !llhd.sig<i32>
    br ^case_exit
^25:
    %alu_result2 = llhd.prb %alu_result : !llhd.sig<i32>
    %27 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_writeback, %alu_result2 after %27 : !llhd.sig<i32>
    br ^case_exit
^case_body2:
    %rd_bypass1 = llhd.prb %rd_bypass : !llhd.sig<i32>
    %28 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %alu_writeback, %rd_bypass1 after %28 : !llhd.sig<i32>
    br ^case_exit
}

llhd.proc @snitch.param1.always_comb.641.1(%acc_pdata_i: !llhd.sig<i64>, %acc_pid_i: !llhd.sig<i5>, %acc_pvalid_i: !llhd.sig<i1>, %rd: !llhd.sig<i5>, %ld_result: !llhd.sig<i64>, %lsu_pvalid: !llhd.sig<i1>, %lsu_rd: !llhd.sig<i5>, %retire_i: !llhd.sig<i1>, %alu_writeback: !llhd.sig<i32>) -> (%acc_pready_o: !llhd.sig<i1> , %gpr_waddr: !llhd.sig<!llhd.array<1xi5>> , %gpr_wdata: !llhd.sig<!llhd.array<1xi32>> , %gpr_we: !llhd.sig<i1> , %lsu_pready: !llhd.sig<i1> , %retire_load: !llhd.sig<i1> , %retire_acc: !llhd.sig<i1> ) {
    br ^0
^0:
    br ^body
^body:
    %1 = llhd.const 0 : i32
    %2 = llhd.const 0 : i1
    %3 = llhd.dyn_extract_slice %gpr_we, %1 : (!llhd.sig<i1>, i32) -> !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %4 after %5 : !llhd.sig<i1>
    %6 = llhd.const 0 : i32
    %7 = llhd.const 0 : i5
    %8 = llhd.array_uniform %7 : !llhd.array<1xi5>
    %9 = llhd.dyn_extract_element %gpr_waddr, %6 : (!llhd.sig<!llhd.array<1xi5>>, i32) -> !llhd.sig<i5>
    %rd1 = llhd.prb %rd : !llhd.sig<i5>
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %9, %rd1 after %10 : !llhd.sig<i5>
    %11 = llhd.const 0 : i32
    %12 = llhd.const 0 : i32
    %13 = llhd.array_uniform %12 : !llhd.array<1xi32>
    %14 = llhd.dyn_extract_element %gpr_wdata, %11 : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %alu_writeback1 = llhd.prb %alu_writeback : !llhd.sig<i32>
    %15 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %14, %alu_writeback1 after %15 : !llhd.sig<i32>
    %16 = llhd.const 0 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_pready, %16 after %17 : !llhd.sig<i1>
    %18 = llhd.const 0 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_pready_o, %18 after %19 : !llhd.sig<i1>
    %20 = llhd.const 0 : i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %retire_acc, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const 0 : i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %retire_load, %22 after %23 : !llhd.sig<i1>
    %retire_i1 = llhd.prb %retire_i : !llhd.sig<i1>
    cond_br %retire_i1, ^if_true, ^if_false
^if_false:
    %lsu_pvalid1 = llhd.prb %lsu_pvalid : !llhd.sig<i1>
    cond_br %lsu_pvalid1, ^if_true1, ^if_false1
^if_true:
    %24 = llhd.const 0 : i32
    %25 = llhd.const 0 : i1
    %26 = llhd.dyn_extract_slice %gpr_we, %24 : (!llhd.sig<i1>, i32) -> !llhd.sig<i1>
    %27 = llhd.const 1 : i1
    %28 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %26, %27 after %28 : !llhd.sig<i1>
    br ^if_exit
^check:
    llhd.wait (%acc_pdata_i, %acc_pid_i, %acc_pvalid_i, %rd, %ld_result, %lsu_pvalid, %lsu_rd, %retire_i, %alu_writeback : !llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>), ^body
^if_exit:
    br ^check
^if_false1:
    %acc_pvalid_i1 = llhd.prb %acc_pvalid_i : !llhd.sig<i1>
    cond_br %acc_pvalid_i1, ^if_true2, ^if_false2
^if_true1:
    %29 = llhd.const 1 : i1
    %30 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %retire_load, %29 after %30 : !llhd.sig<i1>
    %31 = llhd.const 0 : i32
    %32 = llhd.const 0 : i1
    %33 = llhd.dyn_extract_slice %gpr_we, %31 : (!llhd.sig<i1>, i32) -> !llhd.sig<i1>
    %34 = llhd.const 1 : i1
    %35 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %33, %34 after %35 : !llhd.sig<i1>
    %36 = llhd.const 0 : i32
    %37 = llhd.const 0 : i5
    %38 = llhd.array_uniform %37 : !llhd.array<1xi5>
    %39 = llhd.dyn_extract_element %gpr_waddr, %36 : (!llhd.sig<!llhd.array<1xi5>>, i32) -> !llhd.sig<i5>
    %lsu_rd1 = llhd.prb %lsu_rd : !llhd.sig<i5>
    %40 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %39, %lsu_rd1 after %40 : !llhd.sig<i5>
    %41 = llhd.const 0 : i32
    %42 = llhd.const 0 : i32
    %43 = llhd.array_uniform %42 : !llhd.array<1xi32>
    %44 = llhd.dyn_extract_element %gpr_wdata, %41 : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %ld_result1 = llhd.prb %ld_result : !llhd.sig<i64>
    %45 = llhd.const 0 : i1
    %46 = llhd.const 0 : i64
    %47 = llhd.shr %ld_result1, %46, %45 : (i64, i64, i1) -> i64
    %48 = llhd.extract_slice %47, 0 : i64 -> i32
    %49 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %44, %48 after %49 : !llhd.sig<i32>
    %50 = llhd.const 1 : i1
    %51 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_pready, %50 after %51 : !llhd.sig<i1>
    br ^if_exit1
^if_exit1:
    br ^if_exit
^if_false2:
    br ^if_exit2
^if_true2:
    %52 = llhd.const 1 : i1
    %53 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %retire_acc, %52 after %53 : !llhd.sig<i1>
    %54 = llhd.const 0 : i32
    %55 = llhd.const 0 : i1
    %56 = llhd.dyn_extract_slice %gpr_we, %54 : (!llhd.sig<i1>, i32) -> !llhd.sig<i1>
    %57 = llhd.const 1 : i1
    %58 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %56, %57 after %58 : !llhd.sig<i1>
    %59 = llhd.const 0 : i32
    %60 = llhd.const 0 : i5
    %61 = llhd.array_uniform %60 : !llhd.array<1xi5>
    %62 = llhd.dyn_extract_element %gpr_waddr, %59 : (!llhd.sig<!llhd.array<1xi5>>, i32) -> !llhd.sig<i5>
    %acc_pid_i1 = llhd.prb %acc_pid_i : !llhd.sig<i5>
    %63 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %62, %acc_pid_i1 after %63 : !llhd.sig<i5>
    %64 = llhd.const 0 : i32
    %65 = llhd.const 0 : i32
    %66 = llhd.array_uniform %65 : !llhd.array<1xi32>
    %67 = llhd.dyn_extract_element %gpr_wdata, %64 : (!llhd.sig<!llhd.array<1xi32>>, i32) -> !llhd.sig<i32>
    %acc_pdata_i1 = llhd.prb %acc_pdata_i : !llhd.sig<i64>
    %68 = llhd.const 0 : i1
    %69 = llhd.const 0 : i64
    %70 = llhd.shr %acc_pdata_i1, %69, %68 : (i64, i64, i1) -> i64
    %71 = llhd.extract_slice %70, 0 : i64 -> i32
    %72 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %67, %71 after %72 : !llhd.sig<i32>
    %73 = llhd.const 1 : i1
    %74 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_pready_o, %73 after %74 : !llhd.sig<i1>
    br ^if_exit2
^if_exit2:
    br ^if_exit1
}

llhd.entity @snitch.param1(%clk_i: !llhd.sig<i1>, %rst_i: !llhd.sig<i1>, %hart_id_i: !llhd.sig<i32>, %inst_data_i: !llhd.sig<i32>, %inst_ready_i: !llhd.sig<i1>, %acc_qready_i: !llhd.sig<i1>, %acc_pdata_i: !llhd.sig<i64>, %acc_pid_i: !llhd.sig<i5>, %acc_perror_i: !llhd.sig<i1>, %acc_pvalid_i: !llhd.sig<i1>, %data_qready_i: !llhd.sig<i1>, %data_pdata_i: !llhd.sig<i64>, %data_perror_i: !llhd.sig<i1>, %data_pvalid_i: !llhd.sig<i1>, %wake_up_sync_i: !llhd.sig<i1>, %fpu_status_i: !llhd.sig<tuple<i1, i1, i1, i1, i1>>) -> (%inst_addr_o: !llhd.sig<i32> , %inst_valid_o: !llhd.sig<i1> , %acc_qaddr_o: !llhd.sig<i32> , %acc_qid_o: !llhd.sig<i5> , %acc_qdata_op_o: !llhd.sig<i32> , %acc_qdata_arga_o: !llhd.sig<i64> , %acc_qdata_argb_o: !llhd.sig<i64> , %acc_qdata_argc_o: !llhd.sig<i64> , %acc_qvalid_o: !llhd.sig<i1> , %acc_pready_o: !llhd.sig<i1> , %data_qaddr_o: !llhd.sig<i32> , %data_qwrite_o: !llhd.sig<i1> , %data_qamo_o: !llhd.sig<i4> , %data_qdata_o: !llhd.sig<i64> , %data_qstrb_o: !llhd.sig<i8> , %data_qvalid_o: !llhd.sig<i1> , %data_pready_o: !llhd.sig<i1> , %fpu_rnd_mode_o: !llhd.sig<i3> , %core_events_o: !llhd.sig<tuple<i1, i1, i1, i1>> ) {
    %0 = llhd.const 0 : i1
    %illegal_inst = llhd.sig "illegal_inst" %0 : i1
    %1 = llhd.const 0 : i1
    %zero_lsb = llhd.sig "zero_lsb" %1 : i1
    %2 = llhd.const 0 : i32
    %pc_d = llhd.sig "pc_d" %2 : i32
    %3 = llhd.const 0 : i32
    %pc_q = llhd.sig "pc_q" %3 : i32
    %4 = llhd.const 0 : i1
    %wfi_d = llhd.sig "wfi_d" %4 : i1
    %5 = llhd.const 0 : i1
    %wfi_q = llhd.sig "wfi_q" %5 : i1
    %6 = llhd.const 0 : i32
    %consec_pc = llhd.sig "consec_pc" %6 : i32
    %7 = llhd.const 0 : i32
    %iimm = llhd.sig "iimm" %7 : i32
    %8 = llhd.const 0 : i32
    %uimm = llhd.sig "uimm" %8 : i32
    %9 = llhd.const 0 : i32
    %jimm = llhd.sig "jimm" %9 : i32
    %10 = llhd.const 0 : i32
    %bimm = llhd.sig "bimm" %10 : i32
    %11 = llhd.const 0 : i32
    %simm = llhd.sig "simm" %11 : i32
    %12 = llhd.const 0 : i32
    %opa = llhd.sig "opa" %12 : i32
    %13 = llhd.const 0 : i32
    %opb = llhd.sig "opb" %13 : i32
    %14 = llhd.const 0 : i33
    %adder_result = llhd.sig "adder_result" %14 : i33
    %15 = llhd.const 0 : i32
    %alu_result = llhd.sig "alu_result" %15 : i32
    %16 = llhd.const 0 : i5
    %rd = llhd.sig "rd" %16 : i5
    %17 = llhd.const 0 : i5
    %rs1 = llhd.sig "rs1" %17 : i5
    %18 = llhd.const 0 : i5
    %rs2 = llhd.sig "rs2" %18 : i5
    %19 = llhd.const 0 : i1
    %stall = llhd.sig "stall" %19 : i1
    %20 = llhd.const 0 : i1
    %lsu_stall = llhd.sig "lsu_stall" %20 : i1
    %21 = llhd.const 0 : i5
    %22 = llhd.const 0 : i5
    %23 = llhd.array %21, %22 : !llhd.array<2xi5>
    %gpr_raddr = llhd.sig "gpr_raddr" %23 : !llhd.array<2xi5>
    %24 = llhd.const 0 : i32
    %25 = llhd.const 0 : i32
    %26 = llhd.array %24, %25 : !llhd.array<2xi32>
    %gpr_rdata = llhd.sig "gpr_rdata" %26 : !llhd.array<2xi32>
    %27 = llhd.const 0 : i5
    %28 = llhd.array %27 : !llhd.array<1xi5>
    %gpr_waddr = llhd.sig "gpr_waddr" %28 : !llhd.array<1xi5>
    %29 = llhd.const 0 : i32
    %30 = llhd.array %29 : !llhd.array<1xi32>
    %gpr_wdata = llhd.sig "gpr_wdata" %30 : !llhd.array<1xi32>
    %31 = llhd.const 0 : i1
    %gpr_we = llhd.sig "gpr_we" %31 : i1
    %32 = llhd.const 0 : i32
    %sb_d = llhd.sig "sb_d" %32 : i32
    %33 = llhd.const 0 : i32
    %sb_q = llhd.sig "sb_q" %33 : i32
    %34 = llhd.const 0 : i1
    %is_load = llhd.sig "is_load" %34 : i1
    %35 = llhd.const 0 : i1
    %is_store = llhd.sig "is_store" %35 : i1
    %36 = llhd.const 0 : i1
    %is_signed = llhd.sig "is_signed" %36 : i1
    %37 = llhd.const 0 : i2
    %ls_size = llhd.sig "ls_size" %37 : i2
    %38 = llhd.const 0 : i4
    %ls_amo = llhd.sig "ls_amo" %38 : i4
    %39 = llhd.const 0 : i64
    %ld_result = llhd.sig "ld_result" %39 : i64
    %40 = llhd.const 0 : i1
    %lsu_qready = llhd.sig "lsu_qready" %40 : i1
    %41 = llhd.const 0 : i1
    %lsu_qvalid = llhd.sig "lsu_qvalid" %41 : i1
    %42 = llhd.const 0 : i1
    %lsu_pvalid = llhd.sig "lsu_pvalid" %42 : i1
    %43 = llhd.const 0 : i1
    %lsu_pready = llhd.sig "lsu_pready" %43 : i1
    %44 = llhd.const 0 : i5
    %lsu_rd = llhd.sig "lsu_rd" %44 : i5
    %45 = llhd.const 0 : i1
    %retire_load = llhd.sig "retire_load" %45 : i1
    %46 = llhd.const 0 : i1
    %retire_i = llhd.sig "retire_i" %46 : i1
    %47 = llhd.const 0 : i1
    %retire_acc = llhd.sig "retire_acc" %47 : i1
    %48 = llhd.const 0 : i1
    %acc_stall = llhd.sig "acc_stall" %48 : i1
    %49 = llhd.const 0 : i1
    %valid_instr = llhd.sig "valid_instr" %49 : i1
    %50 = llhd.const 0 : i4
    %alu_op = llhd.sig "alu_op" %50 : i4
    %51 = llhd.const 0 : i4
    %opa_select = llhd.sig "opa_select" %51 : i4
    %52 = llhd.const 0 : i4
    %opb_select = llhd.sig "opb_select" %52 : i4
    %53 = llhd.const 0 : i1
    %write_rd = llhd.sig "write_rd" %53 : i1
    %54 = llhd.const 0 : i1
    %uses_rd = llhd.sig "uses_rd" %54 : i1
    %55 = llhd.const 0 : i2
    %next_pc = llhd.sig "next_pc" %55 : i2
    %56 = llhd.const 0 : i2
    %rd_select = llhd.sig "rd_select" %56 : i2
    %57 = llhd.const 0 : i32
    %rd_bypass = llhd.sig "rd_bypass" %57 : i32
    %58 = llhd.const 0 : i1
    %is_branch = llhd.sig "is_branch" %58 : i1
    %59 = llhd.const 0 : i32
    %csr_rvalue = llhd.sig "csr_rvalue" %59 : i32
    %60 = llhd.const 0 : i1
    %csr_en = llhd.sig "csr_en" %60 : i1
    %61 = llhd.const 0 : i3
    %62 = llhd.const 0 : i1
    %63 = llhd.const 0 : i1
    %64 = llhd.const 0 : i1
    %65 = llhd.const 0 : i1
    %66 = llhd.const 0 : i1
    %67 = llhd.tuple %62, %63, %64, %65, %66 : tuple<i1, i1, i1, i1, i1>
    %68 = llhd.tuple %61, %67 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %fcsr_d = llhd.sig "fcsr_d" %68 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %69 = llhd.const 0 : i3
    %70 = llhd.const 0 : i1
    %71 = llhd.const 0 : i1
    %72 = llhd.const 0 : i1
    %73 = llhd.const 0 : i1
    %74 = llhd.const 0 : i1
    %75 = llhd.tuple %70, %71, %72, %73, %74 : tuple<i1, i1, i1, i1, i1>
    %76 = llhd.tuple %69, %75 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %fcsr_q = llhd.sig "fcsr_q" %76 : tuple<i3, tuple<i1, i1, i1, i1, i1>>
    %77 = llhd.const 0 : i1
    %acc_register_rd = llhd.sig "acc_register_rd" %77 : i1
    %78 = llhd.const 0 : i1
    %operands_ready = llhd.sig "operands_ready" %78 : i1
    %79 = llhd.const 0 : i1
    %dst_ready = llhd.sig "dst_ready" %79 : i1
    %80 = llhd.const 0 : i1
    %opa_ready = llhd.sig "opa_ready" %80 : i1
    %81 = llhd.const 0 : i1
    %opb_ready = llhd.sig "opb_ready" %81 : i1
    %82 = llhd.const 0 : i32
    %shift_opa = llhd.sig "shift_opa" %82 : i32
    %83 = llhd.const 0 : i32
    %shift_opa_reversed = llhd.sig "shift_opa_reversed" %83 : i32
    %84 = llhd.const 0 : i32
    %shift_right_result = llhd.sig "shift_right_result" %84 : i32
    %85 = llhd.const 0 : i32
    %shift_left_result = llhd.sig "shift_left_result" %85 : i32
    %86 = llhd.const 0 : i33
    %shift_opa_ext = llhd.sig "shift_opa_ext" %86 : i33
    %87 = llhd.const 0 : i33
    %shift_right_result_ext = llhd.sig "shift_right_result_ext" %87 : i33
    %88 = llhd.const 0 : i1
    %shift_left = llhd.sig "shift_left" %88 : i1
    %89 = llhd.const 0 : i1
    %shift_arithmetic = llhd.sig "shift_arithmetic" %89 : i1
    %90 = llhd.const 0 : i33
    %alu_opa = llhd.sig "alu_opa" %90 : i33
    %91 = llhd.const 0 : i33
    %alu_opb = llhd.sig "alu_opb" %91 : i33
    %92 = llhd.const 0 : i32
    %alu_writeback = llhd.sig "alu_writeback" %92 : i32
    %93 = llhd.const 0 : i12
    %inst_data_i1 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %94 = llhd.const 20 : i5
    %95 = llhd.const 0 : i32
    %96 = llhd.shr %inst_data_i1, %95, %94 : (i32, i32, i5) -> i32
    %97 = llhd.extract_slice %96, 0 : i32 -> i12
    %98 = llhd.insert_slice %93, %97, 0 : i12, i12
    %99 = llhd.extract_slice %98, 11 : i12 -> i1
    %100 = llhd.const 0 : i32
    %101 = llhd.not %100 : i32
    %102 = llhd.array %100, %101 : !llhd.array<2xi32>
    %103 = llhd.dyn_extract_element %102, %99 : (!llhd.array<2xi32>, i1) -> i32
    %104 = llhd.insert_slice %103, %98, 0 : i32, i12
    %105 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %iimm, %104 after %105 : !llhd.sig<i32>
    %106 = llhd.const 0 : i32
    %107 = llhd.const 0 : i12
    %108 = llhd.insert_slice %106, %107, 0 : i32, i12
    %inst_data_i2 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %109 = llhd.const 12 : i4
    %110 = llhd.const 0 : i32
    %111 = llhd.shr %inst_data_i2, %110, %109 : (i32, i32, i4) -> i32
    %112 = llhd.extract_slice %111, 0 : i32 -> i20
    %113 = llhd.insert_slice %108, %112, 12 : i32, i20
    %114 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %uimm, %113 after %114 : !llhd.sig<i32>
    %115 = llhd.const 0 : i21
    %116 = llhd.const 0 : i1
    %117 = llhd.insert_slice %115, %116, 0 : i21, i1
    %inst_data_i3 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %118 = llhd.const 21 : i5
    %119 = llhd.const 0 : i32
    %120 = llhd.shr %inst_data_i3, %119, %118 : (i32, i32, i5) -> i32
    %121 = llhd.extract_slice %120, 0 : i32 -> i10
    %122 = llhd.insert_slice %117, %121, 1 : i21, i10
    %inst_data_i4 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %123 = llhd.const 20 : i32
    %124 = llhd.const 0 : i32
    %125 = llhd.shr %inst_data_i4, %124, %123 : (i32, i32, i32) -> i32
    %126 = llhd.extract_slice %125, 0 : i32 -> i1
    %127 = llhd.insert_slice %122, %126, 11 : i21, i1
    %inst_data_i5 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %128 = llhd.const 12 : i4
    %129 = llhd.const 0 : i32
    %130 = llhd.shr %inst_data_i5, %129, %128 : (i32, i32, i4) -> i32
    %131 = llhd.extract_slice %130, 0 : i32 -> i8
    %132 = llhd.insert_slice %127, %131, 12 : i21, i8
    %inst_data_i6 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %133 = llhd.const 31 : i32
    %134 = llhd.const 0 : i32
    %135 = llhd.shr %inst_data_i6, %134, %133 : (i32, i32, i32) -> i32
    %136 = llhd.extract_slice %135, 0 : i32 -> i1
    %137 = llhd.insert_slice %132, %136, 20 : i21, i1
    %138 = llhd.extract_slice %137, 20 : i21 -> i1
    %139 = llhd.const 0 : i32
    %140 = llhd.not %139 : i32
    %141 = llhd.array %139, %140 : !llhd.array<2xi32>
    %142 = llhd.dyn_extract_element %141, %138 : (!llhd.array<2xi32>, i1) -> i32
    %143 = llhd.insert_slice %142, %137, 0 : i32, i21
    %144 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %jimm, %143 after %144 : !llhd.sig<i32>
    %145 = llhd.const 0 : i13
    %146 = llhd.const 0 : i1
    %147 = llhd.insert_slice %145, %146, 0 : i13, i1
    %inst_data_i7 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %148 = llhd.const 8 : i4
    %149 = llhd.const 0 : i32
    %150 = llhd.shr %inst_data_i7, %149, %148 : (i32, i32, i4) -> i32
    %151 = llhd.extract_slice %150, 0 : i32 -> i4
    %152 = llhd.insert_slice %147, %151, 1 : i13, i4
    %inst_data_i8 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %153 = llhd.const 25 : i5
    %154 = llhd.const 0 : i32
    %155 = llhd.shr %inst_data_i8, %154, %153 : (i32, i32, i5) -> i32
    %156 = llhd.extract_slice %155, 0 : i32 -> i6
    %157 = llhd.insert_slice %152, %156, 5 : i13, i6
    %inst_data_i9 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %158 = llhd.const 7 : i32
    %159 = llhd.const 0 : i32
    %160 = llhd.shr %inst_data_i9, %159, %158 : (i32, i32, i32) -> i32
    %161 = llhd.extract_slice %160, 0 : i32 -> i1
    %162 = llhd.insert_slice %157, %161, 11 : i13, i1
    %inst_data_i10 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %163 = llhd.const 31 : i32
    %164 = llhd.const 0 : i32
    %165 = llhd.shr %inst_data_i10, %164, %163 : (i32, i32, i32) -> i32
    %166 = llhd.extract_slice %165, 0 : i32 -> i1
    %167 = llhd.insert_slice %162, %166, 12 : i13, i1
    %168 = llhd.extract_slice %167, 12 : i13 -> i1
    %169 = llhd.const 0 : i32
    %170 = llhd.not %169 : i32
    %171 = llhd.array %169, %170 : !llhd.array<2xi32>
    %172 = llhd.dyn_extract_element %171, %168 : (!llhd.array<2xi32>, i1) -> i32
    %173 = llhd.insert_slice %172, %167, 0 : i32, i13
    %174 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %bimm, %173 after %174 : !llhd.sig<i32>
    %175 = llhd.const 0 : i12
    %inst_data_i11 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %176 = llhd.const 7 : i3
    %177 = llhd.const 0 : i32
    %178 = llhd.shr %inst_data_i11, %177, %176 : (i32, i32, i3) -> i32
    %179 = llhd.extract_slice %178, 0 : i32 -> i5
    %180 = llhd.insert_slice %175, %179, 0 : i12, i5
    %inst_data_i12 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %181 = llhd.const 25 : i5
    %182 = llhd.const 0 : i32
    %183 = llhd.shr %inst_data_i12, %182, %181 : (i32, i32, i5) -> i32
    %184 = llhd.extract_slice %183, 0 : i32 -> i7
    %185 = llhd.insert_slice %180, %184, 5 : i12, i7
    %186 = llhd.extract_slice %185, 11 : i12 -> i1
    %187 = llhd.const 0 : i32
    %188 = llhd.not %187 : i32
    %189 = llhd.array %187, %188 : !llhd.array<2xi32>
    %190 = llhd.dyn_extract_element %189, %186 : (!llhd.array<2xi32>, i1) -> i32
    %191 = llhd.insert_slice %190, %185, 0 : i32, i12
    %192 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %simm, %191 after %192 : !llhd.sig<i32>
    %fcsr_q1 = llhd.prb %fcsr_q : !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>
    %193 = llhd.extract_element %fcsr_q1, 0 : tuple<i3, tuple<i1, i1, i1, i1, i1>> -> i3
    %194 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fpu_rnd_mode_o, %193 after %194 : !llhd.sig<i3>
    %hart_id_i1 = llhd.prb %hart_id_i : !llhd.sig<i32>
    %195 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qaddr_o, %hart_id_i1 after %195 : !llhd.sig<i32>
    %rd1 = llhd.prb %rd : !llhd.sig<i5>
    %196 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qid_o, %rd1 after %196 : !llhd.sig<i5>
    %inst_data_i13 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %197 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qdata_op_o, %inst_data_i13 after %197 : !llhd.sig<i32>
    %198 = llhd.const 0 : i64
    %gpr_rdata1 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %199 = llhd.const 0 : i32
    %200 = llhd.const 0 : i32
    %201 = llhd.array_uniform %200 : !llhd.array<2xi32>
    %202 = llhd.shr %gpr_rdata1, %201, %199 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %203 = llhd.extract_element %202, 0 : !llhd.array<2xi32> -> i32
    %204 = llhd.insert_slice %198, %203, 0 : i64, i32
    %205 = llhd.const 0 : i1
    %gpr_rdata2 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %206 = llhd.const 0 : i32
    %207 = llhd.const 0 : i32
    %208 = llhd.array_uniform %207 : !llhd.array<2xi32>
    %209 = llhd.shr %gpr_rdata2, %208, %206 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %210 = llhd.extract_element %209, 0 : !llhd.array<2xi32> -> i32
    %211 = llhd.const 31 : i32
    %212 = llhd.const 0 : i32
    %213 = llhd.shr %210, %212, %211 : (i32, i32, i32) -> i32
    %214 = llhd.extract_slice %213, 0 : i32 -> i1
    %215 = llhd.insert_slice %205, %214, 0 : i1, i1
    %216 = llhd.const 0 : i32
    %217 = llhd.insert_slice %216, %215, 0 : i32, i1
    %218 = llhd.insert_slice %217, %215, 1 : i32, i1
    %219 = llhd.insert_slice %218, %215, 2 : i32, i1
    %220 = llhd.insert_slice %219, %215, 3 : i32, i1
    %221 = llhd.insert_slice %220, %215, 4 : i32, i1
    %222 = llhd.insert_slice %221, %215, 5 : i32, i1
    %223 = llhd.insert_slice %222, %215, 6 : i32, i1
    %224 = llhd.insert_slice %223, %215, 7 : i32, i1
    %225 = llhd.insert_slice %224, %215, 8 : i32, i1
    %226 = llhd.insert_slice %225, %215, 9 : i32, i1
    %227 = llhd.insert_slice %226, %215, 10 : i32, i1
    %228 = llhd.insert_slice %227, %215, 11 : i32, i1
    %229 = llhd.insert_slice %228, %215, 12 : i32, i1
    %230 = llhd.insert_slice %229, %215, 13 : i32, i1
    %231 = llhd.insert_slice %230, %215, 14 : i32, i1
    %232 = llhd.insert_slice %231, %215, 15 : i32, i1
    %233 = llhd.insert_slice %232, %215, 16 : i32, i1
    %234 = llhd.insert_slice %233, %215, 17 : i32, i1
    %235 = llhd.insert_slice %234, %215, 18 : i32, i1
    %236 = llhd.insert_slice %235, %215, 19 : i32, i1
    %237 = llhd.insert_slice %236, %215, 20 : i32, i1
    %238 = llhd.insert_slice %237, %215, 21 : i32, i1
    %239 = llhd.insert_slice %238, %215, 22 : i32, i1
    %240 = llhd.insert_slice %239, %215, 23 : i32, i1
    %241 = llhd.insert_slice %240, %215, 24 : i32, i1
    %242 = llhd.insert_slice %241, %215, 25 : i32, i1
    %243 = llhd.insert_slice %242, %215, 26 : i32, i1
    %244 = llhd.insert_slice %243, %215, 27 : i32, i1
    %245 = llhd.insert_slice %244, %215, 28 : i32, i1
    %246 = llhd.insert_slice %245, %215, 29 : i32, i1
    %247 = llhd.insert_slice %246, %215, 30 : i32, i1
    %248 = llhd.insert_slice %247, %215, 31 : i32, i1
    %249 = llhd.insert_slice %204, %248, 32 : i64, i32
    %250 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qdata_arga_o, %249 after %250 : !llhd.sig<i64>
    %251 = llhd.const 0 : i64
    %gpr_rdata3 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %252 = llhd.const 1 : i32
    %253 = llhd.const 0 : i32
    %254 = llhd.array_uniform %253 : !llhd.array<2xi32>
    %255 = llhd.shr %gpr_rdata3, %254, %252 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %256 = llhd.extract_element %255, 0 : !llhd.array<2xi32> -> i32
    %257 = llhd.insert_slice %251, %256, 0 : i64, i32
    %258 = llhd.const 0 : i1
    %gpr_rdata4 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %259 = llhd.const 1 : i32
    %260 = llhd.const 0 : i32
    %261 = llhd.array_uniform %260 : !llhd.array<2xi32>
    %262 = llhd.shr %gpr_rdata4, %261, %259 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %263 = llhd.extract_element %262, 0 : !llhd.array<2xi32> -> i32
    %264 = llhd.const 31 : i32
    %265 = llhd.const 0 : i32
    %266 = llhd.shr %263, %265, %264 : (i32, i32, i32) -> i32
    %267 = llhd.extract_slice %266, 0 : i32 -> i1
    %268 = llhd.insert_slice %258, %267, 0 : i1, i1
    %269 = llhd.const 0 : i32
    %270 = llhd.insert_slice %269, %268, 0 : i32, i1
    %271 = llhd.insert_slice %270, %268, 1 : i32, i1
    %272 = llhd.insert_slice %271, %268, 2 : i32, i1
    %273 = llhd.insert_slice %272, %268, 3 : i32, i1
    %274 = llhd.insert_slice %273, %268, 4 : i32, i1
    %275 = llhd.insert_slice %274, %268, 5 : i32, i1
    %276 = llhd.insert_slice %275, %268, 6 : i32, i1
    %277 = llhd.insert_slice %276, %268, 7 : i32, i1
    %278 = llhd.insert_slice %277, %268, 8 : i32, i1
    %279 = llhd.insert_slice %278, %268, 9 : i32, i1
    %280 = llhd.insert_slice %279, %268, 10 : i32, i1
    %281 = llhd.insert_slice %280, %268, 11 : i32, i1
    %282 = llhd.insert_slice %281, %268, 12 : i32, i1
    %283 = llhd.insert_slice %282, %268, 13 : i32, i1
    %284 = llhd.insert_slice %283, %268, 14 : i32, i1
    %285 = llhd.insert_slice %284, %268, 15 : i32, i1
    %286 = llhd.insert_slice %285, %268, 16 : i32, i1
    %287 = llhd.insert_slice %286, %268, 17 : i32, i1
    %288 = llhd.insert_slice %287, %268, 18 : i32, i1
    %289 = llhd.insert_slice %288, %268, 19 : i32, i1
    %290 = llhd.insert_slice %289, %268, 20 : i32, i1
    %291 = llhd.insert_slice %290, %268, 21 : i32, i1
    %292 = llhd.insert_slice %291, %268, 22 : i32, i1
    %293 = llhd.insert_slice %292, %268, 23 : i32, i1
    %294 = llhd.insert_slice %293, %268, 24 : i32, i1
    %295 = llhd.insert_slice %294, %268, 25 : i32, i1
    %296 = llhd.insert_slice %295, %268, 26 : i32, i1
    %297 = llhd.insert_slice %296, %268, 27 : i32, i1
    %298 = llhd.insert_slice %297, %268, 28 : i32, i1
    %299 = llhd.insert_slice %298, %268, 29 : i32, i1
    %300 = llhd.insert_slice %299, %268, 30 : i32, i1
    %301 = llhd.insert_slice %300, %268, 31 : i32, i1
    %302 = llhd.insert_slice %257, %301, 32 : i64, i32
    %303 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qdata_argb_o, %302 after %303 : !llhd.sig<i64>
    %304 = llhd.const 0 : i64
    %alu_result1 = llhd.prb %alu_result : !llhd.sig<i32>
    %305 = llhd.insert_slice %304, %alu_result1, 0 : i64, i32
    %306 = llhd.const 0 : i32
    %307 = llhd.insert_slice %305, %306, 32 : i64, i32
    %308 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_qdata_argc_o, %307 after %308 : !llhd.sig<i64>
    %pc_q1 = llhd.prb %pc_q : !llhd.sig<i32>
    %309 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %inst_addr_o, %pc_q1 after %309 : !llhd.sig<i32>
    %wfi_q1 = llhd.prb %wfi_q : !llhd.sig<i1>
    %310 = llhd.not %wfi_q1 : i1
    %311 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %inst_valid_o, %310 after %311 : !llhd.sig<i1>
    %opa_select1 = llhd.prb %opa_select : !llhd.sig<i4>
    %312 = llhd.const 1 : i4
    %313 = llhd.neq %opa_select1, %312 : i4
    %sb_q1 = llhd.prb %sb_q : !llhd.sig<i32>
    %rs11 = llhd.prb %rs1 : !llhd.sig<i5>
    %314 = llhd.const 0 : i32
    %315 = llhd.shr %sb_q1, %314, %rs11 : (i32, i32, i5) -> i32
    %316 = llhd.extract_slice %315, 0 : i32 -> i1
    %317 = llhd.not %316 : i1
    %318 = llhd.or %313, %317 : i1
    %319 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opa_ready, %318 after %319 : !llhd.sig<i1>
    %opb_select1 = llhd.prb %opb_select : !llhd.sig<i4>
    %320 = llhd.const 1 : i4
    %321 = llhd.neq %opb_select1, %320 : i4
    %opb_select2 = llhd.prb %opb_select : !llhd.sig<i4>
    %322 = llhd.const 5 : i4
    %323 = llhd.neq %opb_select2, %322 : i4
    %324 = llhd.and %321, %323 : i1
    %sb_q2 = llhd.prb %sb_q : !llhd.sig<i32>
    %rs21 = llhd.prb %rs2 : !llhd.sig<i5>
    %325 = llhd.const 0 : i32
    %326 = llhd.shr %sb_q2, %325, %rs21 : (i32, i32, i5) -> i32
    %327 = llhd.extract_slice %326, 0 : i32 -> i1
    %328 = llhd.not %327 : i1
    %329 = llhd.or %324, %328 : i1
    %330 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %opb_ready, %329 after %330 : !llhd.sig<i1>
    %opa_ready1 = llhd.prb %opa_ready : !llhd.sig<i1>
    %opb_ready1 = llhd.prb %opb_ready : !llhd.sig<i1>
    %331 = llhd.and %opa_ready1, %opb_ready1 : i1
    %332 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %operands_ready, %331 after %332 : !llhd.sig<i1>
    %uses_rd1 = llhd.prb %uses_rd : !llhd.sig<i1>
    %sb_q3 = llhd.prb %sb_q : !llhd.sig<i32>
    %rd2 = llhd.prb %rd : !llhd.sig<i5>
    %333 = llhd.const 0 : i32
    %334 = llhd.shr %sb_q3, %333, %rd2 : (i32, i32, i5) -> i32
    %335 = llhd.extract_slice %334, 0 : i32 -> i1
    %336 = llhd.not %335 : i1
    %337 = llhd.and %uses_rd1, %336 : i1
    %338 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_ready, %337 after %338 : !llhd.sig<i1>
    %inst_ready_i1 = llhd.prb %inst_ready_i : !llhd.sig<i1>
    %inst_valid_o1 = llhd.prb %inst_valid_o : !llhd.sig<i1>
    %339 = llhd.and %inst_ready_i1, %inst_valid_o1 : i1
    %operands_ready1 = llhd.prb %operands_ready : !llhd.sig<i1>
    %340 = llhd.and %339, %operands_ready1 : i1
    %dst_ready1 = llhd.prb %dst_ready : !llhd.sig<i1>
    %341 = llhd.and %340, %dst_ready1 : i1
    %342 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %valid_instr, %341 after %342 : !llhd.sig<i1>
    %acc_qvalid_o1 = llhd.prb %acc_qvalid_o : !llhd.sig<i1>
    %acc_qready_i1 = llhd.prb %acc_qready_i : !llhd.sig<i1>
    %343 = llhd.not %acc_qready_i1 : i1
    %344 = llhd.and %acc_qvalid_o1, %343 : i1
    %345 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %acc_stall, %344 after %345 : !llhd.sig<i1>
    %lsu_qvalid1 = llhd.prb %lsu_qvalid : !llhd.sig<i1>
    %lsu_qready1 = llhd.prb %lsu_qready : !llhd.sig<i1>
    %346 = llhd.not %lsu_qready1 : i1
    %347 = llhd.and %lsu_qvalid1, %346 : i1
    %348 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_stall, %347 after %348 : !llhd.sig<i1>
    %valid_instr1 = llhd.prb %valid_instr : !llhd.sig<i1>
    %349 = llhd.not %valid_instr1 : i1
    %lsu_stall1 = llhd.prb %lsu_stall : !llhd.sig<i1>
    %350 = llhd.or %349, %lsu_stall1 : i1
    %acc_stall1 = llhd.prb %acc_stall : !llhd.sig<i1>
    %351 = llhd.or %350, %acc_stall1 : i1
    %352 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %stall, %351 after %352 : !llhd.sig<i1>
    %pc_q2 = llhd.prb %pc_q : !llhd.sig<i32>
    %is_branch1 = llhd.prb %is_branch : !llhd.sig<i1>
    %alu_result2 = llhd.prb %alu_result : !llhd.sig<i32>
    %353 = llhd.const 0 : i32
    %354 = llhd.const 0 : i32
    %355 = llhd.shr %alu_result2, %354, %353 : (i32, i32, i32) -> i32
    %356 = llhd.extract_slice %355, 0 : i32 -> i1
    %357 = llhd.and %is_branch1, %356 : i1
    %bimm1 = llhd.prb %bimm : !llhd.sig<i32>
    %358 = llhd.const 0 : i32
    %359 = llhd.const 4 : i3
    %360 = llhd.insert_slice %358, %359, 0 : i32, i3
    %361 = llhd.array %360, %bimm1 : !llhd.array<2xi32>
    %362 = llhd.dyn_extract_element %361, %357 : (!llhd.array<2xi32>, i1) -> i32
    %363 = addi %pc_q2, %362 : i32
    %364 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %consec_pc, %363 after %364 : !llhd.sig<i32>
    %inst_data_i14 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %365 = llhd.const 7 : i3
    %366 = llhd.const 0 : i32
    %367 = llhd.shr %inst_data_i14, %366, %365 : (i32, i32, i3) -> i32
    %368 = llhd.extract_slice %367, 0 : i32 -> i5
    %369 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rd, %368 after %369 : !llhd.sig<i5>
    %inst_data_i15 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %370 = llhd.const 15 : i4
    %371 = llhd.const 0 : i32
    %372 = llhd.shr %inst_data_i15, %371, %370 : (i32, i32, i4) -> i32
    %373 = llhd.extract_slice %372, 0 : i32 -> i5
    %374 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rs1, %373 after %374 : !llhd.sig<i5>
    %inst_data_i16 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %375 = llhd.const 20 : i5
    %376 = llhd.const 0 : i32
    %377 = llhd.shr %inst_data_i16, %376, %375 : (i32, i32, i5) -> i32
    %378 = llhd.extract_slice %377, 0 : i32 -> i5
    %379 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %rs2, %378 after %379 : !llhd.sig<i5>
    %380 = llhd.const 0 : i32
    %381 = llhd.const 0 : i5
    %382 = llhd.array_uniform %381 : !llhd.array<2xi5>
    %383 = llhd.sig "383" %382 : !llhd.array<2xi5>
    %384 = llhd.shr %gpr_raddr, %383, %380 : (!llhd.sig<!llhd.array<2xi5>>, !llhd.sig<!llhd.array<2xi5>>, i32) -> !llhd.sig<!llhd.array<2xi5>>
    %385 = llhd.extract_element %384, 0 : !llhd.sig<!llhd.array<2xi5>> -> !llhd.sig<i5>
    %rs12 = llhd.prb %rs1 : !llhd.sig<i5>
    %386 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %385, %rs12 after %386 : !llhd.sig<i5>
    %387 = llhd.const 1 : i32
    %388 = llhd.const 0 : i5
    %389 = llhd.array_uniform %388 : !llhd.array<2xi5>
    %390 = llhd.sig "390" %389 : !llhd.array<2xi5>
    %391 = llhd.shr %gpr_raddr, %390, %387 : (!llhd.sig<!llhd.array<2xi5>>, !llhd.sig<!llhd.array<2xi5>>, i32) -> !llhd.sig<!llhd.array<2xi5>>
    %392 = llhd.extract_element %391, 0 : !llhd.sig<!llhd.array<2xi5>> -> !llhd.sig<i5>
    %rs22 = llhd.prb %rs2 : !llhd.sig<i5>
    %393 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %392, %rs22 after %393 : !llhd.sig<i5>
    %shift_left1 = llhd.prb %shift_left : !llhd.sig<i1>
    %shift_opa_reversed1 = llhd.prb %shift_opa_reversed : !llhd.sig<i32>
    %opa1 = llhd.prb %opa : !llhd.sig<i32>
    %394 = llhd.array %opa1, %shift_opa_reversed1 : !llhd.array<2xi32>
    %395 = llhd.dyn_extract_element %394, %shift_left1 : (!llhd.array<2xi32>, i1) -> i32
    %396 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_opa, %395 after %396 : !llhd.sig<i32>
    %397 = llhd.const 0 : i33
    %shift_opa1 = llhd.prb %shift_opa : !llhd.sig<i32>
    %398 = llhd.insert_slice %397, %shift_opa1, 0 : i33, i32
    %shift_opa2 = llhd.prb %shift_opa : !llhd.sig<i32>
    %399 = llhd.const 31 : i32
    %400 = llhd.const 0 : i32
    %401 = llhd.shr %shift_opa2, %400, %399 : (i32, i32, i32) -> i32
    %402 = llhd.extract_slice %401, 0 : i32 -> i1
    %shift_arithmetic1 = llhd.prb %shift_arithmetic : !llhd.sig<i1>
    %403 = llhd.and %402, %shift_arithmetic1 : i1
    %404 = llhd.insert_slice %398, %403, 32 : i33, i1
    %405 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_opa_ext, %404 after %405 : !llhd.sig<i33>
    %shift_opa_ext1 = llhd.prb %shift_opa_ext : !llhd.sig<i33>
    %opb1 = llhd.prb %opb : !llhd.sig<i32>
    %406 = llhd.const 0 : i1
    %407 = llhd.const 0 : i32
    %408 = llhd.shr %opb1, %407, %406 : (i32, i32, i1) -> i32
    %409 = llhd.extract_slice %408, 0 : i32 -> i5
    %410 = llhd.const 0 : i33
    %411 = llhd.shr %shift_opa_ext1, %410, %409 : (i33, i33, i5) -> i33
    %412 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_right_result_ext, %411 after %412 : !llhd.sig<i33>
    %shift_right_result_ext1 = llhd.prb %shift_right_result_ext : !llhd.sig<i33>
    %413 = llhd.const 0 : i1
    %414 = llhd.const 0 : i33
    %415 = llhd.shr %shift_right_result_ext1, %414, %413 : (i33, i33, i1) -> i33
    %416 = llhd.extract_slice %415, 0 : i33 -> i32
    %417 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_right_result, %416 after %417 : !llhd.sig<i32>
    %alu_opa1 = llhd.prb %alu_opa : !llhd.sig<i33>
    %alu_opb1 = llhd.prb %alu_opb : !llhd.sig<i33>
    %418 = addi %alu_opa1, %alu_opb1 : i33
    %419 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %adder_result, %418 after %419 : !llhd.sig<i33>
    %valid_instr2 = llhd.prb %valid_instr : !llhd.sig<i1>
    %is_load1 = llhd.prb %is_load : !llhd.sig<i1>
    %is_store1 = llhd.prb %is_store : !llhd.sig<i1>
    %420 = llhd.or %is_load1, %is_store1 : i1
    %421 = llhd.and %valid_instr2, %420 : i1
    %422 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %lsu_qvalid, %421 after %422 : !llhd.sig<i1>
    %write_rd1 = llhd.prb %write_rd : !llhd.sig<i1>
    %valid_instr3 = llhd.prb %valid_instr : !llhd.sig<i1>
    %423 = llhd.and %write_rd1, %valid_instr3 : i1
    %424 = llhd.const 0 : i32
    %rd3 = llhd.prb %rd : !llhd.sig<i5>
    %425 = llhd.insert_slice %424, %rd3, 0 : i32, i5
    %426 = llhd.const 0 : i32
    %427 = llhd.neq %425, %426 : i32
    %428 = llhd.and %423, %427 : i1
    %429 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %retire_i, %428 after %429 : !llhd.sig<i1>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %430 = llhd.const 0 : i1
    %431 = llhd.sig "431" %430 : i1
    %432 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %431, %clk_i1 after %432 : !llhd.sig<i1>
    %gpr_raddr1 = llhd.prb %gpr_raddr : !llhd.sig<!llhd.array<2xi5>>
    %433 = llhd.const 0 : i5
    %434 = llhd.array_uniform %433 : !llhd.array<2xi5>
    %435 = llhd.sig "435" %434 : !llhd.array<2xi5>
    %436 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %435, %gpr_raddr1 after %436 : !llhd.sig<!llhd.array<2xi5>>
    %gpr_waddr1 = llhd.prb %gpr_waddr : !llhd.sig<!llhd.array<1xi5>>
    %437 = llhd.const 0 : i5
    %438 = llhd.array_uniform %437 : !llhd.array<1xi5>
    %439 = llhd.sig "439" %438 : !llhd.array<1xi5>
    %440 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %439, %gpr_waddr1 after %440 : !llhd.sig<!llhd.array<1xi5>>
    %gpr_wdata1 = llhd.prb %gpr_wdata : !llhd.sig<!llhd.array<1xi32>>
    %441 = llhd.const 0 : i32
    %442 = llhd.array_uniform %441 : !llhd.array<1xi32>
    %443 = llhd.sig "443" %442 : !llhd.array<1xi32>
    %444 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %443, %gpr_wdata1 after %444 : !llhd.sig<!llhd.array<1xi32>>
    %gpr_we1 = llhd.prb %gpr_we : !llhd.sig<i1>
    %445 = llhd.const 0 : i1
    %446 = llhd.sig "446" %445 : i1
    %447 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %446, %gpr_we1 after %447 : !llhd.sig<i1>
    llhd.inst "inst" @snitch_regfile.param2(%431, %435, %439, %443, %446) -> (%gpr_rdata) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<2xi5>>, !llhd.sig<!llhd.array<1xi5>>, !llhd.sig<!llhd.array<1xi32>>, !llhd.sig<i1>) -> (!llhd.sig<!llhd.array<2xi32>>)
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %448 = llhd.const 0 : i1
    %449 = llhd.sig "449" %448 : i1
    %450 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %449, %clk_i2 after %450 : !llhd.sig<i1>
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %451 = llhd.const 0 : i1
    %452 = llhd.sig "452" %451 : i1
    %453 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %452, %rst_i1 after %453 : !llhd.sig<i1>
    %rd4 = llhd.prb %rd : !llhd.sig<i5>
    %454 = llhd.const 0 : i5
    %455 = llhd.sig "455" %454 : i5
    %456 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %455, %rd4 after %456 : !llhd.sig<i5>
    %is_store2 = llhd.prb %is_store : !llhd.sig<i1>
    %457 = llhd.const 0 : i1
    %458 = llhd.sig "458" %457 : i1
    %459 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %458, %is_store2 after %459 : !llhd.sig<i1>
    %is_signed1 = llhd.prb %is_signed : !llhd.sig<i1>
    %460 = llhd.const 0 : i1
    %461 = llhd.sig "461" %460 : i1
    %462 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %461, %is_signed1 after %462 : !llhd.sig<i1>
    %alu_result3 = llhd.prb %alu_result : !llhd.sig<i32>
    %463 = llhd.const 0 : i32
    %464 = llhd.sig "464" %463 : i32
    %465 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %464, %alu_result3 after %465 : !llhd.sig<i32>
    %466 = llhd.const 0 : i64
    %gpr_rdata5 = llhd.prb %gpr_rdata : !llhd.sig<!llhd.array<2xi32>>
    %467 = llhd.const 1 : i32
    %468 = llhd.const 0 : i32
    %469 = llhd.array_uniform %468 : !llhd.array<2xi32>
    %470 = llhd.shr %gpr_rdata5, %469, %467 : (!llhd.array<2xi32>, !llhd.array<2xi32>, i32) -> !llhd.array<2xi32>
    %471 = llhd.extract_element %470, 0 : !llhd.array<2xi32> -> i32
    %472 = llhd.insert_slice %466, %471, 0 : i64, i32
    %473 = llhd.const 0 : i32
    %474 = llhd.insert_slice %472, %473, 32 : i64, i32
    %475 = llhd.const 0 : i64
    %476 = llhd.sig "476" %475 : i64
    %477 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %476, %474 after %477 : !llhd.sig<i64>
    %ls_size1 = llhd.prb %ls_size : !llhd.sig<i2>
    %478 = llhd.const 0 : i2
    %479 = llhd.sig "479" %478 : i2
    %480 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %479, %ls_size1 after %480 : !llhd.sig<i2>
    %ls_amo1 = llhd.prb %ls_amo : !llhd.sig<i4>
    %481 = llhd.const 0 : i4
    %482 = llhd.sig "482" %481 : i4
    %483 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %482, %ls_amo1 after %483 : !llhd.sig<i4>
    %lsu_qvalid2 = llhd.prb %lsu_qvalid : !llhd.sig<i1>
    %484 = llhd.const 0 : i1
    %485 = llhd.sig "485" %484 : i1
    %486 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %485, %lsu_qvalid2 after %486 : !llhd.sig<i1>
    %487 = llhd.const 0 : i1
    %488 = llhd.sig "488" %487 : i1
    %lsu_pready1 = llhd.prb %lsu_pready : !llhd.sig<i1>
    %489 = llhd.const 0 : i1
    %490 = llhd.sig "490" %489 : i1
    %491 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %490, %lsu_pready1 after %491 : !llhd.sig<i1>
    %data_qready_i1 = llhd.prb %data_qready_i : !llhd.sig<i1>
    %492 = llhd.const 0 : i1
    %493 = llhd.sig "493" %492 : i1
    %494 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %493, %data_qready_i1 after %494 : !llhd.sig<i1>
    %data_pdata_i1 = llhd.prb %data_pdata_i : !llhd.sig<i64>
    %495 = llhd.const 0 : i64
    %496 = llhd.sig "496" %495 : i64
    %497 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %496, %data_pdata_i1 after %497 : !llhd.sig<i64>
    %data_perror_i1 = llhd.prb %data_perror_i : !llhd.sig<i1>
    %498 = llhd.const 0 : i1
    %499 = llhd.sig "499" %498 : i1
    %500 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %499, %data_perror_i1 after %500 : !llhd.sig<i1>
    %data_pvalid_i1 = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %501 = llhd.const 0 : i1
    %502 = llhd.sig "502" %501 : i1
    %503 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %502, %data_pvalid_i1 after %503 : !llhd.sig<i1>
    llhd.inst "inst1" @snitch_lsu.param5(%449, %452, %455, %458, %461, %464, %476, %479, %482, %485, %490, %493, %496, %499, %502) -> (%lsu_qready, %ld_result, %lsu_rd, %488, %lsu_pvalid, %data_qaddr_o, %data_qwrite_o, %data_qamo_o, %data_qdata_o, %data_qstrb_o, %data_qvalid_o, %data_pready_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i64>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i64>, !llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i1>)
    %504 = llhd.const 0 : i32
    %505 = llhd.const 0 : i32
    %506 = llhd.sig "506" %505 : i32
    %507 = llhd.shr %shift_opa_reversed, %506, %504 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %508 = llhd.extract_slice %507, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa2 = llhd.prb %opa : !llhd.sig<i32>
    %509 = llhd.const 31 : i32
    %510 = llhd.const 0 : i32
    %511 = subi %509, %510 : i32
    %512 = llhd.const 0 : i32
    %513 = llhd.shr %opa2, %512, %511 : (i32, i32, i32) -> i32
    %514 = llhd.extract_slice %513, 0 : i32 -> i1
    %515 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %508, %514 after %515 : !llhd.sig<i1>
    %516 = llhd.const 0 : i32
    %517 = llhd.const 0 : i32
    %518 = llhd.sig "518" %517 : i32
    %519 = llhd.shr %shift_left_result, %518, %516 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %520 = llhd.extract_slice %519, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result1 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %521 = llhd.const 31 : i32
    %522 = llhd.const 0 : i32
    %523 = subi %521, %522 : i32
    %524 = llhd.const 0 : i32
    %525 = llhd.shr %shift_right_result1, %524, %523 : (i32, i32, i32) -> i32
    %526 = llhd.extract_slice %525, 0 : i32 -> i1
    %527 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %520, %526 after %527 : !llhd.sig<i1>
    %528 = llhd.const 1 : i32
    %529 = llhd.const 0 : i32
    %530 = llhd.sig "530" %529 : i32
    %531 = llhd.shr %shift_opa_reversed, %530, %528 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %532 = llhd.extract_slice %531, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa3 = llhd.prb %opa : !llhd.sig<i32>
    %533 = llhd.const 31 : i32
    %534 = llhd.const 1 : i32
    %535 = subi %533, %534 : i32
    %536 = llhd.const 0 : i32
    %537 = llhd.shr %opa3, %536, %535 : (i32, i32, i32) -> i32
    %538 = llhd.extract_slice %537, 0 : i32 -> i1
    %539 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %532, %538 after %539 : !llhd.sig<i1>
    %540 = llhd.const 1 : i32
    %541 = llhd.const 0 : i32
    %542 = llhd.sig "542" %541 : i32
    %543 = llhd.shr %shift_left_result, %542, %540 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %544 = llhd.extract_slice %543, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result2 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %545 = llhd.const 31 : i32
    %546 = llhd.const 1 : i32
    %547 = subi %545, %546 : i32
    %548 = llhd.const 0 : i32
    %549 = llhd.shr %shift_right_result2, %548, %547 : (i32, i32, i32) -> i32
    %550 = llhd.extract_slice %549, 0 : i32 -> i1
    %551 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %544, %550 after %551 : !llhd.sig<i1>
    %552 = llhd.const 2 : i32
    %553 = llhd.const 0 : i32
    %554 = llhd.sig "554" %553 : i32
    %555 = llhd.shr %shift_opa_reversed, %554, %552 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %556 = llhd.extract_slice %555, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa4 = llhd.prb %opa : !llhd.sig<i32>
    %557 = llhd.const 31 : i32
    %558 = llhd.const 2 : i32
    %559 = subi %557, %558 : i32
    %560 = llhd.const 0 : i32
    %561 = llhd.shr %opa4, %560, %559 : (i32, i32, i32) -> i32
    %562 = llhd.extract_slice %561, 0 : i32 -> i1
    %563 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %556, %562 after %563 : !llhd.sig<i1>
    %564 = llhd.const 2 : i32
    %565 = llhd.const 0 : i32
    %566 = llhd.sig "566" %565 : i32
    %567 = llhd.shr %shift_left_result, %566, %564 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %568 = llhd.extract_slice %567, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result3 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %569 = llhd.const 31 : i32
    %570 = llhd.const 2 : i32
    %571 = subi %569, %570 : i32
    %572 = llhd.const 0 : i32
    %573 = llhd.shr %shift_right_result3, %572, %571 : (i32, i32, i32) -> i32
    %574 = llhd.extract_slice %573, 0 : i32 -> i1
    %575 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %568, %574 after %575 : !llhd.sig<i1>
    %576 = llhd.const 3 : i32
    %577 = llhd.const 0 : i32
    %578 = llhd.sig "578" %577 : i32
    %579 = llhd.shr %shift_opa_reversed, %578, %576 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %580 = llhd.extract_slice %579, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa5 = llhd.prb %opa : !llhd.sig<i32>
    %581 = llhd.const 31 : i32
    %582 = llhd.const 3 : i32
    %583 = subi %581, %582 : i32
    %584 = llhd.const 0 : i32
    %585 = llhd.shr %opa5, %584, %583 : (i32, i32, i32) -> i32
    %586 = llhd.extract_slice %585, 0 : i32 -> i1
    %587 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %580, %586 after %587 : !llhd.sig<i1>
    %588 = llhd.const 3 : i32
    %589 = llhd.const 0 : i32
    %590 = llhd.sig "590" %589 : i32
    %591 = llhd.shr %shift_left_result, %590, %588 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %592 = llhd.extract_slice %591, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result4 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %593 = llhd.const 31 : i32
    %594 = llhd.const 3 : i32
    %595 = subi %593, %594 : i32
    %596 = llhd.const 0 : i32
    %597 = llhd.shr %shift_right_result4, %596, %595 : (i32, i32, i32) -> i32
    %598 = llhd.extract_slice %597, 0 : i32 -> i1
    %599 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %592, %598 after %599 : !llhd.sig<i1>
    %600 = llhd.const 4 : i32
    %601 = llhd.const 0 : i32
    %602 = llhd.sig "602" %601 : i32
    %603 = llhd.shr %shift_opa_reversed, %602, %600 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %604 = llhd.extract_slice %603, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa6 = llhd.prb %opa : !llhd.sig<i32>
    %605 = llhd.const 31 : i32
    %606 = llhd.const 4 : i32
    %607 = subi %605, %606 : i32
    %608 = llhd.const 0 : i32
    %609 = llhd.shr %opa6, %608, %607 : (i32, i32, i32) -> i32
    %610 = llhd.extract_slice %609, 0 : i32 -> i1
    %611 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %604, %610 after %611 : !llhd.sig<i1>
    %612 = llhd.const 4 : i32
    %613 = llhd.const 0 : i32
    %614 = llhd.sig "614" %613 : i32
    %615 = llhd.shr %shift_left_result, %614, %612 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %616 = llhd.extract_slice %615, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result5 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %617 = llhd.const 31 : i32
    %618 = llhd.const 4 : i32
    %619 = subi %617, %618 : i32
    %620 = llhd.const 0 : i32
    %621 = llhd.shr %shift_right_result5, %620, %619 : (i32, i32, i32) -> i32
    %622 = llhd.extract_slice %621, 0 : i32 -> i1
    %623 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %616, %622 after %623 : !llhd.sig<i1>
    %624 = llhd.const 5 : i32
    %625 = llhd.const 0 : i32
    %626 = llhd.sig "626" %625 : i32
    %627 = llhd.shr %shift_opa_reversed, %626, %624 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %628 = llhd.extract_slice %627, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa7 = llhd.prb %opa : !llhd.sig<i32>
    %629 = llhd.const 31 : i32
    %630 = llhd.const 5 : i32
    %631 = subi %629, %630 : i32
    %632 = llhd.const 0 : i32
    %633 = llhd.shr %opa7, %632, %631 : (i32, i32, i32) -> i32
    %634 = llhd.extract_slice %633, 0 : i32 -> i1
    %635 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %628, %634 after %635 : !llhd.sig<i1>
    %636 = llhd.const 5 : i32
    %637 = llhd.const 0 : i32
    %638 = llhd.sig "638" %637 : i32
    %639 = llhd.shr %shift_left_result, %638, %636 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %640 = llhd.extract_slice %639, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result6 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %641 = llhd.const 31 : i32
    %642 = llhd.const 5 : i32
    %643 = subi %641, %642 : i32
    %644 = llhd.const 0 : i32
    %645 = llhd.shr %shift_right_result6, %644, %643 : (i32, i32, i32) -> i32
    %646 = llhd.extract_slice %645, 0 : i32 -> i1
    %647 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %640, %646 after %647 : !llhd.sig<i1>
    %648 = llhd.const 6 : i32
    %649 = llhd.const 0 : i32
    %650 = llhd.sig "650" %649 : i32
    %651 = llhd.shr %shift_opa_reversed, %650, %648 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %652 = llhd.extract_slice %651, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa8 = llhd.prb %opa : !llhd.sig<i32>
    %653 = llhd.const 31 : i32
    %654 = llhd.const 6 : i32
    %655 = subi %653, %654 : i32
    %656 = llhd.const 0 : i32
    %657 = llhd.shr %opa8, %656, %655 : (i32, i32, i32) -> i32
    %658 = llhd.extract_slice %657, 0 : i32 -> i1
    %659 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %652, %658 after %659 : !llhd.sig<i1>
    %660 = llhd.const 6 : i32
    %661 = llhd.const 0 : i32
    %662 = llhd.sig "662" %661 : i32
    %663 = llhd.shr %shift_left_result, %662, %660 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %664 = llhd.extract_slice %663, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result7 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %665 = llhd.const 31 : i32
    %666 = llhd.const 6 : i32
    %667 = subi %665, %666 : i32
    %668 = llhd.const 0 : i32
    %669 = llhd.shr %shift_right_result7, %668, %667 : (i32, i32, i32) -> i32
    %670 = llhd.extract_slice %669, 0 : i32 -> i1
    %671 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %664, %670 after %671 : !llhd.sig<i1>
    %672 = llhd.const 7 : i32
    %673 = llhd.const 0 : i32
    %674 = llhd.sig "674" %673 : i32
    %675 = llhd.shr %shift_opa_reversed, %674, %672 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %676 = llhd.extract_slice %675, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa9 = llhd.prb %opa : !llhd.sig<i32>
    %677 = llhd.const 31 : i32
    %678 = llhd.const 7 : i32
    %679 = subi %677, %678 : i32
    %680 = llhd.const 0 : i32
    %681 = llhd.shr %opa9, %680, %679 : (i32, i32, i32) -> i32
    %682 = llhd.extract_slice %681, 0 : i32 -> i1
    %683 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %676, %682 after %683 : !llhd.sig<i1>
    %684 = llhd.const 7 : i32
    %685 = llhd.const 0 : i32
    %686 = llhd.sig "686" %685 : i32
    %687 = llhd.shr %shift_left_result, %686, %684 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %688 = llhd.extract_slice %687, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result8 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %689 = llhd.const 31 : i32
    %690 = llhd.const 7 : i32
    %691 = subi %689, %690 : i32
    %692 = llhd.const 0 : i32
    %693 = llhd.shr %shift_right_result8, %692, %691 : (i32, i32, i32) -> i32
    %694 = llhd.extract_slice %693, 0 : i32 -> i1
    %695 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %688, %694 after %695 : !llhd.sig<i1>
    %696 = llhd.const 8 : i32
    %697 = llhd.const 0 : i32
    %698 = llhd.sig "698" %697 : i32
    %699 = llhd.shr %shift_opa_reversed, %698, %696 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %700 = llhd.extract_slice %699, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa10 = llhd.prb %opa : !llhd.sig<i32>
    %701 = llhd.const 31 : i32
    %702 = llhd.const 8 : i32
    %703 = subi %701, %702 : i32
    %704 = llhd.const 0 : i32
    %705 = llhd.shr %opa10, %704, %703 : (i32, i32, i32) -> i32
    %706 = llhd.extract_slice %705, 0 : i32 -> i1
    %707 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %700, %706 after %707 : !llhd.sig<i1>
    %708 = llhd.const 8 : i32
    %709 = llhd.const 0 : i32
    %710 = llhd.sig "710" %709 : i32
    %711 = llhd.shr %shift_left_result, %710, %708 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %712 = llhd.extract_slice %711, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result9 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %713 = llhd.const 31 : i32
    %714 = llhd.const 8 : i32
    %715 = subi %713, %714 : i32
    %716 = llhd.const 0 : i32
    %717 = llhd.shr %shift_right_result9, %716, %715 : (i32, i32, i32) -> i32
    %718 = llhd.extract_slice %717, 0 : i32 -> i1
    %719 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %712, %718 after %719 : !llhd.sig<i1>
    %720 = llhd.const 9 : i32
    %721 = llhd.const 0 : i32
    %722 = llhd.sig "722" %721 : i32
    %723 = llhd.shr %shift_opa_reversed, %722, %720 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %724 = llhd.extract_slice %723, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa11 = llhd.prb %opa : !llhd.sig<i32>
    %725 = llhd.const 31 : i32
    %726 = llhd.const 9 : i32
    %727 = subi %725, %726 : i32
    %728 = llhd.const 0 : i32
    %729 = llhd.shr %opa11, %728, %727 : (i32, i32, i32) -> i32
    %730 = llhd.extract_slice %729, 0 : i32 -> i1
    %731 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %724, %730 after %731 : !llhd.sig<i1>
    %732 = llhd.const 9 : i32
    %733 = llhd.const 0 : i32
    %734 = llhd.sig "734" %733 : i32
    %735 = llhd.shr %shift_left_result, %734, %732 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %736 = llhd.extract_slice %735, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result10 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %737 = llhd.const 31 : i32
    %738 = llhd.const 9 : i32
    %739 = subi %737, %738 : i32
    %740 = llhd.const 0 : i32
    %741 = llhd.shr %shift_right_result10, %740, %739 : (i32, i32, i32) -> i32
    %742 = llhd.extract_slice %741, 0 : i32 -> i1
    %743 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %736, %742 after %743 : !llhd.sig<i1>
    %744 = llhd.const 10 : i32
    %745 = llhd.const 0 : i32
    %746 = llhd.sig "746" %745 : i32
    %747 = llhd.shr %shift_opa_reversed, %746, %744 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %748 = llhd.extract_slice %747, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa12 = llhd.prb %opa : !llhd.sig<i32>
    %749 = llhd.const 31 : i32
    %750 = llhd.const 10 : i32
    %751 = subi %749, %750 : i32
    %752 = llhd.const 0 : i32
    %753 = llhd.shr %opa12, %752, %751 : (i32, i32, i32) -> i32
    %754 = llhd.extract_slice %753, 0 : i32 -> i1
    %755 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %748, %754 after %755 : !llhd.sig<i1>
    %756 = llhd.const 10 : i32
    %757 = llhd.const 0 : i32
    %758 = llhd.sig "758" %757 : i32
    %759 = llhd.shr %shift_left_result, %758, %756 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %760 = llhd.extract_slice %759, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result11 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %761 = llhd.const 31 : i32
    %762 = llhd.const 10 : i32
    %763 = subi %761, %762 : i32
    %764 = llhd.const 0 : i32
    %765 = llhd.shr %shift_right_result11, %764, %763 : (i32, i32, i32) -> i32
    %766 = llhd.extract_slice %765, 0 : i32 -> i1
    %767 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %760, %766 after %767 : !llhd.sig<i1>
    %768 = llhd.const 11 : i32
    %769 = llhd.const 0 : i32
    %770 = llhd.sig "770" %769 : i32
    %771 = llhd.shr %shift_opa_reversed, %770, %768 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %772 = llhd.extract_slice %771, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa13 = llhd.prb %opa : !llhd.sig<i32>
    %773 = llhd.const 31 : i32
    %774 = llhd.const 11 : i32
    %775 = subi %773, %774 : i32
    %776 = llhd.const 0 : i32
    %777 = llhd.shr %opa13, %776, %775 : (i32, i32, i32) -> i32
    %778 = llhd.extract_slice %777, 0 : i32 -> i1
    %779 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %772, %778 after %779 : !llhd.sig<i1>
    %780 = llhd.const 11 : i32
    %781 = llhd.const 0 : i32
    %782 = llhd.sig "782" %781 : i32
    %783 = llhd.shr %shift_left_result, %782, %780 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %784 = llhd.extract_slice %783, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result12 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %785 = llhd.const 31 : i32
    %786 = llhd.const 11 : i32
    %787 = subi %785, %786 : i32
    %788 = llhd.const 0 : i32
    %789 = llhd.shr %shift_right_result12, %788, %787 : (i32, i32, i32) -> i32
    %790 = llhd.extract_slice %789, 0 : i32 -> i1
    %791 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %784, %790 after %791 : !llhd.sig<i1>
    %792 = llhd.const 12 : i32
    %793 = llhd.const 0 : i32
    %794 = llhd.sig "794" %793 : i32
    %795 = llhd.shr %shift_opa_reversed, %794, %792 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %796 = llhd.extract_slice %795, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa14 = llhd.prb %opa : !llhd.sig<i32>
    %797 = llhd.const 31 : i32
    %798 = llhd.const 12 : i32
    %799 = subi %797, %798 : i32
    %800 = llhd.const 0 : i32
    %801 = llhd.shr %opa14, %800, %799 : (i32, i32, i32) -> i32
    %802 = llhd.extract_slice %801, 0 : i32 -> i1
    %803 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %796, %802 after %803 : !llhd.sig<i1>
    %804 = llhd.const 12 : i32
    %805 = llhd.const 0 : i32
    %806 = llhd.sig "806" %805 : i32
    %807 = llhd.shr %shift_left_result, %806, %804 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %808 = llhd.extract_slice %807, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result13 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %809 = llhd.const 31 : i32
    %810 = llhd.const 12 : i32
    %811 = subi %809, %810 : i32
    %812 = llhd.const 0 : i32
    %813 = llhd.shr %shift_right_result13, %812, %811 : (i32, i32, i32) -> i32
    %814 = llhd.extract_slice %813, 0 : i32 -> i1
    %815 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %808, %814 after %815 : !llhd.sig<i1>
    %816 = llhd.const 13 : i32
    %817 = llhd.const 0 : i32
    %818 = llhd.sig "818" %817 : i32
    %819 = llhd.shr %shift_opa_reversed, %818, %816 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %820 = llhd.extract_slice %819, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa15 = llhd.prb %opa : !llhd.sig<i32>
    %821 = llhd.const 31 : i32
    %822 = llhd.const 13 : i32
    %823 = subi %821, %822 : i32
    %824 = llhd.const 0 : i32
    %825 = llhd.shr %opa15, %824, %823 : (i32, i32, i32) -> i32
    %826 = llhd.extract_slice %825, 0 : i32 -> i1
    %827 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %820, %826 after %827 : !llhd.sig<i1>
    %828 = llhd.const 13 : i32
    %829 = llhd.const 0 : i32
    %830 = llhd.sig "830" %829 : i32
    %831 = llhd.shr %shift_left_result, %830, %828 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %832 = llhd.extract_slice %831, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result14 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %833 = llhd.const 31 : i32
    %834 = llhd.const 13 : i32
    %835 = subi %833, %834 : i32
    %836 = llhd.const 0 : i32
    %837 = llhd.shr %shift_right_result14, %836, %835 : (i32, i32, i32) -> i32
    %838 = llhd.extract_slice %837, 0 : i32 -> i1
    %839 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %832, %838 after %839 : !llhd.sig<i1>
    %840 = llhd.const 14 : i32
    %841 = llhd.const 0 : i32
    %842 = llhd.sig "842" %841 : i32
    %843 = llhd.shr %shift_opa_reversed, %842, %840 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %844 = llhd.extract_slice %843, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa16 = llhd.prb %opa : !llhd.sig<i32>
    %845 = llhd.const 31 : i32
    %846 = llhd.const 14 : i32
    %847 = subi %845, %846 : i32
    %848 = llhd.const 0 : i32
    %849 = llhd.shr %opa16, %848, %847 : (i32, i32, i32) -> i32
    %850 = llhd.extract_slice %849, 0 : i32 -> i1
    %851 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %844, %850 after %851 : !llhd.sig<i1>
    %852 = llhd.const 14 : i32
    %853 = llhd.const 0 : i32
    %854 = llhd.sig "854" %853 : i32
    %855 = llhd.shr %shift_left_result, %854, %852 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %856 = llhd.extract_slice %855, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result15 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %857 = llhd.const 31 : i32
    %858 = llhd.const 14 : i32
    %859 = subi %857, %858 : i32
    %860 = llhd.const 0 : i32
    %861 = llhd.shr %shift_right_result15, %860, %859 : (i32, i32, i32) -> i32
    %862 = llhd.extract_slice %861, 0 : i32 -> i1
    %863 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %856, %862 after %863 : !llhd.sig<i1>
    %864 = llhd.const 15 : i32
    %865 = llhd.const 0 : i32
    %866 = llhd.sig "866" %865 : i32
    %867 = llhd.shr %shift_opa_reversed, %866, %864 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %868 = llhd.extract_slice %867, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa17 = llhd.prb %opa : !llhd.sig<i32>
    %869 = llhd.const 31 : i32
    %870 = llhd.const 15 : i32
    %871 = subi %869, %870 : i32
    %872 = llhd.const 0 : i32
    %873 = llhd.shr %opa17, %872, %871 : (i32, i32, i32) -> i32
    %874 = llhd.extract_slice %873, 0 : i32 -> i1
    %875 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %868, %874 after %875 : !llhd.sig<i1>
    %876 = llhd.const 15 : i32
    %877 = llhd.const 0 : i32
    %878 = llhd.sig "878" %877 : i32
    %879 = llhd.shr %shift_left_result, %878, %876 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %880 = llhd.extract_slice %879, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result16 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %881 = llhd.const 31 : i32
    %882 = llhd.const 15 : i32
    %883 = subi %881, %882 : i32
    %884 = llhd.const 0 : i32
    %885 = llhd.shr %shift_right_result16, %884, %883 : (i32, i32, i32) -> i32
    %886 = llhd.extract_slice %885, 0 : i32 -> i1
    %887 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %880, %886 after %887 : !llhd.sig<i1>
    %888 = llhd.const 16 : i32
    %889 = llhd.const 0 : i32
    %890 = llhd.sig "890" %889 : i32
    %891 = llhd.shr %shift_opa_reversed, %890, %888 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %892 = llhd.extract_slice %891, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa18 = llhd.prb %opa : !llhd.sig<i32>
    %893 = llhd.const 31 : i32
    %894 = llhd.const 16 : i32
    %895 = subi %893, %894 : i32
    %896 = llhd.const 0 : i32
    %897 = llhd.shr %opa18, %896, %895 : (i32, i32, i32) -> i32
    %898 = llhd.extract_slice %897, 0 : i32 -> i1
    %899 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %892, %898 after %899 : !llhd.sig<i1>
    %900 = llhd.const 16 : i32
    %901 = llhd.const 0 : i32
    %902 = llhd.sig "902" %901 : i32
    %903 = llhd.shr %shift_left_result, %902, %900 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %904 = llhd.extract_slice %903, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result17 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %905 = llhd.const 31 : i32
    %906 = llhd.const 16 : i32
    %907 = subi %905, %906 : i32
    %908 = llhd.const 0 : i32
    %909 = llhd.shr %shift_right_result17, %908, %907 : (i32, i32, i32) -> i32
    %910 = llhd.extract_slice %909, 0 : i32 -> i1
    %911 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %904, %910 after %911 : !llhd.sig<i1>
    %912 = llhd.const 17 : i32
    %913 = llhd.const 0 : i32
    %914 = llhd.sig "914" %913 : i32
    %915 = llhd.shr %shift_opa_reversed, %914, %912 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %916 = llhd.extract_slice %915, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa19 = llhd.prb %opa : !llhd.sig<i32>
    %917 = llhd.const 31 : i32
    %918 = llhd.const 17 : i32
    %919 = subi %917, %918 : i32
    %920 = llhd.const 0 : i32
    %921 = llhd.shr %opa19, %920, %919 : (i32, i32, i32) -> i32
    %922 = llhd.extract_slice %921, 0 : i32 -> i1
    %923 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %916, %922 after %923 : !llhd.sig<i1>
    %924 = llhd.const 17 : i32
    %925 = llhd.const 0 : i32
    %926 = llhd.sig "926" %925 : i32
    %927 = llhd.shr %shift_left_result, %926, %924 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %928 = llhd.extract_slice %927, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result18 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %929 = llhd.const 31 : i32
    %930 = llhd.const 17 : i32
    %931 = subi %929, %930 : i32
    %932 = llhd.const 0 : i32
    %933 = llhd.shr %shift_right_result18, %932, %931 : (i32, i32, i32) -> i32
    %934 = llhd.extract_slice %933, 0 : i32 -> i1
    %935 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %928, %934 after %935 : !llhd.sig<i1>
    %936 = llhd.const 18 : i32
    %937 = llhd.const 0 : i32
    %938 = llhd.sig "938" %937 : i32
    %939 = llhd.shr %shift_opa_reversed, %938, %936 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %940 = llhd.extract_slice %939, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa20 = llhd.prb %opa : !llhd.sig<i32>
    %941 = llhd.const 31 : i32
    %942 = llhd.const 18 : i32
    %943 = subi %941, %942 : i32
    %944 = llhd.const 0 : i32
    %945 = llhd.shr %opa20, %944, %943 : (i32, i32, i32) -> i32
    %946 = llhd.extract_slice %945, 0 : i32 -> i1
    %947 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %940, %946 after %947 : !llhd.sig<i1>
    %948 = llhd.const 18 : i32
    %949 = llhd.const 0 : i32
    %950 = llhd.sig "950" %949 : i32
    %951 = llhd.shr %shift_left_result, %950, %948 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %952 = llhd.extract_slice %951, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result19 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %953 = llhd.const 31 : i32
    %954 = llhd.const 18 : i32
    %955 = subi %953, %954 : i32
    %956 = llhd.const 0 : i32
    %957 = llhd.shr %shift_right_result19, %956, %955 : (i32, i32, i32) -> i32
    %958 = llhd.extract_slice %957, 0 : i32 -> i1
    %959 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %952, %958 after %959 : !llhd.sig<i1>
    %960 = llhd.const 19 : i32
    %961 = llhd.const 0 : i32
    %962 = llhd.sig "962" %961 : i32
    %963 = llhd.shr %shift_opa_reversed, %962, %960 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %964 = llhd.extract_slice %963, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa21 = llhd.prb %opa : !llhd.sig<i32>
    %965 = llhd.const 31 : i32
    %966 = llhd.const 19 : i32
    %967 = subi %965, %966 : i32
    %968 = llhd.const 0 : i32
    %969 = llhd.shr %opa21, %968, %967 : (i32, i32, i32) -> i32
    %970 = llhd.extract_slice %969, 0 : i32 -> i1
    %971 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %964, %970 after %971 : !llhd.sig<i1>
    %972 = llhd.const 19 : i32
    %973 = llhd.const 0 : i32
    %974 = llhd.sig "974" %973 : i32
    %975 = llhd.shr %shift_left_result, %974, %972 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %976 = llhd.extract_slice %975, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result20 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %977 = llhd.const 31 : i32
    %978 = llhd.const 19 : i32
    %979 = subi %977, %978 : i32
    %980 = llhd.const 0 : i32
    %981 = llhd.shr %shift_right_result20, %980, %979 : (i32, i32, i32) -> i32
    %982 = llhd.extract_slice %981, 0 : i32 -> i1
    %983 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %976, %982 after %983 : !llhd.sig<i1>
    %984 = llhd.const 20 : i32
    %985 = llhd.const 0 : i32
    %986 = llhd.sig "986" %985 : i32
    %987 = llhd.shr %shift_opa_reversed, %986, %984 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %988 = llhd.extract_slice %987, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa22 = llhd.prb %opa : !llhd.sig<i32>
    %989 = llhd.const 31 : i32
    %990 = llhd.const 20 : i32
    %991 = subi %989, %990 : i32
    %992 = llhd.const 0 : i32
    %993 = llhd.shr %opa22, %992, %991 : (i32, i32, i32) -> i32
    %994 = llhd.extract_slice %993, 0 : i32 -> i1
    %995 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %988, %994 after %995 : !llhd.sig<i1>
    %996 = llhd.const 20 : i32
    %997 = llhd.const 0 : i32
    %998 = llhd.sig "998" %997 : i32
    %999 = llhd.shr %shift_left_result, %998, %996 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1000 = llhd.extract_slice %999, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result21 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1001 = llhd.const 31 : i32
    %1002 = llhd.const 20 : i32
    %1003 = subi %1001, %1002 : i32
    %1004 = llhd.const 0 : i32
    %1005 = llhd.shr %shift_right_result21, %1004, %1003 : (i32, i32, i32) -> i32
    %1006 = llhd.extract_slice %1005, 0 : i32 -> i1
    %1007 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1000, %1006 after %1007 : !llhd.sig<i1>
    %1008 = llhd.const 21 : i32
    %1009 = llhd.const 0 : i32
    %1010 = llhd.sig "1010" %1009 : i32
    %1011 = llhd.shr %shift_opa_reversed, %1010, %1008 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1012 = llhd.extract_slice %1011, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa23 = llhd.prb %opa : !llhd.sig<i32>
    %1013 = llhd.const 31 : i32
    %1014 = llhd.const 21 : i32
    %1015 = subi %1013, %1014 : i32
    %1016 = llhd.const 0 : i32
    %1017 = llhd.shr %opa23, %1016, %1015 : (i32, i32, i32) -> i32
    %1018 = llhd.extract_slice %1017, 0 : i32 -> i1
    %1019 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1012, %1018 after %1019 : !llhd.sig<i1>
    %1020 = llhd.const 21 : i32
    %1021 = llhd.const 0 : i32
    %1022 = llhd.sig "1022" %1021 : i32
    %1023 = llhd.shr %shift_left_result, %1022, %1020 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1024 = llhd.extract_slice %1023, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result22 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1025 = llhd.const 31 : i32
    %1026 = llhd.const 21 : i32
    %1027 = subi %1025, %1026 : i32
    %1028 = llhd.const 0 : i32
    %1029 = llhd.shr %shift_right_result22, %1028, %1027 : (i32, i32, i32) -> i32
    %1030 = llhd.extract_slice %1029, 0 : i32 -> i1
    %1031 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1024, %1030 after %1031 : !llhd.sig<i1>
    %1032 = llhd.const 22 : i32
    %1033 = llhd.const 0 : i32
    %1034 = llhd.sig "1034" %1033 : i32
    %1035 = llhd.shr %shift_opa_reversed, %1034, %1032 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1036 = llhd.extract_slice %1035, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa24 = llhd.prb %opa : !llhd.sig<i32>
    %1037 = llhd.const 31 : i32
    %1038 = llhd.const 22 : i32
    %1039 = subi %1037, %1038 : i32
    %1040 = llhd.const 0 : i32
    %1041 = llhd.shr %opa24, %1040, %1039 : (i32, i32, i32) -> i32
    %1042 = llhd.extract_slice %1041, 0 : i32 -> i1
    %1043 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1036, %1042 after %1043 : !llhd.sig<i1>
    %1044 = llhd.const 22 : i32
    %1045 = llhd.const 0 : i32
    %1046 = llhd.sig "1046" %1045 : i32
    %1047 = llhd.shr %shift_left_result, %1046, %1044 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1048 = llhd.extract_slice %1047, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result23 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1049 = llhd.const 31 : i32
    %1050 = llhd.const 22 : i32
    %1051 = subi %1049, %1050 : i32
    %1052 = llhd.const 0 : i32
    %1053 = llhd.shr %shift_right_result23, %1052, %1051 : (i32, i32, i32) -> i32
    %1054 = llhd.extract_slice %1053, 0 : i32 -> i1
    %1055 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1048, %1054 after %1055 : !llhd.sig<i1>
    %1056 = llhd.const 23 : i32
    %1057 = llhd.const 0 : i32
    %1058 = llhd.sig "1058" %1057 : i32
    %1059 = llhd.shr %shift_opa_reversed, %1058, %1056 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1060 = llhd.extract_slice %1059, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa25 = llhd.prb %opa : !llhd.sig<i32>
    %1061 = llhd.const 31 : i32
    %1062 = llhd.const 23 : i32
    %1063 = subi %1061, %1062 : i32
    %1064 = llhd.const 0 : i32
    %1065 = llhd.shr %opa25, %1064, %1063 : (i32, i32, i32) -> i32
    %1066 = llhd.extract_slice %1065, 0 : i32 -> i1
    %1067 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1060, %1066 after %1067 : !llhd.sig<i1>
    %1068 = llhd.const 23 : i32
    %1069 = llhd.const 0 : i32
    %1070 = llhd.sig "1070" %1069 : i32
    %1071 = llhd.shr %shift_left_result, %1070, %1068 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1072 = llhd.extract_slice %1071, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result24 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1073 = llhd.const 31 : i32
    %1074 = llhd.const 23 : i32
    %1075 = subi %1073, %1074 : i32
    %1076 = llhd.const 0 : i32
    %1077 = llhd.shr %shift_right_result24, %1076, %1075 : (i32, i32, i32) -> i32
    %1078 = llhd.extract_slice %1077, 0 : i32 -> i1
    %1079 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1072, %1078 after %1079 : !llhd.sig<i1>
    %1080 = llhd.const 24 : i32
    %1081 = llhd.const 0 : i32
    %1082 = llhd.sig "1082" %1081 : i32
    %1083 = llhd.shr %shift_opa_reversed, %1082, %1080 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1084 = llhd.extract_slice %1083, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa26 = llhd.prb %opa : !llhd.sig<i32>
    %1085 = llhd.const 31 : i32
    %1086 = llhd.const 24 : i32
    %1087 = subi %1085, %1086 : i32
    %1088 = llhd.const 0 : i32
    %1089 = llhd.shr %opa26, %1088, %1087 : (i32, i32, i32) -> i32
    %1090 = llhd.extract_slice %1089, 0 : i32 -> i1
    %1091 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1084, %1090 after %1091 : !llhd.sig<i1>
    %1092 = llhd.const 24 : i32
    %1093 = llhd.const 0 : i32
    %1094 = llhd.sig "1094" %1093 : i32
    %1095 = llhd.shr %shift_left_result, %1094, %1092 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1096 = llhd.extract_slice %1095, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result25 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1097 = llhd.const 31 : i32
    %1098 = llhd.const 24 : i32
    %1099 = subi %1097, %1098 : i32
    %1100 = llhd.const 0 : i32
    %1101 = llhd.shr %shift_right_result25, %1100, %1099 : (i32, i32, i32) -> i32
    %1102 = llhd.extract_slice %1101, 0 : i32 -> i1
    %1103 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1096, %1102 after %1103 : !llhd.sig<i1>
    %1104 = llhd.const 25 : i32
    %1105 = llhd.const 0 : i32
    %1106 = llhd.sig "1106" %1105 : i32
    %1107 = llhd.shr %shift_opa_reversed, %1106, %1104 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1108 = llhd.extract_slice %1107, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa27 = llhd.prb %opa : !llhd.sig<i32>
    %1109 = llhd.const 31 : i32
    %1110 = llhd.const 25 : i32
    %1111 = subi %1109, %1110 : i32
    %1112 = llhd.const 0 : i32
    %1113 = llhd.shr %opa27, %1112, %1111 : (i32, i32, i32) -> i32
    %1114 = llhd.extract_slice %1113, 0 : i32 -> i1
    %1115 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1108, %1114 after %1115 : !llhd.sig<i1>
    %1116 = llhd.const 25 : i32
    %1117 = llhd.const 0 : i32
    %1118 = llhd.sig "1118" %1117 : i32
    %1119 = llhd.shr %shift_left_result, %1118, %1116 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1120 = llhd.extract_slice %1119, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result26 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1121 = llhd.const 31 : i32
    %1122 = llhd.const 25 : i32
    %1123 = subi %1121, %1122 : i32
    %1124 = llhd.const 0 : i32
    %1125 = llhd.shr %shift_right_result26, %1124, %1123 : (i32, i32, i32) -> i32
    %1126 = llhd.extract_slice %1125, 0 : i32 -> i1
    %1127 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1120, %1126 after %1127 : !llhd.sig<i1>
    %1128 = llhd.const 26 : i32
    %1129 = llhd.const 0 : i32
    %1130 = llhd.sig "1130" %1129 : i32
    %1131 = llhd.shr %shift_opa_reversed, %1130, %1128 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1132 = llhd.extract_slice %1131, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa28 = llhd.prb %opa : !llhd.sig<i32>
    %1133 = llhd.const 31 : i32
    %1134 = llhd.const 26 : i32
    %1135 = subi %1133, %1134 : i32
    %1136 = llhd.const 0 : i32
    %1137 = llhd.shr %opa28, %1136, %1135 : (i32, i32, i32) -> i32
    %1138 = llhd.extract_slice %1137, 0 : i32 -> i1
    %1139 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1132, %1138 after %1139 : !llhd.sig<i1>
    %1140 = llhd.const 26 : i32
    %1141 = llhd.const 0 : i32
    %1142 = llhd.sig "1142" %1141 : i32
    %1143 = llhd.shr %shift_left_result, %1142, %1140 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1144 = llhd.extract_slice %1143, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result27 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1145 = llhd.const 31 : i32
    %1146 = llhd.const 26 : i32
    %1147 = subi %1145, %1146 : i32
    %1148 = llhd.const 0 : i32
    %1149 = llhd.shr %shift_right_result27, %1148, %1147 : (i32, i32, i32) -> i32
    %1150 = llhd.extract_slice %1149, 0 : i32 -> i1
    %1151 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1144, %1150 after %1151 : !llhd.sig<i1>
    %1152 = llhd.const 27 : i32
    %1153 = llhd.const 0 : i32
    %1154 = llhd.sig "1154" %1153 : i32
    %1155 = llhd.shr %shift_opa_reversed, %1154, %1152 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1156 = llhd.extract_slice %1155, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa29 = llhd.prb %opa : !llhd.sig<i32>
    %1157 = llhd.const 31 : i32
    %1158 = llhd.const 27 : i32
    %1159 = subi %1157, %1158 : i32
    %1160 = llhd.const 0 : i32
    %1161 = llhd.shr %opa29, %1160, %1159 : (i32, i32, i32) -> i32
    %1162 = llhd.extract_slice %1161, 0 : i32 -> i1
    %1163 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1156, %1162 after %1163 : !llhd.sig<i1>
    %1164 = llhd.const 27 : i32
    %1165 = llhd.const 0 : i32
    %1166 = llhd.sig "1166" %1165 : i32
    %1167 = llhd.shr %shift_left_result, %1166, %1164 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1168 = llhd.extract_slice %1167, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result28 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1169 = llhd.const 31 : i32
    %1170 = llhd.const 27 : i32
    %1171 = subi %1169, %1170 : i32
    %1172 = llhd.const 0 : i32
    %1173 = llhd.shr %shift_right_result28, %1172, %1171 : (i32, i32, i32) -> i32
    %1174 = llhd.extract_slice %1173, 0 : i32 -> i1
    %1175 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1168, %1174 after %1175 : !llhd.sig<i1>
    %1176 = llhd.const 28 : i32
    %1177 = llhd.const 0 : i32
    %1178 = llhd.sig "1178" %1177 : i32
    %1179 = llhd.shr %shift_opa_reversed, %1178, %1176 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1180 = llhd.extract_slice %1179, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa30 = llhd.prb %opa : !llhd.sig<i32>
    %1181 = llhd.const 31 : i32
    %1182 = llhd.const 28 : i32
    %1183 = subi %1181, %1182 : i32
    %1184 = llhd.const 0 : i32
    %1185 = llhd.shr %opa30, %1184, %1183 : (i32, i32, i32) -> i32
    %1186 = llhd.extract_slice %1185, 0 : i32 -> i1
    %1187 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1180, %1186 after %1187 : !llhd.sig<i1>
    %1188 = llhd.const 28 : i32
    %1189 = llhd.const 0 : i32
    %1190 = llhd.sig "1190" %1189 : i32
    %1191 = llhd.shr %shift_left_result, %1190, %1188 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1192 = llhd.extract_slice %1191, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result29 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1193 = llhd.const 31 : i32
    %1194 = llhd.const 28 : i32
    %1195 = subi %1193, %1194 : i32
    %1196 = llhd.const 0 : i32
    %1197 = llhd.shr %shift_right_result29, %1196, %1195 : (i32, i32, i32) -> i32
    %1198 = llhd.extract_slice %1197, 0 : i32 -> i1
    %1199 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1192, %1198 after %1199 : !llhd.sig<i1>
    %1200 = llhd.const 29 : i32
    %1201 = llhd.const 0 : i32
    %1202 = llhd.sig "1202" %1201 : i32
    %1203 = llhd.shr %shift_opa_reversed, %1202, %1200 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1204 = llhd.extract_slice %1203, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa31 = llhd.prb %opa : !llhd.sig<i32>
    %1205 = llhd.const 31 : i32
    %1206 = llhd.const 29 : i32
    %1207 = subi %1205, %1206 : i32
    %1208 = llhd.const 0 : i32
    %1209 = llhd.shr %opa31, %1208, %1207 : (i32, i32, i32) -> i32
    %1210 = llhd.extract_slice %1209, 0 : i32 -> i1
    %1211 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1204, %1210 after %1211 : !llhd.sig<i1>
    %1212 = llhd.const 29 : i32
    %1213 = llhd.const 0 : i32
    %1214 = llhd.sig "1214" %1213 : i32
    %1215 = llhd.shr %shift_left_result, %1214, %1212 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1216 = llhd.extract_slice %1215, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result30 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1217 = llhd.const 31 : i32
    %1218 = llhd.const 29 : i32
    %1219 = subi %1217, %1218 : i32
    %1220 = llhd.const 0 : i32
    %1221 = llhd.shr %shift_right_result30, %1220, %1219 : (i32, i32, i32) -> i32
    %1222 = llhd.extract_slice %1221, 0 : i32 -> i1
    %1223 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1216, %1222 after %1223 : !llhd.sig<i1>
    %1224 = llhd.const 30 : i32
    %1225 = llhd.const 0 : i32
    %1226 = llhd.sig "1226" %1225 : i32
    %1227 = llhd.shr %shift_opa_reversed, %1226, %1224 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1228 = llhd.extract_slice %1227, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa32 = llhd.prb %opa : !llhd.sig<i32>
    %1229 = llhd.const 31 : i32
    %1230 = llhd.const 30 : i32
    %1231 = subi %1229, %1230 : i32
    %1232 = llhd.const 0 : i32
    %1233 = llhd.shr %opa32, %1232, %1231 : (i32, i32, i32) -> i32
    %1234 = llhd.extract_slice %1233, 0 : i32 -> i1
    %1235 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1228, %1234 after %1235 : !llhd.sig<i1>
    %1236 = llhd.const 30 : i32
    %1237 = llhd.const 0 : i32
    %1238 = llhd.sig "1238" %1237 : i32
    %1239 = llhd.shr %shift_left_result, %1238, %1236 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1240 = llhd.extract_slice %1239, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result31 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1241 = llhd.const 31 : i32
    %1242 = llhd.const 30 : i32
    %1243 = subi %1241, %1242 : i32
    %1244 = llhd.const 0 : i32
    %1245 = llhd.shr %shift_right_result31, %1244, %1243 : (i32, i32, i32) -> i32
    %1246 = llhd.extract_slice %1245, 0 : i32 -> i1
    %1247 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1240, %1246 after %1247 : !llhd.sig<i1>
    %1248 = llhd.const 31 : i32
    %1249 = llhd.const 0 : i32
    %1250 = llhd.sig "1250" %1249 : i32
    %1251 = llhd.shr %shift_opa_reversed, %1250, %1248 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1252 = llhd.extract_slice %1251, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %opa33 = llhd.prb %opa : !llhd.sig<i32>
    %1253 = llhd.const 31 : i32
    %1254 = llhd.const 31 : i32
    %1255 = subi %1253, %1254 : i32
    %1256 = llhd.const 0 : i32
    %1257 = llhd.shr %opa33, %1256, %1255 : (i32, i32, i32) -> i32
    %1258 = llhd.extract_slice %1257, 0 : i32 -> i1
    %1259 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1252, %1258 after %1259 : !llhd.sig<i1>
    %1260 = llhd.const 31 : i32
    %1261 = llhd.const 0 : i32
    %1262 = llhd.sig "1262" %1261 : i32
    %1263 = llhd.shr %shift_left_result, %1262, %1260 : (!llhd.sig<i32>, !llhd.sig<i32>, i32) -> !llhd.sig<i32>
    %1264 = llhd.extract_slice %1263, 0 : !llhd.sig<i32> -> !llhd.sig<i1>
    %shift_right_result32 = llhd.prb %shift_right_result : !llhd.sig<i32>
    %1265 = llhd.const 31 : i32
    %1266 = llhd.const 31 : i32
    %1267 = subi %1265, %1266 : i32
    %1268 = llhd.const 0 : i32
    %1269 = llhd.shr %shift_right_result32, %1268, %1267 : (i32, i32, i32) -> i32
    %1270 = llhd.extract_slice %1269, 0 : i32 -> i1
    %1271 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %1264, %1270 after %1271 : !llhd.sig<i1>
    llhd.inst "inst2" @snitch.param1.always_ff.568.1(%clk_i, %rst_i, %pc_d) -> (%pc_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst3" @snitch.param1.always_ff.569.1(%clk_i, %rst_i, %wfi_d) -> (%wfi_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>)
    llhd.inst "inst4" @snitch.param1.always_ff.570.1(%clk_i, %rst_i, %sb_d) -> (%sb_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst5" @snitch.param1.always_ff.571.1(%clk_i, %rst_i, %fcsr_d) -> (%fcsr_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (!llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>)
    llhd.inst "inst6" @snitch.param1.always_comb.572.1(%stall) -> (%core_events_o) : (!llhd.sig<i1>) -> (!llhd.sig<tuple<i1, i1, i1, i1>>)
    llhd.inst "inst7" @snitch.param1.always_comb.590.1(%acc_pid_i, %rd, %stall, %sb_q, %is_load, %lsu_rd, %retire_load, %retire_acc, %acc_register_rd) -> (%sb_d) : (!llhd.sig<i5>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i32>)
    llhd.inst "inst8" @snitch.param1.always_comb.600.1(%zero_lsb, %pc_q, %wfi_q, %consec_pc, %alu_result, %stall, %next_pc) -> (%pc_d) : (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i2>) -> (!llhd.sig<i32>)
    llhd.inst "inst9" @snitch.param1.always_comb.604.1(%inst_data_i, %wake_up_sync_i, %illegal_inst, %wfi_q, %uimm, %valid_instr, %write_rd, %csr_rvalue) -> (%acc_qvalid_o, %illegal_inst, %zero_lsb, %wfi_d, %is_load, %is_store, %is_signed, %ls_size, %ls_amo, %alu_op, %opa_select, %opb_select, %write_rd, %uses_rd, %next_pc, %rd_select, %rd_bypass, %is_branch, %csr_en, %acc_register_rd) : (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i2>, !llhd.sig<i2>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
    llhd.inst "inst10" @snitch.param1.always_comb.605.1(%hart_id_i, %inst_data_i, %fpu_status_i, %alu_result, %csr_en, %fcsr_q) -> (%csr_rvalue, %fcsr_d) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<tuple<i1, i1, i1, i1, i1>>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>) -> (!llhd.sig<i32>, !llhd.sig<tuple<i3, tuple<i1, i1, i1, i1, i1>>>)
    llhd.inst "inst11" @snitch.param1.always_comb.608.1(%uimm, %jimm, %rs1, %gpr_rdata, %opa_select) -> (%opa) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i5>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>) -> (!llhd.sig<i32>)
    llhd.inst "inst12" @snitch.param1.always_comb.609.1(%pc_q, %iimm, %simm, %gpr_rdata, %opb_select, %csr_rvalue) -> (%opb) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<!llhd.array<2xi32>>, !llhd.sig<i4>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst13" @snitch.param1.always_comb.633.1(%opa, %opb, %adder_result, %alu_op, %shift_right_result, %shift_left_result) -> (%alu_result, %shift_left, %shift_arithmetic, %alu_opa, %alu_opb) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i33>, !llhd.sig<i4>, !llhd.sig<i32>, !llhd.sig<i32>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i33>, !llhd.sig<i33>)
    llhd.inst "inst14" @snitch.param1.always_comb.640.1(%consec_pc, %alu_result, %rd_select, %rd_bypass) -> (%alu_writeback) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i2>, !llhd.sig<i32>) -> (!llhd.sig<i32>)
    llhd.inst "inst15" @snitch.param1.always_comb.641.1(%acc_pdata_i, %acc_pid_i, %acc_pvalid_i, %rd, %ld_result, %lsu_pvalid, %lsu_rd, %retire_i, %alu_writeback) -> (%acc_pready_o, %gpr_waddr, %gpr_wdata, %gpr_we, %lsu_pready, %retire_load, %retire_acc) : (!llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<i1>, !llhd.sig<!llhd.array<1xi5>>, !llhd.sig<!llhd.array<1xi32>>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}

llhd.proc @snitch_tb.always.272.0(%clk_i: !llhd.sig<i1>, %data_qvalid_o: !llhd.sig<i1>, %data_qready_i: !llhd.sig<i1>, %data_pvalid_i: !llhd.sig<i1>, %data_pready_o: !llhd.sig<i1>, %data_resp_pending: !llhd.sig<i32>) -> () {
    br ^0
^0:
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    llhd.wait (%clk_i : !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %clk_i1, %1 : i1
    %3 = llhd.neq %clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %data_pvalid_i1 = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %data_pready_o1 = llhd.prb %data_pready_o : !llhd.sig<i1>
    %4 = llhd.and %data_pvalid_i1, %data_pready_o1 : i1
    cond_br %4, ^if_true, ^if_false
^if_false:
    br ^if_exit
^if_true:
    %data_resp_pending1 = llhd.prb %data_resp_pending : !llhd.sig<i32>
    %5 = llhd.const 1 : i32
    %6 = subi %data_resp_pending1, %5 : i32
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_resp_pending, %6 after %7 : !llhd.sig<i32>
    %data_resp_pending2 = llhd.prb %data_resp_pending : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    %data_qvalid_o1 = llhd.prb %data_qvalid_o : !llhd.sig<i1>
    %data_qready_i1 = llhd.prb %data_qready_i : !llhd.sig<i1>
    %8 = llhd.and %data_qvalid_o1, %data_qready_i1 : i1
    cond_br %8, ^if_true1, ^if_false1
^if_false1:
    br ^if_exit1
^if_true1:
    %data_resp_pending3 = llhd.prb %data_resp_pending : !llhd.sig<i32>
    %9 = llhd.const 1 : i32
    %10 = addi %data_resp_pending3, %9 : i32
    %11 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_resp_pending, %10 after %11 : !llhd.sig<i32>
    %data_resp_pending4 = llhd.prb %data_resp_pending : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^0
}

llhd.proc @snitch_tb.initial.277.0() -> (%clk_i: !llhd.sig<i1> , %rst_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 1 : i32
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_i, %2 after %3 : !llhd.sig<i1>
    %4 = llhd.const 1 : i32
    %5 = llhd.extract_slice %4, 0 : i32 -> i1
    %6 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const 0 : i32
    %8 = llhd.extract_slice %7, 0 : i32 -> i1
    %9 = llhd.const #llhd.time<3ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %8 after %9 : !llhd.sig<i1>
    %10 = llhd.const 0 : i32
    %11 = llhd.extract_slice %10, 0 : i32 -> i1
    %12 = llhd.const #llhd.time<4ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_i, %11 after %12 : !llhd.sig<i1>
    %13 = llhd.const #llhd.time<5ns, 0d, 0e> : !llhd.time
    llhd.wait  for %13, ^14
^14:
    %15 = llhd.const 1000000 : i32
    %loop_count = llhd.var %15 : i32
    br ^loop_body
^loop_body:
    %16 = llhd.load %loop_count : !llhd.ptr<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.neq %16, %17 : i32
    cond_br %18, ^loop_continue, ^loop_exit
^loop_exit:
    %19 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %19, ^20
^loop_continue:
    %21 = llhd.const 1 : i32
    %22 = llhd.extract_slice %21, 0 : i32 -> i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %clk_i, %22 after %23 : !llhd.sig<i1>
    %24 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %24, ^25
^20:
    llhd.halt
^25:
    %26 = llhd.const 0 : i32
    %27 = llhd.extract_slice %26, 0 : i32 -> i1
    %28 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %clk_i, %27 after %28 : !llhd.sig<i1>
    %29 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %29, ^30
^30:
    %31 = llhd.load %loop_count : !llhd.ptr<i32>
    %32 = llhd.const 1 : i32
    %33 = subi %31, %32 : i32
    llhd.store %loop_count, %33 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.entity @snitch_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 0 : i1
    %rst_i = llhd.sig "rst_i" %1 : i1
    %2 = llhd.const 0 : i32
    %inst_addr_o = llhd.sig "inst_addr_o" %2 : i32
    %3 = llhd.const 0 : i32
    %inst_data_i = llhd.sig "inst_data_i" %3 : i32
    %4 = llhd.const 0 : i1
    %inst_valid_o = llhd.sig "inst_valid_o" %4 : i1
    %5 = llhd.const 0 : i1
    %inst_ready_i = llhd.sig "inst_ready_i" %5 : i1
    %6 = llhd.const 0 : i32
    %data_qaddr_o = llhd.sig "data_qaddr_o" %6 : i32
    %7 = llhd.const 0 : i1
    %data_qwrite_o = llhd.sig "data_qwrite_o" %7 : i1
    %8 = llhd.const 0 : i4
    %data_qamo_o = llhd.sig "data_qamo_o" %8 : i4
    %9 = llhd.const 0 : i64
    %data_qdata_o = llhd.sig "data_qdata_o" %9 : i64
    %10 = llhd.const 0 : i8
    %data_qstrb_o = llhd.sig "data_qstrb_o" %10 : i8
    %11 = llhd.const 0 : i1
    %data_qvalid_o = llhd.sig "data_qvalid_o" %11 : i1
    %12 = llhd.const 0 : i1
    %data_qready_i = llhd.sig "data_qready_i" %12 : i1
    %13 = llhd.const 0 : i64
    %data_pdata_i = llhd.sig "data_pdata_i" %13 : i64
    %14 = llhd.const 0 : i1
    %data_perror_i = llhd.sig "data_perror_i" %14 : i1
    %15 = llhd.const 0 : i1
    %data_pvalid_i = llhd.sig "data_pvalid_i" %15 : i1
    %16 = llhd.const 0 : i1
    %data_pready_o = llhd.sig "data_pready_o" %16 : i1
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i32
    %19 = llhd.const 0 : i32
    %20 = llhd.const 0 : i32
    %21 = llhd.const 0 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.const 0 : i32
    %24 = llhd.const 0 : i32
    %25 = llhd.const 0 : i32
    %26 = llhd.const 0 : i32
    %27 = llhd.const 0 : i32
    %28 = llhd.const 0 : i32
    %29 = llhd.const 0 : i32
    %30 = llhd.const 0 : i32
    %31 = llhd.const 0 : i32
    %32 = llhd.const 0 : i32
    %33 = llhd.array %17, %18, %19, %20, %21, %22, %23, %24, %25, %26, %27, %28, %29, %30, %31, %32 : !llhd.array<16xi32>
    %PROGRAM = llhd.sig "PROGRAM" %33 : !llhd.array<16xi32>
    %34 = llhd.const 0 : i32
    %data_resp_pending = llhd.sig "data_resp_pending" %34 : i32
    %35 = llhd.const 1048577811 : i32
    %36 = llhd.const 1050515 : i32
    %37 = llhd.const 1555 : i32
    %38 = llhd.const 3405649335 : i32
    %39 = llhd.const 16123571 : i32
    %40 = llhd.const 14000163 : i32
    %41 = llhd.const 4294379283 : i32
    %42 = llhd.const 493075 : i32
    %43 = llhd.const 427923 : i32
    %44 = llhd.const 4261877475 : i32
    %45 = llhd.const 273678451 : i32
    %46 = llhd.const 4292866159 : i32
    %47 = llhd.const 32871 : i32
    %48 = llhd.const 0 : i32
    %49 = llhd.const 0 : i1
    %50 = llhd.insert_slice %48, %49, 0 : i32, i1
    %51 = llhd.const 0 : i32
    %52 = llhd.const 0 : i1
    %53 = llhd.insert_slice %51, %52, 0 : i32, i1
    %54 = llhd.const 0 : i32
    %55 = llhd.const 0 : i1
    %56 = llhd.insert_slice %54, %55, 0 : i32, i1
    %57 = llhd.array %35, %36, %37, %38, %39, %40, %41, %42, %43, %44, %45, %46, %47, %50, %53, %56 : !llhd.array<16xi32>
    %58 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %PROGRAM, %57 after %58 : !llhd.sig<!llhd.array<16xi32>>
    %PROGRAM1 = llhd.prb %PROGRAM : !llhd.sig<!llhd.array<16xi32>>
    %inst_addr_o1 = llhd.prb %inst_addr_o : !llhd.sig<i32>
    %59 = llhd.const 65536 : i32
    %60 = subi %inst_addr_o1, %59 : i32
    %61 = llhd.const 4 : i32
    %62 = divi_unsigned %60, %61 : i32
    %63 = llhd.const 0 : i32
    %64 = llhd.array_uniform %63 : !llhd.array<16xi32>
    %65 = llhd.shr %PROGRAM1, %64, %62 : (!llhd.array<16xi32>, !llhd.array<16xi32>, i32) -> !llhd.array<16xi32>
    %66 = llhd.extract_element %65, 0 : !llhd.array<16xi32> -> i32
    %67 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %inst_data_i, %66 after %67 : !llhd.sig<i32>
    %68 = llhd.const 1 : i32
    %69 = llhd.extract_slice %68, 0 : i32 -> i1
    %70 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %inst_ready_i, %69 after %70 : !llhd.sig<i1>
    %71 = llhd.const 1 : i32
    %72 = llhd.extract_slice %71, 0 : i32 -> i1
    %73 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_qready_i, %72 after %73 : !llhd.sig<i1>
    %74 = llhd.const 0 : i64
    %75 = llhd.const 3735931568 : i32
    %76 = llhd.insert_slice %74, %75, 0 : i64, i32
    %77 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_pdata_i, %76 after %77 : !llhd.sig<i64>
    %78 = llhd.const 0 : i32
    %79 = llhd.extract_slice %78, 0 : i32 -> i1
    %80 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_perror_i, %79 after %80 : !llhd.sig<i1>
    %data_resp_pending1 = llhd.prb %data_resp_pending : !llhd.sig<i32>
    %81 = llhd.const 0 : i32
    %82 = cmpi "sgt", %data_resp_pending1, %81 : i32
    %83 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %data_pvalid_i, %82 after %83 : !llhd.sig<i1>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %84 = llhd.const 0 : i1
    %85 = llhd.sig "85" %84 : i1
    %86 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %85, %clk_i1 after %86 : !llhd.sig<i1>
    %rst_i1 = llhd.prb %rst_i : !llhd.sig<i1>
    %87 = llhd.const 0 : i1
    %88 = llhd.sig "88" %87 : i1
    %89 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %88, %rst_i1 after %89 : !llhd.sig<i1>
    %90 = llhd.const 66 : i32
    %91 = llhd.const 0 : i32
    %92 = llhd.sig "92" %91 : i32
    %93 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %92, %90 after %93 : !llhd.sig<i32>
    %inst_data_i1 = llhd.prb %inst_data_i : !llhd.sig<i32>
    %94 = llhd.const 0 : i32
    %95 = llhd.sig "95" %94 : i32
    %96 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %95, %inst_data_i1 after %96 : !llhd.sig<i32>
    %inst_ready_i1 = llhd.prb %inst_ready_i : !llhd.sig<i1>
    %97 = llhd.const 0 : i1
    %98 = llhd.sig "98" %97 : i1
    %99 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %98, %inst_ready_i1 after %99 : !llhd.sig<i1>
    %100 = llhd.const 0 : i32
    %101 = llhd.sig "101" %100 : i32
    %102 = llhd.const 0 : i5
    %103 = llhd.sig "103" %102 : i5
    %104 = llhd.const 0 : i32
    %105 = llhd.sig "105" %104 : i32
    %106 = llhd.const 0 : i64
    %107 = llhd.sig "107" %106 : i64
    %108 = llhd.const 0 : i64
    %109 = llhd.sig "109" %108 : i64
    %110 = llhd.const 0 : i64
    %111 = llhd.sig "111" %110 : i64
    %112 = llhd.const 0 : i1
    %113 = llhd.sig "113" %112 : i1
    %114 = llhd.const 0 : i1
    %115 = llhd.sig "115" %114 : i1
    %116 = llhd.const 0 : i64
    %117 = llhd.sig "117" %116 : i64
    %118 = llhd.const 0 : i5
    %119 = llhd.sig "119" %118 : i5
    %120 = llhd.const 0 : i1
    %121 = llhd.sig "121" %120 : i1
    %122 = llhd.const 0 : i1
    %123 = llhd.sig "123" %122 : i1
    %124 = llhd.const 0 : i1
    %125 = llhd.sig "125" %124 : i1
    %data_qready_i1 = llhd.prb %data_qready_i : !llhd.sig<i1>
    %126 = llhd.const 0 : i1
    %127 = llhd.sig "127" %126 : i1
    %128 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %127, %data_qready_i1 after %128 : !llhd.sig<i1>
    %data_pdata_i1 = llhd.prb %data_pdata_i : !llhd.sig<i64>
    %129 = llhd.const 0 : i64
    %130 = llhd.sig "130" %129 : i64
    %131 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %130, %data_pdata_i1 after %131 : !llhd.sig<i64>
    %data_perror_i1 = llhd.prb %data_perror_i : !llhd.sig<i1>
    %132 = llhd.const 0 : i1
    %133 = llhd.sig "133" %132 : i1
    %134 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %133, %data_perror_i1 after %134 : !llhd.sig<i1>
    %data_pvalid_i1 = llhd.prb %data_pvalid_i : !llhd.sig<i1>
    %135 = llhd.const 0 : i1
    %136 = llhd.sig "136" %135 : i1
    %137 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %136, %data_pvalid_i1 after %137 : !llhd.sig<i1>
    %138 = llhd.const 0 : i1
    %139 = llhd.sig "139" %138 : i1
    %140 = llhd.const 0 : i3
    %141 = llhd.sig "141" %140 : i3
    %142 = llhd.const 0 : i1
    %143 = llhd.const 0 : i1
    %144 = llhd.const 0 : i1
    %145 = llhd.const 0 : i1
    %146 = llhd.const 0 : i1
    %147 = llhd.tuple %142, %143, %144, %145, %146 : tuple<i1, i1, i1, i1, i1>
    %148 = llhd.sig "148" %147 : tuple<i1, i1, i1, i1, i1>
    %149 = llhd.const 0 : i1
    %150 = llhd.const 0 : i1
    %151 = llhd.const 0 : i1
    %152 = llhd.const 0 : i1
    %153 = llhd.tuple %149, %150, %151, %152 : tuple<i1, i1, i1, i1>
    %154 = llhd.sig "154" %153 : tuple<i1, i1, i1, i1>
    llhd.inst "inst" @snitch.param1(%85, %88, %92, %95, %98, %115, %117, %119, %121, %123, %127, %130, %133, %136, %139, %148) -> (%inst_addr_o, %inst_valid_o, %101, %103, %105, %107, %109, %111, %113, %125, %data_qaddr_o, %data_qwrite_o, %data_qamo_o, %data_qdata_o, %data_qstrb_o, %data_qvalid_o, %data_pready_o, %141, %154) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i5>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<tuple<i1, i1, i1, i1, i1>>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i5>, !llhd.sig<i32>, !llhd.sig<i64>, !llhd.sig<i64>, !llhd.sig<i64>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i64>, !llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<tuple<i1, i1, i1, i1>>)
    llhd.inst "inst1" @snitch_tb.always.272.0(%clk_i, %data_qvalid_o, %data_qready_i, %data_pvalid_i, %data_pready_o, %data_resp_pending) -> () : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>) -> ()
    llhd.inst "inst2" @snitch_tb.initial.277.0() -> (%clk_i, %rst_i) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
