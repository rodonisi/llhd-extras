llhd.proc @lzc.param1.initial.69.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.proc @lzc.param1.always_comb.217.1(%in_i: !llhd.sig<i16>) -> (%in_tmp: !llhd.sig<i16> ) {
    br ^body
^body:
    %0 = constant 0 : i32
    br ^loop_body(%0: i32)
^loop_body(%i: i32):
    %1 = constant 16 : i32
    %2 = cmpi "slt", %i, %1 : i32
    cond_br %2, ^loop_continue, ^check
^check:
    llhd.wait (%in_i : !llhd.sig<i16>), ^body
^loop_continue:
    %3 = constant 0 : i16
    %4 = llhd.dexts %in_tmp, %i : (!llhd.sig<i16>, i32) -> !llhd.sig<i1>
    %in_i1 = llhd.prb %in_i : !llhd.sig<i16>
    %5 = constant 15 : i32
    %6 = subi %5, %i : i32
    %7 = llhd.shr %in_i1, %3, %6 : (i16, i16, i32) -> i16
    %8 = llhd.exts %7, 0 : i16 -> i1
    %9 = llhd.shr %in_i1, %3, %i : (i16, i16, i32) -> i16
    %10 = llhd.exts %9, 0 : i16 -> i1
    %11 = llhd.vec %10, %8 : vector<2xi1>
    %12 = llhd.extf %11, 1 : vector<2xi1> -> i1
    %13 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %12 after %13 : !llhd.sig<i1>
    %14 = constant 1 : i32
    %15 = addi %i, %14 : i32
    br ^loop_body(%15: i32)
}

