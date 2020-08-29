llhd.proc @lzc.param1.initial.69.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.proc @lzc.param1.always_comb.217.1(%in_i: !llhd.sig<i16>) -> (%in_tmp: !llhd.sig<i16> ) {
    br ^body
^body:
    %0 = llhd.const 0 : i32
    br ^loop_body(%0 : i32)
^loop_body(%i.ld: i32):
    %1 = llhd.const 16 : i32
    %2 = cmpi "ult", %i.ld, %1 : i32
    cond_br %2, ^loop_continue, ^check
^check:
    llhd.wait (%in_i : !llhd.sig<i16>), ^body
^loop_continue:
    %3 = llhd.const 0 : i16
    %4 = llhd.dyn_extract_slice %in_tmp, %i.ld : (!llhd.sig<i16>, i32) -> !llhd.sig<i1>
    %in_i.prb = llhd.prb %in_i : !llhd.sig<i16>
    %5 = llhd.const 15 : i32
    %6 = subi %5, %i.ld : i32
    %7 = llhd.shr %in_i.prb, %3, %6 : (i16, i16, i32) -> i16
    %8 = llhd.extract_slice %7, 0 : i16 -> i1
    %9 = llhd.shr %in_i.prb, %3, %i.ld : (i16, i16, i32) -> i16
    %10 = llhd.extract_slice %9, 0 : i16 -> i1
    %11 = llhd.array %10, %8 : !llhd.array<2xi1>
    %12 = llhd.extract_element %11, 1 : !llhd.array<2xi1> -> i1
    %13 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %12 after %13 : !llhd.sig<i1>
    %14 = llhd.const 1 : i32
    %15 = addi %i.ld, %14 : i32
    br ^loop_body(%15 : i32)
}

