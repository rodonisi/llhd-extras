llhd.proc @rr_arb_tree.param1.always_ff.639.1(%rr_d: !llhd.sig<i3>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>) -> (%rr_q: !llhd.sig<i3> ) {
    br ^init
^init:
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    llhd.wait (%clk_i, %rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %clk_i2 = llhd.prb %clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
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
    %8 = constant 0 : i3
    %9 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %flush_i1 = llhd.prb %flush_i : !llhd.sig<i1>
    %10 = cmpi "ne", %flush_i1, %0 : i1
    cond_br %10, ^if_true1, ^if_false1
^if_true:
    llhd.drv %rr_q, %8 after %9 : !llhd.sig<i3>
    br ^init
^if_false1:
    %rr_d1 = llhd.prb %rr_d : !llhd.sig<i3>
    llhd.drv %rr_q, %rr_d1 after %9 : !llhd.sig<i3>
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

llhd.entity @rr_arb_tree.param1(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %flush_i: !llhd.sig<i1>, %rr_i: !llhd.sig<i3>, %req_i: !llhd.sig<i8>, %data_i: !llhd.sig<vector<8xi32>>, %gnt_i: !llhd.sig<i1>) -> (%gnt_o: !llhd.sig<i8> , %req_o: !llhd.sig<i1> , %data_o: !llhd.sig<i32> , %idx_o: !llhd.sig<i3> ) {
    %0 = constant 0 : i3
    %1 = llhd.vec %0, %0, %0, %0, %0, %0, %0 : vector<7xi3>
    %index_nodes = llhd.sig "sig" %1 : vector<7xi3>
    %2 = constant 0 : i32
    %3 = llhd.vec %2, %2, %2, %2, %2, %2, %2 : vector<7xi32>
    %data_nodes = llhd.sig "sig1" %3 : vector<7xi32>
    %4 = constant 0 : i7
    %gnt_nodes = llhd.sig "sig2" %4 : i7
    %req_nodes = llhd.sig "sig3" %4 : i7
    %rr_q = llhd.sig "sig4" %0 : i3
    %5 = constant 0 : i8
    %req_d = llhd.sig "sig5" %5 : i8
    %req_nodes1 = llhd.prb %req_nodes : !llhd.sig<i7>
    %6 = llhd.exts %req_nodes1, 0 : i7 -> i1
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %req_o, %6 after %7 : !llhd.sig<i1>
    %data_nodes1 = llhd.prb %data_nodes : !llhd.sig<vector<7xi32>>
    %8 = llhd.extf %data_nodes1, 0 : vector<7xi32> -> i32
    llhd.drv %data_o, %8 after %7 : !llhd.sig<i32>
    %index_nodes1 = llhd.prb %index_nodes : !llhd.sig<vector<7xi3>>
    %9 = llhd.extf %index_nodes1, 0 : vector<7xi3> -> i3
    llhd.drv %idx_o, %9 after %7 : !llhd.sig<i3>
    %10 = llhd.exts %gnt_nodes, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %gnt_i1 = llhd.prb %gnt_i : !llhd.sig<i1>
    llhd.drv %10, %gnt_i1 after %7 : !llhd.sig<i1>
    %rr_d = llhd.sig "sig6" %0 : i3
    %11 = constant 0 : i1
    %12 = cmpi "ne", %gnt_i1, %11 : i1
    %req_o1 = llhd.prb %req_o : !llhd.sig<i1>
    %13 = cmpi "ne", %req_o1, %11 : i1
    %14 = llhd.and %12, %13 : i1
    %15 = cmpi "ne", %14, %11 : i1
    %rr_q1 = llhd.prb %rr_q : !llhd.sig<i3>
    %16 = llhd.inss %2, %rr_q1, 0 : i32, i3
    %17 = constant 7 : i32
    %18 = cmpi "eq", %16, %17 : i32
    %19 = cmpi "ne", %18, %11 : i1
    %20 = constant 1 : i3
    %21 = addi %rr_q1, %20 : i3
    %22 = llhd.vec %21, %0 : vector<2xi3>
    %23 = llhd.dextf %22, %19 : (vector<2xi3>, i1) -> i3
    %24 = llhd.vec %rr_q1, %23 : vector<2xi3>
    %25 = llhd.dextf %24, %15 : (vector<2xi3>, i1) -> i3
    llhd.drv %rr_d, %25 after %7 : !llhd.sig<i3>
    %req_i1 = llhd.prb %req_i : !llhd.sig<i8>
    llhd.drv %req_d, %req_i1 after %7 : !llhd.sig<i8>
    llhd.inst "inst" @rr_arb_tree.param1.always_ff.639.1(%rr_d, %clk_i, %rst_ni, %flush_i) -> (%rr_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i3>)
    %sel = llhd.sig "sig7" %11 : i1
    %26 = llhd.exts %req_nodes, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %27 = llhd.exts %req_nodes1, 1 : i7 -> i6
    %28 = llhd.inss %4, %27, 0 : i7, i6
    %29 = llhd.exts %28, 0 : i7 -> i1
    %30 = llhd.exts %req_nodes1, 2 : i7 -> i5
    %31 = llhd.inss %4, %30, 0 : i7, i5
    %32 = llhd.exts %31, 0 : i7 -> i1
    %33 = llhd.or %29, %32 : i1
    llhd.drv %26, %33 after %7 : !llhd.sig<i1>
    %34 = llhd.not %29 : i1
    %35 = llhd.exts %rr_q1, 2 : i3 -> i1
    %36 = llhd.inss %0, %35, 0 : i3, i1
    %37 = llhd.exts %36, 0 : i3 -> i1
    %38 = llhd.and %32, %37 : i1
    %39 = llhd.or %34, %38 : i1
    llhd.drv %sel, %39 after %7 : !llhd.sig<i1>
    %40 = llhd.extf %index_nodes, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel1 = llhd.prb %sel : !llhd.sig<i1>
    %41 = cmpi "ne", %sel1, %11 : i1
    %42 = llhd.univec %0 : i3 -> vector<7xi3>
    %43 = llhd.exts %42, 0 : vector<7xi3> -> vector<2xi3>
    %44 = llhd.exts %index_nodes1, 2 : vector<7xi3> -> vector<5xi3>
    %45 = llhd.inss %42, %43, 5 : vector<7xi3>, vector<2xi3>
    %46 = llhd.inss %45, %44, 0 : vector<7xi3>, vector<5xi3>
    %47 = llhd.extf %46, 0 : vector<7xi3> -> i3
    %48 = llhd.exts %47, 0 : i3 -> i2
    %49 = llhd.inss %0, %48, 0 : i3, i2
    %50 = constant 1 : i1
    %51 = llhd.inss %49, %50, 2 : i3, i1
    %52 = llhd.exts %42, 0 : vector<7xi3> -> vector<1xi3>
    %53 = llhd.exts %index_nodes1, 1 : vector<7xi3> -> vector<6xi3>
    %54 = llhd.inss %42, %52, 6 : vector<7xi3>, vector<1xi3>
    %55 = llhd.inss %54, %53, 0 : vector<7xi3>, vector<6xi3>
    %56 = llhd.extf %55, 0 : vector<7xi3> -> i3
    %57 = llhd.exts %56, 0 : i3 -> i2
    %58 = llhd.inss %0, %57, 0 : i3, i2
    %59 = llhd.inss %58, %11, 2 : i3, i1
    %60 = llhd.vec %59, %51 : vector<2xi3>
    %61 = llhd.dextf %60, %41 : (vector<2xi3>, i1) -> i3
    llhd.drv %40, %61 after %7 : !llhd.sig<i3>
    %62 = llhd.extf %data_nodes, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %63 = llhd.univec %2 : i32 -> vector<7xi32>
    %64 = llhd.exts %63, 0 : vector<7xi32> -> vector<2xi32>
    %65 = llhd.exts %data_nodes1, 2 : vector<7xi32> -> vector<5xi32>
    %66 = llhd.inss %63, %64, 5 : vector<7xi32>, vector<2xi32>
    %67 = llhd.inss %66, %65, 0 : vector<7xi32>, vector<5xi32>
    %68 = llhd.extf %67, 0 : vector<7xi32> -> i32
    %69 = llhd.exts %63, 0 : vector<7xi32> -> vector<1xi32>
    %70 = llhd.exts %data_nodes1, 1 : vector<7xi32> -> vector<6xi32>
    %71 = llhd.inss %63, %69, 6 : vector<7xi32>, vector<1xi32>
    %72 = llhd.inss %71, %70, 0 : vector<7xi32>, vector<6xi32>
    %73 = llhd.extf %72, 0 : vector<7xi32> -> i32
    %74 = llhd.vec %73, %68 : vector<2xi32>
    %75 = llhd.dextf %74, %41 : (vector<2xi32>, i1) -> i32
    llhd.drv %62, %75 after %7 : !llhd.sig<i32>
    %76 = constant 1 : i32
    %77 = llhd.sig "sig8" %4 : i7
    %78 = llhd.shr %gnt_nodes, %77, %76 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %79 = llhd.exts %78, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %gnt_nodes1 = llhd.prb %gnt_nodes : !llhd.sig<i7>
    %80 = llhd.exts %gnt_nodes1, 0 : i7 -> i1
    %81 = llhd.not %sel1 : i1
    %82 = llhd.and %80, %81 : i1
    llhd.drv %79, %82 after %7 : !llhd.sig<i1>
    %83 = constant 2 : i32
    %84 = llhd.sig "sig9" %4 : i7
    %85 = llhd.shr %gnt_nodes, %84, %83 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %86 = llhd.exts %85, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %87 = llhd.and %80, %sel1 : i1
    llhd.drv %86, %87 after %7 : !llhd.sig<i1>
    %sel2 = llhd.sig "sig10" %11 : i1
    %88 = llhd.sig "sig11" %4 : i7
    %89 = llhd.shr %req_nodes, %88, %76 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %90 = llhd.exts %89, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %91 = llhd.exts %req_nodes1, 3 : i7 -> i4
    %92 = llhd.inss %4, %91, 0 : i7, i4
    %93 = llhd.exts %92, 0 : i7 -> i1
    %94 = llhd.exts %req_nodes1, 4 : i7 -> i3
    %95 = llhd.inss %4, %94, 0 : i7, i3
    %96 = llhd.exts %95, 0 : i7 -> i1
    %97 = llhd.or %93, %96 : i1
    llhd.drv %90, %97 after %7 : !llhd.sig<i1>
    %98 = llhd.not %93 : i1
    %99 = llhd.exts %rr_q1, 1 : i3 -> i2
    %100 = llhd.inss %0, %99, 0 : i3, i2
    %101 = llhd.exts %100, 0 : i3 -> i1
    %102 = llhd.and %96, %101 : i1
    %103 = llhd.or %98, %102 : i1
    llhd.drv %sel2, %103 after %7 : !llhd.sig<i1>
    %104 = llhd.sig "sig12" %42 : vector<7xi3>
    %105 = llhd.shr %index_nodes, %104, %76 : (!llhd.sig<vector<7xi3>>, !llhd.sig<vector<7xi3>>, i32) -> !llhd.sig<vector<7xi3>>
    %106 = llhd.extf %105, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel3 = llhd.prb %sel2 : !llhd.sig<i1>
    %107 = cmpi "ne", %sel3, %11 : i1
    %108 = constant 0 : i2
    %109 = llhd.exts %42, 0 : vector<7xi3> -> vector<4xi3>
    %110 = llhd.exts %index_nodes1, 4 : vector<7xi3> -> vector<3xi3>
    %111 = llhd.inss %42, %109, 3 : vector<7xi3>, vector<4xi3>
    %112 = llhd.inss %111, %110, 0 : vector<7xi3>, vector<3xi3>
    %113 = llhd.extf %112, 0 : vector<7xi3> -> i3
    %114 = llhd.exts %113, 0 : i3 -> i1
    %115 = llhd.inss %108, %114, 0 : i2, i1
    %116 = llhd.inss %115, %50, 1 : i2, i1
    %117 = llhd.inss %0, %116, 0 : i3, i2
    %118 = llhd.exts %42, 0 : vector<7xi3> -> vector<3xi3>
    %119 = llhd.exts %index_nodes1, 3 : vector<7xi3> -> vector<4xi3>
    %120 = llhd.inss %42, %118, 4 : vector<7xi3>, vector<3xi3>
    %121 = llhd.inss %120, %119, 0 : vector<7xi3>, vector<4xi3>
    %122 = llhd.extf %121, 0 : vector<7xi3> -> i3
    %123 = llhd.exts %122, 0 : i3 -> i1
    %124 = llhd.inss %108, %123, 0 : i2, i1
    %125 = llhd.inss %124, %11, 1 : i2, i1
    %126 = llhd.inss %0, %125, 0 : i3, i2
    %127 = llhd.vec %126, %117 : vector<2xi3>
    %128 = llhd.dextf %127, %107 : (vector<2xi3>, i1) -> i3
    llhd.drv %106, %128 after %7 : !llhd.sig<i3>
    %129 = llhd.sig "sig13" %63 : vector<7xi32>
    %130 = llhd.shr %data_nodes, %129, %76 : (!llhd.sig<vector<7xi32>>, !llhd.sig<vector<7xi32>>, i32) -> !llhd.sig<vector<7xi32>>
    %131 = llhd.extf %130, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %132 = llhd.exts %63, 0 : vector<7xi32> -> vector<4xi32>
    %133 = llhd.exts %data_nodes1, 4 : vector<7xi32> -> vector<3xi32>
    %134 = llhd.inss %63, %132, 3 : vector<7xi32>, vector<4xi32>
    %135 = llhd.inss %134, %133, 0 : vector<7xi32>, vector<3xi32>
    %136 = llhd.extf %135, 0 : vector<7xi32> -> i32
    %137 = llhd.exts %63, 0 : vector<7xi32> -> vector<3xi32>
    %138 = llhd.exts %data_nodes1, 3 : vector<7xi32> -> vector<4xi32>
    %139 = llhd.inss %63, %137, 4 : vector<7xi32>, vector<3xi32>
    %140 = llhd.inss %139, %138, 0 : vector<7xi32>, vector<4xi32>
    %141 = llhd.extf %140, 0 : vector<7xi32> -> i32
    %142 = llhd.vec %141, %136 : vector<2xi32>
    %143 = llhd.dextf %142, %107 : (vector<2xi32>, i1) -> i32
    llhd.drv %131, %143 after %7 : !llhd.sig<i32>
    %144 = constant 3 : i32
    %145 = llhd.sig "sig14" %4 : i7
    %146 = llhd.shr %gnt_nodes, %145, %144 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %147 = llhd.exts %146, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %148 = llhd.exts %gnt_nodes1, 1 : i7 -> i6
    %149 = llhd.inss %4, %148, 0 : i7, i6
    %150 = llhd.exts %149, 0 : i7 -> i1
    %151 = llhd.not %sel3 : i1
    %152 = llhd.and %150, %151 : i1
    llhd.drv %147, %152 after %7 : !llhd.sig<i1>
    %153 = constant 4 : i32
    %154 = llhd.sig "sig15" %4 : i7
    %155 = llhd.shr %gnt_nodes, %154, %153 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %156 = llhd.exts %155, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %157 = llhd.and %150, %sel3 : i1
    llhd.drv %156, %157 after %7 : !llhd.sig<i1>
    %sel4 = llhd.sig "sig16" %11 : i1
    %158 = llhd.sig "sig17" %4 : i7
    %159 = llhd.shr %req_nodes, %158, %83 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %160 = llhd.exts %159, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %161 = llhd.exts %req_nodes1, 5 : i7 -> i2
    %162 = llhd.inss %4, %161, 0 : i7, i2
    %163 = llhd.exts %162, 0 : i7 -> i1
    %164 = llhd.exts %req_nodes1, 6 : i7 -> i1
    %165 = llhd.inss %4, %164, 0 : i7, i1
    %166 = llhd.exts %165, 0 : i7 -> i1
    %167 = llhd.or %163, %166 : i1
    llhd.drv %160, %167 after %7 : !llhd.sig<i1>
    %168 = llhd.not %163 : i1
    %169 = llhd.and %166, %101 : i1
    %170 = llhd.or %168, %169 : i1
    llhd.drv %sel4, %170 after %7 : !llhd.sig<i1>
    %171 = llhd.sig "sig18" %42 : vector<7xi3>
    %172 = llhd.shr %index_nodes, %171, %83 : (!llhd.sig<vector<7xi3>>, !llhd.sig<vector<7xi3>>, i32) -> !llhd.sig<vector<7xi3>>
    %173 = llhd.extf %172, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel5 = llhd.prb %sel4 : !llhd.sig<i1>
    %174 = cmpi "ne", %sel5, %11 : i1
    %175 = llhd.exts %42, 0 : vector<7xi3> -> vector<6xi3>
    %176 = llhd.exts %index_nodes1, 6 : vector<7xi3> -> vector<1xi3>
    %177 = llhd.inss %42, %175, 1 : vector<7xi3>, vector<6xi3>
    %178 = llhd.inss %177, %176, 0 : vector<7xi3>, vector<1xi3>
    %179 = llhd.extf %178, 0 : vector<7xi3> -> i3
    %180 = llhd.exts %179, 0 : i3 -> i1
    %181 = llhd.inss %108, %180, 0 : i2, i1
    %182 = llhd.inss %181, %50, 1 : i2, i1
    %183 = llhd.inss %0, %182, 0 : i3, i2
    %184 = llhd.exts %42, 0 : vector<7xi3> -> vector<5xi3>
    %185 = llhd.exts %index_nodes1, 5 : vector<7xi3> -> vector<2xi3>
    %186 = llhd.inss %42, %184, 2 : vector<7xi3>, vector<5xi3>
    %187 = llhd.inss %186, %185, 0 : vector<7xi3>, vector<2xi3>
    %188 = llhd.extf %187, 0 : vector<7xi3> -> i3
    %189 = llhd.exts %188, 0 : i3 -> i1
    %190 = llhd.inss %108, %189, 0 : i2, i1
    %191 = llhd.inss %190, %11, 1 : i2, i1
    %192 = llhd.inss %0, %191, 0 : i3, i2
    %193 = llhd.vec %192, %183 : vector<2xi3>
    %194 = llhd.dextf %193, %174 : (vector<2xi3>, i1) -> i3
    llhd.drv %173, %194 after %7 : !llhd.sig<i3>
    %195 = llhd.sig "sig19" %63 : vector<7xi32>
    %196 = llhd.shr %data_nodes, %195, %83 : (!llhd.sig<vector<7xi32>>, !llhd.sig<vector<7xi32>>, i32) -> !llhd.sig<vector<7xi32>>
    %197 = llhd.extf %196, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %198 = llhd.exts %63, 0 : vector<7xi32> -> vector<6xi32>
    %199 = llhd.exts %data_nodes1, 6 : vector<7xi32> -> vector<1xi32>
    %200 = llhd.inss %63, %198, 1 : vector<7xi32>, vector<6xi32>
    %201 = llhd.inss %200, %199, 0 : vector<7xi32>, vector<1xi32>
    %202 = llhd.extf %201, 0 : vector<7xi32> -> i32
    %203 = llhd.exts %63, 0 : vector<7xi32> -> vector<5xi32>
    %204 = llhd.exts %data_nodes1, 5 : vector<7xi32> -> vector<2xi32>
    %205 = llhd.inss %63, %203, 2 : vector<7xi32>, vector<5xi32>
    %206 = llhd.inss %205, %204, 0 : vector<7xi32>, vector<2xi32>
    %207 = llhd.extf %206, 0 : vector<7xi32> -> i32
    %208 = llhd.vec %207, %202 : vector<2xi32>
    %209 = llhd.dextf %208, %174 : (vector<2xi32>, i1) -> i32
    llhd.drv %197, %209 after %7 : !llhd.sig<i32>
    %210 = constant 5 : i32
    %211 = llhd.sig "sig20" %4 : i7
    %212 = llhd.shr %gnt_nodes, %211, %210 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %213 = llhd.exts %212, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %214 = llhd.exts %gnt_nodes1, 2 : i7 -> i5
    %215 = llhd.inss %4, %214, 0 : i7, i5
    %216 = llhd.exts %215, 0 : i7 -> i1
    %217 = llhd.not %sel5 : i1
    %218 = llhd.and %216, %217 : i1
    llhd.drv %213, %218 after %7 : !llhd.sig<i1>
    %219 = constant 6 : i32
    %220 = llhd.sig "sig21" %4 : i7
    %221 = llhd.shr %gnt_nodes, %220, %219 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %222 = llhd.exts %221, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %223 = llhd.and %216, %sel5 : i1
    llhd.drv %222, %223 after %7 : !llhd.sig<i1>
    %sel6 = llhd.sig "sig22" %11 : i1
    %224 = llhd.sig "sig23" %4 : i7
    %225 = llhd.shr %req_nodes, %224, %144 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %226 = llhd.exts %225, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %req_d1 = llhd.prb %req_d : !llhd.sig<i8>
    %227 = llhd.exts %req_d1, 0 : i8 -> i1
    %228 = llhd.exts %req_d1, 1 : i8 -> i7
    %229 = llhd.inss %5, %228, 0 : i8, i7
    %230 = llhd.exts %229, 0 : i8 -> i1
    %231 = llhd.or %227, %230 : i1
    llhd.drv %226, %231 after %7 : !llhd.sig<i1>
    %232 = llhd.not %227 : i1
    %233 = llhd.exts %rr_q1, 0 : i3 -> i1
    %234 = llhd.and %230, %233 : i1
    %235 = llhd.or %232, %234 : i1
    llhd.drv %sel6, %235 after %7 : !llhd.sig<i1>
    %236 = llhd.sig "sig24" %42 : vector<7xi3>
    %237 = llhd.shr %index_nodes, %236, %144 : (!llhd.sig<vector<7xi3>>, !llhd.sig<vector<7xi3>>, i32) -> !llhd.sig<vector<7xi3>>
    %238 = llhd.extf %237, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel7 = llhd.prb %sel6 : !llhd.sig<i1>
    %239 = llhd.inss %0, %sel7, 0 : i3, i1
    llhd.drv %238, %239 after %7 : !llhd.sig<i3>
    %240 = llhd.sig "sig25" %63 : vector<7xi32>
    %241 = llhd.shr %data_nodes, %240, %144 : (!llhd.sig<vector<7xi32>>, !llhd.sig<vector<7xi32>>, i32) -> !llhd.sig<vector<7xi32>>
    %242 = llhd.extf %241, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %243 = cmpi "ne", %sel7, %11 : i1
    %data_i1 = llhd.prb %data_i : !llhd.sig<vector<8xi32>>
    %244 = llhd.univec %2 : i32 -> vector<8xi32>
    %245 = llhd.exts %244, 0 : vector<8xi32> -> vector<1xi32>
    %246 = llhd.exts %data_i1, 1 : vector<8xi32> -> vector<7xi32>
    %247 = llhd.inss %244, %245, 7 : vector<8xi32>, vector<1xi32>
    %248 = llhd.inss %247, %246, 0 : vector<8xi32>, vector<7xi32>
    %249 = llhd.extf %248, 0 : vector<8xi32> -> i32
    %250 = llhd.extf %data_i1, 0 : vector<8xi32> -> i32
    %251 = llhd.vec %250, %249 : vector<2xi32>
    %252 = llhd.dextf %251, %243 : (vector<2xi32>, i1) -> i32
    llhd.drv %242, %252 after %7 : !llhd.sig<i32>
    %253 = llhd.exts %gnt_o, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %254 = llhd.exts %gnt_nodes1, 3 : i7 -> i4
    %255 = llhd.inss %4, %254, 0 : i7, i4
    %256 = llhd.exts %255, 0 : i7 -> i1
    %257 = llhd.and %256, %227 : i1
    %258 = llhd.not %sel7 : i1
    %259 = llhd.and %257, %258 : i1
    llhd.drv %253, %259 after %7 : !llhd.sig<i1>
    %260 = llhd.sig "sig26" %5 : i8
    %261 = llhd.shr %gnt_o, %260, %76 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %262 = llhd.exts %261, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %263 = llhd.and %256, %230 : i1
    %264 = llhd.and %263, %sel7 : i1
    llhd.drv %262, %264 after %7 : !llhd.sig<i1>
    %sel8 = llhd.sig "sig27" %11 : i1
    %265 = llhd.sig "sig28" %4 : i7
    %266 = llhd.shr %req_nodes, %265, %153 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %267 = llhd.exts %266, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %268 = llhd.exts %req_d1, 2 : i8 -> i6
    %269 = llhd.inss %5, %268, 0 : i8, i6
    %270 = llhd.exts %269, 0 : i8 -> i1
    %271 = llhd.exts %req_d1, 3 : i8 -> i5
    %272 = llhd.inss %5, %271, 0 : i8, i5
    %273 = llhd.exts %272, 0 : i8 -> i1
    %274 = llhd.or %270, %273 : i1
    llhd.drv %267, %274 after %7 : !llhd.sig<i1>
    %275 = llhd.not %270 : i1
    %276 = llhd.and %273, %233 : i1
    %277 = llhd.or %275, %276 : i1
    llhd.drv %sel8, %277 after %7 : !llhd.sig<i1>
    %278 = llhd.sig "sig29" %42 : vector<7xi3>
    %279 = llhd.shr %index_nodes, %278, %153 : (!llhd.sig<vector<7xi3>>, !llhd.sig<vector<7xi3>>, i32) -> !llhd.sig<vector<7xi3>>
    %280 = llhd.extf %279, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel9 = llhd.prb %sel8 : !llhd.sig<i1>
    %281 = llhd.inss %0, %sel9, 0 : i3, i1
    llhd.drv %280, %281 after %7 : !llhd.sig<i3>
    %282 = llhd.sig "sig30" %63 : vector<7xi32>
    %283 = llhd.shr %data_nodes, %282, %153 : (!llhd.sig<vector<7xi32>>, !llhd.sig<vector<7xi32>>, i32) -> !llhd.sig<vector<7xi32>>
    %284 = llhd.extf %283, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %285 = cmpi "ne", %sel9, %11 : i1
    %286 = llhd.exts %244, 0 : vector<8xi32> -> vector<3xi32>
    %287 = llhd.exts %data_i1, 3 : vector<8xi32> -> vector<5xi32>
    %288 = llhd.inss %244, %286, 5 : vector<8xi32>, vector<3xi32>
    %289 = llhd.inss %288, %287, 0 : vector<8xi32>, vector<5xi32>
    %290 = llhd.extf %289, 0 : vector<8xi32> -> i32
    %291 = llhd.exts %244, 0 : vector<8xi32> -> vector<2xi32>
    %292 = llhd.exts %data_i1, 2 : vector<8xi32> -> vector<6xi32>
    %293 = llhd.inss %244, %291, 6 : vector<8xi32>, vector<2xi32>
    %294 = llhd.inss %293, %292, 0 : vector<8xi32>, vector<6xi32>
    %295 = llhd.extf %294, 0 : vector<8xi32> -> i32
    %296 = llhd.vec %295, %290 : vector<2xi32>
    %297 = llhd.dextf %296, %285 : (vector<2xi32>, i1) -> i32
    llhd.drv %284, %297 after %7 : !llhd.sig<i32>
    %298 = llhd.sig "sig31" %5 : i8
    %299 = llhd.shr %gnt_o, %298, %83 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %300 = llhd.exts %299, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %301 = llhd.exts %gnt_nodes1, 4 : i7 -> i3
    %302 = llhd.inss %4, %301, 0 : i7, i3
    %303 = llhd.exts %302, 0 : i7 -> i1
    %304 = llhd.and %303, %270 : i1
    %305 = llhd.not %sel9 : i1
    %306 = llhd.and %304, %305 : i1
    llhd.drv %300, %306 after %7 : !llhd.sig<i1>
    %307 = llhd.sig "sig32" %5 : i8
    %308 = llhd.shr %gnt_o, %307, %144 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %309 = llhd.exts %308, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %310 = llhd.and %303, %273 : i1
    %311 = llhd.and %310, %sel9 : i1
    llhd.drv %309, %311 after %7 : !llhd.sig<i1>
    %sel10 = llhd.sig "sig33" %11 : i1
    %312 = llhd.sig "sig34" %4 : i7
    %313 = llhd.shr %req_nodes, %312, %210 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %314 = llhd.exts %313, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %315 = llhd.exts %req_d1, 4 : i8 -> i4
    %316 = llhd.inss %5, %315, 0 : i8, i4
    %317 = llhd.exts %316, 0 : i8 -> i1
    %318 = llhd.exts %req_d1, 5 : i8 -> i3
    %319 = llhd.inss %5, %318, 0 : i8, i3
    %320 = llhd.exts %319, 0 : i8 -> i1
    %321 = llhd.or %317, %320 : i1
    llhd.drv %314, %321 after %7 : !llhd.sig<i1>
    %322 = llhd.not %317 : i1
    %323 = llhd.and %320, %233 : i1
    %324 = llhd.or %322, %323 : i1
    llhd.drv %sel10, %324 after %7 : !llhd.sig<i1>
    %325 = llhd.sig "sig35" %42 : vector<7xi3>
    %326 = llhd.shr %index_nodes, %325, %210 : (!llhd.sig<vector<7xi3>>, !llhd.sig<vector<7xi3>>, i32) -> !llhd.sig<vector<7xi3>>
    %327 = llhd.extf %326, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel11 = llhd.prb %sel10 : !llhd.sig<i1>
    %328 = llhd.inss %0, %sel11, 0 : i3, i1
    llhd.drv %327, %328 after %7 : !llhd.sig<i3>
    %329 = llhd.sig "sig36" %63 : vector<7xi32>
    %330 = llhd.shr %data_nodes, %329, %210 : (!llhd.sig<vector<7xi32>>, !llhd.sig<vector<7xi32>>, i32) -> !llhd.sig<vector<7xi32>>
    %331 = llhd.extf %330, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %332 = cmpi "ne", %sel11, %11 : i1
    %333 = llhd.exts %244, 0 : vector<8xi32> -> vector<5xi32>
    %334 = llhd.exts %data_i1, 5 : vector<8xi32> -> vector<3xi32>
    %335 = llhd.inss %244, %333, 3 : vector<8xi32>, vector<5xi32>
    %336 = llhd.inss %335, %334, 0 : vector<8xi32>, vector<3xi32>
    %337 = llhd.extf %336, 0 : vector<8xi32> -> i32
    %338 = llhd.exts %244, 0 : vector<8xi32> -> vector<4xi32>
    %339 = llhd.exts %data_i1, 4 : vector<8xi32> -> vector<4xi32>
    %340 = llhd.inss %244, %338, 4 : vector<8xi32>, vector<4xi32>
    %341 = llhd.inss %340, %339, 0 : vector<8xi32>, vector<4xi32>
    %342 = llhd.extf %341, 0 : vector<8xi32> -> i32
    %343 = llhd.vec %342, %337 : vector<2xi32>
    %344 = llhd.dextf %343, %332 : (vector<2xi32>, i1) -> i32
    llhd.drv %331, %344 after %7 : !llhd.sig<i32>
    %345 = llhd.sig "sig37" %5 : i8
    %346 = llhd.shr %gnt_o, %345, %153 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %347 = llhd.exts %346, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %348 = llhd.exts %gnt_nodes1, 5 : i7 -> i2
    %349 = llhd.inss %4, %348, 0 : i7, i2
    %350 = llhd.exts %349, 0 : i7 -> i1
    %351 = llhd.and %350, %317 : i1
    %352 = llhd.not %sel11 : i1
    %353 = llhd.and %351, %352 : i1
    llhd.drv %347, %353 after %7 : !llhd.sig<i1>
    %354 = llhd.sig "sig38" %5 : i8
    %355 = llhd.shr %gnt_o, %354, %210 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %356 = llhd.exts %355, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %357 = llhd.and %350, %320 : i1
    %358 = llhd.and %357, %sel11 : i1
    llhd.drv %356, %358 after %7 : !llhd.sig<i1>
    %sel12 = llhd.sig "sig39" %11 : i1
    %359 = llhd.sig "sig40" %4 : i7
    %360 = llhd.shr %req_nodes, %359, %219 : (!llhd.sig<i7>, !llhd.sig<i7>, i32) -> !llhd.sig<i7>
    %361 = llhd.exts %360, 0 : !llhd.sig<i7> -> !llhd.sig<i1>
    %362 = llhd.exts %req_d1, 6 : i8 -> i2
    %363 = llhd.inss %5, %362, 0 : i8, i2
    %364 = llhd.exts %363, 0 : i8 -> i1
    %365 = llhd.exts %req_d1, 7 : i8 -> i1
    %366 = llhd.inss %5, %365, 0 : i8, i1
    %367 = llhd.exts %366, 0 : i8 -> i1
    %368 = llhd.or %364, %367 : i1
    llhd.drv %361, %368 after %7 : !llhd.sig<i1>
    %369 = llhd.not %364 : i1
    %370 = llhd.and %367, %233 : i1
    %371 = llhd.or %369, %370 : i1
    llhd.drv %sel12, %371 after %7 : !llhd.sig<i1>
    %372 = llhd.sig "sig41" %42 : vector<7xi3>
    %373 = llhd.shr %index_nodes, %372, %219 : (!llhd.sig<vector<7xi3>>, !llhd.sig<vector<7xi3>>, i32) -> !llhd.sig<vector<7xi3>>
    %374 = llhd.extf %373, 0 : !llhd.sig<vector<7xi3>> -> !llhd.sig<i3>
    %sel13 = llhd.prb %sel12 : !llhd.sig<i1>
    %375 = llhd.inss %0, %sel13, 0 : i3, i1
    llhd.drv %374, %375 after %7 : !llhd.sig<i3>
    %376 = llhd.sig "sig42" %63 : vector<7xi32>
    %377 = llhd.shr %data_nodes, %376, %219 : (!llhd.sig<vector<7xi32>>, !llhd.sig<vector<7xi32>>, i32) -> !llhd.sig<vector<7xi32>>
    %378 = llhd.extf %377, 0 : !llhd.sig<vector<7xi32>> -> !llhd.sig<i32>
    %379 = cmpi "ne", %sel13, %11 : i1
    %380 = llhd.exts %244, 0 : vector<8xi32> -> vector<7xi32>
    %381 = llhd.exts %data_i1, 7 : vector<8xi32> -> vector<1xi32>
    %382 = llhd.inss %244, %380, 1 : vector<8xi32>, vector<7xi32>
    %383 = llhd.inss %382, %381, 0 : vector<8xi32>, vector<1xi32>
    %384 = llhd.extf %383, 0 : vector<8xi32> -> i32
    %385 = llhd.exts %244, 0 : vector<8xi32> -> vector<6xi32>
    %386 = llhd.exts %data_i1, 6 : vector<8xi32> -> vector<2xi32>
    %387 = llhd.inss %244, %385, 2 : vector<8xi32>, vector<6xi32>
    %388 = llhd.inss %387, %386, 0 : vector<8xi32>, vector<2xi32>
    %389 = llhd.extf %388, 0 : vector<8xi32> -> i32
    %390 = llhd.vec %389, %384 : vector<2xi32>
    %391 = llhd.dextf %390, %379 : (vector<2xi32>, i1) -> i32
    llhd.drv %378, %391 after %7 : !llhd.sig<i32>
    %392 = llhd.sig "sig43" %5 : i8
    %393 = llhd.shr %gnt_o, %392, %219 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %394 = llhd.exts %393, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %395 = llhd.exts %gnt_nodes1, 6 : i7 -> i1
    %396 = llhd.inss %4, %395, 0 : i7, i1
    %397 = llhd.exts %396, 0 : i7 -> i1
    %398 = llhd.and %397, %364 : i1
    %399 = llhd.not %sel13 : i1
    %400 = llhd.and %398, %399 : i1
    llhd.drv %394, %400 after %7 : !llhd.sig<i1>
    %401 = llhd.sig "sig44" %5 : i8
    %402 = llhd.shr %gnt_o, %401, %17 : (!llhd.sig<i8>, !llhd.sig<i8>, i32) -> !llhd.sig<i8>
    %403 = llhd.exts %402, 0 : !llhd.sig<i8> -> !llhd.sig<i1>
    %404 = llhd.and %397, %367 : i1
    %405 = llhd.and %404, %sel13 : i1
    llhd.drv %403, %405 after %7 : !llhd.sig<i1>
    llhd.inst "inst1" @rr_arb_tree.param1.initial.1529.1() -> () : () -> ()
    %406 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    llhd.drv %gnt_o, %5 after %406 : !llhd.sig<i8>
}

llhd.proc @rr_arb_tree_tb.initial.1815.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = constant 0 : i1
    %2 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = constant 1 : i1
    %4 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %rst_ni, %3 after %4 : !llhd.sig<i1>
    %5 = llhd.const #llhd.time<4ns, 0d, 0e> : !llhd.time
    llhd.wait  for %5, ^6
^6:
    %7 = constant 5000000 : i32
    br ^loop_body(%7: i32)
^loop_body(%8: i32):
    %9 = constant 0 : i32
    %10 = cmpi "ne", %8, %9 : i32
    cond_br %10, ^loop_continue, ^loop_exit
^11:
    %12 = constant 1 : i32
    %13 = subi %8, %12 : i32
    br ^loop_body(%13: i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %14 = constant 1 : i1
    %15 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %14 after %15 : !llhd.sig<i1>
    %16 = constant 0 : i1
    %17 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %clk_i, %16 after %17 : !llhd.sig<i1>
    llhd.wait  for %17, ^11
}

llhd.entity @rr_arb_tree_tb() -> () {
    %0 = constant 0 : i1
    %clk_i = llhd.sig "sig" %0 : i1
    %1 = constant 1 : i1
    %rst_ni = llhd.sig "sig1" %1 : i1
    %flush_i = llhd.sig "sig2" %0 : i1
    %2 = constant 0 : i3
    %rr_i = llhd.sig "sig3" %2 : i3
    %3 = constant 0 : i8
    %req_i = llhd.sig "sig4" %3 : i8
    %gnt_o = llhd.sig "sig5" %3 : i8
    %4 = constant 0 : i32
    %5 = llhd.vec %4, %4, %4, %4, %4, %4, %4, %4 : vector<8xi32>
    %data_i = llhd.sig "sig6" %5 : vector<8xi32>
    %gnt_i = llhd.sig "sig7" %0 : i1
    %req_o = llhd.sig "sig8" %0 : i1
    %data_o = llhd.sig "sig9" %4 : i32
    %idx_o = llhd.sig "sig10" %2 : i3
    %6 = constant 255 : i8
    %7 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %req_i, %6 after %7 : !llhd.sig<i8>
    %req_o1 = llhd.prb %req_o : !llhd.sig<i1>
    llhd.drv %gnt_i, %req_o1 after %7 : !llhd.sig<i1>
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %8 = llhd.sig "sig11" %0 : i1
    llhd.drv %8, %clk_i1 after %7 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %9 = llhd.sig "sig12" %0 : i1
    llhd.drv %9, %rst_ni1 after %7 : !llhd.sig<i1>
    %flush_i1 = llhd.prb %flush_i : !llhd.sig<i1>
    %10 = llhd.sig "sig13" %0 : i1
    llhd.drv %10, %flush_i1 after %7 : !llhd.sig<i1>
    %rr_i1 = llhd.prb %rr_i : !llhd.sig<i3>
    %11 = llhd.sig "sig14" %2 : i3
    llhd.drv %11, %rr_i1 after %7 : !llhd.sig<i3>
    %req_i1 = llhd.prb %req_i : !llhd.sig<i8>
    %12 = llhd.sig "sig15" %3 : i8
    llhd.drv %12, %req_i1 after %7 : !llhd.sig<i8>
    %data_i1 = llhd.prb %data_i : !llhd.sig<vector<8xi32>>
    %13 = llhd.univec %4 : i32 -> vector<8xi32>
    %14 = llhd.sig "sig16" %13 : vector<8xi32>
    llhd.drv %14, %data_i1 after %7 : !llhd.sig<vector<8xi32>>
    %gnt_i1 = llhd.prb %gnt_i : !llhd.sig<i1>
    %15 = llhd.sig "sig17" %0 : i1
    llhd.drv %15, %gnt_i1 after %7 : !llhd.sig<i1>
    llhd.inst "inst" @rr_arb_tree.param1(%8, %9, %10, %11, %12, %14, %15) -> (%gnt_o, %req_o, %data_o, %idx_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i8>, !llhd.sig<vector<8xi32>>, !llhd.sig<i1>) -> (!llhd.sig<i8>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i3>)
    llhd.inst "inst1" @rr_arb_tree_tb.initial.1815.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
