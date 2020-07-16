llhd.proc @fir.param1.always_ff.260.1(%add_out: !llhd.sig<vector<4xi16>>, %CLK: !llhd.sig<i1>) -> (%q: !llhd.sig<vector<4xi16>> ) {
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %CLK1, %0 : i1
    %2 = cmpi "ne", %CLK2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = constant 1 : i32
    %4 = constant 0 : i16
    %5 = llhd.univec %4 : i16 -> vector<4xi16>
    %6 = llhd.dextf %q, %3 : (!llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<vector<4xi16>>
    %7 = llhd.extf %add_out1, 0 : vector<4xi16> -> i16
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %6, %7 after %8 : !llhd.sig<i16>
    br ^init
}

llhd.proc @fir.param1.always_ff.260.10(%add_out: !llhd.sig<vector<4xi16>>, %CLK: !llhd.sig<i1>) -> (%q: !llhd.sig<vector<4xi16>> ) {
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %CLK1, %0 : i1
    %2 = cmpi "ne", %CLK2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = constant 2 : i32
    %4 = constant 0 : i16
    %5 = llhd.univec %4 : i16 -> vector<4xi16>
    %6 = llhd.dextf %q, %3 : (!llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<vector<4xi16>>
    %7 = llhd.exts %5, 0 : vector<4xi16> -> vector<1xi16>
    %8 = llhd.exts %add_out1, 1 : vector<4xi16> -> vector<3xi16>
    %9 = llhd.inss %5, %7, 3 : vector<4xi16>, vector<1xi16>
    %10 = llhd.inss %9, %8, 0 : vector<4xi16>, vector<3xi16>
    %11 = llhd.extf %10, 0 : vector<4xi16> -> i16
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %6, %11 after %12 : !llhd.sig<i16>
    br ^init
}

llhd.proc @fir.param1.always_ff.260.11(%add_out: !llhd.sig<vector<4xi16>>, %CLK: !llhd.sig<i1>) -> (%q: !llhd.sig<vector<4xi16>> ) {
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %CLK1, %0 : i1
    %2 = cmpi "ne", %CLK2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = constant 3 : i32
    %4 = constant 0 : i16
    %5 = llhd.univec %4 : i16 -> vector<4xi16>
    %6 = llhd.dextf %q, %3 : (!llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<vector<4xi16>>
    %7 = llhd.exts %5, 0 : vector<4xi16> -> vector<2xi16>
    %8 = llhd.exts %add_out1, 2 : vector<4xi16> -> vector<2xi16>
    %9 = llhd.inss %5, %7, 2 : vector<4xi16>, vector<2xi16>
    %10 = llhd.inss %9, %8, 0 : vector<4xi16>, vector<2xi16>
    %11 = llhd.extf %10, 0 : vector<4xi16> -> i16
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %6, %11 after %12 : !llhd.sig<i16>
    br ^init
}

llhd.entity @fir.param1(%CLK: !llhd.sig<i1>, %X: !llhd.sig<i8>, %W: !llhd.sig<vector<4xi8>>) -> (%Y: !llhd.sig<i16> ) {
    %0 = constant 0 : i16
    %1 = llhd.vec %0, %0, %0, %0 : vector<4xi16>
    %mul_out = llhd.sig "sig" %1 : vector<4xi16>
    %add_out = llhd.sig "sig1" %1 : vector<4xi16>
    %q = llhd.sig "sig2" %1 : vector<4xi16>
    %2 = llhd.extf %q, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %2, %0 after %3 : !llhd.sig<i16>
    %add_out1 = llhd.prb %add_out : !llhd.sig<vector<4xi16>>
    %4 = llhd.univec %0 : i16 -> vector<4xi16>
    %5 = llhd.exts %4, 0 : vector<4xi16> -> vector<3xi16>
    %6 = llhd.exts %add_out1, 3 : vector<4xi16> -> vector<1xi16>
    %7 = llhd.inss %4, %5, 1 : vector<4xi16>, vector<3xi16>
    %8 = llhd.inss %7, %6, 0 : vector<4xi16>, vector<1xi16>
    %9 = llhd.extf %8, 0 : vector<4xi16> -> i16
    llhd.drv %Y, %9 after %3 : !llhd.sig<i16>
    %10 = llhd.extf %mul_out, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %W1 = llhd.prb %W : !llhd.sig<vector<4xi8>>
    %11 = llhd.extf %W1, 0 : vector<4xi8> -> i8
    %12 = llhd.inss %0, %11, 0 : i16, i8
    %X1 = llhd.prb %X : !llhd.sig<i8>
    %13 = llhd.inss %0, %X1, 0 : i16, i8
    %14 = muli %12, %13 : i16
    llhd.drv %10, %14 after %3 : !llhd.sig<i16>
    %15 = constant 1 : i32
    %16 = llhd.sig "sig3" %4 : vector<4xi16>
    %17 = llhd.shr %mul_out, %16, %15 : (!llhd.sig<vector<4xi16>>, !llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<vector<4xi16>>
    %18 = llhd.extf %17, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %19 = constant 0 : i8
    %20 = llhd.univec %19 : i8 -> vector<4xi8>
    %21 = llhd.exts %20, 0 : vector<4xi8> -> vector<1xi8>
    %22 = llhd.exts %W1, 1 : vector<4xi8> -> vector<3xi8>
    %23 = llhd.inss %20, %21, 3 : vector<4xi8>, vector<1xi8>
    %24 = llhd.inss %23, %22, 0 : vector<4xi8>, vector<3xi8>
    %25 = llhd.extf %24, 0 : vector<4xi8> -> i8
    %26 = llhd.inss %0, %25, 0 : i16, i8
    %27 = muli %26, %13 : i16
    llhd.drv %18, %27 after %3 : !llhd.sig<i16>
    %28 = constant 2 : i32
    %29 = llhd.sig "sig4" %4 : vector<4xi16>
    %30 = llhd.shr %mul_out, %29, %28 : (!llhd.sig<vector<4xi16>>, !llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<vector<4xi16>>
    %31 = llhd.extf %30, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %32 = llhd.exts %20, 0 : vector<4xi8> -> vector<2xi8>
    %33 = llhd.exts %W1, 2 : vector<4xi8> -> vector<2xi8>
    %34 = llhd.inss %20, %32, 2 : vector<4xi8>, vector<2xi8>
    %35 = llhd.inss %34, %33, 0 : vector<4xi8>, vector<2xi8>
    %36 = llhd.extf %35, 0 : vector<4xi8> -> i8
    %37 = llhd.inss %0, %36, 0 : i16, i8
    %38 = muli %37, %13 : i16
    llhd.drv %31, %38 after %3 : !llhd.sig<i16>
    %39 = constant 3 : i32
    %40 = llhd.sig "sig5" %4 : vector<4xi16>
    %41 = llhd.shr %mul_out, %40, %39 : (!llhd.sig<vector<4xi16>>, !llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<vector<4xi16>>
    %42 = llhd.extf %41, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %43 = llhd.exts %20, 0 : vector<4xi8> -> vector<3xi8>
    %44 = llhd.exts %W1, 3 : vector<4xi8> -> vector<1xi8>
    %45 = llhd.inss %20, %43, 1 : vector<4xi8>, vector<3xi8>
    %46 = llhd.inss %45, %44, 0 : vector<4xi8>, vector<1xi8>
    %47 = llhd.extf %46, 0 : vector<4xi8> -> i8
    %48 = llhd.inss %0, %47, 0 : i16, i8
    %49 = muli %48, %13 : i16
    llhd.drv %42, %49 after %3 : !llhd.sig<i16>
    %50 = llhd.extf %add_out, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %q1 = llhd.prb %q : !llhd.sig<vector<4xi16>>
    %51 = llhd.extf %q1, 0 : vector<4xi16> -> i16
    %mul_out1 = llhd.prb %mul_out : !llhd.sig<vector<4xi16>>
    %52 = llhd.exts %mul_out1, 3 : vector<4xi16> -> vector<1xi16>
    %53 = llhd.inss %7, %52, 0 : vector<4xi16>, vector<1xi16>
    %54 = llhd.extf %53, 0 : vector<4xi16> -> i16
    %55 = addi %51, %54 : i16
    llhd.drv %50, %55 after %3 : !llhd.sig<i16>
    %56 = llhd.sig "sig6" %4 : vector<4xi16>
    %57 = llhd.shr %add_out, %56, %15 : (!llhd.sig<vector<4xi16>>, !llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<vector<4xi16>>
    %58 = llhd.extf %57, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %59 = llhd.exts %4, 0 : vector<4xi16> -> vector<1xi16>
    %60 = llhd.exts %q1, 1 : vector<4xi16> -> vector<3xi16>
    %61 = llhd.inss %4, %59, 3 : vector<4xi16>, vector<1xi16>
    %62 = llhd.inss %61, %60, 0 : vector<4xi16>, vector<3xi16>
    %63 = llhd.extf %62, 0 : vector<4xi16> -> i16
    %64 = llhd.exts %4, 0 : vector<4xi16> -> vector<2xi16>
    %65 = llhd.exts %mul_out1, 2 : vector<4xi16> -> vector<2xi16>
    %66 = llhd.inss %4, %64, 2 : vector<4xi16>, vector<2xi16>
    %67 = llhd.inss %66, %65, 0 : vector<4xi16>, vector<2xi16>
    %68 = llhd.extf %67, 0 : vector<4xi16> -> i16
    %69 = addi %63, %68 : i16
    llhd.drv %58, %69 after %3 : !llhd.sig<i16>
    %70 = llhd.sig "sig7" %4 : vector<4xi16>
    %71 = llhd.shr %add_out, %70, %28 : (!llhd.sig<vector<4xi16>>, !llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<vector<4xi16>>
    %72 = llhd.extf %71, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %73 = llhd.exts %q1, 2 : vector<4xi16> -> vector<2xi16>
    %74 = llhd.inss %66, %73, 0 : vector<4xi16>, vector<2xi16>
    %75 = llhd.extf %74, 0 : vector<4xi16> -> i16
    %76 = llhd.exts %mul_out1, 1 : vector<4xi16> -> vector<3xi16>
    %77 = llhd.inss %61, %76, 0 : vector<4xi16>, vector<3xi16>
    %78 = llhd.extf %77, 0 : vector<4xi16> -> i16
    %79 = addi %75, %78 : i16
    llhd.drv %72, %79 after %3 : !llhd.sig<i16>
    %80 = llhd.sig "sig8" %4 : vector<4xi16>
    %81 = llhd.shr %add_out, %80, %39 : (!llhd.sig<vector<4xi16>>, !llhd.sig<vector<4xi16>>, i32) -> !llhd.sig<vector<4xi16>>
    %82 = llhd.extf %81, 0 : !llhd.sig<vector<4xi16>> -> !llhd.sig<i16>
    %83 = llhd.exts %q1, 3 : vector<4xi16> -> vector<1xi16>
    %84 = llhd.inss %7, %83, 0 : vector<4xi16>, vector<1xi16>
    %85 = llhd.extf %84, 0 : vector<4xi16> -> i16
    %86 = llhd.extf %mul_out1, 0 : vector<4xi16> -> i16
    %87 = addi %85, %86 : i16
    llhd.drv %82, %87 after %3 : !llhd.sig<i16>
    llhd.inst "inst" @fir.param1.always_ff.260.1(%add_out, %CLK) -> (%q) : (!llhd.sig<vector<4xi16>>, !llhd.sig<i1>) -> (!llhd.sig<vector<4xi16>>)
    llhd.inst "inst1" @fir.param1.always_ff.260.10(%add_out, %CLK) -> (%q) : (!llhd.sig<vector<4xi16>>, !llhd.sig<i1>) -> (!llhd.sig<vector<4xi16>>)
    llhd.inst "inst2" @fir.param1.always_ff.260.11(%add_out, %CLK) -> (%q) : (!llhd.sig<vector<4xi16>>, !llhd.sig<i1>) -> (!llhd.sig<vector<4xi16>>)
}

llhd.proc @fir_tb.initial.478.0() -> (%CLK: !llhd.sig<i1> , %X: !llhd.sig<i8> ) {
    br ^0
^0:
    %1 = constant 0 : i8
    %2 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %X, %1 after %2 : !llhd.sig<i8>
    %3 = constant 5000000 : i32
    br ^loop_body(%3: i32)
^loop_body(%4: i32):
    %5 = constant 0 : i32
    %6 = cmpi "ne", %4, %5 : i32
    cond_br %6, ^loop_continue, ^loop_exit
^7:
    %8 = constant 1 : i32
    %9 = subi %4, %8 : i32
    br ^loop_body(%9: i32)
^loop_exit:
    llhd.halt
^loop_continue:
    %10 = constant 1 : i1
    %11 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.drv %CLK, %10 after %11 : !llhd.sig<i1>
    %12 = constant 0 : i1
    %13 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    llhd.drv %CLK, %12 after %13 : !llhd.sig<i1>
    llhd.wait  for %13, ^7
}

llhd.proc @fir_tb.always.501.0(%CLK: !llhd.sig<i1>) -> (%X: !llhd.sig<i8> ) {
    br ^init
^init:
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    llhd.wait (%CLK : !llhd.sig<i1>), ^check
^check:
    %CLK2 = llhd.prb %CLK : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %CLK1, %0 : i1
    %2 = cmpi "ne", %CLK2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    cond_br %posedge, ^event, ^init
^event:
    %3 = constant 0 : i32
    %X1 = llhd.prb %X : !llhd.sig<i8>
    %4 = llhd.inss %3, %X1, 0 : i32, i8
    %5 = constant 9 : i32
    %6 = addi %4, %5 : i32
    %7 = constant 19 : i32
    %8 = remi_unsigned %6, %7 : i32
    %9 = llhd.exts %8, 0 : i32 -> i8
    %10 = llhd.const #llhd.time<500ps, 0d, 0e> : !llhd.time
    llhd.drv %X, %9 after %10 : !llhd.sig<i8>
    br ^init
}

llhd.entity @fir_tb() -> () {
    %0 = constant 0 : i1
    %CLK = llhd.sig "sig" %0 : i1
    %1 = constant 0 : i8
    %X = llhd.sig "sig1" %1 : i8
    %2 = llhd.vec %1, %1, %1, %1 : vector<4xi8>
    %W = llhd.sig "sig2" %2 : vector<4xi8>
    %3 = constant 0 : i16
    %Y = llhd.sig "sig3" %3 : i16
    %4 = llhd.extf %W, 0 : !llhd.sig<vector<4xi8>> -> !llhd.sig<i8>
    %5 = constant 254 : i8
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %5 after %6 : !llhd.sig<i8>
    %7 = constant 1 : i32
    %8 = llhd.univec %1 : i8 -> vector<4xi8>
    %9 = llhd.sig "sig4" %8 : vector<4xi8>
    %10 = llhd.shr %W, %9, %7 : (!llhd.sig<vector<4xi8>>, !llhd.sig<vector<4xi8>>, i32) -> !llhd.sig<vector<4xi8>>
    %11 = llhd.extf %10, 0 : !llhd.sig<vector<4xi8>> -> !llhd.sig<i8>
    %12 = constant 255 : i8
    llhd.drv %11, %12 after %6 : !llhd.sig<i8>
    %13 = constant 2 : i32
    %14 = llhd.sig "sig5" %8 : vector<4xi8>
    %15 = llhd.shr %W, %14, %13 : (!llhd.sig<vector<4xi8>>, !llhd.sig<vector<4xi8>>, i32) -> !llhd.sig<vector<4xi8>>
    %16 = llhd.extf %15, 0 : !llhd.sig<vector<4xi8>> -> !llhd.sig<i8>
    %17 = constant 3 : i8
    llhd.drv %16, %17 after %6 : !llhd.sig<i8>
    %18 = constant 3 : i32
    %19 = llhd.sig "sig6" %8 : vector<4xi8>
    %20 = llhd.shr %W, %19, %18 : (!llhd.sig<vector<4xi8>>, !llhd.sig<vector<4xi8>>, i32) -> !llhd.sig<vector<4xi8>>
    %21 = llhd.extf %20, 0 : !llhd.sig<vector<4xi8>> -> !llhd.sig<i8>
    %22 = constant 4 : i8
    llhd.drv %21, %22 after %6 : !llhd.sig<i8>
    %CLK1 = llhd.prb %CLK : !llhd.sig<i1>
    %23 = llhd.sig "sig7" %0 : i1
    llhd.drv %23, %CLK1 after %6 : !llhd.sig<i1>
    %X1 = llhd.prb %X : !llhd.sig<i8>
    %24 = llhd.sig "sig8" %1 : i8
    llhd.drv %24, %X1 after %6 : !llhd.sig<i8>
    %W1 = llhd.prb %W : !llhd.sig<vector<4xi8>>
    %25 = llhd.sig "sig9" %8 : vector<4xi8>
    llhd.drv %25, %W1 after %6 : !llhd.sig<vector<4xi8>>
    llhd.inst "inst" @fir.param1(%23, %24, %25) -> (%Y) : (!llhd.sig<i1>, !llhd.sig<i8>, !llhd.sig<vector<4xi8>>) -> (!llhd.sig<i16>)
    llhd.inst "inst1" @fir_tb.initial.478.0() -> (%CLK, %X) : () -> (!llhd.sig<i1>, !llhd.sig<i8>)
    llhd.inst "inst2" @fir_tb.always.501.0(%CLK) -> (%X) : (!llhd.sig<i1>) -> (!llhd.sig<i8>)
}