llhd.entity @lzc.param1(%in_i: !llhd.sig<i16>) -> (%cnt_o: !llhd.sig<i4> , %empty_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i4
    %1 = llhd.array %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0 : !llhd.array<16xi4>
    %index_lut = llhd.sig "index_lut" %1 : !llhd.array<16xi4>
    %2 = llhd.const 0 : i16
    %sel_nodes = llhd.sig "sel_nodes" %2 : i16
    %index_nodes = llhd.sig "index_nodes" %1 : !llhd.array<16xi4>
    %in_tmp = llhd.sig "in_tmp" %2 : i16
    %index_nodes.prb = llhd.prb %index_nodes : !llhd.sig<!llhd.array<16xi4>>
    %3 = llhd.extract_element %index_nodes.prb, 0 : !llhd.array<16xi4> -> i4
    %4 = llhd.array %0, %3 : !llhd.array<2xi4>
    %5 = llhd.extract_element %4, 1 : !llhd.array<2xi4> -> i4
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %cnt_o, %5 after %6 : !llhd.sig<i4>
    %sel_nodes.prb = llhd.prb %sel_nodes : !llhd.sig<i16>
    %7 = llhd.extract_slice %sel_nodes.prb, 0 : i16 -> i1
    %8 = llhd.not %7 : i1
    %in_i.prb = llhd.prb %in_i : !llhd.sig<i16>
    %9 = llhd.extract_slice %in_i.prb, 0 : i16 -> i1
    %10 = llhd.extract_slice %in_i.prb, 1 : i16 -> i1
    %11 = llhd.or %9, %10 : i1
    %12 = llhd.extract_slice %in_i.prb, 2 : i16 -> i1
    %13 = llhd.or %11, %12 : i1
    %14 = llhd.extract_slice %in_i.prb, 3 : i16 -> i1
    %15 = llhd.or %13, %14 : i1
    %16 = llhd.extract_slice %in_i.prb, 4 : i16 -> i1
    %17 = llhd.or %15, %16 : i1
    %18 = llhd.extract_slice %in_i.prb, 5 : i16 -> i1
    %19 = llhd.or %17, %18 : i1
    %20 = llhd.extract_slice %in_i.prb, 6 : i16 -> i1
    %21 = llhd.or %19, %20 : i1
    %22 = llhd.extract_slice %in_i.prb, 7 : i16 -> i1
    %23 = llhd.or %21, %22 : i1
    %24 = llhd.extract_slice %in_i.prb, 8 : i16 -> i1
    %25 = llhd.or %23, %24 : i1
    %26 = llhd.extract_slice %in_i.prb, 9 : i16 -> i1
    %27 = llhd.or %25, %26 : i1
    %28 = llhd.extract_slice %in_i.prb, 10 : i16 -> i1
    %29 = llhd.or %27, %28 : i1
    %30 = llhd.extract_slice %in_i.prb, 11 : i16 -> i1
    %31 = llhd.or %29, %30 : i1
    %32 = llhd.extract_slice %in_i.prb, 12 : i16 -> i1
    %33 = llhd.or %31, %32 : i1
    %34 = llhd.extract_slice %in_i.prb, 13 : i16 -> i1
    %35 = llhd.or %33, %34 : i1
    %36 = llhd.extract_slice %in_i.prb, 14 : i16 -> i1
    %37 = llhd.or %35, %36 : i1
    %38 = llhd.extract_slice %in_i.prb, 15 : i16 -> i1
    %39 = llhd.or %37, %38 : i1
    %40 = llhd.not %39 : i1
    %41 = llhd.array %40, %8 : !llhd.array<2xi1>
    %42 = llhd.extract_element %41, 1 : !llhd.array<2xi1> -> i1
    llhd.drv %empty_o, %42 after %6 : !llhd.sig<i1>
    %43 = llhd.extract_element %index_lut, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    llhd.drv %43, %0 after %6 : !llhd.sig<i4>
    %44 = llhd.const 1 : i32
    %45 = llhd.array_uniform %0 : !llhd.array<16xi4>
    %46 = llhd.sig "46" %45 : !llhd.array<16xi4>
    %47 = llhd.shr %index_lut, %46, %44 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %48 = llhd.extract_element %47, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %49 = llhd.const 1 : i4
    llhd.drv %48, %49 after %6 : !llhd.sig<i4>
    %50 = llhd.const 2 : i32
    %51 = llhd.sig "51" %45 : !llhd.array<16xi4>
    %52 = llhd.shr %index_lut, %51, %50 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %53 = llhd.extract_element %52, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %54 = llhd.const 2 : i4
    llhd.drv %53, %54 after %6 : !llhd.sig<i4>
    %55 = llhd.const 3 : i32
    %56 = llhd.sig "56" %45 : !llhd.array<16xi4>
    %57 = llhd.shr %index_lut, %56, %55 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %58 = llhd.extract_element %57, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %59 = llhd.const 3 : i4
    llhd.drv %58, %59 after %6 : !llhd.sig<i4>
    %60 = llhd.const 4 : i32
    %61 = llhd.sig "61" %45 : !llhd.array<16xi4>
    %62 = llhd.shr %index_lut, %61, %60 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %63 = llhd.extract_element %62, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %64 = llhd.const 4 : i4
    llhd.drv %63, %64 after %6 : !llhd.sig<i4>
    %65 = llhd.const 5 : i32
    %66 = llhd.sig "66" %45 : !llhd.array<16xi4>
    %67 = llhd.shr %index_lut, %66, %65 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %68 = llhd.extract_element %67, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %69 = llhd.const 5 : i4
    llhd.drv %68, %69 after %6 : !llhd.sig<i4>
    %70 = llhd.const 6 : i32
    %71 = llhd.sig "71" %45 : !llhd.array<16xi4>
    %72 = llhd.shr %index_lut, %71, %70 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %73 = llhd.extract_element %72, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %74 = llhd.const 6 : i4
    llhd.drv %73, %74 after %6 : !llhd.sig<i4>
    %75 = llhd.const 7 : i32
    %76 = llhd.sig "76" %45 : !llhd.array<16xi4>
    %77 = llhd.shr %index_lut, %76, %75 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %78 = llhd.extract_element %77, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %79 = llhd.const 7 : i4
    llhd.drv %78, %79 after %6 : !llhd.sig<i4>
    %80 = llhd.const 8 : i32
    %81 = llhd.sig "81" %45 : !llhd.array<16xi4>
    %82 = llhd.shr %index_lut, %81, %80 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %83 = llhd.extract_element %82, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %84 = llhd.const 8 : i4
    llhd.drv %83, %84 after %6 : !llhd.sig<i4>
    %85 = llhd.const 9 : i32
    %86 = llhd.sig "86" %45 : !llhd.array<16xi4>
    %87 = llhd.shr %index_lut, %86, %85 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %88 = llhd.extract_element %87, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %89 = llhd.const 9 : i4
    llhd.drv %88, %89 after %6 : !llhd.sig<i4>
    %90 = llhd.const 10 : i32
    %91 = llhd.sig "91" %45 : !llhd.array<16xi4>
    %92 = llhd.shr %index_lut, %91, %90 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %93 = llhd.extract_element %92, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %94 = llhd.const 10 : i4
    llhd.drv %93, %94 after %6 : !llhd.sig<i4>
    %95 = llhd.const 11 : i32
    %96 = llhd.sig "96" %45 : !llhd.array<16xi4>
    %97 = llhd.shr %index_lut, %96, %95 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %98 = llhd.extract_element %97, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %99 = llhd.const 11 : i4
    llhd.drv %98, %99 after %6 : !llhd.sig<i4>
    %100 = llhd.const 12 : i32
    %101 = llhd.sig "101" %45 : !llhd.array<16xi4>
    %102 = llhd.shr %index_lut, %101, %100 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %103 = llhd.extract_element %102, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %104 = llhd.const 12 : i4
    llhd.drv %103, %104 after %6 : !llhd.sig<i4>
    %105 = llhd.const 13 : i32
    %106 = llhd.sig "106" %45 : !llhd.array<16xi4>
    %107 = llhd.shr %index_lut, %106, %105 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %108 = llhd.extract_element %107, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %109 = llhd.const 13 : i4
    llhd.drv %108, %109 after %6 : !llhd.sig<i4>
    %110 = llhd.const 14 : i32
    %111 = llhd.sig "111" %45 : !llhd.array<16xi4>
    %112 = llhd.shr %index_lut, %111, %110 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %113 = llhd.extract_element %112, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %114 = llhd.const 14 : i4
    llhd.drv %113, %114 after %6 : !llhd.sig<i4>
    %115 = llhd.const 15 : i32
    %116 = llhd.sig "116" %45 : !llhd.array<16xi4>
    %117 = llhd.shr %index_lut, %116, %115 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %118 = llhd.extract_element %117, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %119 = llhd.const 15 : i4
    llhd.drv %118, %119 after %6 : !llhd.sig<i4>
    %120 = llhd.extract_slice %sel_nodes, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %121 = llhd.extract_slice %sel_nodes.prb, 1 : i16 -> i15
    %122 = llhd.insert_slice %2, %121, 0 : i16, i15
    %123 = llhd.extract_slice %122, 0 : i16 -> i1
    %124 = llhd.extract_slice %sel_nodes.prb, 2 : i16 -> i14
    %125 = llhd.insert_slice %2, %124, 0 : i16, i14
    %126 = llhd.extract_slice %125, 0 : i16 -> i1
    %127 = llhd.or %123, %126 : i1
    llhd.drv %120, %127 after %6 : !llhd.sig<i1>
    %128 = llhd.extract_element %index_nodes, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %129 = llhd.const 1 : i1
    %130 = llhd.eq %123, %129 : i1
    %131 = llhd.const 0 : i1
    %132 = llhd.neq %130, %131 : i1
    %133 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<1xi4>
    %134 = llhd.extract_slice %index_nodes.prb, 1 : !llhd.array<16xi4> -> !llhd.array<15xi4>
    %135 = llhd.insert_slice %45, %133, 15 : !llhd.array<16xi4>, !llhd.array<1xi4>
    %136 = llhd.insert_slice %135, %134, 0 : !llhd.array<16xi4>, !llhd.array<15xi4>
    %137 = llhd.extract_element %136, 0 : !llhd.array<16xi4> -> i4
    %138 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<2xi4>
    %139 = llhd.extract_slice %index_nodes.prb, 2 : !llhd.array<16xi4> -> !llhd.array<14xi4>
    %140 = llhd.insert_slice %45, %138, 14 : !llhd.array<16xi4>, !llhd.array<2xi4>
    %141 = llhd.insert_slice %140, %139, 0 : !llhd.array<16xi4>, !llhd.array<14xi4>
    %142 = llhd.extract_element %141, 0 : !llhd.array<16xi4> -> i4
    %143 = llhd.array %142, %137 : !llhd.array<2xi4>
    %144 = llhd.dyn_extract_element %143, %132 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %128, %144 after %6 : !llhd.sig<i4>
    %145 = llhd.sig "145" %2 : i16
    %146 = llhd.shr %sel_nodes, %145, %44 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %147 = llhd.extract_slice %146, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %148 = llhd.extract_slice %sel_nodes.prb, 3 : i16 -> i13
    %149 = llhd.insert_slice %2, %148, 0 : i16, i13
    %150 = llhd.extract_slice %149, 0 : i16 -> i1
    %151 = llhd.extract_slice %sel_nodes.prb, 4 : i16 -> i12
    %152 = llhd.insert_slice %2, %151, 0 : i16, i12
    %153 = llhd.extract_slice %152, 0 : i16 -> i1
    %154 = llhd.or %150, %153 : i1
    llhd.drv %147, %154 after %6 : !llhd.sig<i1>
    %155 = llhd.sig "155" %45 : !llhd.array<16xi4>
    %156 = llhd.shr %index_nodes, %155, %44 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %157 = llhd.extract_element %156, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %158 = llhd.eq %150, %129 : i1
    %159 = llhd.neq %158, %131 : i1
    %160 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<3xi4>
    %161 = llhd.extract_slice %index_nodes.prb, 3 : !llhd.array<16xi4> -> !llhd.array<13xi4>
    %162 = llhd.insert_slice %45, %160, 13 : !llhd.array<16xi4>, !llhd.array<3xi4>
    %163 = llhd.insert_slice %162, %161, 0 : !llhd.array<16xi4>, !llhd.array<13xi4>
    %164 = llhd.extract_element %163, 0 : !llhd.array<16xi4> -> i4
    %165 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<4xi4>
    %166 = llhd.extract_slice %index_nodes.prb, 4 : !llhd.array<16xi4> -> !llhd.array<12xi4>
    %167 = llhd.insert_slice %45, %165, 12 : !llhd.array<16xi4>, !llhd.array<4xi4>
    %168 = llhd.insert_slice %167, %166, 0 : !llhd.array<16xi4>, !llhd.array<12xi4>
    %169 = llhd.extract_element %168, 0 : !llhd.array<16xi4> -> i4
    %170 = llhd.array %169, %164 : !llhd.array<2xi4>
    %171 = llhd.dyn_extract_element %170, %159 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %157, %171 after %6 : !llhd.sig<i4>
    %172 = llhd.sig "172" %2 : i16
    %173 = llhd.shr %sel_nodes, %172, %50 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %174 = llhd.extract_slice %173, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %175 = llhd.extract_slice %sel_nodes.prb, 5 : i16 -> i11
    %176 = llhd.insert_slice %2, %175, 0 : i16, i11
    %177 = llhd.extract_slice %176, 0 : i16 -> i1
    %178 = llhd.extract_slice %sel_nodes.prb, 6 : i16 -> i10
    %179 = llhd.insert_slice %2, %178, 0 : i16, i10
    %180 = llhd.extract_slice %179, 0 : i16 -> i1
    %181 = llhd.or %177, %180 : i1
    llhd.drv %174, %181 after %6 : !llhd.sig<i1>
    %182 = llhd.sig "182" %45 : !llhd.array<16xi4>
    %183 = llhd.shr %index_nodes, %182, %50 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %184 = llhd.extract_element %183, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %185 = llhd.eq %177, %129 : i1
    %186 = llhd.neq %185, %131 : i1
    %187 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<5xi4>
    %188 = llhd.extract_slice %index_nodes.prb, 5 : !llhd.array<16xi4> -> !llhd.array<11xi4>
    %189 = llhd.insert_slice %45, %187, 11 : !llhd.array<16xi4>, !llhd.array<5xi4>
    %190 = llhd.insert_slice %189, %188, 0 : !llhd.array<16xi4>, !llhd.array<11xi4>
    %191 = llhd.extract_element %190, 0 : !llhd.array<16xi4> -> i4
    %192 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<6xi4>
    %193 = llhd.extract_slice %index_nodes.prb, 6 : !llhd.array<16xi4> -> !llhd.array<10xi4>
    %194 = llhd.insert_slice %45, %192, 10 : !llhd.array<16xi4>, !llhd.array<6xi4>
    %195 = llhd.insert_slice %194, %193, 0 : !llhd.array<16xi4>, !llhd.array<10xi4>
    %196 = llhd.extract_element %195, 0 : !llhd.array<16xi4> -> i4
    %197 = llhd.array %196, %191 : !llhd.array<2xi4>
    %198 = llhd.dyn_extract_element %197, %186 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %184, %198 after %6 : !llhd.sig<i4>
    %199 = llhd.sig "199" %2 : i16
    %200 = llhd.shr %sel_nodes, %199, %55 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %201 = llhd.extract_slice %200, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %202 = llhd.extract_slice %sel_nodes.prb, 7 : i16 -> i9
    %203 = llhd.insert_slice %2, %202, 0 : i16, i9
    %204 = llhd.extract_slice %203, 0 : i16 -> i1
    %205 = llhd.extract_slice %sel_nodes.prb, 8 : i16 -> i8
    %206 = llhd.insert_slice %2, %205, 0 : i16, i8
    %207 = llhd.extract_slice %206, 0 : i16 -> i1
    %208 = llhd.or %204, %207 : i1
    llhd.drv %201, %208 after %6 : !llhd.sig<i1>
    %209 = llhd.sig "209" %45 : !llhd.array<16xi4>
    %210 = llhd.shr %index_nodes, %209, %55 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %211 = llhd.extract_element %210, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %212 = llhd.eq %204, %129 : i1
    %213 = llhd.neq %212, %131 : i1
    %214 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<7xi4>
    %215 = llhd.extract_slice %index_nodes.prb, 7 : !llhd.array<16xi4> -> !llhd.array<9xi4>
    %216 = llhd.insert_slice %45, %214, 9 : !llhd.array<16xi4>, !llhd.array<7xi4>
    %217 = llhd.insert_slice %216, %215, 0 : !llhd.array<16xi4>, !llhd.array<9xi4>
    %218 = llhd.extract_element %217, 0 : !llhd.array<16xi4> -> i4
    %219 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<8xi4>
    %220 = llhd.extract_slice %index_nodes.prb, 8 : !llhd.array<16xi4> -> !llhd.array<8xi4>
    %221 = llhd.insert_slice %45, %219, 8 : !llhd.array<16xi4>, !llhd.array<8xi4>
    %222 = llhd.insert_slice %221, %220, 0 : !llhd.array<16xi4>, !llhd.array<8xi4>
    %223 = llhd.extract_element %222, 0 : !llhd.array<16xi4> -> i4
    %224 = llhd.array %223, %218 : !llhd.array<2xi4>
    %225 = llhd.dyn_extract_element %224, %213 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %211, %225 after %6 : !llhd.sig<i4>
    %226 = llhd.sig "226" %2 : i16
    %227 = llhd.shr %sel_nodes, %226, %60 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %228 = llhd.extract_slice %227, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %229 = llhd.extract_slice %sel_nodes.prb, 9 : i16 -> i7
    %230 = llhd.insert_slice %2, %229, 0 : i16, i7
    %231 = llhd.extract_slice %230, 0 : i16 -> i1
    %232 = llhd.extract_slice %sel_nodes.prb, 10 : i16 -> i6
    %233 = llhd.insert_slice %2, %232, 0 : i16, i6
    %234 = llhd.extract_slice %233, 0 : i16 -> i1
    %235 = llhd.or %231, %234 : i1
    llhd.drv %228, %235 after %6 : !llhd.sig<i1>
    %236 = llhd.sig "236" %45 : !llhd.array<16xi4>
    %237 = llhd.shr %index_nodes, %236, %60 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %238 = llhd.extract_element %237, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %239 = llhd.eq %231, %129 : i1
    %240 = llhd.neq %239, %131 : i1
    %241 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<9xi4>
    %242 = llhd.extract_slice %index_nodes.prb, 9 : !llhd.array<16xi4> -> !llhd.array<7xi4>
    %243 = llhd.insert_slice %45, %241, 7 : !llhd.array<16xi4>, !llhd.array<9xi4>
    %244 = llhd.insert_slice %243, %242, 0 : !llhd.array<16xi4>, !llhd.array<7xi4>
    %245 = llhd.extract_element %244, 0 : !llhd.array<16xi4> -> i4
    %246 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<10xi4>
    %247 = llhd.extract_slice %index_nodes.prb, 10 : !llhd.array<16xi4> -> !llhd.array<6xi4>
    %248 = llhd.insert_slice %45, %246, 6 : !llhd.array<16xi4>, !llhd.array<10xi4>
    %249 = llhd.insert_slice %248, %247, 0 : !llhd.array<16xi4>, !llhd.array<6xi4>
    %250 = llhd.extract_element %249, 0 : !llhd.array<16xi4> -> i4
    %251 = llhd.array %250, %245 : !llhd.array<2xi4>
    %252 = llhd.dyn_extract_element %251, %240 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %238, %252 after %6 : !llhd.sig<i4>
    %253 = llhd.sig "253" %2 : i16
    %254 = llhd.shr %sel_nodes, %253, %65 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %255 = llhd.extract_slice %254, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %256 = llhd.extract_slice %sel_nodes.prb, 11 : i16 -> i5
    %257 = llhd.insert_slice %2, %256, 0 : i16, i5
    %258 = llhd.extract_slice %257, 0 : i16 -> i1
    %259 = llhd.extract_slice %sel_nodes.prb, 12 : i16 -> i4
    %260 = llhd.insert_slice %2, %259, 0 : i16, i4
    %261 = llhd.extract_slice %260, 0 : i16 -> i1
    %262 = llhd.or %258, %261 : i1
    llhd.drv %255, %262 after %6 : !llhd.sig<i1>
    %263 = llhd.sig "263" %45 : !llhd.array<16xi4>
    %264 = llhd.shr %index_nodes, %263, %65 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %265 = llhd.extract_element %264, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %266 = llhd.eq %258, %129 : i1
    %267 = llhd.neq %266, %131 : i1
    %268 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<11xi4>
    %269 = llhd.extract_slice %index_nodes.prb, 11 : !llhd.array<16xi4> -> !llhd.array<5xi4>
    %270 = llhd.insert_slice %45, %268, 5 : !llhd.array<16xi4>, !llhd.array<11xi4>
    %271 = llhd.insert_slice %270, %269, 0 : !llhd.array<16xi4>, !llhd.array<5xi4>
    %272 = llhd.extract_element %271, 0 : !llhd.array<16xi4> -> i4
    %273 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<12xi4>
    %274 = llhd.extract_slice %index_nodes.prb, 12 : !llhd.array<16xi4> -> !llhd.array<4xi4>
    %275 = llhd.insert_slice %45, %273, 4 : !llhd.array<16xi4>, !llhd.array<12xi4>
    %276 = llhd.insert_slice %275, %274, 0 : !llhd.array<16xi4>, !llhd.array<4xi4>
    %277 = llhd.extract_element %276, 0 : !llhd.array<16xi4> -> i4
    %278 = llhd.array %277, %272 : !llhd.array<2xi4>
    %279 = llhd.dyn_extract_element %278, %267 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %265, %279 after %6 : !llhd.sig<i4>
    %280 = llhd.sig "280" %2 : i16
    %281 = llhd.shr %sel_nodes, %280, %70 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %282 = llhd.extract_slice %281, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %283 = llhd.extract_slice %sel_nodes.prb, 13 : i16 -> i3
    %284 = llhd.insert_slice %2, %283, 0 : i16, i3
    %285 = llhd.extract_slice %284, 0 : i16 -> i1
    %286 = llhd.extract_slice %sel_nodes.prb, 14 : i16 -> i2
    %287 = llhd.insert_slice %2, %286, 0 : i16, i2
    %288 = llhd.extract_slice %287, 0 : i16 -> i1
    %289 = llhd.or %285, %288 : i1
    llhd.drv %282, %289 after %6 : !llhd.sig<i1>
    %290 = llhd.sig "290" %45 : !llhd.array<16xi4>
    %291 = llhd.shr %index_nodes, %290, %70 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %292 = llhd.extract_element %291, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %293 = llhd.eq %285, %129 : i1
    %294 = llhd.neq %293, %131 : i1
    %295 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<13xi4>
    %296 = llhd.extract_slice %index_nodes.prb, 13 : !llhd.array<16xi4> -> !llhd.array<3xi4>
    %297 = llhd.insert_slice %45, %295, 3 : !llhd.array<16xi4>, !llhd.array<13xi4>
    %298 = llhd.insert_slice %297, %296, 0 : !llhd.array<16xi4>, !llhd.array<3xi4>
    %299 = llhd.extract_element %298, 0 : !llhd.array<16xi4> -> i4
    %300 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<14xi4>
    %301 = llhd.extract_slice %index_nodes.prb, 14 : !llhd.array<16xi4> -> !llhd.array<2xi4>
    %302 = llhd.insert_slice %45, %300, 2 : !llhd.array<16xi4>, !llhd.array<14xi4>
    %303 = llhd.insert_slice %302, %301, 0 : !llhd.array<16xi4>, !llhd.array<2xi4>
    %304 = llhd.extract_element %303, 0 : !llhd.array<16xi4> -> i4
    %305 = llhd.array %304, %299 : !llhd.array<2xi4>
    %306 = llhd.dyn_extract_element %305, %294 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %292, %306 after %6 : !llhd.sig<i4>
    %307 = llhd.sig "307" %2 : i16
    %308 = llhd.shr %sel_nodes, %307, %75 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %309 = llhd.extract_slice %308, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %in_tmp.prb = llhd.prb %in_tmp : !llhd.sig<i16>
    %310 = llhd.extract_slice %in_tmp.prb, 0 : i16 -> i1
    %311 = llhd.extract_slice %in_tmp.prb, 1 : i16 -> i15
    %312 = llhd.insert_slice %2, %311, 0 : i16, i15
    %313 = llhd.extract_slice %312, 0 : i16 -> i1
    %314 = llhd.or %310, %313 : i1
    llhd.drv %309, %314 after %6 : !llhd.sig<i1>
    %315 = llhd.sig "315" %45 : !llhd.array<16xi4>
    %316 = llhd.shr %index_nodes, %315, %75 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %317 = llhd.extract_element %316, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %318 = llhd.eq %310, %129 : i1
    %319 = llhd.neq %318, %131 : i1
    %index_lut.prb = llhd.prb %index_lut : !llhd.sig<!llhd.array<16xi4>>
    %320 = llhd.extract_element %index_lut.prb, 0 : !llhd.array<16xi4> -> i4
    %321 = llhd.extract_slice %index_lut.prb, 1 : !llhd.array<16xi4> -> !llhd.array<15xi4>
    %322 = llhd.insert_slice %135, %321, 0 : !llhd.array<16xi4>, !llhd.array<15xi4>
    %323 = llhd.extract_element %322, 0 : !llhd.array<16xi4> -> i4
    %324 = llhd.array %323, %320 : !llhd.array<2xi4>
    %325 = llhd.dyn_extract_element %324, %319 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %317, %325 after %6 : !llhd.sig<i4>
    %326 = llhd.sig "326" %2 : i16
    %327 = llhd.shr %sel_nodes, %326, %80 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %328 = llhd.extract_slice %327, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %329 = llhd.extract_slice %in_tmp.prb, 2 : i16 -> i14
    %330 = llhd.insert_slice %2, %329, 0 : i16, i14
    %331 = llhd.extract_slice %330, 0 : i16 -> i1
    %332 = llhd.extract_slice %in_tmp.prb, 3 : i16 -> i13
    %333 = llhd.insert_slice %2, %332, 0 : i16, i13
    %334 = llhd.extract_slice %333, 0 : i16 -> i1
    %335 = llhd.or %331, %334 : i1
    llhd.drv %328, %335 after %6 : !llhd.sig<i1>
    %336 = llhd.sig "336" %45 : !llhd.array<16xi4>
    %337 = llhd.shr %index_nodes, %336, %80 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %338 = llhd.extract_element %337, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %339 = llhd.eq %331, %129 : i1
    %340 = llhd.neq %339, %131 : i1
    %341 = llhd.extract_slice %index_lut.prb, 2 : !llhd.array<16xi4> -> !llhd.array<14xi4>
    %342 = llhd.insert_slice %140, %341, 0 : !llhd.array<16xi4>, !llhd.array<14xi4>
    %343 = llhd.extract_element %342, 0 : !llhd.array<16xi4> -> i4
    %344 = llhd.extract_slice %index_lut.prb, 3 : !llhd.array<16xi4> -> !llhd.array<13xi4>
    %345 = llhd.insert_slice %162, %344, 0 : !llhd.array<16xi4>, !llhd.array<13xi4>
    %346 = llhd.extract_element %345, 0 : !llhd.array<16xi4> -> i4
    %347 = llhd.array %346, %343 : !llhd.array<2xi4>
    %348 = llhd.dyn_extract_element %347, %340 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %338, %348 after %6 : !llhd.sig<i4>
    %349 = llhd.sig "349" %2 : i16
    %350 = llhd.shr %sel_nodes, %349, %85 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %351 = llhd.extract_slice %350, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %352 = llhd.extract_slice %in_tmp.prb, 4 : i16 -> i12
    %353 = llhd.insert_slice %2, %352, 0 : i16, i12
    %354 = llhd.extract_slice %353, 0 : i16 -> i1
    %355 = llhd.extract_slice %in_tmp.prb, 5 : i16 -> i11
    %356 = llhd.insert_slice %2, %355, 0 : i16, i11
    %357 = llhd.extract_slice %356, 0 : i16 -> i1
    %358 = llhd.or %354, %357 : i1
    llhd.drv %351, %358 after %6 : !llhd.sig<i1>
    %359 = llhd.sig "359" %45 : !llhd.array<16xi4>
    %360 = llhd.shr %index_nodes, %359, %85 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %361 = llhd.extract_element %360, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %362 = llhd.eq %354, %129 : i1
    %363 = llhd.neq %362, %131 : i1
    %364 = llhd.extract_slice %index_lut.prb, 4 : !llhd.array<16xi4> -> !llhd.array<12xi4>
    %365 = llhd.insert_slice %167, %364, 0 : !llhd.array<16xi4>, !llhd.array<12xi4>
    %366 = llhd.extract_element %365, 0 : !llhd.array<16xi4> -> i4
    %367 = llhd.extract_slice %index_lut.prb, 5 : !llhd.array<16xi4> -> !llhd.array<11xi4>
    %368 = llhd.insert_slice %189, %367, 0 : !llhd.array<16xi4>, !llhd.array<11xi4>
    %369 = llhd.extract_element %368, 0 : !llhd.array<16xi4> -> i4
    %370 = llhd.array %369, %366 : !llhd.array<2xi4>
    %371 = llhd.dyn_extract_element %370, %363 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %361, %371 after %6 : !llhd.sig<i4>
    %372 = llhd.sig "372" %2 : i16
    %373 = llhd.shr %sel_nodes, %372, %90 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %374 = llhd.extract_slice %373, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %375 = llhd.extract_slice %in_tmp.prb, 6 : i16 -> i10
    %376 = llhd.insert_slice %2, %375, 0 : i16, i10
    %377 = llhd.extract_slice %376, 0 : i16 -> i1
    %378 = llhd.extract_slice %in_tmp.prb, 7 : i16 -> i9
    %379 = llhd.insert_slice %2, %378, 0 : i16, i9
    %380 = llhd.extract_slice %379, 0 : i16 -> i1
    %381 = llhd.or %377, %380 : i1
    llhd.drv %374, %381 after %6 : !llhd.sig<i1>
    %382 = llhd.sig "382" %45 : !llhd.array<16xi4>
    %383 = llhd.shr %index_nodes, %382, %90 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %384 = llhd.extract_element %383, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %385 = llhd.eq %377, %129 : i1
    %386 = llhd.neq %385, %131 : i1
    %387 = llhd.extract_slice %index_lut.prb, 6 : !llhd.array<16xi4> -> !llhd.array<10xi4>
    %388 = llhd.insert_slice %194, %387, 0 : !llhd.array<16xi4>, !llhd.array<10xi4>
    %389 = llhd.extract_element %388, 0 : !llhd.array<16xi4> -> i4
    %390 = llhd.extract_slice %index_lut.prb, 7 : !llhd.array<16xi4> -> !llhd.array<9xi4>
    %391 = llhd.insert_slice %216, %390, 0 : !llhd.array<16xi4>, !llhd.array<9xi4>
    %392 = llhd.extract_element %391, 0 : !llhd.array<16xi4> -> i4
    %393 = llhd.array %392, %389 : !llhd.array<2xi4>
    %394 = llhd.dyn_extract_element %393, %386 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %384, %394 after %6 : !llhd.sig<i4>
    %395 = llhd.sig "395" %2 : i16
    %396 = llhd.shr %sel_nodes, %395, %95 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %397 = llhd.extract_slice %396, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %398 = llhd.extract_slice %in_tmp.prb, 8 : i16 -> i8
    %399 = llhd.insert_slice %2, %398, 0 : i16, i8
    %400 = llhd.extract_slice %399, 0 : i16 -> i1
    %401 = llhd.extract_slice %in_tmp.prb, 9 : i16 -> i7
    %402 = llhd.insert_slice %2, %401, 0 : i16, i7
    %403 = llhd.extract_slice %402, 0 : i16 -> i1
    %404 = llhd.or %400, %403 : i1
    llhd.drv %397, %404 after %6 : !llhd.sig<i1>
    %405 = llhd.sig "405" %45 : !llhd.array<16xi4>
    %406 = llhd.shr %index_nodes, %405, %95 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %407 = llhd.extract_element %406, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %408 = llhd.eq %400, %129 : i1
    %409 = llhd.neq %408, %131 : i1
    %410 = llhd.extract_slice %index_lut.prb, 8 : !llhd.array<16xi4> -> !llhd.array<8xi4>
    %411 = llhd.insert_slice %221, %410, 0 : !llhd.array<16xi4>, !llhd.array<8xi4>
    %412 = llhd.extract_element %411, 0 : !llhd.array<16xi4> -> i4
    %413 = llhd.extract_slice %index_lut.prb, 9 : !llhd.array<16xi4> -> !llhd.array<7xi4>
    %414 = llhd.insert_slice %243, %413, 0 : !llhd.array<16xi4>, !llhd.array<7xi4>
    %415 = llhd.extract_element %414, 0 : !llhd.array<16xi4> -> i4
    %416 = llhd.array %415, %412 : !llhd.array<2xi4>
    %417 = llhd.dyn_extract_element %416, %409 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %407, %417 after %6 : !llhd.sig<i4>
    %418 = llhd.sig "418" %2 : i16
    %419 = llhd.shr %sel_nodes, %418, %100 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %420 = llhd.extract_slice %419, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %421 = llhd.extract_slice %in_tmp.prb, 10 : i16 -> i6
    %422 = llhd.insert_slice %2, %421, 0 : i16, i6
    %423 = llhd.extract_slice %422, 0 : i16 -> i1
    %424 = llhd.extract_slice %in_tmp.prb, 11 : i16 -> i5
    %425 = llhd.insert_slice %2, %424, 0 : i16, i5
    %426 = llhd.extract_slice %425, 0 : i16 -> i1
    %427 = llhd.or %423, %426 : i1
    llhd.drv %420, %427 after %6 : !llhd.sig<i1>
    %428 = llhd.sig "428" %45 : !llhd.array<16xi4>
    %429 = llhd.shr %index_nodes, %428, %100 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %430 = llhd.extract_element %429, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %431 = llhd.eq %423, %129 : i1
    %432 = llhd.neq %431, %131 : i1
    %433 = llhd.extract_slice %index_lut.prb, 10 : !llhd.array<16xi4> -> !llhd.array<6xi4>
    %434 = llhd.insert_slice %248, %433, 0 : !llhd.array<16xi4>, !llhd.array<6xi4>
    %435 = llhd.extract_element %434, 0 : !llhd.array<16xi4> -> i4
    %436 = llhd.extract_slice %index_lut.prb, 11 : !llhd.array<16xi4> -> !llhd.array<5xi4>
    %437 = llhd.insert_slice %270, %436, 0 : !llhd.array<16xi4>, !llhd.array<5xi4>
    %438 = llhd.extract_element %437, 0 : !llhd.array<16xi4> -> i4
    %439 = llhd.array %438, %435 : !llhd.array<2xi4>
    %440 = llhd.dyn_extract_element %439, %432 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %430, %440 after %6 : !llhd.sig<i4>
    %441 = llhd.sig "441" %2 : i16
    %442 = llhd.shr %sel_nodes, %441, %105 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %443 = llhd.extract_slice %442, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %444 = llhd.extract_slice %in_tmp.prb, 12 : i16 -> i4
    %445 = llhd.insert_slice %2, %444, 0 : i16, i4
    %446 = llhd.extract_slice %445, 0 : i16 -> i1
    %447 = llhd.extract_slice %in_tmp.prb, 13 : i16 -> i3
    %448 = llhd.insert_slice %2, %447, 0 : i16, i3
    %449 = llhd.extract_slice %448, 0 : i16 -> i1
    %450 = llhd.or %446, %449 : i1
    llhd.drv %443, %450 after %6 : !llhd.sig<i1>
    %451 = llhd.sig "451" %45 : !llhd.array<16xi4>
    %452 = llhd.shr %index_nodes, %451, %105 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %453 = llhd.extract_element %452, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %454 = llhd.eq %446, %129 : i1
    %455 = llhd.neq %454, %131 : i1
    %456 = llhd.extract_slice %index_lut.prb, 12 : !llhd.array<16xi4> -> !llhd.array<4xi4>
    %457 = llhd.insert_slice %275, %456, 0 : !llhd.array<16xi4>, !llhd.array<4xi4>
    %458 = llhd.extract_element %457, 0 : !llhd.array<16xi4> -> i4
    %459 = llhd.extract_slice %index_lut.prb, 13 : !llhd.array<16xi4> -> !llhd.array<3xi4>
    %460 = llhd.insert_slice %297, %459, 0 : !llhd.array<16xi4>, !llhd.array<3xi4>
    %461 = llhd.extract_element %460, 0 : !llhd.array<16xi4> -> i4
    %462 = llhd.array %461, %458 : !llhd.array<2xi4>
    %463 = llhd.dyn_extract_element %462, %455 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %453, %463 after %6 : !llhd.sig<i4>
    %464 = llhd.sig "464" %2 : i16
    %465 = llhd.shr %sel_nodes, %464, %110 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %466 = llhd.extract_slice %465, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %467 = llhd.extract_slice %in_tmp.prb, 14 : i16 -> i2
    %468 = llhd.insert_slice %2, %467, 0 : i16, i2
    %469 = llhd.extract_slice %468, 0 : i16 -> i1
    %470 = llhd.extract_slice %in_tmp.prb, 15 : i16 -> i1
    %471 = llhd.insert_slice %2, %470, 0 : i16, i1
    %472 = llhd.extract_slice %471, 0 : i16 -> i1
    %473 = llhd.or %469, %472 : i1
    llhd.drv %466, %473 after %6 : !llhd.sig<i1>
    %474 = llhd.sig "474" %45 : !llhd.array<16xi4>
    %475 = llhd.shr %index_nodes, %474, %110 : (!llhd.sig<!llhd.array<16xi4>>, !llhd.sig<!llhd.array<16xi4>>, i32) -> !llhd.sig<!llhd.array<16xi4>>
    %476 = llhd.extract_element %475, 0 : !llhd.sig<!llhd.array<16xi4>> -> !llhd.sig<i4>
    %477 = llhd.eq %469, %129 : i1
    %478 = llhd.neq %477, %131 : i1
    %479 = llhd.extract_slice %index_lut.prb, 14 : !llhd.array<16xi4> -> !llhd.array<2xi4>
    %480 = llhd.insert_slice %302, %479, 0 : !llhd.array<16xi4>, !llhd.array<2xi4>
    %481 = llhd.extract_element %480, 0 : !llhd.array<16xi4> -> i4
    %482 = llhd.extract_slice %45, 0 : !llhd.array<16xi4> -> !llhd.array<15xi4>
    %483 = llhd.extract_slice %index_lut.prb, 15 : !llhd.array<16xi4> -> !llhd.array<1xi4>
    %484 = llhd.insert_slice %45, %482, 1 : !llhd.array<16xi4>, !llhd.array<15xi4>
    %485 = llhd.insert_slice %484, %483, 0 : !llhd.array<16xi4>, !llhd.array<1xi4>
    %486 = llhd.extract_element %485, 0 : !llhd.array<16xi4> -> i4
    %487 = llhd.array %486, %481 : !llhd.array<2xi4>
    %488 = llhd.dyn_extract_element %487, %478 : (!llhd.array<2xi4>, i1) -> i4
    llhd.drv %476, %488 after %6 : !llhd.sig<i4>
    llhd.inst "inst" @lzc.param1.initial.69.1() -> () : () -> ()
    llhd.inst "inst1" @lzc.param1.always_comb.217.1(%in_i) -> (%in_tmp) : (!llhd.sig<i16>) -> (!llhd.sig<i16>)
}