llhd.entity @lzc.param1(%in_i: !llhd.sig<i16>) -> (%cnt_o: !llhd.sig<i4> , %empty_o: !llhd.sig<i1> ) {
    %0 = constant 0 : i4
    %1 = llhd.vec %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0, %0 : vector<16xi4>
    %index_lut = llhd.sig "sig" %1 : vector<16xi4>
    %2 = constant 0 : i16
    %sel_nodes = llhd.sig "sig1" %2 : i16
    %index_nodes = llhd.sig "sig2" %1 : vector<16xi4>
    %in_tmp = llhd.sig "sig3" %2 : i16
    %index_nodes1 = llhd.prb %index_nodes : !llhd.sig<vector<16xi4>>
    %3 = llhd.extf %index_nodes1, 0 : vector<16xi4> -> i4
    %4 = llhd.vec %0, %3 : vector<2xi4>
    %5 = llhd.extf %4, 1 : vector<2xi4> -> i4
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %cnt_o, %5 after %6 : !llhd.sig<i4>
    %sel_nodes1 = llhd.prb %sel_nodes : !llhd.sig<i16>
    %7 = llhd.exts %sel_nodes1, 0 : i16 -> i1
    %8 = llhd.not %7 : i1
    %in_i1 = llhd.prb %in_i : !llhd.sig<i16>
    %9 = llhd.exts %in_i1, 0 : i16 -> i1
    %10 = llhd.exts %in_i1, 1 : i16 -> i1
    %11 = llhd.or %9, %10 : i1
    %12 = llhd.exts %in_i1, 2 : i16 -> i1
    %13 = llhd.or %11, %12 : i1
    %14 = llhd.exts %in_i1, 3 : i16 -> i1
    %15 = llhd.or %13, %14 : i1
    %16 = llhd.exts %in_i1, 4 : i16 -> i1
    %17 = llhd.or %15, %16 : i1
    %18 = llhd.exts %in_i1, 5 : i16 -> i1
    %19 = llhd.or %17, %18 : i1
    %20 = llhd.exts %in_i1, 6 : i16 -> i1
    %21 = llhd.or %19, %20 : i1
    %22 = llhd.exts %in_i1, 7 : i16 -> i1
    %23 = llhd.or %21, %22 : i1
    %24 = llhd.exts %in_i1, 8 : i16 -> i1
    %25 = llhd.or %23, %24 : i1
    %26 = llhd.exts %in_i1, 9 : i16 -> i1
    %27 = llhd.or %25, %26 : i1
    %28 = llhd.exts %in_i1, 10 : i16 -> i1
    %29 = llhd.or %27, %28 : i1
    %30 = llhd.exts %in_i1, 11 : i16 -> i1
    %31 = llhd.or %29, %30 : i1
    %32 = llhd.exts %in_i1, 12 : i16 -> i1
    %33 = llhd.or %31, %32 : i1
    %34 = llhd.exts %in_i1, 13 : i16 -> i1
    %35 = llhd.or %33, %34 : i1
    %36 = llhd.exts %in_i1, 14 : i16 -> i1
    %37 = llhd.or %35, %36 : i1
    %38 = llhd.exts %in_i1, 15 : i16 -> i1
    %39 = llhd.or %37, %38 : i1
    %40 = llhd.not %39 : i1
    %41 = llhd.vec %40, %8 : vector<2xi1>
    %42 = llhd.extf %41, 1 : vector<2xi1> -> i1
    llhd.drv %empty_o, %42 after %6 : !llhd.sig<i1>
    %43 = llhd.extf %index_lut, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    llhd.drv %43, %0 after %6 : !llhd.sig<i4>
    %44 = constant 1 : i32
    %45 = llhd.univec %0 : i4 -> vector<16xi4>
    %46 = llhd.sig "sig4" %45 : vector<16xi4>
    %47 = llhd.shr %index_lut, %46, %44 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %48 = llhd.extf %47, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %49 = constant 1 : i4
    llhd.drv %48, %49 after %6 : !llhd.sig<i4>
    %50 = constant 2 : i32
    %51 = llhd.sig "sig5" %45 : vector<16xi4>
    %52 = llhd.shr %index_lut, %51, %50 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %53 = llhd.extf %52, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %54 = constant 2 : i4
    llhd.drv %53, %54 after %6 : !llhd.sig<i4>
    %55 = constant 3 : i32
    %56 = llhd.sig "sig6" %45 : vector<16xi4>
    %57 = llhd.shr %index_lut, %56, %55 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %58 = llhd.extf %57, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %59 = constant 3 : i4
    llhd.drv %58, %59 after %6 : !llhd.sig<i4>
    %60 = constant 4 : i32
    %61 = llhd.sig "sig7" %45 : vector<16xi4>
    %62 = llhd.shr %index_lut, %61, %60 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %63 = llhd.extf %62, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %64 = constant 4 : i4
    llhd.drv %63, %64 after %6 : !llhd.sig<i4>
    %65 = constant 5 : i32
    %66 = llhd.sig "sig8" %45 : vector<16xi4>
    %67 = llhd.shr %index_lut, %66, %65 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %68 = llhd.extf %67, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %69 = constant 5 : i4
    llhd.drv %68, %69 after %6 : !llhd.sig<i4>
    %70 = constant 6 : i32
    %71 = llhd.sig "sig9" %45 : vector<16xi4>
    %72 = llhd.shr %index_lut, %71, %70 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %73 = llhd.extf %72, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %74 = constant 6 : i4
    llhd.drv %73, %74 after %6 : !llhd.sig<i4>
    %75 = constant 7 : i32
    %76 = llhd.sig "sig10" %45 : vector<16xi4>
    %77 = llhd.shr %index_lut, %76, %75 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %78 = llhd.extf %77, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %79 = constant 7 : i4
    llhd.drv %78, %79 after %6 : !llhd.sig<i4>
    %80 = constant 8 : i32
    %81 = llhd.sig "sig11" %45 : vector<16xi4>
    %82 = llhd.shr %index_lut, %81, %80 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %83 = llhd.extf %82, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %84 = constant 8 : i4
    llhd.drv %83, %84 after %6 : !llhd.sig<i4>
    %85 = constant 9 : i32
    %86 = llhd.sig "sig12" %45 : vector<16xi4>
    %87 = llhd.shr %index_lut, %86, %85 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %88 = llhd.extf %87, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %89 = constant 9 : i4
    llhd.drv %88, %89 after %6 : !llhd.sig<i4>
    %90 = constant 10 : i32
    %91 = llhd.sig "sig13" %45 : vector<16xi4>
    %92 = llhd.shr %index_lut, %91, %90 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %93 = llhd.extf %92, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %94 = constant 10 : i4
    llhd.drv %93, %94 after %6 : !llhd.sig<i4>
    %95 = constant 11 : i32
    %96 = llhd.sig "sig14" %45 : vector<16xi4>
    %97 = llhd.shr %index_lut, %96, %95 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %98 = llhd.extf %97, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %99 = constant 11 : i4
    llhd.drv %98, %99 after %6 : !llhd.sig<i4>
    %100 = constant 12 : i32
    %101 = llhd.sig "sig15" %45 : vector<16xi4>
    %102 = llhd.shr %index_lut, %101, %100 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %103 = llhd.extf %102, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %104 = constant 12 : i4
    llhd.drv %103, %104 after %6 : !llhd.sig<i4>
    %105 = constant 13 : i32
    %106 = llhd.sig "sig16" %45 : vector<16xi4>
    %107 = llhd.shr %index_lut, %106, %105 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %108 = llhd.extf %107, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %109 = constant 13 : i4
    llhd.drv %108, %109 after %6 : !llhd.sig<i4>
    %110 = constant 14 : i32
    %111 = llhd.sig "sig17" %45 : vector<16xi4>
    %112 = llhd.shr %index_lut, %111, %110 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %113 = llhd.extf %112, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %114 = constant 14 : i4
    llhd.drv %113, %114 after %6 : !llhd.sig<i4>
    %115 = constant 15 : i32
    %116 = llhd.sig "sig18" %45 : vector<16xi4>
    %117 = llhd.shr %index_lut, %116, %115 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %118 = llhd.extf %117, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %119 = constant 15 : i4
    llhd.drv %118, %119 after %6 : !llhd.sig<i4>
    %120 = llhd.exts %sel_nodes, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %121 = llhd.exts %sel_nodes1, 1 : i16 -> i15
    %122 = llhd.inss %2, %121, 0 : i16, i15
    %123 = llhd.exts %122, 0 : i16 -> i1
    %124 = llhd.exts %sel_nodes1, 2 : i16 -> i14
    %125 = llhd.inss %2, %124, 0 : i16, i14
    %126 = llhd.exts %125, 0 : i16 -> i1
    %127 = llhd.or %123, %126 : i1
    llhd.drv %120, %127 after %6 : !llhd.sig<i1>
    %128 = llhd.extf %index_nodes, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %129 = constant 1 : i1
    %130 = cmpi "eq", %123, %129 : i1
    %131 = constant 0 : i1
    %132 = cmpi "ne", %130, %131 : i1
    %133 = llhd.exts %45, 0 : vector<16xi4> -> vector<1xi4>
    %134 = llhd.exts %index_nodes1, 1 : vector<16xi4> -> vector<15xi4>
    %135 = llhd.inss %45, %133, 15 : vector<16xi4>, vector<1xi4>
    %136 = llhd.inss %135, %134, 0 : vector<16xi4>, vector<15xi4>
    %137 = llhd.extf %136, 0 : vector<16xi4> -> i4
    %138 = llhd.exts %45, 0 : vector<16xi4> -> vector<2xi4>
    %139 = llhd.exts %index_nodes1, 2 : vector<16xi4> -> vector<14xi4>
    %140 = llhd.inss %45, %138, 14 : vector<16xi4>, vector<2xi4>
    %141 = llhd.inss %140, %139, 0 : vector<16xi4>, vector<14xi4>
    %142 = llhd.extf %141, 0 : vector<16xi4> -> i4
    %143 = llhd.vec %142, %137 : vector<2xi4>
    %144 = llhd.dextf %143, %132 : (vector<2xi4>, i1) -> i4
    llhd.drv %128, %144 after %6 : !llhd.sig<i4>
    %145 = llhd.sig "sig19" %2 : i16
    %146 = llhd.shr %sel_nodes, %145, %44 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %147 = llhd.exts %146, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %148 = llhd.exts %sel_nodes1, 3 : i16 -> i13
    %149 = llhd.inss %2, %148, 0 : i16, i13
    %150 = llhd.exts %149, 0 : i16 -> i1
    %151 = llhd.exts %sel_nodes1, 4 : i16 -> i12
    %152 = llhd.inss %2, %151, 0 : i16, i12
    %153 = llhd.exts %152, 0 : i16 -> i1
    %154 = llhd.or %150, %153 : i1
    llhd.drv %147, %154 after %6 : !llhd.sig<i1>
    %155 = llhd.sig "sig20" %45 : vector<16xi4>
    %156 = llhd.shr %index_nodes, %155, %44 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %157 = llhd.extf %156, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %158 = cmpi "eq", %150, %129 : i1
    %159 = cmpi "ne", %158, %131 : i1
    %160 = llhd.exts %45, 0 : vector<16xi4> -> vector<3xi4>
    %161 = llhd.exts %index_nodes1, 3 : vector<16xi4> -> vector<13xi4>
    %162 = llhd.inss %45, %160, 13 : vector<16xi4>, vector<3xi4>
    %163 = llhd.inss %162, %161, 0 : vector<16xi4>, vector<13xi4>
    %164 = llhd.extf %163, 0 : vector<16xi4> -> i4
    %165 = llhd.exts %45, 0 : vector<16xi4> -> vector<4xi4>
    %166 = llhd.exts %index_nodes1, 4 : vector<16xi4> -> vector<12xi4>
    %167 = llhd.inss %45, %165, 12 : vector<16xi4>, vector<4xi4>
    %168 = llhd.inss %167, %166, 0 : vector<16xi4>, vector<12xi4>
    %169 = llhd.extf %168, 0 : vector<16xi4> -> i4
    %170 = llhd.vec %169, %164 : vector<2xi4>
    %171 = llhd.dextf %170, %159 : (vector<2xi4>, i1) -> i4
    llhd.drv %157, %171 after %6 : !llhd.sig<i4>
    %172 = llhd.sig "sig21" %2 : i16
    %173 = llhd.shr %sel_nodes, %172, %50 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %174 = llhd.exts %173, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %175 = llhd.exts %sel_nodes1, 5 : i16 -> i11
    %176 = llhd.inss %2, %175, 0 : i16, i11
    %177 = llhd.exts %176, 0 : i16 -> i1
    %178 = llhd.exts %sel_nodes1, 6 : i16 -> i10
    %179 = llhd.inss %2, %178, 0 : i16, i10
    %180 = llhd.exts %179, 0 : i16 -> i1
    %181 = llhd.or %177, %180 : i1
    llhd.drv %174, %181 after %6 : !llhd.sig<i1>
    %182 = llhd.sig "sig22" %45 : vector<16xi4>
    %183 = llhd.shr %index_nodes, %182, %50 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %184 = llhd.extf %183, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %185 = cmpi "eq", %177, %129 : i1
    %186 = cmpi "ne", %185, %131 : i1
    %187 = llhd.exts %45, 0 : vector<16xi4> -> vector<5xi4>
    %188 = llhd.exts %index_nodes1, 5 : vector<16xi4> -> vector<11xi4>
    %189 = llhd.inss %45, %187, 11 : vector<16xi4>, vector<5xi4>
    %190 = llhd.inss %189, %188, 0 : vector<16xi4>, vector<11xi4>
    %191 = llhd.extf %190, 0 : vector<16xi4> -> i4
    %192 = llhd.exts %45, 0 : vector<16xi4> -> vector<6xi4>
    %193 = llhd.exts %index_nodes1, 6 : vector<16xi4> -> vector<10xi4>
    %194 = llhd.inss %45, %192, 10 : vector<16xi4>, vector<6xi4>
    %195 = llhd.inss %194, %193, 0 : vector<16xi4>, vector<10xi4>
    %196 = llhd.extf %195, 0 : vector<16xi4> -> i4
    %197 = llhd.vec %196, %191 : vector<2xi4>
    %198 = llhd.dextf %197, %186 : (vector<2xi4>, i1) -> i4
    llhd.drv %184, %198 after %6 : !llhd.sig<i4>
    %199 = llhd.sig "sig23" %2 : i16
    %200 = llhd.shr %sel_nodes, %199, %55 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %201 = llhd.exts %200, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %202 = llhd.exts %sel_nodes1, 7 : i16 -> i9
    %203 = llhd.inss %2, %202, 0 : i16, i9
    %204 = llhd.exts %203, 0 : i16 -> i1
    %205 = llhd.exts %sel_nodes1, 8 : i16 -> i8
    %206 = llhd.inss %2, %205, 0 : i16, i8
    %207 = llhd.exts %206, 0 : i16 -> i1
    %208 = llhd.or %204, %207 : i1
    llhd.drv %201, %208 after %6 : !llhd.sig<i1>
    %209 = llhd.sig "sig24" %45 : vector<16xi4>
    %210 = llhd.shr %index_nodes, %209, %55 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %211 = llhd.extf %210, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %212 = cmpi "eq", %204, %129 : i1
    %213 = cmpi "ne", %212, %131 : i1
    %214 = llhd.exts %45, 0 : vector<16xi4> -> vector<7xi4>
    %215 = llhd.exts %index_nodes1, 7 : vector<16xi4> -> vector<9xi4>
    %216 = llhd.inss %45, %214, 9 : vector<16xi4>, vector<7xi4>
    %217 = llhd.inss %216, %215, 0 : vector<16xi4>, vector<9xi4>
    %218 = llhd.extf %217, 0 : vector<16xi4> -> i4
    %219 = llhd.exts %45, 0 : vector<16xi4> -> vector<8xi4>
    %220 = llhd.exts %index_nodes1, 8 : vector<16xi4> -> vector<8xi4>
    %221 = llhd.inss %45, %219, 8 : vector<16xi4>, vector<8xi4>
    %222 = llhd.inss %221, %220, 0 : vector<16xi4>, vector<8xi4>
    %223 = llhd.extf %222, 0 : vector<16xi4> -> i4
    %224 = llhd.vec %223, %218 : vector<2xi4>
    %225 = llhd.dextf %224, %213 : (vector<2xi4>, i1) -> i4
    llhd.drv %211, %225 after %6 : !llhd.sig<i4>
    %226 = llhd.sig "sig25" %2 : i16
    %227 = llhd.shr %sel_nodes, %226, %60 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %228 = llhd.exts %227, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %229 = llhd.exts %sel_nodes1, 9 : i16 -> i7
    %230 = llhd.inss %2, %229, 0 : i16, i7
    %231 = llhd.exts %230, 0 : i16 -> i1
    %232 = llhd.exts %sel_nodes1, 10 : i16 -> i6
    %233 = llhd.inss %2, %232, 0 : i16, i6
    %234 = llhd.exts %233, 0 : i16 -> i1
    %235 = llhd.or %231, %234 : i1
    llhd.drv %228, %235 after %6 : !llhd.sig<i1>
    %236 = llhd.sig "sig26" %45 : vector<16xi4>
    %237 = llhd.shr %index_nodes, %236, %60 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %238 = llhd.extf %237, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %239 = cmpi "eq", %231, %129 : i1
    %240 = cmpi "ne", %239, %131 : i1
    %241 = llhd.exts %45, 0 : vector<16xi4> -> vector<9xi4>
    %242 = llhd.exts %index_nodes1, 9 : vector<16xi4> -> vector<7xi4>
    %243 = llhd.inss %45, %241, 7 : vector<16xi4>, vector<9xi4>
    %244 = llhd.inss %243, %242, 0 : vector<16xi4>, vector<7xi4>
    %245 = llhd.extf %244, 0 : vector<16xi4> -> i4
    %246 = llhd.exts %45, 0 : vector<16xi4> -> vector<10xi4>
    %247 = llhd.exts %index_nodes1, 10 : vector<16xi4> -> vector<6xi4>
    %248 = llhd.inss %45, %246, 6 : vector<16xi4>, vector<10xi4>
    %249 = llhd.inss %248, %247, 0 : vector<16xi4>, vector<6xi4>
    %250 = llhd.extf %249, 0 : vector<16xi4> -> i4
    %251 = llhd.vec %250, %245 : vector<2xi4>
    %252 = llhd.dextf %251, %240 : (vector<2xi4>, i1) -> i4
    llhd.drv %238, %252 after %6 : !llhd.sig<i4>
    %253 = llhd.sig "sig27" %2 : i16
    %254 = llhd.shr %sel_nodes, %253, %65 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %255 = llhd.exts %254, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %256 = llhd.exts %sel_nodes1, 11 : i16 -> i5
    %257 = llhd.inss %2, %256, 0 : i16, i5
    %258 = llhd.exts %257, 0 : i16 -> i1
    %259 = llhd.exts %sel_nodes1, 12 : i16 -> i4
    %260 = llhd.inss %2, %259, 0 : i16, i4
    %261 = llhd.exts %260, 0 : i16 -> i1
    %262 = llhd.or %258, %261 : i1
    llhd.drv %255, %262 after %6 : !llhd.sig<i1>
    %263 = llhd.sig "sig28" %45 : vector<16xi4>
    %264 = llhd.shr %index_nodes, %263, %65 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %265 = llhd.extf %264, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %266 = cmpi "eq", %258, %129 : i1
    %267 = cmpi "ne", %266, %131 : i1
    %268 = llhd.exts %45, 0 : vector<16xi4> -> vector<11xi4>
    %269 = llhd.exts %index_nodes1, 11 : vector<16xi4> -> vector<5xi4>
    %270 = llhd.inss %45, %268, 5 : vector<16xi4>, vector<11xi4>
    %271 = llhd.inss %270, %269, 0 : vector<16xi4>, vector<5xi4>
    %272 = llhd.extf %271, 0 : vector<16xi4> -> i4
    %273 = llhd.exts %45, 0 : vector<16xi4> -> vector<12xi4>
    %274 = llhd.exts %index_nodes1, 12 : vector<16xi4> -> vector<4xi4>
    %275 = llhd.inss %45, %273, 4 : vector<16xi4>, vector<12xi4>
    %276 = llhd.inss %275, %274, 0 : vector<16xi4>, vector<4xi4>
    %277 = llhd.extf %276, 0 : vector<16xi4> -> i4
    %278 = llhd.vec %277, %272 : vector<2xi4>
    %279 = llhd.dextf %278, %267 : (vector<2xi4>, i1) -> i4
    llhd.drv %265, %279 after %6 : !llhd.sig<i4>
    %280 = llhd.sig "sig29" %2 : i16
    %281 = llhd.shr %sel_nodes, %280, %70 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %282 = llhd.exts %281, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %283 = llhd.exts %sel_nodes1, 13 : i16 -> i3
    %284 = llhd.inss %2, %283, 0 : i16, i3
    %285 = llhd.exts %284, 0 : i16 -> i1
    %286 = llhd.exts %sel_nodes1, 14 : i16 -> i2
    %287 = llhd.inss %2, %286, 0 : i16, i2
    %288 = llhd.exts %287, 0 : i16 -> i1
    %289 = llhd.or %285, %288 : i1
    llhd.drv %282, %289 after %6 : !llhd.sig<i1>
    %290 = llhd.sig "sig30" %45 : vector<16xi4>
    %291 = llhd.shr %index_nodes, %290, %70 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %292 = llhd.extf %291, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %293 = cmpi "eq", %285, %129 : i1
    %294 = cmpi "ne", %293, %131 : i1
    %295 = llhd.exts %45, 0 : vector<16xi4> -> vector<13xi4>
    %296 = llhd.exts %index_nodes1, 13 : vector<16xi4> -> vector<3xi4>
    %297 = llhd.inss %45, %295, 3 : vector<16xi4>, vector<13xi4>
    %298 = llhd.inss %297, %296, 0 : vector<16xi4>, vector<3xi4>
    %299 = llhd.extf %298, 0 : vector<16xi4> -> i4
    %300 = llhd.exts %45, 0 : vector<16xi4> -> vector<14xi4>
    %301 = llhd.exts %index_nodes1, 14 : vector<16xi4> -> vector<2xi4>
    %302 = llhd.inss %45, %300, 2 : vector<16xi4>, vector<14xi4>
    %303 = llhd.inss %302, %301, 0 : vector<16xi4>, vector<2xi4>
    %304 = llhd.extf %303, 0 : vector<16xi4> -> i4
    %305 = llhd.vec %304, %299 : vector<2xi4>
    %306 = llhd.dextf %305, %294 : (vector<2xi4>, i1) -> i4
    llhd.drv %292, %306 after %6 : !llhd.sig<i4>
    %307 = llhd.sig "sig31" %2 : i16
    %308 = llhd.shr %sel_nodes, %307, %75 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %309 = llhd.exts %308, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %in_tmp1 = llhd.prb %in_tmp : !llhd.sig<i16>
    %310 = llhd.exts %in_tmp1, 0 : i16 -> i1
    %311 = llhd.exts %in_tmp1, 1 : i16 -> i15
    %312 = llhd.inss %2, %311, 0 : i16, i15
    %313 = llhd.exts %312, 0 : i16 -> i1
    %314 = llhd.or %310, %313 : i1
    llhd.drv %309, %314 after %6 : !llhd.sig<i1>
    %315 = llhd.sig "sig32" %45 : vector<16xi4>
    %316 = llhd.shr %index_nodes, %315, %75 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %317 = llhd.extf %316, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %318 = cmpi "eq", %310, %129 : i1
    %319 = cmpi "ne", %318, %131 : i1
    %index_lut1 = llhd.prb %index_lut : !llhd.sig<vector<16xi4>>
    %320 = llhd.extf %index_lut1, 0 : vector<16xi4> -> i4
    %321 = llhd.exts %index_lut1, 1 : vector<16xi4> -> vector<15xi4>
    %322 = llhd.inss %135, %321, 0 : vector<16xi4>, vector<15xi4>
    %323 = llhd.extf %322, 0 : vector<16xi4> -> i4
    %324 = llhd.vec %323, %320 : vector<2xi4>
    %325 = llhd.dextf %324, %319 : (vector<2xi4>, i1) -> i4
    llhd.drv %317, %325 after %6 : !llhd.sig<i4>
    %326 = llhd.sig "sig33" %2 : i16
    %327 = llhd.shr %sel_nodes, %326, %80 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %328 = llhd.exts %327, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %329 = llhd.exts %in_tmp1, 2 : i16 -> i14
    %330 = llhd.inss %2, %329, 0 : i16, i14
    %331 = llhd.exts %330, 0 : i16 -> i1
    %332 = llhd.exts %in_tmp1, 3 : i16 -> i13
    %333 = llhd.inss %2, %332, 0 : i16, i13
    %334 = llhd.exts %333, 0 : i16 -> i1
    %335 = llhd.or %331, %334 : i1
    llhd.drv %328, %335 after %6 : !llhd.sig<i1>
    %336 = llhd.sig "sig34" %45 : vector<16xi4>
    %337 = llhd.shr %index_nodes, %336, %80 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %338 = llhd.extf %337, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %339 = cmpi "eq", %331, %129 : i1
    %340 = cmpi "ne", %339, %131 : i1
    %341 = llhd.exts %index_lut1, 2 : vector<16xi4> -> vector<14xi4>
    %342 = llhd.inss %140, %341, 0 : vector<16xi4>, vector<14xi4>
    %343 = llhd.extf %342, 0 : vector<16xi4> -> i4
    %344 = llhd.exts %index_lut1, 3 : vector<16xi4> -> vector<13xi4>
    %345 = llhd.inss %162, %344, 0 : vector<16xi4>, vector<13xi4>
    %346 = llhd.extf %345, 0 : vector<16xi4> -> i4
    %347 = llhd.vec %346, %343 : vector<2xi4>
    %348 = llhd.dextf %347, %340 : (vector<2xi4>, i1) -> i4
    llhd.drv %338, %348 after %6 : !llhd.sig<i4>
    %349 = llhd.sig "sig35" %2 : i16
    %350 = llhd.shr %sel_nodes, %349, %85 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %351 = llhd.exts %350, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %352 = llhd.exts %in_tmp1, 4 : i16 -> i12
    %353 = llhd.inss %2, %352, 0 : i16, i12
    %354 = llhd.exts %353, 0 : i16 -> i1
    %355 = llhd.exts %in_tmp1, 5 : i16 -> i11
    %356 = llhd.inss %2, %355, 0 : i16, i11
    %357 = llhd.exts %356, 0 : i16 -> i1
    %358 = llhd.or %354, %357 : i1
    llhd.drv %351, %358 after %6 : !llhd.sig<i1>
    %359 = llhd.sig "sig36" %45 : vector<16xi4>
    %360 = llhd.shr %index_nodes, %359, %85 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %361 = llhd.extf %360, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %362 = cmpi "eq", %354, %129 : i1
    %363 = cmpi "ne", %362, %131 : i1
    %364 = llhd.exts %index_lut1, 4 : vector<16xi4> -> vector<12xi4>
    %365 = llhd.inss %167, %364, 0 : vector<16xi4>, vector<12xi4>
    %366 = llhd.extf %365, 0 : vector<16xi4> -> i4
    %367 = llhd.exts %index_lut1, 5 : vector<16xi4> -> vector<11xi4>
    %368 = llhd.inss %189, %367, 0 : vector<16xi4>, vector<11xi4>
    %369 = llhd.extf %368, 0 : vector<16xi4> -> i4
    %370 = llhd.vec %369, %366 : vector<2xi4>
    %371 = llhd.dextf %370, %363 : (vector<2xi4>, i1) -> i4
    llhd.drv %361, %371 after %6 : !llhd.sig<i4>
    %372 = llhd.sig "sig37" %2 : i16
    %373 = llhd.shr %sel_nodes, %372, %90 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %374 = llhd.exts %373, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %375 = llhd.exts %in_tmp1, 6 : i16 -> i10
    %376 = llhd.inss %2, %375, 0 : i16, i10
    %377 = llhd.exts %376, 0 : i16 -> i1
    %378 = llhd.exts %in_tmp1, 7 : i16 -> i9
    %379 = llhd.inss %2, %378, 0 : i16, i9
    %380 = llhd.exts %379, 0 : i16 -> i1
    %381 = llhd.or %377, %380 : i1
    llhd.drv %374, %381 after %6 : !llhd.sig<i1>
    %382 = llhd.sig "sig38" %45 : vector<16xi4>
    %383 = llhd.shr %index_nodes, %382, %90 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %384 = llhd.extf %383, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %385 = cmpi "eq", %377, %129 : i1
    %386 = cmpi "ne", %385, %131 : i1
    %387 = llhd.exts %index_lut1, 6 : vector<16xi4> -> vector<10xi4>
    %388 = llhd.inss %194, %387, 0 : vector<16xi4>, vector<10xi4>
    %389 = llhd.extf %388, 0 : vector<16xi4> -> i4
    %390 = llhd.exts %index_lut1, 7 : vector<16xi4> -> vector<9xi4>
    %391 = llhd.inss %216, %390, 0 : vector<16xi4>, vector<9xi4>
    %392 = llhd.extf %391, 0 : vector<16xi4> -> i4
    %393 = llhd.vec %392, %389 : vector<2xi4>
    %394 = llhd.dextf %393, %386 : (vector<2xi4>, i1) -> i4
    llhd.drv %384, %394 after %6 : !llhd.sig<i4>
    %395 = llhd.sig "sig39" %2 : i16
    %396 = llhd.shr %sel_nodes, %395, %95 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %397 = llhd.exts %396, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %398 = llhd.exts %in_tmp1, 8 : i16 -> i8
    %399 = llhd.inss %2, %398, 0 : i16, i8
    %400 = llhd.exts %399, 0 : i16 -> i1
    %401 = llhd.exts %in_tmp1, 9 : i16 -> i7
    %402 = llhd.inss %2, %401, 0 : i16, i7
    %403 = llhd.exts %402, 0 : i16 -> i1
    %404 = llhd.or %400, %403 : i1
    llhd.drv %397, %404 after %6 : !llhd.sig<i1>
    %405 = llhd.sig "sig40" %45 : vector<16xi4>
    %406 = llhd.shr %index_nodes, %405, %95 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %407 = llhd.extf %406, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %408 = cmpi "eq", %400, %129 : i1
    %409 = cmpi "ne", %408, %131 : i1
    %410 = llhd.exts %index_lut1, 8 : vector<16xi4> -> vector<8xi4>
    %411 = llhd.inss %221, %410, 0 : vector<16xi4>, vector<8xi4>
    %412 = llhd.extf %411, 0 : vector<16xi4> -> i4
    %413 = llhd.exts %index_lut1, 9 : vector<16xi4> -> vector<7xi4>
    %414 = llhd.inss %243, %413, 0 : vector<16xi4>, vector<7xi4>
    %415 = llhd.extf %414, 0 : vector<16xi4> -> i4
    %416 = llhd.vec %415, %412 : vector<2xi4>
    %417 = llhd.dextf %416, %409 : (vector<2xi4>, i1) -> i4
    llhd.drv %407, %417 after %6 : !llhd.sig<i4>
    %418 = llhd.sig "sig41" %2 : i16
    %419 = llhd.shr %sel_nodes, %418, %100 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %420 = llhd.exts %419, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %421 = llhd.exts %in_tmp1, 10 : i16 -> i6
    %422 = llhd.inss %2, %421, 0 : i16, i6
    %423 = llhd.exts %422, 0 : i16 -> i1
    %424 = llhd.exts %in_tmp1, 11 : i16 -> i5
    %425 = llhd.inss %2, %424, 0 : i16, i5
    %426 = llhd.exts %425, 0 : i16 -> i1
    %427 = llhd.or %423, %426 : i1
    llhd.drv %420, %427 after %6 : !llhd.sig<i1>
    %428 = llhd.sig "sig42" %45 : vector<16xi4>
    %429 = llhd.shr %index_nodes, %428, %100 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %430 = llhd.extf %429, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %431 = cmpi "eq", %423, %129 : i1
    %432 = cmpi "ne", %431, %131 : i1
    %433 = llhd.exts %index_lut1, 10 : vector<16xi4> -> vector<6xi4>
    %434 = llhd.inss %248, %433, 0 : vector<16xi4>, vector<6xi4>
    %435 = llhd.extf %434, 0 : vector<16xi4> -> i4
    %436 = llhd.exts %index_lut1, 11 : vector<16xi4> -> vector<5xi4>
    %437 = llhd.inss %270, %436, 0 : vector<16xi4>, vector<5xi4>
    %438 = llhd.extf %437, 0 : vector<16xi4> -> i4
    %439 = llhd.vec %438, %435 : vector<2xi4>
    %440 = llhd.dextf %439, %432 : (vector<2xi4>, i1) -> i4
    llhd.drv %430, %440 after %6 : !llhd.sig<i4>
    %441 = llhd.sig "sig43" %2 : i16
    %442 = llhd.shr %sel_nodes, %441, %105 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %443 = llhd.exts %442, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %444 = llhd.exts %in_tmp1, 12 : i16 -> i4
    %445 = llhd.inss %2, %444, 0 : i16, i4
    %446 = llhd.exts %445, 0 : i16 -> i1
    %447 = llhd.exts %in_tmp1, 13 : i16 -> i3
    %448 = llhd.inss %2, %447, 0 : i16, i3
    %449 = llhd.exts %448, 0 : i16 -> i1
    %450 = llhd.or %446, %449 : i1
    llhd.drv %443, %450 after %6 : !llhd.sig<i1>
    %451 = llhd.sig "sig44" %45 : vector<16xi4>
    %452 = llhd.shr %index_nodes, %451, %105 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %453 = llhd.extf %452, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %454 = cmpi "eq", %446, %129 : i1
    %455 = cmpi "ne", %454, %131 : i1
    %456 = llhd.exts %index_lut1, 12 : vector<16xi4> -> vector<4xi4>
    %457 = llhd.inss %275, %456, 0 : vector<16xi4>, vector<4xi4>
    %458 = llhd.extf %457, 0 : vector<16xi4> -> i4
    %459 = llhd.exts %index_lut1, 13 : vector<16xi4> -> vector<3xi4>
    %460 = llhd.inss %297, %459, 0 : vector<16xi4>, vector<3xi4>
    %461 = llhd.extf %460, 0 : vector<16xi4> -> i4
    %462 = llhd.vec %461, %458 : vector<2xi4>
    %463 = llhd.dextf %462, %455 : (vector<2xi4>, i1) -> i4
    llhd.drv %453, %463 after %6 : !llhd.sig<i4>
    %464 = llhd.sig "sig45" %2 : i16
    %465 = llhd.shr %sel_nodes, %464, %110 : (!llhd.sig<i16>, !llhd.sig<i16>, i32) -> !llhd.sig<i16>
    %466 = llhd.exts %465, 0 : !llhd.sig<i16> -> !llhd.sig<i1>
    %467 = llhd.exts %in_tmp1, 14 : i16 -> i2
    %468 = llhd.inss %2, %467, 0 : i16, i2
    %469 = llhd.exts %468, 0 : i16 -> i1
    %470 = llhd.exts %in_tmp1, 15 : i16 -> i1
    %471 = llhd.inss %2, %470, 0 : i16, i1
    %472 = llhd.exts %471, 0 : i16 -> i1
    %473 = llhd.or %469, %472 : i1
    llhd.drv %466, %473 after %6 : !llhd.sig<i1>
    %474 = llhd.sig "sig46" %45 : vector<16xi4>
    %475 = llhd.shr %index_nodes, %474, %110 : (!llhd.sig<vector<16xi4>>, !llhd.sig<vector<16xi4>>, i32) -> !llhd.sig<vector<16xi4>>
    %476 = llhd.extf %475, 0 : !llhd.sig<vector<16xi4>> -> !llhd.sig<i4>
    %477 = cmpi "eq", %469, %129 : i1
    %478 = cmpi "ne", %477, %131 : i1
    %479 = llhd.exts %index_lut1, 14 : vector<16xi4> -> vector<2xi4>
    %480 = llhd.inss %302, %479, 0 : vector<16xi4>, vector<2xi4>
    %481 = llhd.extf %480, 0 : vector<16xi4> -> i4
    %482 = llhd.exts %45, 0 : vector<16xi4> -> vector<15xi4>
    %483 = llhd.exts %index_lut1, 15 : vector<16xi4> -> vector<1xi4>
    %484 = llhd.inss %45, %482, 1 : vector<16xi4>, vector<15xi4>
    %485 = llhd.inss %484, %483, 0 : vector<16xi4>, vector<1xi4>
    %486 = llhd.extf %485, 0 : vector<16xi4> -> i4
    %487 = llhd.vec %486, %481 : vector<2xi4>
    %488 = llhd.dextf %487, %478 : (vector<2xi4>, i1) -> i4
    llhd.drv %476, %488 after %6 : !llhd.sig<i4>
    llhd.inst "inst" @lzc.param1.initial.69.1() -> () : () -> ()
    llhd.inst "inst1" @lzc.param1.always_comb.217.1(%in_i) -> (%in_tmp) : (!llhd.sig<i16>) -> (!llhd.sig<i16>)
}

