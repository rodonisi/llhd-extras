llhd.proc @fir.param1.always_ff.395.1(%CLK: !llhd.sig<i1>, %add_out: !llhd.sig<!llhd.array<4xi16>>) -> (%q: !llhd.sig<!llhd.array<4xi16>> ) {
    br ^0
^0:
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %CLK1, %1 : i1
    %3 = llhd.neq %CLK2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %4 = llhd.const 1 : i32
    %5 = llhd.const 0 : i16
    %6 = llhd.array_uniform %5 : !llhd.array<4xi16>
    %7 = llhd.dyn_extract_element %q, %4 : (!llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %8 = llhd.const 1 : i32
    %9 = llhd.const 1 : i32
    %10 = subi %8, %9 : i32
    %11 = llhd.const 0 : i16
    %12 = llhd.array_uniform %11 : !llhd.array<4xi16>
    %13 = llhd.shr %add_out1, %12, %10 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %14 = llhd.extract_element %13, 0 : !llhd.array<4xi16> -> i16
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %7, %14 after %15 : !llhd.sig<i16>
    br ^0
}

llhd.proc @fir.param1.always_ff.395.10(%CLK: !llhd.sig<i1>, %add_out: !llhd.sig<!llhd.array<4xi16>>) -> (%q: !llhd.sig<!llhd.array<4xi16>> ) {
    br ^0
^0:
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %CLK1, %1 : i1
    %3 = llhd.neq %CLK2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %4 = llhd.const 2 : i32
    %5 = llhd.const 0 : i16
    %6 = llhd.array_uniform %5 : !llhd.array<4xi16>
    %7 = llhd.dyn_extract_element %q, %4 : (!llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %8 = llhd.const 2 : i32
    %9 = llhd.const 1 : i32
    %10 = subi %8, %9 : i32
    %11 = llhd.const 0 : i16
    %12 = llhd.array_uniform %11 : !llhd.array<4xi16>
    %13 = llhd.shr %add_out1, %12, %10 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %14 = llhd.extract_element %13, 0 : !llhd.array<4xi16> -> i16
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %7, %14 after %15 : !llhd.sig<i16>
    br ^0
}

llhd.proc @fir.param1.always_ff.395.11(%CLK: !llhd.sig<i1>, %add_out: !llhd.sig<!llhd.array<4xi16>>) -> (%q: !llhd.sig<!llhd.array<4xi16>> ) {
    br ^0
^0:
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %CLK1, %1 : i1
    %3 = llhd.neq %CLK2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    cond_br %posedge, ^event, ^init
^event:
    %4 = llhd.const 3 : i32
    %5 = llhd.const 0 : i16
    %6 = llhd.array_uniform %5 : !llhd.array<4xi16>
    %7 = llhd.dyn_extract_element %q, %4 : (!llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %8 = llhd.const 3 : i32
    %9 = llhd.const 1 : i32
    %10 = subi %8, %9 : i32
    %11 = llhd.const 0 : i16
    %12 = llhd.array_uniform %11 : !llhd.array<4xi16>
    %13 = llhd.shr %add_out1, %12, %10 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %14 = llhd.extract_element %13, 0 : !llhd.array<4xi16> -> i16
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %7, %14 after %15 : !llhd.sig<i16>
    br ^0
}

llhd.entity @fir.param1(%CLK: !llhd.sig<i1>, %X: !llhd.sig<i8>, %W: !llhd.sig<!llhd.array<4xi8>>) -> (%Y: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %1 = llhd.const 0 : i16
    %2 = llhd.const 0 : i16
    %3 = llhd.const 0 : i16
    %4 = llhd.array %0, %1, %2, %3 : !llhd.array<4xi16>
    %mul_out = llhd.sig "mul_out" %4 : !llhd.array<4xi16>
    %5 = llhd.const 0 : i16
    %6 = llhd.const 0 : i16
    %7 = llhd.const 0 : i16
    %8 = llhd.const 0 : i16
    %9 = llhd.array %5, %6, %7, %8 : !llhd.array<4xi16>
    %add_out = llhd.sig "add_out" %9 : !llhd.array<4xi16>
    %10 = llhd.const 0 : i16
    %11 = llhd.const 0 : i16
    %12 = llhd.const 0 : i16
    %13 = llhd.const 0 : i16
    %14 = llhd.array %10, %11, %12, %13 : !llhd.array<4xi16>
    %q = llhd.sig "q" %14 : !llhd.array<4xi16>
    %15 = llhd.const 0 : i32
    %16 = llhd.const 0 : i16
    %17 = llhd.array_uniform %16 : !llhd.array<4xi16>
    %18 = llhd.sig "18" %17 : !llhd.array<4xi16>
    %19 = llhd.shr %q, %18, %15 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %20 = llhd.extract_element %19, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %21 = llhd.const 0 : i16
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %20, %21 after %22 : !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %23 = llhd.const 4 : i32
    %24 = llhd.const 1 : i32
    %25 = subi %23, %24 : i32
    %26 = llhd.const 0 : i16
    %27 = llhd.array_uniform %26 : !llhd.array<4xi16>
    %28 = llhd.shr %add_out1, %27, %25 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %29 = llhd.extract_element %28, 0 : !llhd.array<4xi16> -> i16
    %30 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Y, %29 after %30 : !llhd.sig<i16>
    %31 = llhd.const 0 : i32
    %32 = llhd.const 0 : i16
    %33 = llhd.array_uniform %32 : !llhd.array<4xi16>
    %34 = llhd.sig "34" %33 : !llhd.array<4xi16>
    %35 = llhd.shr %mul_out, %34, %31 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %36 = llhd.extract_element %35, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %37 = llhd.const 0 : i16
    %W1 = llhd.prb %W : !llhd.sig<!llhd.array<4xi8>>
    %38 = llhd.const 0 : i32
    %39 = llhd.const 0 : i8
    %40 = llhd.array_uniform %39 : !llhd.array<4xi8>
    %41 = llhd.shr %W1, %40, %38 : (!llhd.array<4xi8>, !llhd.array<4xi8>, i32) -> !llhd.array<4xi8>
    %42 = llhd.extract_element %41, 0 : !llhd.array<4xi8> -> i8
    %43 = llhd.insert_slice %37, %42, 0 : i16, i8
    %44 = llhd.const 0 : i16
    %X1 = llhd.prb %X : !llhd.sig<i8>
    %45 = llhd.insert_slice %44, %X1, 0 : i16, i8
    %46 = muli %43, %45 : i16
    %47 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %36, %46 after %47 : !llhd.sig<i16>
    %48 = llhd.const 1 : i32
    %49 = llhd.const 0 : i16
    %50 = llhd.array_uniform %49 : !llhd.array<4xi16>
    %51 = llhd.sig "51" %50 : !llhd.array<4xi16>
    %52 = llhd.shr %mul_out, %51, %48 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %53 = llhd.extract_element %52, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %54 = llhd.const 0 : i16
    %W2 = llhd.prb %W : !llhd.sig<!llhd.array<4xi8>>
    %55 = llhd.const 1 : i32
    %56 = llhd.const 0 : i8
    %57 = llhd.array_uniform %56 : !llhd.array<4xi8>
    %58 = llhd.shr %W2, %57, %55 : (!llhd.array<4xi8>, !llhd.array<4xi8>, i32) -> !llhd.array<4xi8>
    %59 = llhd.extract_element %58, 0 : !llhd.array<4xi8> -> i8
    %60 = llhd.insert_slice %54, %59, 0 : i16, i8
    %61 = llhd.const 0 : i16
    %X2 = llhd.prb %X : !llhd.sig<i8>
    %62 = llhd.insert_slice %61, %X2, 0 : i16, i8
    %63 = muli %60, %62 : i16
    %64 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %53, %63 after %64 : !llhd.sig<i16>
    %65 = llhd.const 2 : i32
    %66 = llhd.const 0 : i16
    %67 = llhd.array_uniform %66 : !llhd.array<4xi16>
    %68 = llhd.sig "68" %67 : !llhd.array<4xi16>
    %69 = llhd.shr %mul_out, %68, %65 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %70 = llhd.extract_element %69, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %71 = llhd.const 0 : i16
    %W3 = llhd.prb %W : !llhd.sig<!llhd.array<4xi8>>
    %72 = llhd.const 2 : i32
    %73 = llhd.const 0 : i8
    %74 = llhd.array_uniform %73 : !llhd.array<4xi8>
    %75 = llhd.shr %W3, %74, %72 : (!llhd.array<4xi8>, !llhd.array<4xi8>, i32) -> !llhd.array<4xi8>
    %76 = llhd.extract_element %75, 0 : !llhd.array<4xi8> -> i8
    %77 = llhd.insert_slice %71, %76, 0 : i16, i8
    %78 = llhd.const 0 : i16
    %X3 = llhd.prb %X : !llhd.sig<i8>
    %79 = llhd.insert_slice %78, %X3, 0 : i16, i8
    %80 = muli %77, %79 : i16
    %81 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %70, %80 after %81 : !llhd.sig<i16>
    %82 = llhd.const 3 : i32
    %83 = llhd.const 0 : i16
    %84 = llhd.array_uniform %83 : !llhd.array<4xi16>
    %85 = llhd.sig "85" %84 : !llhd.array<4xi16>
    %86 = llhd.shr %mul_out, %85, %82 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %87 = llhd.extract_element %86, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %88 = llhd.const 0 : i16
    %W4 = llhd.prb %W : !llhd.sig<!llhd.array<4xi8>>
    %89 = llhd.const 3 : i32
    %90 = llhd.const 0 : i8
    %91 = llhd.array_uniform %90 : !llhd.array<4xi8>
    %92 = llhd.shr %W4, %91, %89 : (!llhd.array<4xi8>, !llhd.array<4xi8>, i32) -> !llhd.array<4xi8>
    %93 = llhd.extract_element %92, 0 : !llhd.array<4xi8> -> i8
    %94 = llhd.insert_slice %88, %93, 0 : i16, i8
    %95 = llhd.const 0 : i16
    %X4 = llhd.prb %X : !llhd.sig<i8>
    %96 = llhd.insert_slice %95, %X4, 0 : i16, i8
    %97 = muli %94, %96 : i16
    %98 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %87, %97 after %98 : !llhd.sig<i16>
    %99 = llhd.const 0 : i32
    %100 = llhd.const 0 : i16
    %101 = llhd.array_uniform %100 : !llhd.array<4xi16>
    %102 = llhd.sig "102" %101 : !llhd.array<4xi16>
    %103 = llhd.shr %add_out, %102, %99 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %104 = llhd.extract_element %103, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %q1 = llhd.prb %q : !llhd.sig<!llhd.array<4xi16>>
    %105 = llhd.const 0 : i32
    %106 = llhd.const 0 : i16
    %107 = llhd.array_uniform %106 : !llhd.array<4xi16>
    %108 = llhd.shr %q1, %107, %105 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %109 = llhd.extract_element %108, 0 : !llhd.array<4xi16> -> i16
    %mul_out1 = llhd.prb %mul_out : !llhd.sig<!llhd.array<4xi16>>
    %110 = llhd.const 4 : i32
    %111 = llhd.const 0 : i32
    %112 = subi %110, %111 : i32
    %113 = llhd.const 1 : i32
    %114 = subi %112, %113 : i32
    %115 = llhd.const 0 : i16
    %116 = llhd.array_uniform %115 : !llhd.array<4xi16>
    %117 = llhd.shr %mul_out1, %116, %114 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %118 = llhd.extract_element %117, 0 : !llhd.array<4xi16> -> i16
    %119 = addi %109, %118 : i16
    %120 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %104, %119 after %120 : !llhd.sig<i16>
    %121 = llhd.const 1 : i32
    %122 = llhd.const 0 : i16
    %123 = llhd.array_uniform %122 : !llhd.array<4xi16>
    %124 = llhd.sig "124" %123 : !llhd.array<4xi16>
    %125 = llhd.shr %add_out, %124, %121 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %126 = llhd.extract_element %125, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %q2 = llhd.prb %q : !llhd.sig<!llhd.array<4xi16>>
    %127 = llhd.const 1 : i32
    %128 = llhd.const 0 : i16
    %129 = llhd.array_uniform %128 : !llhd.array<4xi16>
    %130 = llhd.shr %q2, %129, %127 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %131 = llhd.extract_element %130, 0 : !llhd.array<4xi16> -> i16
    %mul_out2 = llhd.prb %mul_out : !llhd.sig<!llhd.array<4xi16>>
    %132 = llhd.const 4 : i32
    %133 = llhd.const 1 : i32
    %134 = subi %132, %133 : i32
    %135 = llhd.const 1 : i32
    %136 = subi %134, %135 : i32
    %137 = llhd.const 0 : i16
    %138 = llhd.array_uniform %137 : !llhd.array<4xi16>
    %139 = llhd.shr %mul_out2, %138, %136 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %140 = llhd.extract_element %139, 0 : !llhd.array<4xi16> -> i16
    %141 = addi %131, %140 : i16
    %142 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %126, %141 after %142 : !llhd.sig<i16>
    %143 = llhd.const 2 : i32
    %144 = llhd.const 0 : i16
    %145 = llhd.array_uniform %144 : !llhd.array<4xi16>
    %146 = llhd.sig "146" %145 : !llhd.array<4xi16>
    %147 = llhd.shr %add_out, %146, %143 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %148 = llhd.extract_element %147, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %q3 = llhd.prb %q : !llhd.sig<!llhd.array<4xi16>>
    %149 = llhd.const 2 : i32
    %150 = llhd.const 0 : i16
    %151 = llhd.array_uniform %150 : !llhd.array<4xi16>
    %152 = llhd.shr %q3, %151, %149 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %153 = llhd.extract_element %152, 0 : !llhd.array<4xi16> -> i16
    %mul_out3 = llhd.prb %mul_out : !llhd.sig<!llhd.array<4xi16>>
    %154 = llhd.const 4 : i32
    %155 = llhd.const 2 : i32
    %156 = subi %154, %155 : i32
    %157 = llhd.const 1 : i32
    %158 = subi %156, %157 : i32
    %159 = llhd.const 0 : i16
    %160 = llhd.array_uniform %159 : !llhd.array<4xi16>
    %161 = llhd.shr %mul_out3, %160, %158 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %162 = llhd.extract_element %161, 0 : !llhd.array<4xi16> -> i16
    %163 = addi %153, %162 : i16
    %164 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %148, %163 after %164 : !llhd.sig<i16>
    %165 = llhd.const 3 : i32
    %166 = llhd.const 0 : i16
    %167 = llhd.array_uniform %166 : !llhd.array<4xi16>
    %168 = llhd.sig "168" %167 : !llhd.array<4xi16>
    %169 = llhd.shr %add_out, %168, %165 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %170 = llhd.extract_element %169, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %q4 = llhd.prb %q : !llhd.sig<!llhd.array<4xi16>>
    %171 = llhd.const 3 : i32
    %172 = llhd.const 0 : i16
    %173 = llhd.array_uniform %172 : !llhd.array<4xi16>
    %174 = llhd.shr %q4, %173, %171 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %175 = llhd.extract_element %174, 0 : !llhd.array<4xi16> -> i16
    %mul_out4 = llhd.prb %mul_out : !llhd.sig<!llhd.array<4xi16>>
    %176 = llhd.const 4 : i32
    %177 = llhd.const 3 : i32
    %178 = subi %176, %177 : i32
    %179 = llhd.const 1 : i32
    %180 = subi %178, %179 : i32
    %181 = llhd.const 0 : i16
    %182 = llhd.array_uniform %181 : !llhd.array<4xi16>
    %183 = llhd.shr %mul_out4, %182, %180 : (!llhd.array<4xi16>, !llhd.array<4xi16>, i32) -> !llhd.array<4xi16>
    %184 = llhd.extract_element %183, 0 : !llhd.array<4xi16> -> i16
    %185 = addi %175, %184 : i16
    %186 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %170, %185 after %186 : !llhd.sig<i16>
    llhd.inst "inst" @fir.param1.always_ff.395.1(%CLK, %add_out) -> (%q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<4xi16>>) -> (!llhd.sig<!llhd.array<4xi16>>)
    llhd.inst "inst1" @fir.param1.always_ff.395.10(%CLK, %add_out) -> (%q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<4xi16>>) -> (!llhd.sig<!llhd.array<4xi16>>)
    llhd.inst "inst2" @fir.param1.always_ff.395.11(%CLK, %add_out) -> (%q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<4xi16>>) -> (!llhd.sig<!llhd.array<4xi16>>)
}

llhd.proc @fir_tb.initial.239.0() -> (%CLK: !llhd.sig<i1> , %X: !llhd.sig<i8> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i8
    %2 = llhd.const 0 : i1
    %3 = llhd.insert_slice %1, %2, 0 : i8, i1
    %4 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %X, %3 after %4 : !llhd.sig<i8>
    %5 = llhd.const 5000000 : i32
    %loop_count = llhd.var %5 : i32
    br ^loop_body
^loop_body:
    %6 = llhd.load %loop_count : !llhd.ptr<i32>
    %7 = llhd.const 0 : i32
    %8 = llhd.neq %6, %7 : i32
    cond_br %8, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    %9 = llhd.const 1 : i32
    %10 = llhd.extract_slice %9, 0 : i32 -> i1
    %11 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %CLK, %10 after %11 : !llhd.sig<i1>
    %12 = llhd.const 0 : i32
    %13 = llhd.extract_slice %12, 0 : i32 -> i1
    %14 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %CLK, %13 after %14 : !llhd.sig<i1>
    %15 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.wait  for %15, ^16
^16:
    %17 = llhd.load %loop_count : !llhd.ptr<i32>
    %18 = llhd.const 1 : i32
    %19 = subi %17, %18 : i32
    llhd.store %loop_count, %19 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.proc @fir_tb.always.240.0(%CLK: !llhd.sig<i1>, %X: !llhd.sig<i8>) -> (%X1: !llhd.sig<i8> ) {
    br ^0
^0:
    %1 = llhd.prb %X1 : !llhd.sig<i8>
    %X.shadow = llhd.var %1 : i8
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %X1 : !llhd.sig<i8>
    llhd.store %X.shadow, %2 : !llhd.ptr<i8>
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %CLK1, %3 : i1
    %5 = llhd.neq %CLK2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    cond_br %posedge, ^event, ^init
^event:
    %6 = llhd.const 0 : i32
    %X2 = llhd.load %X.shadow : !llhd.ptr<i8>
    %7 = llhd.insert_slice %6, %X2, 0 : i32, i8
    %8 = llhd.const 9 : i32
    %9 = addi %7, %8 : i32
    %10 = llhd.const 19 : i32
    %11 = remi_unsigned %9, %10 : i32
    %12 = llhd.extract_slice %11, 0 : i32 -> i8
    %13 = llhd.const #llhd.time<500ps, 0d, 0e> : !llhd.time
    llhd.drv %X1, %12 after %13 : !llhd.sig<i8>
    br ^0
}

llhd.entity @fir_tb() -> () {
    %0 = llhd.const 0 : i1
    %CLK = llhd.sig "CLK" %0 : i1
    %1 = llhd.const 0 : i8
    %X = llhd.sig "X" %1 : i8
    %2 = llhd.const 0 : i8
    %3 = llhd.const 0 : i8
    %4 = llhd.const 0 : i8
    %5 = llhd.const 0 : i8
    %6 = llhd.array %2, %3, %4, %5 : !llhd.array<4xi8>
    %W = llhd.sig "W" %6 : !llhd.array<4xi8>
    %7 = llhd.const 0 : i16
    %Y = llhd.sig "Y" %7 : i16
    %8 = llhd.const 0 : i32
    %9 = llhd.const 0 : i8
    %10 = llhd.array_uniform %9 : !llhd.array<4xi8>
    %11 = llhd.sig "11" %10 : !llhd.array<4xi8>
    %12 = llhd.shr %W, %11, %8 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %13 = llhd.extract_element %12, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %14 = llhd.const 2 : i32
    %15 = llhd.neg %14 : i32
    %16 = llhd.extract_slice %15, 0 : i32 -> i8
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %13, %16 after %17 : !llhd.sig<i8>
    %18 = llhd.const 1 : i32
    %19 = llhd.const 0 : i8
    %20 = llhd.array_uniform %19 : !llhd.array<4xi8>
    %21 = llhd.sig "21" %20 : !llhd.array<4xi8>
    %22 = llhd.shr %W, %21, %18 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %23 = llhd.extract_element %22, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %24 = llhd.const 1 : i32
    %25 = llhd.neg %24 : i32
    %26 = llhd.extract_slice %25, 0 : i32 -> i8
    %27 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %23, %26 after %27 : !llhd.sig<i8>
    %28 = llhd.const 2 : i32
    %29 = llhd.const 0 : i8
    %30 = llhd.array_uniform %29 : !llhd.array<4xi8>
    %31 = llhd.sig "31" %30 : !llhd.array<4xi8>
    %32 = llhd.shr %W, %31, %28 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %33 = llhd.extract_element %32, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %34 = llhd.const 3 : i32
    %35 = llhd.extract_slice %34, 0 : i32 -> i8
    %36 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %33, %35 after %36 : !llhd.sig<i8>
    %37 = llhd.const 3 : i32
    %38 = llhd.const 0 : i8
    %39 = llhd.array_uniform %38 : !llhd.array<4xi8>
    %40 = llhd.sig "40" %39 : !llhd.array<4xi8>
    %41 = llhd.shr %W, %40, %37 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %42 = llhd.extract_element %41, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %43 = llhd.const 4 : i32
    %44 = llhd.extract_slice %43, 0 : i32 -> i8
    %45 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %42, %44 after %45 : !llhd.sig<i8>
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    %46 = llhd.const 0 : i1
    %47 = llhd.sig "47" %46 : i1
    %48 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %47, %CLK1 after %48 : !llhd.sig<i1>
    %X1 = llhd.prb %X : !llhd.sig<i8>
    %49 = llhd.const 0 : i8
    %50 = llhd.sig "50" %49 : i8
    %51 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %50, %X1 after %51 : !llhd.sig<i8>
    %W1 = llhd.prb %W : !llhd.sig<!llhd.array<4xi8>>
    %52 = llhd.const 0 : i8
    %53 = llhd.array_uniform %52 : !llhd.array<4xi8>
    %54 = llhd.sig "54" %53 : !llhd.array<4xi8>
    %55 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %54, %W1 after %55 : !llhd.sig<!llhd.array<4xi8>>
    llhd.inst "inst" @fir.param1(%47, %50, %54) -> (%Y) : (!llhd.sig<i1>, !llhd.sig<i8>, !llhd.sig<!llhd.array<4xi8>>) -> (!llhd.sig<i16>)
    llhd.inst "inst1" @fir_tb.initial.239.0() -> (%CLK, %X) : () -> (!llhd.sig<i1>, !llhd.sig<i8>)
    llhd.inst "inst2" @fir_tb.always.240.0(%CLK, %X) -> (%X) : (!llhd.sig<i1>, !llhd.sig<i8>) -> (!llhd.sig<i8>)
}
