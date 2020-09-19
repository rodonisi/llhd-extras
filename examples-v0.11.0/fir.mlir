llhd.proc @fir.param1.always_ff.260.1(%CLK: !llhd.sig<i1>, %add_out: !llhd.sig<!llhd.array<4xi16>>) -> (%q: !llhd.sig<!llhd.array<4xi16>> ) {
    br ^init
^init:
    %CLK.prb = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK.prb1 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %CLK.prb, %0 : i1
    %2 = llhd.neq %CLK.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = llhd.const 1 : i32
    %4 = llhd.const 0 : i16
    %5 = llhd.array_uniform %4 : !llhd.array<4xi16>
    %6 = llhd.dyn_extract_element %q, %3 : (!llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out.prb = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %7 = llhd.extract_element %add_out.prb, 0 : !llhd.array<4xi16> -> i16
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %6, %7 after %8 : !llhd.sig<i16>
    br ^init
}

llhd.proc @fir.param1.always_ff.260.10(%CLK: !llhd.sig<i1>, %add_out: !llhd.sig<!llhd.array<4xi16>>) -> (%q: !llhd.sig<!llhd.array<4xi16>> ) {
    br ^init
^init:
    %CLK.prb = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK.prb1 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %CLK.prb, %0 : i1
    %2 = llhd.neq %CLK.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = llhd.const 2 : i32
    %4 = llhd.const 0 : i16
    %5 = llhd.array_uniform %4 : !llhd.array<4xi16>
    %6 = llhd.dyn_extract_element %q, %3 : (!llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out.prb = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %7 = llhd.extract_slice %5, 0 : !llhd.array<4xi16> -> !llhd.array<1xi16>
    %8 = llhd.extract_slice %add_out.prb, 1 : !llhd.array<4xi16> -> !llhd.array<3xi16>
    %9 = llhd.insert_slice %5, %7, 3 : !llhd.array<4xi16>, !llhd.array<1xi16>
    %10 = llhd.insert_slice %9, %8, 0 : !llhd.array<4xi16>, !llhd.array<3xi16>
    %11 = llhd.extract_element %10, 0 : !llhd.array<4xi16> -> i16
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %6, %11 after %12 : !llhd.sig<i16>
    br ^init
}

llhd.proc @fir.param1.always_ff.260.11(%CLK: !llhd.sig<i1>, %add_out: !llhd.sig<!llhd.array<4xi16>>) -> (%q: !llhd.sig<!llhd.array<4xi16>> ) {
    br ^init
^init:
    %CLK.prb = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK.prb1 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %CLK.prb, %0 : i1
    %2 = llhd.neq %CLK.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = llhd.const 3 : i32
    %4 = llhd.const 0 : i16
    %5 = llhd.array_uniform %4 : !llhd.array<4xi16>
    %6 = llhd.dyn_extract_element %q, %3 : (!llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out.prb = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %7 = llhd.extract_slice %5, 0 : !llhd.array<4xi16> -> !llhd.array<2xi16>
    %8 = llhd.extract_slice %add_out.prb, 2 : !llhd.array<4xi16> -> !llhd.array<2xi16>
    %9 = llhd.insert_slice %5, %7, 2 : !llhd.array<4xi16>, !llhd.array<2xi16>
    %10 = llhd.insert_slice %9, %8, 0 : !llhd.array<4xi16>, !llhd.array<2xi16>
    %11 = llhd.extract_element %10, 0 : !llhd.array<4xi16> -> i16
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %6, %11 after %12 : !llhd.sig<i16>
    br ^init
}

llhd.entity @fir.param1(%CLK: !llhd.sig<i1>, %X: !llhd.sig<i8>, %W: !llhd.sig<!llhd.array<4xi8>>) -> (%Y: !llhd.sig<i16> ) {
    %0 = llhd.const 0 : i16
    %1 = llhd.array %0, %0, %0, %0 : !llhd.array<4xi16>
    %mul_out = llhd.sig "mul_out" %1 : !llhd.array<4xi16>
    %add_out = llhd.sig "add_out" %1 : !llhd.array<4xi16>
    %q = llhd.sig "q" %1 : !llhd.array<4xi16>
    %2 = llhd.extract_element %q, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %2, %0 after %3 : !llhd.sig<i16>
    %add_out.prb = llhd.prb %add_out : !llhd.sig<!llhd.array<4xi16>>
    %4 = llhd.array_uniform %0 : !llhd.array<4xi16>
    %5 = llhd.extract_slice %4, 0 : !llhd.array<4xi16> -> !llhd.array<3xi16>
    %6 = llhd.extract_slice %add_out.prb, 3 : !llhd.array<4xi16> -> !llhd.array<1xi16>
    %7 = llhd.insert_slice %4, %5, 1 : !llhd.array<4xi16>, !llhd.array<3xi16>
    %8 = llhd.insert_slice %7, %6, 0 : !llhd.array<4xi16>, !llhd.array<1xi16>
    %9 = llhd.extract_element %8, 0 : !llhd.array<4xi16> -> i16
    llhd.drv %Y, %9 after %3 : !llhd.sig<i16>
    %10 = llhd.extract_element %mul_out, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %W.prb = llhd.prb %W : !llhd.sig<!llhd.array<4xi8>>
    %11 = llhd.extract_element %W.prb, 0 : !llhd.array<4xi8> -> i8
    %zext = llhd.insert_slice %0, %11, 0 : i16, i8
    %X.prb = llhd.prb %X : !llhd.sig<i8>
    %zext1 = llhd.insert_slice %0, %X.prb, 0 : i16, i8
    %12 = muli %zext, %zext1 : i16
    llhd.drv %10, %12 after %3 : !llhd.sig<i16>
    %13 = llhd.const 1 : i32
    %14 = llhd.sig "14" %4 : !llhd.array<4xi16>
    %15 = llhd.shr %mul_out, %14, %13 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %16 = llhd.extract_element %15, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %17 = llhd.const 0 : i8
    %18 = llhd.array_uniform %17 : !llhd.array<4xi8>
    %19 = llhd.extract_slice %18, 0 : !llhd.array<4xi8> -> !llhd.array<1xi8>
    %20 = llhd.extract_slice %W.prb, 1 : !llhd.array<4xi8> -> !llhd.array<3xi8>
    %21 = llhd.insert_slice %18, %19, 3 : !llhd.array<4xi8>, !llhd.array<1xi8>
    %22 = llhd.insert_slice %21, %20, 0 : !llhd.array<4xi8>, !llhd.array<3xi8>
    %23 = llhd.extract_element %22, 0 : !llhd.array<4xi8> -> i8
    %zext2 = llhd.insert_slice %0, %23, 0 : i16, i8
    %24 = muli %zext2, %zext1 : i16
    llhd.drv %16, %24 after %3 : !llhd.sig<i16>
    %25 = llhd.const 2 : i32
    %26 = llhd.sig "26" %4 : !llhd.array<4xi16>
    %27 = llhd.shr %mul_out, %26, %25 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %28 = llhd.extract_element %27, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %29 = llhd.extract_slice %18, 0 : !llhd.array<4xi8> -> !llhd.array<2xi8>
    %30 = llhd.extract_slice %W.prb, 2 : !llhd.array<4xi8> -> !llhd.array<2xi8>
    %31 = llhd.insert_slice %18, %29, 2 : !llhd.array<4xi8>, !llhd.array<2xi8>
    %32 = llhd.insert_slice %31, %30, 0 : !llhd.array<4xi8>, !llhd.array<2xi8>
    %33 = llhd.extract_element %32, 0 : !llhd.array<4xi8> -> i8
    %zext3 = llhd.insert_slice %0, %33, 0 : i16, i8
    %34 = muli %zext3, %zext1 : i16
    llhd.drv %28, %34 after %3 : !llhd.sig<i16>
    %35 = llhd.const 3 : i32
    %36 = llhd.sig "36" %4 : !llhd.array<4xi16>
    %37 = llhd.shr %mul_out, %36, %35 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %38 = llhd.extract_element %37, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %39 = llhd.extract_slice %18, 0 : !llhd.array<4xi8> -> !llhd.array<3xi8>
    %40 = llhd.extract_slice %W.prb, 3 : !llhd.array<4xi8> -> !llhd.array<1xi8>
    %41 = llhd.insert_slice %18, %39, 1 : !llhd.array<4xi8>, !llhd.array<3xi8>
    %42 = llhd.insert_slice %41, %40, 0 : !llhd.array<4xi8>, !llhd.array<1xi8>
    %43 = llhd.extract_element %42, 0 : !llhd.array<4xi8> -> i8
    %zext4 = llhd.insert_slice %0, %43, 0 : i16, i8
    %44 = muli %zext4, %zext1 : i16
    llhd.drv %38, %44 after %3 : !llhd.sig<i16>
    %45 = llhd.extract_element %add_out, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %q.prb = llhd.prb %q : !llhd.sig<!llhd.array<4xi16>>
    %46 = llhd.extract_element %q.prb, 0 : !llhd.array<4xi16> -> i16
    %mul_out.prb = llhd.prb %mul_out : !llhd.sig<!llhd.array<4xi16>>
    %47 = llhd.extract_slice %mul_out.prb, 3 : !llhd.array<4xi16> -> !llhd.array<1xi16>
    %48 = llhd.insert_slice %7, %47, 0 : !llhd.array<4xi16>, !llhd.array<1xi16>
    %49 = llhd.extract_element %48, 0 : !llhd.array<4xi16> -> i16
    %50 = addi %46, %49 : i16
    llhd.drv %45, %50 after %3 : !llhd.sig<i16>
    %51 = llhd.sig "51" %4 : !llhd.array<4xi16>
    %52 = llhd.shr %add_out, %51, %13 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %53 = llhd.extract_element %52, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %54 = llhd.extract_slice %4, 0 : !llhd.array<4xi16> -> !llhd.array<1xi16>
    %55 = llhd.extract_slice %q.prb, 1 : !llhd.array<4xi16> -> !llhd.array<3xi16>
    %56 = llhd.insert_slice %4, %54, 3 : !llhd.array<4xi16>, !llhd.array<1xi16>
    %57 = llhd.insert_slice %56, %55, 0 : !llhd.array<4xi16>, !llhd.array<3xi16>
    %58 = llhd.extract_element %57, 0 : !llhd.array<4xi16> -> i16
    %59 = llhd.extract_slice %4, 0 : !llhd.array<4xi16> -> !llhd.array<2xi16>
    %60 = llhd.extract_slice %mul_out.prb, 2 : !llhd.array<4xi16> -> !llhd.array<2xi16>
    %61 = llhd.insert_slice %4, %59, 2 : !llhd.array<4xi16>, !llhd.array<2xi16>
    %62 = llhd.insert_slice %61, %60, 0 : !llhd.array<4xi16>, !llhd.array<2xi16>
    %63 = llhd.extract_element %62, 0 : !llhd.array<4xi16> -> i16
    %64 = addi %58, %63 : i16
    llhd.drv %53, %64 after %3 : !llhd.sig<i16>
    %65 = llhd.sig "65" %4 : !llhd.array<4xi16>
    %66 = llhd.shr %add_out, %65, %25 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %67 = llhd.extract_element %66, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %68 = llhd.extract_slice %q.prb, 2 : !llhd.array<4xi16> -> !llhd.array<2xi16>
    %69 = llhd.insert_slice %61, %68, 0 : !llhd.array<4xi16>, !llhd.array<2xi16>
    %70 = llhd.extract_element %69, 0 : !llhd.array<4xi16> -> i16
    %71 = llhd.extract_slice %mul_out.prb, 1 : !llhd.array<4xi16> -> !llhd.array<3xi16>
    %72 = llhd.insert_slice %56, %71, 0 : !llhd.array<4xi16>, !llhd.array<3xi16>
    %73 = llhd.extract_element %72, 0 : !llhd.array<4xi16> -> i16
    %74 = addi %70, %73 : i16
    llhd.drv %67, %74 after %3 : !llhd.sig<i16>
    %75 = llhd.sig "75" %4 : !llhd.array<4xi16>
    %76 = llhd.shr %add_out, %75, %35 : (!llhd.sig<!llhd.array<4xi16>>, !llhd.sig<!llhd.array<4xi16>>, i32) -> !llhd.sig<!llhd.array<4xi16>>
    %77 = llhd.extract_element %76, 0 : !llhd.sig<!llhd.array<4xi16>> -> !llhd.sig<i16>
    %78 = llhd.extract_slice %q.prb, 3 : !llhd.array<4xi16> -> !llhd.array<1xi16>
    %79 = llhd.insert_slice %7, %78, 0 : !llhd.array<4xi16>, !llhd.array<1xi16>
    %80 = llhd.extract_element %79, 0 : !llhd.array<4xi16> -> i16
    %81 = llhd.extract_element %mul_out.prb, 0 : !llhd.array<4xi16> -> i16
    %82 = addi %80, %81 : i16
    llhd.drv %77, %82 after %3 : !llhd.sig<i16>
    llhd.inst "inst" @fir.param1.always_ff.260.1(%CLK, %add_out) -> (%q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<4xi16>>) -> (!llhd.sig<!llhd.array<4xi16>>)
    llhd.inst "inst1" @fir.param1.always_ff.260.10(%CLK, %add_out) -> (%q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<4xi16>>) -> (!llhd.sig<!llhd.array<4xi16>>)
    llhd.inst "inst2" @fir.param1.always_ff.260.11(%CLK, %add_out) -> (%q) : (!llhd.sig<i1>, !llhd.sig<!llhd.array<4xi16>>) -> (!llhd.sig<!llhd.array<4xi16>>)
}

llhd.proc @fir_tb.initial.478.0() -> (%CLK: !llhd.sig<i1> , %X: !llhd.sig<i8> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i8
    %2 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %X, %1 after %2 : !llhd.sig<i8>
    %3 = llhd.const 5000000 : i32
    %loop_count = llhd.var %3 : i32
    br ^loop_body
^loop_body:
    %4 = llhd.load %loop_count : !llhd.ptr<i32>
    %5 = llhd.const 0 : i32
    %6 = llhd.neq %4, %5 : i32
    cond_br %6, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    %7 = llhd.const 1 : i1
    %8 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %CLK, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const 0 : i1
    %10 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %CLK, %9 after %10 : !llhd.sig<i1>
    llhd.wait  for %10, ^11
^11:
    %12 = llhd.load %loop_count : !llhd.ptr<i32>
    llhd.store %loop_count, %12 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.proc @fir_tb.always.501.0(%CLK: !llhd.sig<i1>) -> (%X: !llhd.sig<i8> ) {
    br ^0
^0:
    %1 = llhd.prb %X : !llhd.sig<i8>
    %X.shadow = llhd.var %1 : i8
    br ^init
^init:
    %CLK.prb = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %X : !llhd.sig<i8>
    llhd.store %X.shadow, %2 : !llhd.ptr<i8>
    %CLK.prb1 = llhd.prb %CLK : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %CLK.prb, %3 : i1
    %5 = llhd.neq %CLK.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    cond_br %posedge, ^event, ^init
^event:
    %6 = llhd.const 0 : i32
    %X.shadow.ld = llhd.load %X.shadow : !llhd.ptr<i8>
    %zext = llhd.insert_slice %6, %X.shadow.ld, 0 : i32, i8
    %7 = llhd.const 9 : i32
    %8 = addi %zext, %7 : i32
    %9 = llhd.const 19 : i32
    %10 = remi_unsigned %8, %9 : i32
    %11 = llhd.extract_slice %10, 0 : i32 -> i8
    %12 = llhd.const #llhd.time<500ps, 0d, 0e> : !llhd.time
    llhd.drv %X, %11 after %12 : !llhd.sig<i8>
    br ^0
}

llhd.entity @fir_tb() -> () {
    %0 = llhd.const 0 : i1
    %CLK = llhd.sig "CLK" %0 : i1
    %1 = llhd.const 0 : i8
    %X = llhd.sig "X" %1 : i8
    %2 = llhd.array %1, %1, %1, %1 : !llhd.array<4xi8>
    %W = llhd.sig "W" %2 : !llhd.array<4xi8>
    %3 = llhd.const 0 : i16
    %Y = llhd.sig "Y" %3 : i16
    %4 = llhd.extract_element %W, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %5 = llhd.const 254 : i8
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %5 after %6 : !llhd.sig<i8>
    %7 = llhd.const 1 : i32
    %8 = llhd.array_uniform %1 : !llhd.array<4xi8>
    %9 = llhd.sig "9" %8 : !llhd.array<4xi8>
    %10 = llhd.shr %W, %9, %7 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %11 = llhd.extract_element %10, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %12 = llhd.const 255 : i8
    llhd.drv %11, %12 after %6 : !llhd.sig<i8>
    %13 = llhd.const 2 : i32
    %14 = llhd.sig "14" %8 : !llhd.array<4xi8>
    %15 = llhd.shr %W, %14, %13 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %16 = llhd.extract_element %15, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %17 = llhd.const 3 : i8
    llhd.drv %16, %17 after %6 : !llhd.sig<i8>
    %18 = llhd.const 3 : i32
    %19 = llhd.sig "19" %8 : !llhd.array<4xi8>
    %20 = llhd.shr %W, %19, %18 : (!llhd.sig<!llhd.array<4xi8>>, !llhd.sig<!llhd.array<4xi8>>, i32) -> !llhd.sig<!llhd.array<4xi8>>
    %21 = llhd.extract_element %20, 0 : !llhd.sig<!llhd.array<4xi8>> -> !llhd.sig<i8>
    %22 = llhd.const 4 : i8
    llhd.drv %21, %22 after %6 : !llhd.sig<i8>
    llhd.inst "inst" @fir.param1(%CLK, %X, %W) -> (%Y) : (!llhd.sig<i1>, !llhd.sig<i8>, !llhd.sig<!llhd.array<4xi8>>) -> (!llhd.sig<i16>)
    llhd.inst "inst1" @fir_tb.initial.478.0() -> (%CLK, %X) : () -> (!llhd.sig<i1>, !llhd.sig<i8>)
    llhd.inst "inst2" @fir_tb.always.501.0(%CLK) -> (%X) : (!llhd.sig<i1>) -> (!llhd.sig<i8>)
}