llhd.proc @lfsr_16bit.param37.always_comb.1243.37(%shift_q: !llhd.sig<i16>, %en_i: !llhd.sig<i1>) -> (%shift_d: !llhd.sig<i16> , %out_o: !llhd.sig<i16> ) {
    br ^body
^body:
    %shift_q1 = llhd.prb %shift_q : !llhd.sig<i16>
    %0 = llhd.exts %shift_q1, 15 : i16 -> i1
    %1 = constant 0 : i16
    %2 = llhd.inss %1, %0, 0 : i16, i1
    %3 = llhd.exts %2, 0 : i16 -> i1
    %4 = llhd.exts %shift_q1, 12 : i16 -> i4
    %5 = llhd.inss %1, %4, 0 : i16, i4
    %6 = llhd.exts %5, 0 : i16 -> i1
    %7 = llhd.xor %3, %6 : i1
    %8 = llhd.exts %shift_q1, 5 : i16 -> i11
    %9 = llhd.inss %1, %8, 0 : i16, i11
    %10 = llhd.exts %9, 0 : i16 -> i1
    %11 = llhd.xor %7, %10 : i1
    %12 = llhd.exts %shift_q1, 1 : i16 -> i15
    %13 = llhd.inss %1, %12, 0 : i16, i15
    %14 = llhd.exts %13, 0 : i16 -> i1
    %15 = llhd.xor %11, %14 : i1
    %16 = constant 0 : i1
    %17 = cmpi "ne", %15, %16 : i1
    %18 = llhd.not %17 : i1
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %shift_d, %shift_q1 after %19 : !llhd.sig<i16>
    %en_i1 = llhd.prb %en_i : !llhd.sig<i1>
    %20 = cmpi "ne", %en_i1, %16 : i1
    cond_br %20, ^if_true, ^if_exit
^if_exit:
    llhd.drv %out_o, %shift_q1 after %19 : !llhd.sig<i16>
    llhd.wait (%shift_q, %en_i : !llhd.sig<i16>, !llhd.sig<i1>), ^body
^if_true:
    %21 = llhd.inss %1, %18, 0 : i16, i1
    %22 = llhd.exts %shift_q1, 0 : i16 -> i15
    %23 = llhd.inss %21, %22, 1 : i16, i15
    llhd.drv %shift_d, %23 after %19 : !llhd.sig<i16>
    br ^if_exit
}