llhd.proc @lfsr_16bit.param3.always_comb.1243.3(%en_i: !llhd.sig<i1>, %shift_q: !llhd.sig<i16>) -> (%out_o: !llhd.sig<i16> , %shift_d: !llhd.sig<i16> ) {
    br ^body
^body:
    %shift_q.prb = llhd.prb %shift_q : !llhd.sig<i16>
    %0 = llhd.extract_slice %shift_q.prb, 15 : i16 -> i1
    %1 = llhd.const 0 : i16
    %2 = llhd.insert_slice %1, %0, 0 : i16, i1
    %3 = llhd.extract_slice %2, 0 : i16 -> i1
    %4 = llhd.extract_slice %shift_q.prb, 12 : i16 -> i4
    %5 = llhd.insert_slice %1, %4, 0 : i16, i4
    %6 = llhd.extract_slice %5, 0 : i16 -> i1
    %7 = llhd.xor %3, %6 : i1
    %8 = llhd.extract_slice %shift_q.prb, 5 : i16 -> i11
    %9 = llhd.insert_slice %1, %8, 0 : i16, i11
    %10 = llhd.extract_slice %9, 0 : i16 -> i1
    %11 = llhd.xor %7, %10 : i1
    %12 = llhd.extract_slice %shift_q.prb, 1 : i16 -> i15
    %13 = llhd.insert_slice %1, %12, 0 : i16, i15
    %14 = llhd.extract_slice %13, 0 : i16 -> i1
    %15 = llhd.xor %11, %14 : i1
    %16 = llhd.const 0 : i1
    %17 = llhd.neq %15, %16 : i1
    %18 = llhd.not %17 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %shift_q.prb after %19 : !llhd.sig<i16>
    %en_i.prb = llhd.prb %en_i : !llhd.sig<i1>
    %20 = llhd.neq %en_i.prb, %16 : i1
    cond_br %20, ^if_true, ^if_exit
^if_exit:
    llhd.drv %out_o, %shift_q.prb after %19 : !llhd.sig<i16>
    llhd.wait (%en_i, %shift_q : !llhd.sig<i1>, !llhd.sig<i16>), ^body
^if_true:
    %21 = llhd.insert_slice %1, %18, 0 : i16, i1
    %22 = llhd.extract_slice %shift_q.prb, 0 : i16 -> i15
    %concat = llhd.insert_slice %21, %22, 1 : i16, i15
    llhd.drv %shift_d, %concat after %19 : !llhd.sig<i16>
    br ^if_exit
}

