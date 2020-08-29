llhd.proc @rr_arb_tree.param1.always_ff.639.1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %rr_d: !llhd.sig<i3>) -> (%rr_q: !llhd.sig<i3> ) {
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
    %8 = llhd.const 0 : i3
    %9 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %flush_i.prb = llhd.prb %flush_i : !llhd.sig<i1>
    %10 = llhd.neq %flush_i.prb, %0 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    llhd.drv %rr_q, %8 after %9 : !llhd.sig<i3>
    br ^init
^if_false1:
    %rr_d.prb = llhd.prb %rr_d : !llhd.sig<i3>
    llhd.drv %rr_q, %rr_d.prb after %9 : !llhd.sig<i3>
    br ^init
^if_true1:
    llhd.drv %rr_q, %8 after %9 : !llhd.sig<i3>
    br ^init
}

llhd.proc @rr_arb_tree.param1.initial.1529.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @rr_arb_tree.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %rr_i: !llhd.sig<i3>, %req_i: !llhd.sig<i8>, %data_i: !llhd.sig<!llhd.array<32xi8>>, %gnt_i: !llhd.sig<i1>) -> (%gnt_o: !llhd.sig<i8> , %req_o: !llhd.sig<i1> , %data_o: !llhd.sig<i32> , %idx_o: !llhd.sig<i3> ) {
    %0 = llhd.const 0 : i3
    %1 = llhd.array %0, %0, %0, %0, %0, %0, %0 : !llhd.array<7xi3>
    %index_nodes = llhd.sig "index_nodes" %1 : !llhd.array<7xi3>
    %2 = llhd.const 0 : i7
    %3 = llhd.array %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2, %2 : !llhd.array<32xi7>
    %data_nodes = llhd.sig "data_nodes" %3 : !llhd.array<32xi7>
    %gnt_nodes = llhd.sig "gnt_nodes" %2 : i7
    %req_nodes = llhd.sig "req_nodes" %2 : i7
    %rr_q = llhd.sig "rr_q" %0 : i3
    %4 = llhd.const 0 : i8
    %req_d = llhd.sig "req_d" %4 : i8
    %req_nodes.prb = llhd.prb %req_nodes : !llhd.sig<i7>
    %5 = llhd.extract_slice %req_nodes.prb, 0 : i7 -> i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %req_o, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const 0 : i32
    %data_nodes.prb = llhd.prb %data_nodes : !llhd.sig<!llhd.array<32xi7>>
    %8 = llhd.extract_element %data_nodes.prb, 0 : !llhd.array<32xi7> -> i7
    %zext = llhd.insert_slice %7, %8, 0 : i32, i7
    llhd.drv %data_o, %zext after %6 : !llhd.sig<i32>
    %index_nodes.prb = llhd.prb %index_nodes : !llhd.sig<!llhd.array<7xi3>>
    %9 = llhd.extract_element %index_nodes.prb, 0 : !llhd.array<7xi3> -> i3
    llhd.drv %idx_o, %9 after %6 : !llhd.sig<i3>
    %10 = llhd.extract_slice %gnt_nodes, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %gnt_i.prb = llhd.prb %gnt_i : !llhd.sig<i1>
    llhd.drv %10, %gnt_i.prb after %6 : !llhd.sig<i1>
    %rr_d = llhd.sig "rr_d" %0 : i3
    %11 = llhd.const 0 : i1
    %12 = llhd.neq %gnt_i.prb, %11 : i1
    %req_o.prb = llhd.prb %req_o : !llhd.sig<i1>
    %13 = llhd.neq %req_o.prb, %11 : i1
    %14 = llhd.and %12, %13 : i1
    %15 = llhd.neq %14, %11 : i1
    %rr_q.prb = llhd.prb %rr_q : !llhd.sig<i3>
    %zext1 = llhd.insert_slice %7, %rr_q.prb, 0 : i32, i3
    %16 = llhd.const 7 : i32
    %17 = llhd.eq %zext1, %16 : i32
    %18 = llhd.neq %17, %11 : i1
    %19 = llhd.const 1 : i3
    %20 = addi %rr_q.prb, %19 : i3
    %21 = llhd.array %20, %0 : !llhd.array<2xi3>
    %22 = llhd.dyn_extract_element %21, %18 : (!llhd.array<2xi3>, i1) -> i3
    %23 = llhd.array %rr_q.prb, %22 : !llhd.array<2xi3>
    %24 = llhd.dyn_extract_element %23, %15 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %rr_d, %24 after %6 : !llhd.sig<i3>
    %req_i.prb = llhd.prb %req_i : !llhd.sig<i8>
    llhd.drv %req_d, %req_i.prb after %6 : !llhd.sig<i8>
    llhd.inst "inst" @rr_arb_tree.param1.always_ff.639.1(%clk_i, %rst_ni, %flush_i, %rr_d) -> (%rr_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>) -> (!llhd.sig<i3>)
    %sel = llhd.sig "sel" %11 : i1
    %25 = llhd.extract_slice %req_nodes, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %26 = llhd.extract_slice %req_nodes.prb, 1 : i7 -> i6
    %27 = llhd.insert_slice %2, %26, 0 : i7, i6
    %28 = llhd.extract_slice %27, 0 : i7 -> i1
    %29 = llhd.extract_slice %req_nodes.prb, 2 : i7 -> i5
    %30 = llhd.insert_slice %2, %29, 0 : i7, i5
    %31 = llhd.extract_slice %30, 0 : i7 -> i1
    %32 = llhd.or %28, %31 : i1
    llhd.drv %25, %32 after %6 : !llhd.sig<i1>
    %33 = llhd.not %28 : i1
    %34 = llhd.extract_slice %rr_q.prb, 2 : i3 -> i1
    %35 = llhd.insert_slice %0, %34, 0 : i3, i1
    %36 = llhd.extract_slice %35, 0 : i3 -> i1
    %37 = llhd.and %31, %36 : i1
    %38 = llhd.or %33, %37 : i1
    llhd.drv %sel, %38 after %6 : !llhd.sig<i1>
    %39 = llhd.extract_element %index_nodes, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb = llhd.prb %sel : !llhd.sig<i1>
    %40 = llhd.neq %sel.prb, %11 : i1
    %41 = llhd.array_uniform %0 : !llhd.array<7xi3>
    %42 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<2xi3>
    %43 = llhd.extract_slice %index_nodes.prb, 2 : !llhd.array<7xi3> -> !llhd.array<5xi3>
    %44 = llhd.insert_slice %41, %42, 5 : !llhd.array<7xi3>, !llhd.array<2xi3>
    %45 = llhd.insert_slice %44, %43, 0 : !llhd.array<7xi3>, !llhd.array<5xi3>
    %46 = llhd.extract_element %45, 0 : !llhd.array<7xi3> -> i3
    %47 = llhd.extract_slice %46, 0 : i3 -> i2
    %48 = llhd.insert_slice %0, %47, 0 : i3, i2
    %49 = llhd.const 1 : i1
    %concat = llhd.insert_slice %48, %49, 2 : i3, i1
    %50 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<1xi3>
    %51 = llhd.extract_slice %index_nodes.prb, 1 : !llhd.array<7xi3> -> !llhd.array<6xi3>
    %52 = llhd.insert_slice %41, %50, 6 : !llhd.array<7xi3>, !llhd.array<1xi3>
    %53 = llhd.insert_slice %52, %51, 0 : !llhd.array<7xi3>, !llhd.array<6xi3>
    %54 = llhd.extract_element %53, 0 : !llhd.array<7xi3> -> i3
    %55 = llhd.extract_slice %54, 0 : i3 -> i2
    %56 = llhd.insert_slice %0, %55, 0 : i3, i2
    %concat1 = llhd.insert_slice %56, %11, 2 : i3, i1
    %57 = llhd.array %concat1, %concat : !llhd.array<2xi3>
    %58 = llhd.dyn_extract_element %57, %40 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %39, %58 after %6 : !llhd.sig<i3>
    %59 = llhd.extract_element %data_nodes, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %60 = llhd.array_uniform %2 : !llhd.array<32xi7>
    %61 = llhd.extract_slice %60, 0 : !llhd.array<32xi7> -> !llhd.array<2xi7>
    %62 = llhd.extract_slice %data_nodes.prb, 2 : !llhd.array<32xi7> -> !llhd.array<30xi7>
    %63 = llhd.insert_slice %60, %61, 30 : !llhd.array<32xi7>, !llhd.array<2xi7>
    %64 = llhd.insert_slice %63, %62, 0 : !llhd.array<32xi7>, !llhd.array<30xi7>
    %65 = llhd.extract_element %64, 0 : !llhd.array<32xi7> -> i7
    %66 = llhd.extract_slice %60, 0 : !llhd.array<32xi7> -> !llhd.array<1xi7>
    %67 = llhd.extract_slice %data_nodes.prb, 1 : !llhd.array<32xi7> -> !llhd.array<31xi7>
    %68 = llhd.insert_slice %60, %66, 31 : !llhd.array<32xi7>, !llhd.array<1xi7>
    %69 = llhd.insert_slice %68, %67, 0 : !llhd.array<32xi7>, !llhd.array<31xi7>
    %70 = llhd.extract_element %69, 0 : !llhd.array<32xi7> -> i7
    %71 = llhd.array %70, %65 : !llhd.array<2xi7>
    %72 = llhd.dyn_extract_element %71, %40 : (!llhd.array<2xi7>, i1) -> i7
    llhd.drv %59, %72 after %6 : !llhd.sig<i7>
    %73 = llhd.const 1 : i32
    %74 = llhd.sig "74" %2 : i7
    %75 = llhd.shr %gnt_nodes, %74, %73 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %76 = llhd.extract_slice %75, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %gnt_nodes.prb = llhd.prb %gnt_nodes : !llhd.sig<i7>
    %77 = llhd.extract_slice %gnt_nodes.prb, 0 : i7 -> i1
    %78 = llhd.not %sel.prb : i1
    %79 = llhd.and %77, %78 : i1
    llhd.drv %76, %79 after %6 : !llhd.sig<i1>
    %80 = llhd.const 2 : i32
    %81 = llhd.sig "81" %2 : i7
    %82 = llhd.shr %gnt_nodes, %81, %80 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %83 = llhd.extract_slice %82, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %84 = llhd.and %77, %sel.prb : i1
    llhd.drv %83, %84 after %6 : !llhd.sig<i1>
    %sel1 = llhd.sig "sel1" %11 : i1
    %85 = llhd.sig "85" %2 : i7
    %86 = llhd.shr %req_nodes, %85, %73 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %87 = llhd.extract_slice %86, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %88 = llhd.extract_slice %req_nodes.prb, 3 : i7 -> i4
    %89 = llhd.insert_slice %2, %88, 0 : i7, i4
    %90 = llhd.extract_slice %89, 0 : i7 -> i1
    %91 = llhd.extract_slice %req_nodes.prb, 4 : i7 -> i3
    %92 = llhd.insert_slice %2, %91, 0 : i7, i3
    %93 = llhd.extract_slice %92, 0 : i7 -> i1
    %94 = llhd.or %90, %93 : i1
    llhd.drv %87, %94 after %6 : !llhd.sig<i1>
    %95 = llhd.not %90 : i1
    %96 = llhd.extract_slice %rr_q.prb, 1 : i3 -> i2
    %97 = llhd.insert_slice %0, %96, 0 : i3, i2
    %98 = llhd.extract_slice %97, 0 : i3 -> i1
    %99 = llhd.and %93, %98 : i1
    %100 = llhd.or %95, %99 : i1
    llhd.drv %sel1, %100 after %6 : !llhd.sig<i1>
    %101 = llhd.sig "101" %41 : !llhd.array<7xi3>
    %102 = llhd.shr %index_nodes, %101, %73 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %103 = llhd.extract_element %102, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb1 = llhd.prb %sel1 : !llhd.sig<i1>
    %104 = llhd.neq %sel.prb1, %11 : i1
    %105 = llhd.const 0 : i2
    %106 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<4xi3>
    %107 = llhd.extract_slice %index_nodes.prb, 4 : !llhd.array<7xi3> -> !llhd.array<3xi3>
    %108 = llhd.insert_slice %41, %106, 3 : !llhd.array<7xi3>, !llhd.array<4xi3>
    %109 = llhd.insert_slice %108, %107, 0 : !llhd.array<7xi3>, !llhd.array<3xi3>
    %110 = llhd.extract_element %109, 0 : !llhd.array<7xi3> -> i3
    %111 = llhd.extract_slice %110, 0 : i3 -> i1
    %112 = llhd.insert_slice %105, %111, 0 : i2, i1
    %concat2 = llhd.insert_slice %112, %49, 1 : i2, i1
    %zext2 = llhd.insert_slice %0, %concat2, 0 : i3, i2
    %113 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<3xi3>
    %114 = llhd.extract_slice %index_nodes.prb, 3 : !llhd.array<7xi3> -> !llhd.array<4xi3>
    %115 = llhd.insert_slice %41, %113, 4 : !llhd.array<7xi3>, !llhd.array<3xi3>
    %116 = llhd.insert_slice %115, %114, 0 : !llhd.array<7xi3>, !llhd.array<4xi3>
    %117 = llhd.extract_element %116, 0 : !llhd.array<7xi3> -> i3
    %118 = llhd.extract_slice %117, 0 : i3 -> i1
    %119 = llhd.insert_slice %105, %118, 0 : i2, i1
    %concat3 = llhd.insert_slice %119, %11, 1 : i2, i1
    %zext3 = llhd.insert_slice %0, %concat3, 0 : i3, i2
    %120 = llhd.array %zext3, %zext2 : !llhd.array<2xi3>
    %121 = llhd.dyn_extract_element %120, %104 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %103, %121 after %6 : !llhd.sig<i3>
    %122 = llhd.sig "122" %60 : !llhd.array<32xi7>
    %123 = llhd.shr %data_nodes, %122, %73 : (!llhd.sig<!llhd.array<32xi7>>, !llhd.sig<!llhd.array<32xi7>>, i32) -> !llhd.sig<!llhd.array<32xi7>>
    %124 = llhd.extract_element %123, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %125 = llhd.extract_slice %60, 0 : !llhd.array<32xi7> -> !llhd.array<4xi7>
    %126 = llhd.extract_slice %data_nodes.prb, 4 : !llhd.array<32xi7> -> !llhd.array<28xi7>
    %127 = llhd.insert_slice %60, %125, 28 : !llhd.array<32xi7>, !llhd.array<4xi7>
    %128 = llhd.insert_slice %127, %126, 0 : !llhd.array<32xi7>, !llhd.array<28xi7>
    %129 = llhd.extract_element %128, 0 : !llhd.array<32xi7> -> i7
    %130 = llhd.extract_slice %60, 0 : !llhd.array<32xi7> -> !llhd.array<3xi7>
    %131 = llhd.extract_slice %data_nodes.prb, 3 : !llhd.array<32xi7> -> !llhd.array<29xi7>
    %132 = llhd.insert_slice %60, %130, 29 : !llhd.array<32xi7>, !llhd.array<3xi7>
    %133 = llhd.insert_slice %132, %131, 0 : !llhd.array<32xi7>, !llhd.array<29xi7>
    %134 = llhd.extract_element %133, 0 : !llhd.array<32xi7> -> i7
    %135 = llhd.array %134, %129 : !llhd.array<2xi7>
    %136 = llhd.dyn_extract_element %135, %104 : (!llhd.array<2xi7>, i1) -> i7
    llhd.drv %124, %136 after %6 : !llhd.sig<i7>
    %137 = llhd.const 3 : i32
    %138 = llhd.sig "138" %2 : i7
    %139 = llhd.shr %gnt_nodes, %138, %137 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %140 = llhd.extract_slice %139, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %141 = llhd.extract_slice %gnt_nodes.prb, 1 : i7 -> i6
    %142 = llhd.insert_slice %2, %141, 0 : i7, i6
    %143 = llhd.extract_slice %142, 0 : i7 -> i1
    %144 = llhd.not %sel.prb1 : i1
    %145 = llhd.and %143, %144 : i1
    llhd.drv %140, %145 after %6 : !llhd.sig<i1>
    %146 = llhd.const 4 : i32
    %147 = llhd.sig "147" %2 : i7
    %148 = llhd.shr %gnt_nodes, %147, %146 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %149 = llhd.extract_slice %148, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %150 = llhd.and %143, %sel.prb1 : i1
    llhd.drv %149, %150 after %6 : !llhd.sig<i1>
    %sel2 = llhd.sig "sel2" %11 : i1
    %151 = llhd.sig "151" %2 : i7
    %152 = llhd.shr %req_nodes, %151, %80 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %153 = llhd.extract_slice %152, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %154 = llhd.extract_slice %req_nodes.prb, 5 : i7 -> i2
    %155 = llhd.insert_slice %2, %154, 0 : i7, i2
    %156 = llhd.extract_slice %155, 0 : i7 -> i1
    %157 = llhd.extract_slice %req_nodes.prb, 6 : i7 -> i1
    %158 = llhd.insert_slice %2, %157, 0 : i7, i1
    %159 = llhd.extract_slice %158, 0 : i7 -> i1
    %160 = llhd.or %156, %159 : i1
    llhd.drv %153, %160 after %6 : !llhd.sig<i1>
    %161 = llhd.not %156 : i1
    %162 = llhd.and %159, %98 : i1
    %163 = llhd.or %161, %162 : i1
    llhd.drv %sel2, %163 after %6 : !llhd.sig<i1>
    %164 = llhd.sig "164" %41 : !llhd.array<7xi3>
    %165 = llhd.shr %index_nodes, %164, %80 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %166 = llhd.extract_element %165, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb2 = llhd.prb %sel2 : !llhd.sig<i1>
    %167 = llhd.neq %sel.prb2, %11 : i1
    %168 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<6xi3>
    %169 = llhd.extract_slice %index_nodes.prb, 6 : !llhd.array<7xi3> -> !llhd.array<1xi3>
    %170 = llhd.insert_slice %41, %168, 1 : !llhd.array<7xi3>, !llhd.array<6xi3>
    %171 = llhd.insert_slice %170, %169, 0 : !llhd.array<7xi3>, !llhd.array<1xi3>
    %172 = llhd.extract_element %171, 0 : !llhd.array<7xi3> -> i3
    %173 = llhd.extract_slice %172, 0 : i3 -> i1
    %174 = llhd.insert_slice %105, %173, 0 : i2, i1
    %concat4 = llhd.insert_slice %174, %49, 1 : i2, i1
    %zext4 = llhd.insert_slice %0, %concat4, 0 : i3, i2
    %175 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<5xi3>
    %176 = llhd.extract_slice %index_nodes.prb, 5 : !llhd.array<7xi3> -> !llhd.array<2xi3>
    %177 = llhd.insert_slice %41, %175, 2 : !llhd.array<7xi3>, !llhd.array<5xi3>
    %178 = llhd.insert_slice %177, %176, 0 : !llhd.array<7xi3>, !llhd.array<2xi3>
    %179 = llhd.extract_element %178, 0 : !llhd.array<7xi3> -> i3
    %180 = llhd.extract_slice %179, 0 : i3 -> i1
    %181 = llhd.insert_slice %105, %180, 0 : i2, i1
    %concat5 = llhd.insert_slice %181, %11, 1 : i2, i1
    %zext5 = llhd.insert_slice %0, %concat5, 0 : i3, i2
    %182 = llhd.array %zext5, %zext4 : !llhd.array<2xi3>
    %183 = llhd.dyn_extract_element %182, %167 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %166, %183 after %6 : !llhd.sig<i3>
    %184 = llhd.sig "184" %60 : !llhd.array<32xi7>
    %185 = llhd.shr %data_nodes, %184, %80 : (!llhd.sig<!llhd.array<32xi7>>, !llhd.sig<!llhd.array<32xi7>>, i32) -> !llhd.sig<!llhd.array<32xi7>>
    %186 = llhd.extract_element %185, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %187 = llhd.extract_slice %60, 0 : !llhd.array<32xi7> -> !llhd.array<6xi7>
    %188 = llhd.extract_slice %data_nodes.prb, 6 : !llhd.array<32xi7> -> !llhd.array<26xi7>
    %189 = llhd.insert_slice %60, %187, 26 : !llhd.array<32xi7>, !llhd.array<6xi7>
    %190 = llhd.insert_slice %189, %188, 0 : !llhd.array<32xi7>, !llhd.array<26xi7>
    %191 = llhd.extract_element %190, 0 : !llhd.array<32xi7> -> i7
    %192 = llhd.extract_slice %60, 0 : !llhd.array<32xi7> -> !llhd.array<5xi7>
    %193 = llhd.extract_slice %data_nodes.prb, 5 : !llhd.array<32xi7> -> !llhd.array<27xi7>
    %194 = llhd.insert_slice %60, %192, 27 : !llhd.array<32xi7>, !llhd.array<5xi7>
    %195 = llhd.insert_slice %194, %193, 0 : !llhd.array<32xi7>, !llhd.array<27xi7>
    %196 = llhd.extract_element %195, 0 : !llhd.array<32xi7> -> i7
    %197 = llhd.array %196, %191 : !llhd.array<2xi7>
    %198 = llhd.dyn_extract_element %197, %167 : (!llhd.array<2xi7>, i1) -> i7
    llhd.drv %186, %198 after %6 : !llhd.sig<i7>
    %199 = llhd.const 5 : i32
    %200 = llhd.sig "200" %2 : i7
    %201 = llhd.shr %gnt_nodes, %200, %199 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %202 = llhd.extract_slice %201, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %203 = llhd.extract_slice %gnt_nodes.prb, 2 : i7 -> i5
    %204 = llhd.insert_slice %2, %203, 0 : i7, i5
    %205 = llhd.extract_slice %204, 0 : i7 -> i1
    %206 = llhd.not %sel.prb2 : i1
    %207 = llhd.and %205, %206 : i1
    llhd.drv %202, %207 after %6 : !llhd.sig<i1>
    %208 = llhd.const 6 : i32
    %209 = llhd.sig "209" %2 : i7
    %210 = llhd.shr %gnt_nodes, %209, %208 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %211 = llhd.extract_slice %210, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %212 = llhd.and %205, %sel.prb2 : i1
    llhd.drv %211, %212 after %6 : !llhd.sig<i1>
    %sel3 = llhd.sig "sel3" %11 : i1
    %213 = llhd.sig "213" %2 : i7
    %214 = llhd.shr %req_nodes, %213, %137 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %215 = llhd.extract_slice %214, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %req_d.prb = llhd.prb %req_d : !llhd.sig<i8>
    %216 = llhd.extract_slice %req_d.prb, 0 : i8 -> i1
    %217 = llhd.extract_slice %req_d.prb, 1 : i8 -> i7
    %218 = llhd.insert_slice %4, %217, 0 : i8, i7
    %219 = llhd.extract_slice %218, 0 : i8 -> i1
    %220 = llhd.or %216, %219 : i1
    llhd.drv %215, %220 after %6 : !llhd.sig<i1>
    %221 = llhd.not %216 : i1
    %222 = llhd.extract_slice %rr_q.prb, 0 : i3 -> i1
    %223 = llhd.and %219, %222 : i1
    %224 = llhd.or %221, %223 : i1
    llhd.drv %sel3, %224 after %6 : !llhd.sig<i1>
    %225 = llhd.sig "225" %41 : !llhd.array<7xi3>
    %226 = llhd.shr %index_nodes, %225, %137 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %227 = llhd.extract_element %226, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb3 = llhd.prb %sel3 : !llhd.sig<i1>
    %zext6 = llhd.insert_slice %0, %sel.prb3, 0 : i3, i1
    llhd.drv %227, %zext6 after %6 : !llhd.sig<i3>
    %228 = llhd.sig "228" %60 : !llhd.array<32xi7>
    %229 = llhd.shr %data_nodes, %228, %137 : (!llhd.sig<!llhd.array<32xi7>>, !llhd.sig<!llhd.array<32xi7>>, i32) -> !llhd.sig<!llhd.array<32xi7>>
    %230 = llhd.extract_element %229, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %231 = llhd.neq %sel.prb3, %11 : i1
    %data_i.prb = llhd.prb %data_i : !llhd.sig<!llhd.array<32xi8>>
    %232 = llhd.array_uniform %4 : !llhd.array<32xi8>
    %233 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<1xi8>
    %234 = llhd.extract_slice %data_i.prb, 1 : !llhd.array<32xi8> -> !llhd.array<31xi8>
    %235 = llhd.insert_slice %232, %233, 31 : !llhd.array<32xi8>, !llhd.array<1xi8>
    %236 = llhd.insert_slice %235, %234, 0 : !llhd.array<32xi8>, !llhd.array<31xi8>
    %237 = llhd.extract_element %236, 0 : !llhd.array<32xi8> -> i8
    %238 = llhd.extract_element %data_i.prb, 0 : !llhd.array<32xi8> -> i8
    %239 = llhd.array %238, %237 : !llhd.array<2xi8>
    %240 = llhd.dyn_extract_element %239, %231 : (!llhd.array<2xi8>, i1) -> i8
    %241 = llhd.extract_slice %240, 0 : i8 -> i7
    llhd.drv %230, %241 after %6 : !llhd.sig<i7>
    %242 = llhd.extract_slice %gnt_o, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %243 = llhd.extract_slice %gnt_nodes.prb, 3 : i7 -> i4
    %244 = llhd.insert_slice %2, %243, 0 : i7, i4
    %245 = llhd.extract_slice %244, 0 : i7 -> i1
    %246 = llhd.and %245, %216 : i1
    %247 = llhd.not %sel.prb3 : i1
    %248 = llhd.and %246, %247 : i1
    llhd.drv %242, %248 after %6 : !llhd.sig<i1>
    %249 = llhd.sig "249" %4 : i8
    %250 = llhd.shr %gnt_o, %249, %73 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %251 = llhd.extract_slice %250, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %252 = llhd.and %245, %219 : i1
    %253 = llhd.and %252, %sel.prb3 : i1
    llhd.drv %251, %253 after %6 : !llhd.sig<i1>
    %sel4 = llhd.sig "sel4" %11 : i1
    %254 = llhd.sig "254" %2 : i7
    %255 = llhd.shr %req_nodes, %254, %146 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %256 = llhd.extract_slice %255, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %257 = llhd.extract_slice %req_d.prb, 2 : i8 -> i6
    %258 = llhd.insert_slice %4, %257, 0 : i8, i6
    %259 = llhd.extract_slice %258, 0 : i8 -> i1
    %260 = llhd.extract_slice %req_d.prb, 3 : i8 -> i5
    %261 = llhd.insert_slice %4, %260, 0 : i8, i5
    %262 = llhd.extract_slice %261, 0 : i8 -> i1
    %263 = llhd.or %259, %262 : i1
    llhd.drv %256, %263 after %6 : !llhd.sig<i1>
    %264 = llhd.not %259 : i1
    %265 = llhd.and %262, %222 : i1
    %266 = llhd.or %264, %265 : i1
    llhd.drv %sel4, %266 after %6 : !llhd.sig<i1>
    %267 = llhd.sig "267" %41 : !llhd.array<7xi3>
    %268 = llhd.shr %index_nodes, %267, %146 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %269 = llhd.extract_element %268, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb4 = llhd.prb %sel4 : !llhd.sig<i1>
    %zext7 = llhd.insert_slice %0, %sel.prb4, 0 : i3, i1
    llhd.drv %269, %zext7 after %6 : !llhd.sig<i3>
    %270 = llhd.sig "270" %60 : !llhd.array<32xi7>
    %271 = llhd.shr %data_nodes, %270, %146 : (!llhd.sig<!llhd.array<32xi7>>, !llhd.sig<!llhd.array<32xi7>>, i32) -> !llhd.sig<!llhd.array<32xi7>>
    %272 = llhd.extract_element %271, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %273 = llhd.neq %sel.prb4, %11 : i1
    %274 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<3xi8>
    %275 = llhd.extract_slice %data_i.prb, 3 : !llhd.array<32xi8> -> !llhd.array<29xi8>
    %276 = llhd.insert_slice %232, %274, 29 : !llhd.array<32xi8>, !llhd.array<3xi8>
    %277 = llhd.insert_slice %276, %275, 0 : !llhd.array<32xi8>, !llhd.array<29xi8>
    %278 = llhd.extract_element %277, 0 : !llhd.array<32xi8> -> i8
    %279 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<2xi8>
    %280 = llhd.extract_slice %data_i.prb, 2 : !llhd.array<32xi8> -> !llhd.array<30xi8>
    %281 = llhd.insert_slice %232, %279, 30 : !llhd.array<32xi8>, !llhd.array<2xi8>
    %282 = llhd.insert_slice %281, %280, 0 : !llhd.array<32xi8>, !llhd.array<30xi8>
    %283 = llhd.extract_element %282, 0 : !llhd.array<32xi8> -> i8
    %284 = llhd.array %283, %278 : !llhd.array<2xi8>
    %285 = llhd.dyn_extract_element %284, %273 : (!llhd.array<2xi8>, i1) -> i8
    %286 = llhd.extract_slice %285, 0 : i8 -> i7
    llhd.drv %272, %286 after %6 : !llhd.sig<i7>
    %287 = llhd.sig "287" %4 : i8
    %288 = llhd.shr %gnt_o, %287, %80 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %289 = llhd.extract_slice %288, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %290 = llhd.extract_slice %gnt_nodes.prb, 4 : i7 -> i3
    %291 = llhd.insert_slice %2, %290, 0 : i7, i3
    %292 = llhd.extract_slice %291, 0 : i7 -> i1
    %293 = llhd.and %292, %259 : i1
    %294 = llhd.not %sel.prb4 : i1
    %295 = llhd.and %293, %294 : i1
    llhd.drv %289, %295 after %6 : !llhd.sig<i1>
    %296 = llhd.sig "296" %4 : i8
    %297 = llhd.shr %gnt_o, %296, %137 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %298 = llhd.extract_slice %297, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %299 = llhd.and %292, %262 : i1
    %300 = llhd.and %299, %sel.prb4 : i1
    llhd.drv %298, %300 after %6 : !llhd.sig<i1>
    %sel5 = llhd.sig "sel5" %11 : i1
    %301 = llhd.sig "301" %2 : i7
    %302 = llhd.shr %req_nodes, %301, %199 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %303 = llhd.extract_slice %302, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %304 = llhd.extract_slice %req_d.prb, 4 : i8 -> i4
    %305 = llhd.insert_slice %4, %304, 0 : i8, i4
    %306 = llhd.extract_slice %305, 0 : i8 -> i1
    %307 = llhd.extract_slice %req_d.prb, 5 : i8 -> i3
    %308 = llhd.insert_slice %4, %307, 0 : i8, i3
    %309 = llhd.extract_slice %308, 0 : i8 -> i1
    %310 = llhd.or %306, %309 : i1
    llhd.drv %303, %310 after %6 : !llhd.sig<i1>
    %311 = llhd.not %306 : i1
    %312 = llhd.and %309, %222 : i1
    %313 = llhd.or %311, %312 : i1
    llhd.drv %sel5, %313 after %6 : !llhd.sig<i1>
    %314 = llhd.sig "314" %41 : !llhd.array<7xi3>
    %315 = llhd.shr %index_nodes, %314, %199 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %316 = llhd.extract_element %315, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb5 = llhd.prb %sel5 : !llhd.sig<i1>
    %zext8 = llhd.insert_slice %0, %sel.prb5, 0 : i3, i1
    llhd.drv %316, %zext8 after %6 : !llhd.sig<i3>
    %317 = llhd.sig "317" %60 : !llhd.array<32xi7>
    %318 = llhd.shr %data_nodes, %317, %199 : (!llhd.sig<!llhd.array<32xi7>>, !llhd.sig<!llhd.array<32xi7>>, i32) -> !llhd.sig<!llhd.array<32xi7>>
    %319 = llhd.extract_element %318, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %320 = llhd.neq %sel.prb5, %11 : i1
    %321 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<5xi8>
    %322 = llhd.extract_slice %data_i.prb, 5 : !llhd.array<32xi8> -> !llhd.array<27xi8>
    %323 = llhd.insert_slice %232, %321, 27 : !llhd.array<32xi8>, !llhd.array<5xi8>
    %324 = llhd.insert_slice %323, %322, 0 : !llhd.array<32xi8>, !llhd.array<27xi8>
    %325 = llhd.extract_element %324, 0 : !llhd.array<32xi8> -> i8
    %326 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<4xi8>
    %327 = llhd.extract_slice %data_i.prb, 4 : !llhd.array<32xi8> -> !llhd.array<28xi8>
    %328 = llhd.insert_slice %232, %326, 28 : !llhd.array<32xi8>, !llhd.array<4xi8>
    %329 = llhd.insert_slice %328, %327, 0 : !llhd.array<32xi8>, !llhd.array<28xi8>
    %330 = llhd.extract_element %329, 0 : !llhd.array<32xi8> -> i8
    %331 = llhd.array %330, %325 : !llhd.array<2xi8>
    %332 = llhd.dyn_extract_element %331, %320 : (!llhd.array<2xi8>, i1) -> i8
    %333 = llhd.extract_slice %332, 0 : i8 -> i7
    llhd.drv %319, %333 after %6 : !llhd.sig<i7>
    %334 = llhd.sig "334" %4 : i8
    %335 = llhd.shr %gnt_o, %334, %146 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %336 = llhd.extract_slice %335, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %337 = llhd.extract_slice %gnt_nodes.prb, 5 : i7 -> i2
    %338 = llhd.insert_slice %2, %337, 0 : i7, i2
    %339 = llhd.extract_slice %338, 0 : i7 -> i1
    %340 = llhd.and %339, %306 : i1
    %341 = llhd.not %sel.prb5 : i1
    %342 = llhd.and %340, %341 : i1
    llhd.drv %336, %342 after %6 : !llhd.sig<i1>
    %343 = llhd.sig "343" %4 : i8
    %344 = llhd.shr %gnt_o, %343, %199 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %345 = llhd.extract_slice %344, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %346 = llhd.and %339, %309 : i1
    %347 = llhd.and %346, %sel.prb5 : i1
    llhd.drv %345, %347 after %6 : !llhd.sig<i1>
    %sel6 = llhd.sig "sel6" %11 : i1
    %348 = llhd.sig "348" %2 : i7
    %349 = llhd.shr %req_nodes, %348, %208 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %350 = llhd.extract_slice %349, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %351 = llhd.extract_slice %req_d.prb, 6 : i8 -> i2
    %352 = llhd.insert_slice %4, %351, 0 : i8, i2
    %353 = llhd.extract_slice %352, 0 : i8 -> i1
    %354 = llhd.extract_slice %req_d.prb, 7 : i8 -> i1
    %355 = llhd.insert_slice %4, %354, 0 : i8, i1
    %356 = llhd.extract_slice %355, 0 : i8 -> i1
    %357 = llhd.or %353, %356 : i1
    llhd.drv %350, %357 after %6 : !llhd.sig<i1>
    %358 = llhd.not %353 : i1
    %359 = llhd.and %356, %222 : i1
    %360 = llhd.or %358, %359 : i1
    llhd.drv %sel6, %360 after %6 : !llhd.sig<i1>
    %361 = llhd.sig "361" %41 : !llhd.array<7xi3>
    %362 = llhd.shr %index_nodes, %361, %208 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %363 = llhd.extract_element %362, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb6 = llhd.prb %sel6 : !llhd.sig<i1>
    %zext9 = llhd.insert_slice %0, %sel.prb6, 0 : i3, i1
    llhd.drv %363, %zext9 after %6 : !llhd.sig<i3>
    %364 = llhd.sig "364" %60 : !llhd.array<32xi7>
    %365 = llhd.shr %data_nodes, %364, %208 : (!llhd.sig<!llhd.array<32xi7>>, !llhd.sig<!llhd.array<32xi7>>, i32) -> !llhd.sig<!llhd.array<32xi7>>
    %366 = llhd.extract_element %365, 0 : !llhd.sig<!llhd.array<32xi7>> -> !llhd.sig<i7>
    %367 = llhd.neq %sel.prb6, %11 : i1
    %368 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<7xi8>
    %369 = llhd.extract_slice %data_i.prb, 7 : !llhd.array<32xi8> -> !llhd.array<25xi8>
    %370 = llhd.insert_slice %232, %368, 25 : !llhd.array<32xi8>, !llhd.array<7xi8>
    %371 = llhd.insert_slice %370, %369, 0 : !llhd.array<32xi8>, !llhd.array<25xi8>
    %372 = llhd.extract_element %371, 0 : !llhd.array<32xi8> -> i8
    %373 = llhd.extract_slice %232, 0 : !llhd.array<32xi8> -> !llhd.array<6xi8>
    %374 = llhd.extract_slice %data_i.prb, 6 : !llhd.array<32xi8> -> !llhd.array<26xi8>
    %375 = llhd.insert_slice %232, %373, 26 : !llhd.array<32xi8>, !llhd.array<6xi8>
    %376 = llhd.insert_slice %375, %374, 0 : !llhd.array<32xi8>, !llhd.array<26xi8>
    %377 = llhd.extract_element %376, 0 : !llhd.array<32xi8> -> i8
    %378 = llhd.array %377, %372 : !llhd.array<2xi8>
    %379 = llhd.dyn_extract_element %378, %367 : (!llhd.array<2xi8>, i1) -> i8
    %380 = llhd.extract_slice %379, 0 : i8 -> i7
    llhd.drv %366, %380 after %6 : !llhd.sig<i7>
    %381 = llhd.sig "381" %4 : i8
    %382 = llhd.shr %gnt_o, %381, %208 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %383 = llhd.extract_slice %382, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %384 = llhd.extract_slice %gnt_nodes.prb, 6 : i7 -> i1
    %385 = llhd.insert_slice %2, %384, 0 : i7, i1
    %386 = llhd.extract_slice %385, 0 : i7 -> i1
    %387 = llhd.and %386, %353 : i1
    %388 = llhd.not %sel.prb6 : i1
    %389 = llhd.and %387, %388 : i1
    llhd.drv %383, %389 after %6 : !llhd.sig<i1>
    %390 = llhd.sig "390" %4 : i8
    %391 = llhd.shr %gnt_o, %390, %16 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %392 = llhd.extract_slice %391, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %393 = llhd.and %386, %356 : i1
    %394 = llhd.and %393, %sel.prb6 : i1
    llhd.drv %392, %394 after %6 : !llhd.sig<i1>
    llhd.inst "inst1" @rr_arb_tree.param1.initial.1529.1() -> () : () -> ()
    // %395 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %gnt_o, %4 after %395 : !llhd.sig<i8>
}