llhd.proc @lfsr_16bit.param37.always_ff.1284.37(%shift_d: !llhd.sig<i16>, %clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>) -> (%shift_q: !llhd.sig<i16> ) {
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
    %5 = llhd.not %rst_ni2 : i1
    %6 = cmpi "ne", %5, %0 : i1
    %7 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %6, ^if_true, ^if_false
^if_false:
    %shift_d1 = llhd.prb %shift_d : !llhd.sig<i16>
    llhd.drv %shift_q, %shift_d1 after %7 : !llhd.sig<i16>
    br ^init
^if_true:
    %8 = constant 1 : i16
    llhd.drv %shift_q, %8 after %7 : !llhd.sig<i16>
    br ^init
}

llhd.proc @lfsr_16bit.param37.initial.1302.37() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.entity @lfsr_16bit.param37(%clk_i: !llhd.sig<i1>, %rst_ni: !llhd.sig<i1>, %en_i: !llhd.sig<i1>) -> (%out_o: !llhd.sig<i16> ) {
    %0 = constant 0 : i16
    %shift_d = llhd.sig "sig" %0 : i16
    %shift_q = llhd.sig "sig1" %0 : i16
    llhd.inst "inst" @lfsr_16bit.param37.always_comb.1243.37(%shift_q, %en_i) -> (%shift_d, %out_o) : (!llhd.sig<i16>, !llhd.sig<i1>) -> (!llhd.sig<i16>, !llhd.sig<i16>)
    llhd.inst "inst1" @lfsr_16bit.param37.always_ff.1284.37(%shift_d, %clk_i, %rst_ni) -> (%shift_q) : (!llhd.sig<i16>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lfsr_16bit.param37.initial.1302.37() -> () : () -> ()
}

llhd.proc @lzc_tb.initial.1083.0() -> (%clk_i: !llhd.sig<i1> , %rst_ni: !llhd.sig<i1> ) {
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
    %7 = constant 1000000 : i32
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

llhd.entity @lzc_tb() -> () {
    %0 = constant 0 : i16
    %in_i = llhd.sig "sig" %0 : i16
    %1 = constant 0 : i4
    %cnt_o = llhd.sig "sig1" %1 : i4
    %2 = constant 0 : i1
    %empty_o = llhd.sig "sig2" %2 : i1
    %clk_i = llhd.sig "sig3" %2 : i1
    %3 = constant 1 : i1
    %rst_ni = llhd.sig "sig4" %3 : i1
    %in_i1 = llhd.prb %in_i : !llhd.sig<i16>
    %4 = llhd.sig "sig5" %0 : i16
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %in_i1 after %5 : !llhd.sig<i16>
    llhd.inst "inst" @lzc.param1(%4) -> (%cnt_o, %empty_o) : (!llhd.sig<i16>) -> (!llhd.sig<i4>, !llhd.sig<i1>)
    %clk_i1 = llhd.prb %clk_i : !llhd.sig<i1>
    %6 = llhd.sig "sig6" %2 : i1
    llhd.drv %6, %clk_i1 after %5 : !llhd.sig<i1>
    %rst_ni1 = llhd.prb %rst_ni : !llhd.sig<i1>
    %7 = llhd.sig "sig7" %2 : i1
    llhd.drv %7, %rst_ni1 after %5 : !llhd.sig<i1>
    %8 = llhd.sig "sig8" %2 : i1
    llhd.drv %8, %3 after %5 : !llhd.sig<i1>
    llhd.inst "inst1" @lfsr_16bit.param37(%6, %7, %8) -> (%in_i) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i16>)
    llhd.inst "inst2" @lzc_tb.initial.1083.0() -> (%clk_i, %rst_ni) : () -> (!llhd.sig<i1>, !llhd.sig<i1>)
}