llhd.proc @lfsr_16bit.param3.always_ff.1284.3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %shift_d: !llhd.sig<i16>) -> (%shift_q: !llhd.sig<i16> ) {
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
    %shift_d.prb = llhd.prb %shift_d : !llhd.sig<i16>
    llhd.drv %shift_q, %shift_d.prb after %7 : !llhd.sig<i16>
    br ^init
^if_true:
    %8 = llhd.const 1 : i16
    llhd.drv %shift_q, %8 after %7 : !llhd.sig<i16>
    br ^init
}

llhd.proc @lfsr_16bit.param3.initial.1302.3() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param3(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %shift_d = llhd.sig "shift_d" %0 : i16
    %shift_q = llhd.sig "shift_q" %0 : i16
    llhd.inst "inst" @lfsr_16bit.param3.always_comb.1243.3(%en_i, %shift_q) -> (%out_o, %shift_d) : (!llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param3.always_ff.1284.3(%clk_i, %rst_ni, %shift_d) -> (%shift_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i16>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param3.initial.1302.3() -> () : () -> ()
}

llhd.proc @lzc_tb.initial.1083.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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

llhd.entity @lzc_tb() -> () {
    %0 = llhd.const 0 : i16
    %in_i = llhd.sig "in_i" %0 : i16
    %1 = llhd.const 0 : i4
    %cnt_o = llhd.sig "cnt_o" %1 : i4
    %2 = llhd.const 0 : i1
    %empty_o = llhd.sig "empty_o" %2 : i1
    %clk_i = llhd.sig "clk_i" %2 : i1
    %3 = llhd.const 1 : i1
    %rst_ni = llhd.sig "rst_ni" %3 : i1
    %in_i.prb = llhd.prb %in_i : !llhd.sig<i16>
    %4 = llhd.sig "4" %0 : i16
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %in_i.prb after %5 : !llhd.sig<i16>
    llhd.inst "inst" @lzc.param1(%4) -> (%cnt_o, %empty_o) : (!llhd.sig<i16>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
    %clk_i.prb = llhd.prb %clk_i : !llhd.sig<i1>
    %6 = llhd.sig "6" %2 : i1
    llhd.drv %6, %clk_i.prb after %5 : !llhd.sig<i1>
    %rst_ni.prb = llhd.prb %rst_ni : !llhd.sig<i1>
    %7 = llhd.sig "7" %2 : i1
    llhd.drv %7, %rst_ni.prb after %5 : !llhd.sig<i1>
    %8 = llhd.sig "8" %2 : i1
    llhd.drv %8, %3 after %5 : !llhd.sig<i1>
    llhd.inst "inst1" @lfsr_16bit.param3(%6, %7, %8) -> (%in_i) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lzc_tb.initial.1083.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