llhd.proc @rr_arb_tree_tb.initial.1815.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %7 = llhd.const 5000000 : i32
    br ^loop_body(%7, %7 : i32, i32)
^loop_body(%8: i32, %9: i32):
    %10 = llhd.const 0 : i32
    %11 = llhd.neq %8, %10 : i32
    cond_br %11, ^loop_continue, ^loop_exit
^12:
    br ^loop_body(%8, %9 : i32, i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %13 = llhd.const 1 : i1
    %14 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %13 after %14 : !llhd.sig<i1>
    %15 = llhd.const 0 : i1
    %16 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %15 after %16 : !llhd.sig<i1>
    llhd.wait  for %16, ^12
}

llhd.entity @rr_arb_tree_tb() -> () {
    %0 = llhd.const 0 : i1
    %clk_i = llhd.sig "clk_i" %0 : i1
    %1 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %1 : i1
    %flush_i = llhd.sig "flush_i" %0 : i1
    %2 = llhd.const 0 : i3
    %rr_i = llhd.sig "rr_i" %2 : i3
    %3 = llhd.const 0 : i8
    %req_i = llhd.sig "req_i" %3 : i8
    %gnt_o = llhd.sig "gnt_o" %3 : i8
    %4 = llhd.const 0 : i32
    %5 = llhd.array %4, %4, %4, %4, %4, %4, %4, %4 : !llhd.array<8xi32>
    %data_i = llhd.sig "data_i" %5 : !llhd.array<8xi32>
    %gnt_i = llhd.sig "gnt_i" %0 : i1
    %req_o = llhd.sig "req_o" %0 : i1
    %data_o = llhd.sig "data_o" %4 : i32
    %idx_o = llhd.sig "idx_o" %2 : i3
    %6 = llhd.const 255 : i8
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %req_i, %6 after %7 : !llhd.sig<i8>
    %req_o.prb = llhd.prb %req_o : !llhd.sig<i1>
    llhd.drv %gnt_i, %req_o.prb after %7 : !llhd.sig<i1>
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %8 = llhd.sig "8" %0 : i1
    llhd.drv %8, %clk_i.prb after %7 : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    %9 = llhd.sig "9" %0 : i1
    llhd.drv %9, %rst_ni.prb after %7 : !llhd.sig<i1>
    %flush_i.prb = llhd.prb %flush_i : !llhd.sig<i1>
    %10 = llhd.sig "10" %0 : i1
    llhd.drv %10, %flush_i.prb after %7 : !llhd.sig<i1>
    %rr_i.prb = llhd.prb %rr_i : !llhd.sig<i3>
    %11 = llhd.sig "11" %2 : i3
    llhd.drv %11, %rr_i.prb after %7 : !llhd.sig<i3>
    %req_i.prb = llhd.prb %req_i : !llhd.sig<i8>
    %12 = llhd.sig "12" %3 : i8
    llhd.drv %12, %req_i.prb after %7 : !llhd.sig<i8>
    %13 = llhd.const 0 : i256
    %data_i.prb = llhd.prb %data_i : !llhd.sig<!llhd.array<8xi32>>
    %14 = llhd.array_uniform %4 : !llhd.array<8xi32>
    %15 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<7xi32>
    %16 = llhd.extract_slice %data_i.prb, 7 : !llhd.array<8xi32> -> !llhd.array<1xi32>
    %17 = llhd.insert_slice %14, %15, 1 : !llhd.array<8xi32>, !llhd.array<7xi32>
    %18 = llhd.insert_slice %17, %16, 0 : !llhd.array<8xi32>, !llhd.array<1xi32>
    %19 = llhd.extract_element %18, 0 : !llhd.array<8xi32> -> i32
    %20 = llhd.insert_slice %13, %19, 0 : i256, i32
    %21 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<6xi32>
    %22 = llhd.extract_slice %data_i.prb, 6 : !llhd.array<8xi32> -> !llhd.array<2xi32>
    %23 = llhd.insert_slice %14, %21, 2 : !llhd.array<8xi32>, !llhd.array<6xi32>
    %24 = llhd.insert_slice %23, %22, 0 : !llhd.array<8xi32>, !llhd.array<2xi32>
    %25 = llhd.extract_element %24, 0 : !llhd.array<8xi32> -> i32
    %26 = llhd.insert_slice %20, %25, 32 : i256, i32
    %27 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<5xi32>
    %28 = llhd.extract_slice %data_i.prb, 5 : !llhd.array<8xi32> -> !llhd.array<3xi32>
    %29 = llhd.insert_slice %14, %27, 3 : !llhd.array<8xi32>, !llhd.array<5xi32>
    %30 = llhd.insert_slice %29, %28, 0 : !llhd.array<8xi32>, !llhd.array<3xi32>
    %31 = llhd.extract_element %30, 0 : !llhd.array<8xi32> -> i32
    %32 = llhd.insert_slice %26, %31, 64 : i256, i32
    %33 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<4xi32>
    %34 = llhd.extract_slice %data_i.prb, 4 : !llhd.array<8xi32> -> !llhd.array<4xi32>
    %35 = llhd.insert_slice %14, %33, 4 : !llhd.array<8xi32>, !llhd.array<4xi32>
    %36 = llhd.insert_slice %35, %34, 0 : !llhd.array<8xi32>, !llhd.array<4xi32>
    %37 = llhd.extract_element %36, 0 : !llhd.array<8xi32> -> i32
    %38 = llhd.insert_slice %32, %37, 96 : i256, i32
    %39 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<3xi32>
    %40 = llhd.extract_slice %data_i.prb, 3 : !llhd.array<8xi32> -> !llhd.array<5xi32>
    %41 = llhd.insert_slice %14, %39, 5 : !llhd.array<8xi32>, !llhd.array<3xi32>
    %42 = llhd.insert_slice %41, %40, 0 : !llhd.array<8xi32>, !llhd.array<5xi32>
    %43 = llhd.extract_element %42, 0 : !llhd.array<8xi32> -> i32
    %44 = llhd.insert_slice %38, %43, 128 : i256, i32
    %45 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<2xi32>
    %46 = llhd.extract_slice %data_i.prb, 2 : !llhd.array<8xi32> -> !llhd.array<6xi32>
    %47 = llhd.insert_slice %14, %45, 6 : !llhd.array<8xi32>, !llhd.array<2xi32>
    %48 = llhd.insert_slice %47, %46, 0 : !llhd.array<8xi32>, !llhd.array<6xi32>
    %49 = llhd.extract_element %48, 0 : !llhd.array<8xi32> -> i32
    %50 = llhd.insert_slice %44, %49, 160 : i256, i32
    %51 = llhd.extract_slice %14, 0 : !llhd.array<8xi32> -> !llhd.array<1xi32>
    %52 = llhd.extract_slice %data_i.prb, 1 : !llhd.array<8xi32> -> !llhd.array<7xi32>
    %53 = llhd.insert_slice %14, %51, 7 : !llhd.array<8xi32>, !llhd.array<1xi32>
    %54 = llhd.insert_slice %53, %52, 0 : !llhd.array<8xi32>, !llhd.array<7xi32>
    %55 = llhd.extract_element %54, 0 : !llhd.array<8xi32> -> i32
    %56 = llhd.insert_slice %50, %55, 192 : i256, i32
    %57 = llhd.extract_element %data_i.prb, 0 : !llhd.array<8xi32> -> i32
    %concat = llhd.insert_slice %56, %57, 224 : i256, i32
    %58 = llhd.extract_slice %concat, 0 : i256 -> i8
    %59 = llhd.extract_slice %concat, 8 : i256 -> i248
    %60 = llhd.insert_slice %13, %59, 0 : i256, i248
    %61 = llhd.extract_slice %60, 0 : i256 -> i8
    %62 = llhd.extract_slice %concat, 16 : i256 -> i240
    %63 = llhd.insert_slice %13, %62, 0 : i256, i240
    %64 = llhd.extract_slice %63, 0 : i256 -> i8
    %65 = llhd.extract_slice %concat, 24 : i256 -> i232
    %66 = llhd.insert_slice %13, %65, 0 : i256, i232
    %67 = llhd.extract_slice %66, 0 : i256 -> i8
    %68 = llhd.extract_slice %concat, 32 : i256 -> i224
    %69 = llhd.insert_slice %13, %68, 0 : i256, i224
    %70 = llhd.extract_slice %69, 0 : i256 -> i8
    %71 = llhd.extract_slice %concat, 40 : i256 -> i216
    %72 = llhd.insert_slice %13, %71, 0 : i256, i216
    %73 = llhd.extract_slice %72, 0 : i256 -> i8
    %74 = llhd.extract_slice %concat, 48 : i256 -> i208
    %75 = llhd.insert_slice %13, %74, 0 : i256, i208
    %76 = llhd.extract_slice %75, 0 : i256 -> i8
    %77 = llhd.extract_slice %concat, 56 : i256 -> i200
    %78 = llhd.insert_slice %13, %77, 0 : i256, i200
    %79 = llhd.extract_slice %78, 0 : i256 -> i8
    %80 = llhd.extract_slice %concat, 64 : i256 -> i192
    %81 = llhd.insert_slice %13, %80, 0 : i256, i192
    %82 = llhd.extract_slice %81, 0 : i256 -> i8
    %83 = llhd.extract_slice %concat, 72 : i256 -> i184
    %84 = llhd.insert_slice %13, %83, 0 : i256, i184
    %85 = llhd.extract_slice %84, 0 : i256 -> i8
    %86 = llhd.extract_slice %concat, 80 : i256 -> i176
    %87 = llhd.insert_slice %13, %86, 0 : i256, i176
    %88 = llhd.extract_slice %87, 0 : i256 -> i8
    %89 = llhd.extract_slice %concat, 88 : i256 -> i168
    %90 = llhd.insert_slice %13, %89, 0 : i256, i168
    %91 = llhd.extract_slice %90, 0 : i256 -> i8
    %92 = llhd.extract_slice %concat, 96 : i256 -> i160
    %93 = llhd.insert_slice %13, %92, 0 : i256, i160
    %94 = llhd.extract_slice %93, 0 : i256 -> i8
    %95 = llhd.extract_slice %concat, 104 : i256 -> i152
    %96 = llhd.insert_slice %13, %95, 0 : i256, i152
    %97 = llhd.extract_slice %96, 0 : i256 -> i8
    %98 = llhd.extract_slice %concat, 112 : i256 -> i144
    %99 = llhd.insert_slice %13, %98, 0 : i256, i144
    %100 = llhd.extract_slice %99, 0 : i256 -> i8
    %101 = llhd.extract_slice %concat, 120 : i256 -> i136
    %102 = llhd.insert_slice %13, %101, 0 : i256, i136
    %103 = llhd.extract_slice %102, 0 : i256 -> i8
    %104 = llhd.extract_slice %concat, 128 : i256 -> i128
    %105 = llhd.insert_slice %13, %104, 0 : i256, i128
    %106 = llhd.extract_slice %105, 0 : i256 -> i8
    %107 = llhd.extract_slice %concat, 136 : i256 -> i120
    %108 = llhd.insert_slice %13, %107, 0 : i256, i120
    %109 = llhd.extract_slice %108, 0 : i256 -> i8
    %110 = llhd.extract_slice %concat, 144 : i256 -> i112
    %111 = llhd.insert_slice %13, %110, 0 : i256, i112
    %112 = llhd.extract_slice %111, 0 : i256 -> i8
    %113 = llhd.extract_slice %concat, 152 : i256 -> i104
    %114 = llhd.insert_slice %13, %113, 0 : i256, i104
    %115 = llhd.extract_slice %114, 0 : i256 -> i8
    %116 = llhd.extract_slice %concat, 160 : i256 -> i96
    %117 = llhd.insert_slice %13, %116, 0 : i256, i96
    %118 = llhd.extract_slice %117, 0 : i256 -> i8
    %119 = llhd.extract_slice %concat, 168 : i256 -> i88
    %120 = llhd.insert_slice %13, %119, 0 : i256, i88
    %121 = llhd.extract_slice %120, 0 : i256 -> i8
    %122 = llhd.extract_slice %concat, 176 : i256 -> i80
    %123 = llhd.insert_slice %13, %122, 0 : i256, i80
    %124 = llhd.extract_slice %123, 0 : i256 -> i8
    %125 = llhd.extract_slice %concat, 184 : i256 -> i72
    %126 = llhd.insert_slice %13, %125, 0 : i256, i72
    %127 = llhd.extract_slice %126, 0 : i256 -> i8
    %128 = llhd.extract_slice %concat, 192 : i256 -> i64
    %129 = llhd.insert_slice %13, %128, 0 : i256, i64
    %130 = llhd.extract_slice %129, 0 : i256 -> i8
    %131 = llhd.extract_slice %concat, 200 : i256 -> i56
    %132 = llhd.insert_slice %13, %131, 0 : i256, i56
    %133 = llhd.extract_slice %132, 0 : i256 -> i8
    %134 = llhd.extract_slice %concat, 208 : i256 -> i48
    %135 = llhd.insert_slice %13, %134, 0 : i256, i48
    %136 = llhd.extract_slice %135, 0 : i256 -> i8
    %137 = llhd.extract_slice %concat, 216 : i256 -> i40
    %138 = llhd.insert_slice %13, %137, 0 : i256, i40
    %139 = llhd.extract_slice %138, 0 : i256 -> i8
    %140 = llhd.extract_slice %concat, 224 : i256 -> i32
    %141 = llhd.insert_slice %13, %140, 0 : i256, i32
    %142 = llhd.extract_slice %141, 0 : i256 -> i8
    %143 = llhd.extract_slice %concat, 232 : i256 -> i24
    %144 = llhd.insert_slice %13, %143, 0 : i256, i24
    %145 = llhd.extract_slice %144, 0 : i256 -> i8
    %146 = llhd.extract_slice %concat, 240 : i256 -> i16
    %147 = llhd.insert_slice %13, %146, 0 : i256, i16
    %148 = llhd.extract_slice %147, 0 : i256 -> i8
    %149 = llhd.extract_slice %concat, 248 : i256 -> i8
    %150 = llhd.insert_slice %13, %149, 0 : i256, i8
    %151 = llhd.extract_slice %150, 0 : i256 -> i8
    %152 = llhd.array %58, %61, %64, %67, %70, %73, %76, %79, %82, %85, %88, %91, %94, %97, %100, %103, %106, %109, %112, %115, %118, %121, %124, %127, %130, %133, %136, %139, %142, %145, %148, %151 : !llhd.array<32xi8>
    %153 = llhd.array_uniform %3 : !llhd.array<32xi8>
    %154 = llhd.sig "154" %153 : !llhd.array<32xi8>
    llhd.drv %154, %152 after %7 : !llhd.sig<!llhd.array<32xi8>>
    %gnt_i.prb = llhd.prb %gnt_i : !llhd.sig<i1>
    %155 = llhd.sig "155" %0 : i1
    llhd.drv %155, %gnt_i.prb after %7 : !llhd.sig<i1>
    llhd.inst "inst" @rr_arb_tree.param1(%8, %9, %10, %11, %12, %154, %155) -> (%gnt_o, %req_o, %data_o, %idx_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i8>, !llhd.sig<!llhd.array<32xi8>>, !llhd.sig<i1>) -> (!llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i3>)
    llhd.inst "inst1" @rr_arb_tree_tb.initial.1815.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
