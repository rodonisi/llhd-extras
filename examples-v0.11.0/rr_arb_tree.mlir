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

llhd.entity @rr_arb_tree.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %rr_i: !llhd.sig<i3>, %req_i: !llhd.sig<i8>, %data_i: !llhd.sig<!llhd.array<8xi32>>, %gnt_i: !llhd.sig<i1>) -> (%gnt_o: !llhd.sig<i8> , %req_o: !llhd.sig<i1> , %data_o: !llhd.sig<i32> , %idx_o: !llhd.sig<i3> ) {
    %0 = llhd.const 0 : i3
    %1 = llhd.array %0, %0, %0, %0, %0, %0, %0 : !llhd.array<7xi3>
    %index_nodes = llhd.sig "index_nodes" %1 : !llhd.array<7xi3>
    %2 = llhd.const 0 : i32
    %3 = llhd.array %2, %2, %2, %2, %2, %2, %2 : !llhd.array<7xi32>
    %data_nodes = llhd.sig "data_nodes" %3 : !llhd.array<7xi32>
    %4 = llhd.const 0 : i7
    %gnt_nodes = llhd.sig "gnt_nodes" %4 : i7
    %req_nodes = llhd.sig "req_nodes" %4 : i7
    %rr_q = llhd.sig "rr_q" %0 : i3
    %5 = llhd.const 0 : i8
    %req_d = llhd.sig "req_d" %5 : i8
    %req_nodes.prb = llhd.prb %req_nodes : !llhd.sig<i7>
    %6 = llhd.extract_slice %req_nodes.prb, 0 : i7 -> i1
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %req_o, %6 after %7 : !llhd.sig<i1>
    %data_nodes.prb = llhd.prb %data_nodes : !llhd.sig<!llhd.array<7xi32>>
    %8 = llhd.extract_element %data_nodes.prb, 0 : !llhd.array<7xi32> -> i32
    llhd.drv %data_o, %8 after %7 : !llhd.sig<i32>
    %index_nodes.prb = llhd.prb %index_nodes : !llhd.sig<!llhd.array<7xi3>>
    %9 = llhd.extract_element %index_nodes.prb, 0 : !llhd.array<7xi3> -> i3
    llhd.drv %idx_o, %9 after %7 : !llhd.sig<i3>
    %10 = llhd.extract_slice %gnt_nodes, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %gnt_i.prb = llhd.prb %gnt_i : !llhd.sig<i1>
    llhd.drv %10, %gnt_i.prb after %7 : !llhd.sig<i1>
    %rr_d = llhd.sig "rr_d" %0 : i3
    %11 = llhd.const 0 : i1
    %12 = llhd.neq %gnt_i.prb, %11 : i1
    %req_o.prb = llhd.prb %req_o : !llhd.sig<i1>
    %13 = llhd.neq %req_o.prb, %11 : i1
    %14 = llhd.and %12, %13 : i1
    %15 = llhd.neq %14, %11 : i1
    %rr_q.prb = llhd.prb %rr_q : !llhd.sig<i3>
    %zext = llhd.insert_slice %2, %rr_q.prb, 0 : i32, i3
    %16 = llhd.const 7 : i32
    %17 = llhd.eq %zext, %16 : i32
    %18 = llhd.neq %17, %11 : i1
    %19 = llhd.const 1 : i3
    %20 = addi %rr_q.prb, %19 : i3
    %21 = llhd.array %20, %0 : !llhd.array<2xi3>
    %22 = llhd.dyn_extract_element %21, %18 : (!llhd.array<2xi3>, i1) -> i3
    %23 = llhd.array %rr_q.prb, %22 : !llhd.array<2xi3>
    %24 = llhd.dyn_extract_element %23, %15 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %rr_d, %24 after %7 : !llhd.sig<i3>
    %req_i.prb = llhd.prb %req_i : !llhd.sig<i8>
    llhd.drv %req_d, %req_i.prb after %7 : !llhd.sig<i8>
    llhd.inst "inst" @rr_arb_tree.param1.always_ff.639.1(%clk_i, %rst_ni, %flush_i, %rr_d) -> (%rr_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>) -> (!llhd.sig<i3>)
    %sel = llhd.sig "sel" %11 : i1
    %25 = llhd.extract_slice %req_nodes, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %26 = llhd.extract_slice %req_nodes.prb, 1 : i7 -> i6
    %27 = llhd.insert_slice %4, %26, 0 : i7, i6
    %28 = llhd.extract_slice %27, 0 : i7 -> i1
    %29 = llhd.extract_slice %req_nodes.prb, 2 : i7 -> i5
    %30 = llhd.insert_slice %4, %29, 0 : i7, i5
    %31 = llhd.extract_slice %30, 0 : i7 -> i1
    %32 = llhd.or %28, %31 : i1
    llhd.drv %25, %32 after %7 : !llhd.sig<i1>
    %33 = llhd.not %28 : i1
    %34 = llhd.extract_slice %rr_q.prb, 2 : i3 -> i1
    %35 = llhd.insert_slice %0, %34, 0 : i3, i1
    %36 = llhd.extract_slice %35, 0 : i3 -> i1
    %37 = llhd.and %31, %36 : i1
    %38 = llhd.or %33, %37 : i1
    llhd.drv %sel, %38 after %7 : !llhd.sig<i1>
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
    llhd.drv %39, %58 after %7 : !llhd.sig<i3>
    %59 = llhd.extract_element %data_nodes, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %60 = llhd.array_uniform %2 : !llhd.array<7xi32>
    %61 = llhd.extract_slice %60, 0 : !llhd.array<7xi32> -> !llhd.array<2xi32>
    %62 = llhd.extract_slice %data_nodes.prb, 2 : !llhd.array<7xi32> -> !llhd.array<5xi32>
    %63 = llhd.insert_slice %60, %61, 5 : !llhd.array<7xi32>, !llhd.array<2xi32>
    %64 = llhd.insert_slice %63, %62, 0 : !llhd.array<7xi32>, !llhd.array<5xi32>
    %65 = llhd.extract_element %64, 0 : !llhd.array<7xi32> -> i32
    %66 = llhd.extract_slice %60, 0 : !llhd.array<7xi32> -> !llhd.array<1xi32>
    %67 = llhd.extract_slice %data_nodes.prb, 1 : !llhd.array<7xi32> -> !llhd.array<6xi32>
    %68 = llhd.insert_slice %60, %66, 6 : !llhd.array<7xi32>, !llhd.array<1xi32>
    %69 = llhd.insert_slice %68, %67, 0 : !llhd.array<7xi32>, !llhd.array<6xi32>
    %70 = llhd.extract_element %69, 0 : !llhd.array<7xi32> -> i32
    %71 = llhd.array %70, %65 : !llhd.array<2xi32>
    %72 = llhd.dyn_extract_element %71, %40 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %59, %72 after %7 : !llhd.sig<i32>
    %73 = llhd.const 1 : i32
    %74 = llhd.sig "74" %4 : i7
    %75 = llhd.shr %gnt_nodes, %74, %73 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %76 = llhd.extract_slice %75, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %gnt_nodes.prb = llhd.prb %gnt_nodes : !llhd.sig<i7>
    %77 = llhd.extract_slice %gnt_nodes.prb, 0 : i7 -> i1
    %78 = llhd.not %sel.prb : i1
    %79 = llhd.and %77, %78 : i1
    llhd.drv %76, %79 after %7 : !llhd.sig<i1>
    %80 = llhd.const 2 : i32
    %81 = llhd.sig "81" %4 : i7
    %82 = llhd.shr %gnt_nodes, %81, %80 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %83 = llhd.extract_slice %82, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %84 = llhd.and %77, %sel.prb : i1
    llhd.drv %83, %84 after %7 : !llhd.sig<i1>
    %sel1 = llhd.sig "sel1" %11 : i1
    %85 = llhd.sig "85" %4 : i7
    %86 = llhd.shr %req_nodes, %85, %73 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %87 = llhd.extract_slice %86, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %88 = llhd.extract_slice %req_nodes.prb, 3 : i7 -> i4
    %89 = llhd.insert_slice %4, %88, 0 : i7, i4
    %90 = llhd.extract_slice %89, 0 : i7 -> i1
    %91 = llhd.extract_slice %req_nodes.prb, 4 : i7 -> i3
    %92 = llhd.insert_slice %4, %91, 0 : i7, i3
    %93 = llhd.extract_slice %92, 0 : i7 -> i1
    %94 = llhd.or %90, %93 : i1
    llhd.drv %87, %94 after %7 : !llhd.sig<i1>
    %95 = llhd.not %90 : i1
    %96 = llhd.extract_slice %rr_q.prb, 1 : i3 -> i2
    %97 = llhd.insert_slice %0, %96, 0 : i3, i2
    %98 = llhd.extract_slice %97, 0 : i3 -> i1
    %99 = llhd.and %93, %98 : i1
    %100 = llhd.or %95, %99 : i1
    llhd.drv %sel1, %100 after %7 : !llhd.sig<i1>
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
    %zext1 = llhd.insert_slice %0, %concat2, 0 : i3, i2
    %113 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<3xi3>
    %114 = llhd.extract_slice %index_nodes.prb, 3 : !llhd.array<7xi3> -> !llhd.array<4xi3>
    %115 = llhd.insert_slice %41, %113, 4 : !llhd.array<7xi3>, !llhd.array<3xi3>
    %116 = llhd.insert_slice %115, %114, 0 : !llhd.array<7xi3>, !llhd.array<4xi3>
    %117 = llhd.extract_element %116, 0 : !llhd.array<7xi3> -> i3
    %118 = llhd.extract_slice %117, 0 : i3 -> i1
    %119 = llhd.insert_slice %105, %118, 0 : i2, i1
    %concat3 = llhd.insert_slice %119, %11, 1 : i2, i1
    %zext2 = llhd.insert_slice %0, %concat3, 0 : i3, i2
    %120 = llhd.array %zext2, %zext1 : !llhd.array<2xi3>
    %121 = llhd.dyn_extract_element %120, %104 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %103, %121 after %7 : !llhd.sig<i3>
    %122 = llhd.sig "122" %60 : !llhd.array<7xi32>
    %123 = llhd.shr %data_nodes, %122, %73 : (!llhd.sig<!llhd.array<7xi32>>, !llhd.sig<!llhd.array<7xi32>>, i32) -> !llhd.sig<!llhd.array<7xi32>>
    %124 = llhd.extract_element %123, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %125 = llhd.extract_slice %60, 0 : !llhd.array<7xi32> -> !llhd.array<4xi32>
    %126 = llhd.extract_slice %data_nodes.prb, 4 : !llhd.array<7xi32> -> !llhd.array<3xi32>
    %127 = llhd.insert_slice %60, %125, 3 : !llhd.array<7xi32>, !llhd.array<4xi32>
    %128 = llhd.insert_slice %127, %126, 0 : !llhd.array<7xi32>, !llhd.array<3xi32>
    %129 = llhd.extract_element %128, 0 : !llhd.array<7xi32> -> i32
    %130 = llhd.extract_slice %60, 0 : !llhd.array<7xi32> -> !llhd.array<3xi32>
    %131 = llhd.extract_slice %data_nodes.prb, 3 : !llhd.array<7xi32> -> !llhd.array<4xi32>
    %132 = llhd.insert_slice %60, %130, 4 : !llhd.array<7xi32>, !llhd.array<3xi32>
    %133 = llhd.insert_slice %132, %131, 0 : !llhd.array<7xi32>, !llhd.array<4xi32>
    %134 = llhd.extract_element %133, 0 : !llhd.array<7xi32> -> i32
    %135 = llhd.array %134, %129 : !llhd.array<2xi32>
    %136 = llhd.dyn_extract_element %135, %104 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %124, %136 after %7 : !llhd.sig<i32>
    %137 = llhd.const 3 : i32
    %138 = llhd.sig "138" %4 : i7
    %139 = llhd.shr %gnt_nodes, %138, %137 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %140 = llhd.extract_slice %139, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %141 = llhd.extract_slice %gnt_nodes.prb, 1 : i7 -> i6
    %142 = llhd.insert_slice %4, %141, 0 : i7, i6
    %143 = llhd.extract_slice %142, 0 : i7 -> i1
    %144 = llhd.not %sel.prb1 : i1
    %145 = llhd.and %143, %144 : i1
    llhd.drv %140, %145 after %7 : !llhd.sig<i1>
    %146 = llhd.const 4 : i32
    %147 = llhd.sig "147" %4 : i7
    %148 = llhd.shr %gnt_nodes, %147, %146 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %149 = llhd.extract_slice %148, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %150 = llhd.and %143, %sel.prb1 : i1
    llhd.drv %149, %150 after %7 : !llhd.sig<i1>
    %sel2 = llhd.sig "sel2" %11 : i1
    %151 = llhd.sig "151" %4 : i7
    %152 = llhd.shr %req_nodes, %151, %80 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %153 = llhd.extract_slice %152, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %154 = llhd.extract_slice %req_nodes.prb, 5 : i7 -> i2
    %155 = llhd.insert_slice %4, %154, 0 : i7, i2
    %156 = llhd.extract_slice %155, 0 : i7 -> i1
    %157 = llhd.extract_slice %req_nodes.prb, 6 : i7 -> i1
    %158 = llhd.insert_slice %4, %157, 0 : i7, i1
    %159 = llhd.extract_slice %158, 0 : i7 -> i1
    %160 = llhd.or %156, %159 : i1
    llhd.drv %153, %160 after %7 : !llhd.sig<i1>
    %161 = llhd.not %156 : i1
    %162 = llhd.and %159, %98 : i1
    %163 = llhd.or %161, %162 : i1
    llhd.drv %sel2, %163 after %7 : !llhd.sig<i1>
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
    %zext3 = llhd.insert_slice %0, %concat4, 0 : i3, i2
    %175 = llhd.extract_slice %41, 0 : !llhd.array<7xi3> -> !llhd.array<5xi3>
    %176 = llhd.extract_slice %index_nodes.prb, 5 : !llhd.array<7xi3> -> !llhd.array<2xi3>
    %177 = llhd.insert_slice %41, %175, 2 : !llhd.array<7xi3>, !llhd.array<5xi3>
    %178 = llhd.insert_slice %177, %176, 0 : !llhd.array<7xi3>, !llhd.array<2xi3>
    %179 = llhd.extract_element %178, 0 : !llhd.array<7xi3> -> i3
    %180 = llhd.extract_slice %179, 0 : i3 -> i1
    %181 = llhd.insert_slice %105, %180, 0 : i2, i1
    %concat5 = llhd.insert_slice %181, %11, 1 : i2, i1
    %zext4 = llhd.insert_slice %0, %concat5, 0 : i3, i2
    %182 = llhd.array %zext4, %zext3 : !llhd.array<2xi3>
    %183 = llhd.dyn_extract_element %182, %167 : (!llhd.array<2xi3>, i1) -> i3
    llhd.drv %166, %183 after %7 : !llhd.sig<i3>
    %184 = llhd.sig "184" %60 : !llhd.array<7xi32>
    %185 = llhd.shr %data_nodes, %184, %80 : (!llhd.sig<!llhd.array<7xi32>>, !llhd.sig<!llhd.array<7xi32>>, i32) -> !llhd.sig<!llhd.array<7xi32>>
    %186 = llhd.extract_element %185, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %187 = llhd.extract_slice %60, 0 : !llhd.array<7xi32> -> !llhd.array<6xi32>
    %188 = llhd.extract_slice %data_nodes.prb, 6 : !llhd.array<7xi32> -> !llhd.array<1xi32>
    %189 = llhd.insert_slice %60, %187, 1 : !llhd.array<7xi32>, !llhd.array<6xi32>
    %190 = llhd.insert_slice %189, %188, 0 : !llhd.array<7xi32>, !llhd.array<1xi32>
    %191 = llhd.extract_element %190, 0 : !llhd.array<7xi32> -> i32
    %192 = llhd.extract_slice %60, 0 : !llhd.array<7xi32> -> !llhd.array<5xi32>
    %193 = llhd.extract_slice %data_nodes.prb, 5 : !llhd.array<7xi32> -> !llhd.array<2xi32>
    %194 = llhd.insert_slice %60, %192, 2 : !llhd.array<7xi32>, !llhd.array<5xi32>
    %195 = llhd.insert_slice %194, %193, 0 : !llhd.array<7xi32>, !llhd.array<2xi32>
    %196 = llhd.extract_element %195, 0 : !llhd.array<7xi32> -> i32
    %197 = llhd.array %196, %191 : !llhd.array<2xi32>
    %198 = llhd.dyn_extract_element %197, %167 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %186, %198 after %7 : !llhd.sig<i32>
    %199 = llhd.const 5 : i32
    %200 = llhd.sig "200" %4 : i7
    %201 = llhd.shr %gnt_nodes, %200, %199 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %202 = llhd.extract_slice %201, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %203 = llhd.extract_slice %gnt_nodes.prb, 2 : i7 -> i5
    %204 = llhd.insert_slice %4, %203, 0 : i7, i5
    %205 = llhd.extract_slice %204, 0 : i7 -> i1
    %206 = llhd.not %sel.prb2 : i1
    %207 = llhd.and %205, %206 : i1
    llhd.drv %202, %207 after %7 : !llhd.sig<i1>
    %208 = llhd.const 6 : i32
    %209 = llhd.sig "209" %4 : i7
    %210 = llhd.shr %gnt_nodes, %209, %208 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %211 = llhd.extract_slice %210, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %212 = llhd.and %205, %sel.prb2 : i1
    llhd.drv %211, %212 after %7 : !llhd.sig<i1>
    %sel3 = llhd.sig "sel3" %11 : i1
    %213 = llhd.sig "213" %4 : i7
    %214 = llhd.shr %req_nodes, %213, %137 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %215 = llhd.extract_slice %214, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %req_d.prb = llhd.prb %req_d : !llhd.sig<i8>
    %216 = llhd.extract_slice %req_d.prb, 0 : i8 -> i1
    %217 = llhd.extract_slice %req_d.prb, 1 : i8 -> i7
    %218 = llhd.insert_slice %5, %217, 0 : i8, i7
    %219 = llhd.extract_slice %218, 0 : i8 -> i1
    %220 = llhd.or %216, %219 : i1
    llhd.drv %215, %220 after %7 : !llhd.sig<i1>
    %221 = llhd.not %216 : i1
    %222 = llhd.extract_slice %rr_q.prb, 0 : i3 -> i1
    %223 = llhd.and %219, %222 : i1
    %224 = llhd.or %221, %223 : i1
    llhd.drv %sel3, %224 after %7 : !llhd.sig<i1>
    %225 = llhd.sig "225" %41 : !llhd.array<7xi3>
    %226 = llhd.shr %index_nodes, %225, %137 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %227 = llhd.extract_element %226, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb3 = llhd.prb %sel3 : !llhd.sig<i1>
    %zext5 = llhd.insert_slice %0, %sel.prb3, 0 : i3, i1
    llhd.drv %227, %zext5 after %7 : !llhd.sig<i3>
    %228 = llhd.sig "228" %60 : !llhd.array<7xi32>
    %229 = llhd.shr %data_nodes, %228, %137 : (!llhd.sig<!llhd.array<7xi32>>, !llhd.sig<!llhd.array<7xi32>>, i32) -> !llhd.sig<!llhd.array<7xi32>>
    %230 = llhd.extract_element %229, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %231 = llhd.neq %sel.prb3, %11 : i1
    %data_i.prb = llhd.prb %data_i : !llhd.sig<!llhd.array<8xi32>>
    %232 = llhd.array_uniform %2 : !llhd.array<8xi32>
    %233 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<1xi32>
    %234 = llhd.extract_slice %data_i.prb, 1 : !llhd.array<8xi32> -> !llhd.array<7xi32>
    %235 = llhd.insert_slice %232, %233, 7 : !llhd.array<8xi32>, !llhd.array<1xi32>
    %236 = llhd.insert_slice %235, %234, 0 : !llhd.array<8xi32>, !llhd.array<7xi32>
    %237 = llhd.extract_element %236, 0 : !llhd.array<8xi32> -> i32
    %238 = llhd.extract_element %data_i.prb, 0 : !llhd.array<8xi32> -> i32
    %239 = llhd.array %238, %237 : !llhd.array<2xi32>
    %240 = llhd.dyn_extract_element %239, %231 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %230, %240 after %7 : !llhd.sig<i32>
    %241 = llhd.extract_slice %gnt_o, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %242 = llhd.extract_slice %gnt_nodes.prb, 3 : i7 -> i4
    %243 = llhd.insert_slice %4, %242, 0 : i7, i4
    %244 = llhd.extract_slice %243, 0 : i7 -> i1
    %245 = llhd.and %244, %216 : i1
    %246 = llhd.not %sel.prb3 : i1
    %247 = llhd.and %245, %246 : i1
    llhd.drv %241, %247 after %7 : !llhd.sig<i1>
    %248 = llhd.sig "248" %5 : i8
    %249 = llhd.shr %gnt_o, %248, %73 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %250 = llhd.extract_slice %249, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %251 = llhd.and %244, %219 : i1
    %252 = llhd.and %251, %sel.prb3 : i1
    llhd.drv %250, %252 after %7 : !llhd.sig<i1>
    %sel4 = llhd.sig "sel4" %11 : i1
    %253 = llhd.sig "253" %4 : i7
    %254 = llhd.shr %req_nodes, %253, %146 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %255 = llhd.extract_slice %254, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %256 = llhd.extract_slice %req_d.prb, 2 : i8 -> i6
    %257 = llhd.insert_slice %5, %256, 0 : i8, i6
    %258 = llhd.extract_slice %257, 0 : i8 -> i1
    %259 = llhd.extract_slice %req_d.prb, 3 : i8 -> i5
    %260 = llhd.insert_slice %5, %259, 0 : i8, i5
    %261 = llhd.extract_slice %260, 0 : i8 -> i1
    %262 = llhd.or %258, %261 : i1
    llhd.drv %255, %262 after %7 : !llhd.sig<i1>
    %263 = llhd.not %258 : i1
    %264 = llhd.and %261, %222 : i1
    %265 = llhd.or %263, %264 : i1
    llhd.drv %sel4, %265 after %7 : !llhd.sig<i1>
    %266 = llhd.sig "266" %41 : !llhd.array<7xi3>
    %267 = llhd.shr %index_nodes, %266, %146 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %268 = llhd.extract_element %267, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb4 = llhd.prb %sel4 : !llhd.sig<i1>
    %zext6 = llhd.insert_slice %0, %sel.prb4, 0 : i3, i1
    llhd.drv %268, %zext6 after %7 : !llhd.sig<i3>
    %269 = llhd.sig "269" %60 : !llhd.array<7xi32>
    %270 = llhd.shr %data_nodes, %269, %146 : (!llhd.sig<!llhd.array<7xi32>>, !llhd.sig<!llhd.array<7xi32>>, i32) -> !llhd.sig<!llhd.array<7xi32>>
    %271 = llhd.extract_element %270, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %272 = llhd.neq %sel.prb4, %11 : i1
    %273 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<3xi32>
    %274 = llhd.extract_slice %data_i.prb, 3 : !llhd.array<8xi32> -> !llhd.array<5xi32>
    %275 = llhd.insert_slice %232, %273, 5 : !llhd.array<8xi32>, !llhd.array<3xi32>
    %276 = llhd.insert_slice %275, %274, 0 : !llhd.array<8xi32>, !llhd.array<5xi32>
    %277 = llhd.extract_element %276, 0 : !llhd.array<8xi32> -> i32
    %278 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<2xi32>
    %279 = llhd.extract_slice %data_i.prb, 2 : !llhd.array<8xi32> -> !llhd.array<6xi32>
    %280 = llhd.insert_slice %232, %278, 6 : !llhd.array<8xi32>, !llhd.array<2xi32>
    %281 = llhd.insert_slice %280, %279, 0 : !llhd.array<8xi32>, !llhd.array<6xi32>
    %282 = llhd.extract_element %281, 0 : !llhd.array<8xi32> -> i32
    %283 = llhd.array %282, %277 : !llhd.array<2xi32>
    %284 = llhd.dyn_extract_element %283, %272 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %271, %284 after %7 : !llhd.sig<i32>
    %285 = llhd.sig "285" %5 : i8
    %286 = llhd.shr %gnt_o, %285, %80 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %287 = llhd.extract_slice %286, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %288 = llhd.extract_slice %gnt_nodes.prb, 4 : i7 -> i3
    %289 = llhd.insert_slice %4, %288, 0 : i7, i3
    %290 = llhd.extract_slice %289, 0 : i7 -> i1
    %291 = llhd.and %290, %258 : i1
    %292 = llhd.not %sel.prb4 : i1
    %293 = llhd.and %291, %292 : i1
    llhd.drv %287, %293 after %7 : !llhd.sig<i1>
    %294 = llhd.sig "294" %5 : i8
    %295 = llhd.shr %gnt_o, %294, %137 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %296 = llhd.extract_slice %295, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %297 = llhd.and %290, %261 : i1
    %298 = llhd.and %297, %sel.prb4 : i1
    llhd.drv %296, %298 after %7 : !llhd.sig<i1>
    %sel5 = llhd.sig "sel5" %11 : i1
    %299 = llhd.sig "299" %4 : i7
    %300 = llhd.shr %req_nodes, %299, %199 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %301 = llhd.extract_slice %300, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %302 = llhd.extract_slice %req_d.prb, 4 : i8 -> i4
    %303 = llhd.insert_slice %5, %302, 0 : i8, i4
    %304 = llhd.extract_slice %303, 0 : i8 -> i1
    %305 = llhd.extract_slice %req_d.prb, 5 : i8 -> i3
    %306 = llhd.insert_slice %5, %305, 0 : i8, i3
    %307 = llhd.extract_slice %306, 0 : i8 -> i1
    %308 = llhd.or %304, %307 : i1
    llhd.drv %301, %308 after %7 : !llhd.sig<i1>
    %309 = llhd.not %304 : i1
    %310 = llhd.and %307, %222 : i1
    %311 = llhd.or %309, %310 : i1
    llhd.drv %sel5, %311 after %7 : !llhd.sig<i1>
    %312 = llhd.sig "312" %41 : !llhd.array<7xi3>
    %313 = llhd.shr %index_nodes, %312, %199 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %314 = llhd.extract_element %313, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb5 = llhd.prb %sel5 : !llhd.sig<i1>
    %zext7 = llhd.insert_slice %0, %sel.prb5, 0 : i3, i1
    llhd.drv %314, %zext7 after %7 : !llhd.sig<i3>
    %315 = llhd.sig "315" %60 : !llhd.array<7xi32>
    %316 = llhd.shr %data_nodes, %315, %199 : (!llhd.sig<!llhd.array<7xi32>>, !llhd.sig<!llhd.array<7xi32>>, i32) -> !llhd.sig<!llhd.array<7xi32>>
    %317 = llhd.extract_element %316, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %318 = llhd.neq %sel.prb5, %11 : i1
    %319 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<5xi32>
    %320 = llhd.extract_slice %data_i.prb, 5 : !llhd.array<8xi32> -> !llhd.array<3xi32>
    %321 = llhd.insert_slice %232, %319, 3 : !llhd.array<8xi32>, !llhd.array<5xi32>
    %322 = llhd.insert_slice %321, %320, 0 : !llhd.array<8xi32>, !llhd.array<3xi32>
    %323 = llhd.extract_element %322, 0 : !llhd.array<8xi32> -> i32
    %324 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<4xi32>
    %325 = llhd.extract_slice %data_i.prb, 4 : !llhd.array<8xi32> -> !llhd.array<4xi32>
    %326 = llhd.insert_slice %232, %324, 4 : !llhd.array<8xi32>, !llhd.array<4xi32>
    %327 = llhd.insert_slice %326, %325, 0 : !llhd.array<8xi32>, !llhd.array<4xi32>
    %328 = llhd.extract_element %327, 0 : !llhd.array<8xi32> -> i32
    %329 = llhd.array %328, %323 : !llhd.array<2xi32>
    %330 = llhd.dyn_extract_element %329, %318 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %317, %330 after %7 : !llhd.sig<i32>
    %331 = llhd.sig "331" %5 : i8
    %332 = llhd.shr %gnt_o, %331, %146 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %333 = llhd.extract_slice %332, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %334 = llhd.extract_slice %gnt_nodes.prb, 5 : i7 -> i2
    %335 = llhd.insert_slice %4, %334, 0 : i7, i2
    %336 = llhd.extract_slice %335, 0 : i7 -> i1
    %337 = llhd.and %336, %304 : i1
    %338 = llhd.not %sel.prb5 : i1
    %339 = llhd.and %337, %338 : i1
    llhd.drv %333, %339 after %7 : !llhd.sig<i1>
    %340 = llhd.sig "340" %5 : i8
    %341 = llhd.shr %gnt_o, %340, %199 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %342 = llhd.extract_slice %341, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %343 = llhd.and %336, %307 : i1
    %344 = llhd.and %343, %sel.prb5 : i1
    llhd.drv %342, %344 after %7 : !llhd.sig<i1>
    %sel6 = llhd.sig "sel6" %11 : i1
    %345 = llhd.sig "345" %4 : i7
    %346 = llhd.shr %req_nodes, %345, %208 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %347 = llhd.extract_slice %346, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %348 = llhd.extract_slice %req_d.prb, 6 : i8 -> i2
    %349 = llhd.insert_slice %5, %348, 0 : i8, i2
    %350 = llhd.extract_slice %349, 0 : i8 -> i1
    %351 = llhd.extract_slice %req_d.prb, 7 : i8 -> i1
    %352 = llhd.insert_slice %5, %351, 0 : i8, i1
    %353 = llhd.extract_slice %352, 0 : i8 -> i1
    %354 = llhd.or %350, %353 : i1
    llhd.drv %347, %354 after %7 : !llhd.sig<i1>
    %355 = llhd.not %350 : i1
    %356 = llhd.and %353, %222 : i1
    %357 = llhd.or %355, %356 : i1
    llhd.drv %sel6, %357 after %7 : !llhd.sig<i1>
    %358 = llhd.sig "358" %41 : !llhd.array<7xi3>
    %359 = llhd.shr %index_nodes, %358, %208 : (!llhd.sig<!llhd.array<7xi3>>, !llhd.sig<!llhd.array<7xi3>>, i32) -> !llhd.sig<!llhd.array<7xi3>>
    %360 = llhd.extract_element %359, 0 : !llhd.sig<!llhd.array<7xi3>> -> !llhd.sig<i3>
    %sel.prb6 = llhd.prb %sel6 : !llhd.sig<i1>
    %zext8 = llhd.insert_slice %0, %sel.prb6, 0 : i3, i1
    llhd.drv %360, %zext8 after %7 : !llhd.sig<i3>
    %361 = llhd.sig "361" %60 : !llhd.array<7xi32>
    %362 = llhd.shr %data_nodes, %361, %208 : (!llhd.sig<!llhd.array<7xi32>>, !llhd.sig<!llhd.array<7xi32>>, i32) -> !llhd.sig<!llhd.array<7xi32>>
    %363 = llhd.extract_element %362, 0 : !llhd.sig<!llhd.array<7xi32>> -> !llhd.sig<i32>
    %364 = llhd.neq %sel.prb6, %11 : i1
    %365 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<7xi32>
    %366 = llhd.extract_slice %data_i.prb, 7 : !llhd.array<8xi32> -> !llhd.array<1xi32>
    %367 = llhd.insert_slice %232, %365, 1 : !llhd.array<8xi32>, !llhd.array<7xi32>
    %368 = llhd.insert_slice %367, %366, 0 : !llhd.array<8xi32>, !llhd.array<1xi32>
    %369 = llhd.extract_element %368, 0 : !llhd.array<8xi32> -> i32
    %370 = llhd.extract_slice %232, 0 : !llhd.array<8xi32> -> !llhd.array<6xi32>
    %371 = llhd.extract_slice %data_i.prb, 6 : !llhd.array<8xi32> -> !llhd.array<2xi32>
    %372 = llhd.insert_slice %232, %370, 2 : !llhd.array<8xi32>, !llhd.array<6xi32>
    %373 = llhd.insert_slice %372, %371, 0 : !llhd.array<8xi32>, !llhd.array<2xi32>
    %374 = llhd.extract_element %373, 0 : !llhd.array<8xi32> -> i32
    %375 = llhd.array %374, %369 : !llhd.array<2xi32>
    %376 = llhd.dyn_extract_element %375, %364 : (!llhd.array<2xi32>, i1) -> i32
    llhd.drv %363, %376 after %7 : !llhd.sig<i32>
    %377 = llhd.sig "377" %5 : i8
    %378 = llhd.shr %gnt_o, %377, %208 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %379 = llhd.extract_slice %378, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %380 = llhd.extract_slice %gnt_nodes.prb, 6 : i7 -> i1
    %381 = llhd.insert_slice %4, %380, 0 : i7, i1
    %382 = llhd.extract_slice %381, 0 : i7 -> i1
    %383 = llhd.and %382, %350 : i1
    %384 = llhd.not %sel.prb6 : i1
    %385 = llhd.and %383, %384 : i1
    llhd.drv %379, %385 after %7 : !llhd.sig<i1>
    %386 = llhd.sig "386" %5 : i8
    %387 = llhd.shr %gnt_o, %386, %16 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %388 = llhd.extract_slice %387, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %389 = llhd.and %382, %353 : i1
    %390 = llhd.and %389, %sel.prb6 : i1
    llhd.drv %388, %390 after %7 : !llhd.sig<i1>
    llhd.inst "inst1" @rr_arb_tree.param1.initial.1529.1() -> () : () -> ()
    // %391 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %gnt_o, %5 after %391 : !llhd.sig<i8>
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
    llhd.inst "inst" @rr_arb_tree.param1(%clk_i, %rst_ni, %flush_i, %rr_i, %req_i, %data_i, %gnt_i) -> (%gnt_o, %req_o, %data_o, %idx_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i8>, !llhd.sig<!llhd.array<8xi32>>, !llhd.sig<i1>) -> (!llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i3>)
    llhd.inst "inst1" @rr_arb_tree_tb.initial.1815.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
