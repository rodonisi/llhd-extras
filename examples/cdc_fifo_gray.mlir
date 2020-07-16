llhd.entity @binary_to_gray.param2(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %0 = llhd.exts %A1, 1 : i4 -> i3
    %1 = constant 0 : i4
    %2 = llhd.inss %1, %0, 0 : i4, i3
    %3 = llhd.xor %A1, %2 : i4
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i4>
}

llhd.entity @binary_to_gray.param3(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %0 = llhd.exts %A1, 1 : i4 -> i3
    %1 = constant 0 : i4
    %2 = llhd.inss %1, %0, 0 : i4, i3
    %3 = llhd.xor %A1, %2 : i4
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i4>
}

llhd.entity @gray_to_binary.param4(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %0 = llhd.exts %Z, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %1 = llhd.exts %A1, 0 : i4 -> i1
    %2 = llhd.exts %A1, 1 : i4 -> i1
    %3 = llhd.xor %1, %2 : i1
    %4 = llhd.exts %A1, 2 : i4 -> i1
    %5 = llhd.xor %3, %4 : i1
    %6 = llhd.exts %A1, 3 : i4 -> i1
    %7 = llhd.xor %5, %6 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %0, %7 after %8 : !llhd.sig<i1>
    %9 = constant 1 : i32
    %10 = constant 0 : i4
    %11 = llhd.sig "sig" %10 : i4
    %12 = llhd.shr %Z, %11, %9 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %13 = llhd.exts %12, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %14 = llhd.exts %A1, 1 : i4 -> i3
    %15 = llhd.inss %10, %14, 0 : i4, i3
    %16 = llhd.exts %15, 0 : i4 -> i3
    %17 = llhd.exts %16, 0 : i3 -> i1
    %18 = llhd.exts %16, 1 : i3 -> i1
    %19 = llhd.xor %17, %18 : i1
    %20 = llhd.exts %16, 2 : i3 -> i1
    %21 = llhd.xor %19, %20 : i1
    llhd.drv %13, %21 after %8 : !llhd.sig<i1>
    %22 = constant 2 : i32
    %23 = llhd.sig "sig1" %10 : i4
    %24 = llhd.shr %Z, %23, %22 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %25 = llhd.exts %24, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %26 = llhd.exts %A1, 2 : i4 -> i2
    %27 = llhd.inss %10, %26, 0 : i4, i2
    %28 = llhd.exts %27, 0 : i4 -> i2
    %29 = llhd.exts %28, 0 : i2 -> i1
    %30 = llhd.exts %28, 1 : i2 -> i1
    %31 = llhd.xor %29, %30 : i1
    llhd.drv %25, %31 after %8 : !llhd.sig<i1>
    %32 = constant 3 : i32
    %33 = llhd.sig "sig2" %10 : i4
    %34 = llhd.shr %Z, %33, %32 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %35 = llhd.exts %34, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %36 = llhd.inss %10, %6, 0 : i4, i1
    %37 = llhd.exts %36, 0 : i4 -> i1
    llhd.drv %35, %37 after %8 : !llhd.sig<i1>
    %38 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    llhd.drv %Z, %10 after %38 : !llhd.sig<i4>
}

llhd.entity @gray_to_binary.param9(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %0 = llhd.exts %Z, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %1 = llhd.exts %A1, 0 : i4 -> i1
    %2 = llhd.exts %A1, 1 : i4 -> i1
    %3 = llhd.xor %1, %2 : i1
    %4 = llhd.exts %A1, 2 : i4 -> i1
    %5 = llhd.xor %3, %4 : i1
    %6 = llhd.exts %A1, 3 : i4 -> i1
    %7 = llhd.xor %5, %6 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %0, %7 after %8 : !llhd.sig<i1>
    %9 = constant 1 : i32
    %10 = constant 0 : i4
    %11 = llhd.sig "sig" %10 : i4
    %12 = llhd.shr %Z, %11, %9 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %13 = llhd.exts %12, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %14 = llhd.exts %A1, 1 : i4 -> i3
    %15 = llhd.inss %10, %14, 0 : i4, i3
    %16 = llhd.exts %15, 0 : i4 -> i3
    %17 = llhd.exts %16, 0 : i3 -> i1
    %18 = llhd.exts %16, 1 : i3 -> i1
    %19 = llhd.xor %17, %18 : i1
    %20 = llhd.exts %16, 2 : i3 -> i1
    %21 = llhd.xor %19, %20 : i1
    llhd.drv %13, %21 after %8 : !llhd.sig<i1>
    %22 = constant 2 : i32
    %23 = llhd.sig "sig1" %10 : i4
    %24 = llhd.shr %Z, %23, %22 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %25 = llhd.exts %24, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %26 = llhd.exts %A1, 2 : i4 -> i2
    %27 = llhd.inss %10, %26, 0 : i4, i2
    %28 = llhd.exts %27, 0 : i4 -> i2
    %29 = llhd.exts %28, 0 : i2 -> i1
    %30 = llhd.exts %28, 1 : i2 -> i1
    %31 = llhd.xor %29, %30 : i1
    llhd.drv %25, %31 after %8 : !llhd.sig<i1>
    %32 = constant 3 : i32
    %33 = llhd.sig "sig2" %10 : i4
    %34 = llhd.shr %Z, %33, %32 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %35 = llhd.exts %34, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %36 = llhd.inss %10, %6, 0 : i4, i1
    %37 = llhd.exts %36, 0 : i4 -> i1
    llhd.drv %35, %37 after %8 : !llhd.sig<i1>
    %38 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    llhd.drv %Z, %10 after %38 : !llhd.sig<i4>
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.1(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = llhd.extf %fifo_data_q, 0 : !llhd.sig<vector<8xi32>> -> !llhd.sig<i32>
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %8 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    llhd.drv %9, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %9, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.14(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 1 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.15(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 2 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.16(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 3 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.17(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 4 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.18(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 5 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.19(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 6 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.20(%fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%fifo_data_q: !llhd.sig<vector<8xi32>> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = constant 0 : i32
    %9 = constant 7 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = cmpi "ne", %fifo_write1, %0 : i1
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %12 = llhd.inss %8, %fifo_widx1, 0 : i32, i3
    %13 = cmpi "eq", %12, %9 : i32
    %14 = cmpi "ne", %13, %0 : i1
    %15 = llhd.and %11, %14 : i1
    %16 = cmpi "ne", %15, %0 : i1
    cond_br %16, ^if_true1, ^init
^if_true:
    %17 = llhd.univec %8 : i32 -> vector<8xi32>
    %18 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %18, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %19 = llhd.univec %8 : i32 -> vector<8xi32>
    %20 = llhd.dextf %fifo_data_q, %9 : (!llhd.sig<vector<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %20, %fifo_wdata1 after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.initial.69.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.proc @cdc_fifo_gray.param1.always_ff.417.1(%src_wptr_bin_d: !llhd.sig<i4>, %src_wptr_gray_d: !llhd.sig<i4>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_valid_i: !llhd.sig<i1>, %src_ready_o: !llhd.sig<i1>) -> (%src_wptr_bin_q: !llhd.sig<i4> , %src_wptr_gray_q: !llhd.sig<i4> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %9 = cmpi "ne", %src_valid_i1, %0 : i1
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %10 = cmpi "ne", %src_ready_o1, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = cmpi "ne", %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    %13 = constant 0 : i4
    llhd.drv %src_wptr_bin_q, %13 after %8 : !llhd.sig<i4>
    llhd.drv %src_wptr_gray_q, %13 after %8 : !llhd.sig<i4>
    br ^init
^if_true1:
    %src_wptr_bin_d1 = llhd.prb %src_wptr_bin_d : !llhd.sig<i4>
    llhd.drv %src_wptr_bin_q, %src_wptr_bin_d1 after %8 : !llhd.sig<i4>
    %src_wptr_gray_d1 = llhd.prb %src_wptr_gray_d : !llhd.sig<i4>
    llhd.drv %src_wptr_gray_q, %src_wptr_gray_d1 after %8 : !llhd.sig<i4>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.486.1(%dst_rptr_bin_d: !llhd.sig<i4>, %dst_rptr_gray_d: !llhd.sig<i4>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_valid_o: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%dst_rptr_bin_q: !llhd.sig<i4> , %dst_rptr_gray_q: !llhd.sig<i4> ) {
    br ^init
^init:
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    llhd.wait (%dst_clk_i, %dst_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %dst_clk_i2 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %dst_clk_i1, %0 : i1
    %2 = cmpi "ne", %dst_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %dst_rst_ni2 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %dst_rst_ni1, %0 : i1
    %4 = cmpi "eq", %dst_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %dst_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %dst_valid_o1 = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %9 = cmpi "ne", %dst_valid_o1, %0 : i1
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %10 = cmpi "ne", %dst_ready_i1, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = cmpi "ne", %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    %13 = constant 0 : i4
    llhd.drv %dst_rptr_bin_q, %13 after %8 : !llhd.sig<i4>
    llhd.drv %dst_rptr_gray_q, %13 after %8 : !llhd.sig<i4>
    br ^init
^if_true1:
    %dst_rptr_bin_d1 = llhd.prb %dst_rptr_bin_d : !llhd.sig<i4>
    llhd.drv %dst_rptr_bin_q, %dst_rptr_bin_d1 after %8 : !llhd.sig<i4>
    %dst_rptr_gray_d1 = llhd.prb %dst_rptr_gray_d : !llhd.sig<i4>
    llhd.drv %dst_rptr_gray_q, %dst_rptr_gray_d1 after %8 : !llhd.sig<i4>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.559.1(%dst_rptr_gray_q: !llhd.sig<i4>, %src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>) -> (%src_rptr_gray_q: !llhd.sig<i4> , %src_rptr_gray_q2: !llhd.sig<i4> ) {
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %src_clk_i1, %0 : i1
    %2 = cmpi "ne", %src_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %src_rst_ni1, %0 : i1
    %4 = cmpi "eq", %src_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %src_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %dst_rptr_gray_q1 = llhd.prb %dst_rptr_gray_q : !llhd.sig<i4>
    llhd.drv %src_rptr_gray_q, %dst_rptr_gray_q1 after %8 : !llhd.sig<i4>
    %src_rptr_gray_q1 = llhd.prb %src_rptr_gray_q : !llhd.sig<i4>
    llhd.drv %src_rptr_gray_q2, %src_rptr_gray_q1 after %8 : !llhd.sig<i4>
    br ^init
^if_true:
    %9 = constant 0 : i4
    llhd.drv %src_rptr_gray_q, %9 after %8 : !llhd.sig<i4>
    llhd.drv %src_rptr_gray_q2, %9 after %8 : !llhd.sig<i4>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.620.1(%src_wptr_gray_q: !llhd.sig<i4>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>) -> (%dst_wptr_gray_q: !llhd.sig<i4> , %dst_wptr_gray_q2: !llhd.sig<i4> ) {
    br ^init
^init:
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    llhd.wait (%dst_clk_i, %dst_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %dst_clk_i2 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %0 = constant 0 : i1
    %1 = cmpi "eq", %dst_clk_i1, %0 : i1
    %2 = cmpi "ne", %dst_clk_i2, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %dst_rst_ni2 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %3 = cmpi "ne", %dst_rst_ni1, %0 : i1
    %4 = cmpi "eq", %dst_rst_ni2, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = cmpi "ne", %dst_rst_ni2, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = cmpi "ne", %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %src_wptr_gray_q1 = llhd.prb %src_wptr_gray_q : !llhd.sig<i4>
    llhd.drv %dst_wptr_gray_q, %src_wptr_gray_q1 after %8 : !llhd.sig<i4>
    %dst_wptr_gray_q1 = llhd.prb %dst_wptr_gray_q : !llhd.sig<i4>
    llhd.drv %dst_wptr_gray_q2, %dst_wptr_gray_q1 after %8 : !llhd.sig<i4>
    br ^init
^if_true:
    %9 = constant 0 : i4
    llhd.drv %dst_wptr_gray_q, %9 after %8 : !llhd.sig<i4>
    llhd.drv %dst_wptr_gray_q2, %9 after %8 : !llhd.sig<i4>
    br ^init
}

llhd.entity @cdc_fifo_gray.param1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_data_i: !llhd.sig<i32>, %src_valid_i: !llhd.sig<i1>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%src_ready_o: !llhd.sig<i1> , %dst_data_o: !llhd.sig<i32> , %dst_valid_o: !llhd.sig<i1> ) {
    %0 = constant 0 : i3
    %fifo_widx = llhd.sig "sig" %0 : i3
    %fifo_ridx = llhd.sig "sig1" %0 : i3
    %1 = constant 0 : i1
    %fifo_write = llhd.sig "sig2" %1 : i1
    %2 = constant 0 : i32
    %fifo_wdata = llhd.sig "sig3" %2 : i32
    %fifo_rdata = llhd.sig "sig4" %2 : i32
    %3 = llhd.vec %2, %2, %2, %2, %2, %2, %2, %2 : vector<8xi32>
    %fifo_data_q = llhd.sig "sig5" %3 : vector<8xi32>
    %4 = constant 0 : i4
    %src_wptr_bin_q = llhd.sig "sig6" %4 : i4
    %src_wptr_gray_q = llhd.sig "sig7" %4 : i4
    %dst_rptr_bin_q = llhd.sig "sig8" %4 : i4
    %dst_rptr_gray_q = llhd.sig "sig9" %4 : i4
    %src_wptr_bin_d = llhd.sig "sig10" %4 : i4
    %src_wptr_gray_d = llhd.sig "sig11" %4 : i4
    %dst_rptr_bin_d = llhd.sig "sig12" %4 : i4
    %dst_rptr_gray_d = llhd.sig "sig13" %4 : i4
    %src_rptr_gray_q = llhd.sig "sig14" %4 : i4
    %src_rptr_gray_q2 = llhd.sig "sig15" %4 : i4
    %dst_wptr_gray_q = llhd.sig "sig16" %4 : i4
    %dst_wptr_gray_q2 = llhd.sig "sig17" %4 : i4
    %src_rptr_bin = llhd.sig "sig18" %4 : i4
    %dst_wptr_bin = llhd.sig "sig19" %4 : i4
    %fifo_data_q1 = llhd.prb %fifo_data_q : !llhd.sig<vector<8xi32>>
    %fifo_ridx1 = llhd.prb %fifo_ridx : !llhd.sig<i3>
    %5 = llhd.univec %2 : i32 -> vector<8xi32>
    %6 = llhd.shr %fifo_data_q1, %5, %fifo_ridx1 : (vector<8xi32>, vector<8xi32>, i3) -> vector<8xi32>
    %7 = llhd.extf %6, 0 : vector<8xi32> -> i32
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_rdata, %7 after %8 : !llhd.sig<i32>
    %src_wptr_bin_q1 = llhd.prb %src_wptr_bin_q : !llhd.sig<i4>
    %9 = llhd.inss %2, %src_wptr_bin_q1, 0 : i32, i4
    %10 = constant 1 : i32
    %11 = addi %9, %10 : i32
    %12 = llhd.exts %11, 0 : i32 -> i4
    llhd.drv %src_wptr_bin_d, %12 after %8 : !llhd.sig<i4>
    %dst_rptr_bin_q1 = llhd.prb %dst_rptr_bin_q : !llhd.sig<i4>
    %13 = llhd.inss %2, %dst_rptr_bin_q1, 0 : i32, i4
    %14 = addi %13, %10 : i32
    %15 = llhd.exts %14, 0 : i32 -> i4
    llhd.drv %dst_rptr_bin_d, %15 after %8 : !llhd.sig<i4>
    %src_rptr_bin1 = llhd.prb %src_rptr_bin : !llhd.sig<i4>
    %16 = llhd.xor %src_wptr_bin_q1, %src_rptr_bin1 : i4
    %17 = constant 8 : i4
    %18 = cmpi "ne", %16, %17 : i4
    llhd.drv %src_ready_o, %18 after %8 : !llhd.sig<i1>
    %dst_wptr_bin1 = llhd.prb %dst_wptr_bin : !llhd.sig<i4>
    %19 = llhd.xor %dst_rptr_bin_q1, %dst_wptr_bin1 : i4
    %20 = cmpi "ne", %19, %4 : i4
    llhd.drv %dst_valid_o, %20 after %8 : !llhd.sig<i1>
    %21 = llhd.exts %src_wptr_bin_q1, 0 : i4 -> i3
    llhd.drv %fifo_widx, %21 after %8 : !llhd.sig<i3>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    llhd.drv %fifo_wdata, %src_data_i1 after %8 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %22 = cmpi "ne", %src_valid_i1, %1 : i1
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %23 = cmpi "ne", %src_ready_o1, %1 : i1
    %24 = llhd.and %22, %23 : i1
    llhd.drv %fifo_write, %24 after %8 : !llhd.sig<i1>
    %25 = llhd.exts %dst_rptr_bin_q1, 0 : i4 -> i3
    llhd.drv %fifo_ridx, %25 after %8 : !llhd.sig<i3>
    %fifo_rdata1 = llhd.prb %fifo_rdata : !llhd.sig<i32>
    llhd.drv %dst_data_o, %fifo_rdata1 after %8 : !llhd.sig<i32>
    %src_wptr_bin_d1 = llhd.prb %src_wptr_bin_d : !llhd.sig<i4>
    %26 = llhd.sig "sig20" %4 : i4
    llhd.drv %26, %src_wptr_bin_d1 after %8 : !llhd.sig<i4>
    llhd.inst "inst" @binary_to_gray.param2(%26) -> (%src_wptr_gray_d) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    %dst_rptr_bin_d1 = llhd.prb %dst_rptr_bin_d : !llhd.sig<i4>
    %27 = llhd.sig "sig21" %4 : i4
    llhd.drv %27, %dst_rptr_bin_d1 after %8 : !llhd.sig<i4>
    llhd.inst "inst1" @binary_to_gray.param3(%27) -> (%dst_rptr_gray_d) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    %src_rptr_gray_q21 = llhd.prb %src_rptr_gray_q2 : !llhd.sig<i4>
    %28 = llhd.sig "sig22" %4 : i4
    llhd.drv %28, %src_rptr_gray_q21 after %8 : !llhd.sig<i4>
    llhd.inst "inst2" @gray_to_binary.param4(%28) -> (%src_rptr_bin) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    %dst_wptr_gray_q21 = llhd.prb %dst_wptr_gray_q2 : !llhd.sig<i4>
    %29 = llhd.sig "sig23" %4 : i4
    llhd.drv %29, %dst_wptr_gray_q21 after %8 : !llhd.sig<i4>
    llhd.inst "inst3" @gray_to_binary.param9(%29) -> (%dst_wptr_bin) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    llhd.inst "inst4" @cdc_fifo_gray.param1.always_ff.265.1(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst5" @cdc_fifo_gray.param1.always_ff.265.14(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst6" @cdc_fifo_gray.param1.always_ff.265.15(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst7" @cdc_fifo_gray.param1.always_ff.265.16(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst8" @cdc_fifo_gray.param1.always_ff.265.17(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst9" @cdc_fifo_gray.param1.always_ff.265.18(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst10" @cdc_fifo_gray.param1.always_ff.265.19(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst11" @cdc_fifo_gray.param1.always_ff.265.20(%fifo_widx, %fifo_write, %fifo_wdata, %src_rst_ni, %src_clk_i) -> (%fifo_data_q) : (!llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<vector<8xi32>>)
    llhd.inst "inst12" @cdc_fifo_gray.param1.initial.69.1() -> () : () -> ()
    llhd.inst "inst13" @cdc_fifo_gray.param1.always_ff.417.1(%src_wptr_bin_d, %src_wptr_gray_d, %src_rst_ni, %src_clk_i, %src_valid_i, %src_ready_o) -> (%src_wptr_bin_q, %src_wptr_gray_q) : (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst14" @cdc_fifo_gray.param1.always_ff.486.1(%dst_rptr_bin_d, %dst_rptr_gray_d, %dst_rst_ni, %dst_clk_i, %dst_valid_o, %dst_ready_i) -> (%dst_rptr_bin_q, %dst_rptr_gray_q) : (!llhd.sig<i4>, !llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst15" @cdc_fifo_gray.param1.always_ff.559.1(%dst_rptr_gray_q, %src_rst_ni, %src_clk_i) -> (%src_rptr_gray_q, %src_rptr_gray_q2) : (!llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst16" @cdc_fifo_gray.param1.always_ff.620.1(%src_wptr_gray_q, %dst_rst_ni, %dst_clk_i) -> (%dst_wptr_gray_q, %dst_wptr_gray_q2) : (!llhd.sig<i4>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
}

llhd.proc @cdc_fifo_gray_tb.initial.1006.0(%src_ready_o: !llhd.sig<i1>) -> (%src_rst_ni: !llhd.sig<i1> , %src_clk_i: !llhd.sig<i1> , %src_data_i: !llhd.sig<i32> , %src_valid_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = constant 0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %3, ^4
^4:
    %5 = constant 1 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %7, ^8
^8:
    %9 = constant 0 : i32
    br ^loop_body(%9: i32)
^loop_body(%i: i32):
    %10 = constant 1000000 : i32
    %11 = cmpi "slt", %i, %10 : i32
    cond_br %11, ^loop_body1, ^loop_exit
^12:
    %13 = constant 1 : i32
    %14 = addi %i, %13 : i32
    br ^loop_body(%14: i32)
^loop_exit:
    llhd.halt
^loop_body1:
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %15 = constant 0 : i1
    %16 = cmpi "ne", %src_ready_o1, %15 : i1
    %17 = llhd.not %16 : i1
    %18 = cmpi "ne", %17, %15 : i1
    %19 = constant 1 : i1
    %20 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %21 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %18, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %src_data_i, %i after %20 : !llhd.sig<i32>
    llhd.drv %src_valid_i, %19 after %20 : !llhd.sig<i1>
    %22 = llhd.const #llhd.time<1ps, 0d, 0e> : !llhd.time
    llhd.drv %src_clk_i, %19 after %22 : !llhd.sig<i1>
    llhd.wait  for %21, ^23
^loop_continue:
    llhd.drv %src_clk_i, %19 after %20 : !llhd.sig<i1>
    llhd.wait  for %21, ^24
^23:
    %25 = constant 0 : i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %25 after %26 : !llhd.sig<i1>
    %27 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %27, ^12
^24:
    %28 = constant 0 : i1
    %29 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %28 after %29 : !llhd.sig<i1>
    %30 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %30, ^31
^31:
    br ^loop_body1
}

llhd.proc @cdc_fifo_gray_tb.initial.1154.0(%dst_data_o: !llhd.sig<i32>, %dst_valid_o: !llhd.sig<i1>) -> (%ERRORS: !llhd.sig<i32> , %dst_rst_ni: !llhd.sig<i1> , %dst_clk_i: !llhd.sig<i1> , %dst_ready_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.wait  for %1, ^2
^2:
    %3 = constant 0 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %3 after %4 : !llhd.sig<i1>
    %5 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %5, ^6
^6:
    %7 = constant 1 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %9, ^10
^10:
    %11 = constant 1 : i1
    %12 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_ready_i, %11 after %12 : !llhd.sig<i1>
    %13 = constant 0 : i32
    br ^loop_body(%13: i32)
^loop_body(%i: i32):
    %14 = constant 1000000 : i32
    %15 = cmpi "slt", %i, %14 : i32
    cond_br %15, ^loop_body1, ^loop_exit
^16:
    %17 = constant 1 : i32
    %18 = addi %i, %17 : i32
    br ^loop_body(%18: i32)
^loop_exit:
    llhd.halt
^loop_body1:
    %dst_valid_o1 = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %19 = constant 0 : i1
    %20 = cmpi "ne", %dst_valid_o1, %19 : i1
    %21 = llhd.not %20 : i1
    %22 = cmpi "ne", %21, %19 : i1
    %23 = constant 1 : i1
    %24 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %25 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %22, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %dst_clk_i, %23 after %24 : !llhd.sig<i1>
    %26 = constant 0 : i32
    %dst_data_o1 = llhd.prb %dst_data_o : !llhd.sig<i32>
    %27 = cmpi "ne", %i, %dst_data_o1 : i32
    %28 = llhd.inss %26, %27, 0 : i32, i1
    %ERRORS1 = llhd.prb %ERRORS : !llhd.sig<i32>
    %29 = addi %ERRORS1, %28 : i32
    llhd.drv %ERRORS, %29 after %24 : !llhd.sig<i32>
    llhd.wait  for %25, ^30
^loop_continue:
    llhd.drv %dst_clk_i, %23 after %24 : !llhd.sig<i1>
    llhd.wait  for %25, ^31
^30:
    %32 = constant 0 : i1
    %33 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %32 after %33 : !llhd.sig<i1>
    %34 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %34, ^16
^31:
    %35 = constant 0 : i1
    %36 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %35 after %36 : !llhd.sig<i1>
    %37 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %37, ^38
^38:
    br ^loop_body1
}

llhd.entity @cdc_fifo_gray_tb() -> () {
    %0 = constant 0 : i32
    %ERRORS = llhd.sig "sig" %0 : i32
    %1 = constant 1 : i1
    %src_rst_ni = llhd.sig "sig1" %1 : i1
    %2 = constant 0 : i1
    %src_clk_i = llhd.sig "sig2" %2 : i1
    %src_data_i = llhd.sig "sig3" %0 : i32
    %src_valid_i = llhd.sig "sig4" %2 : i1
    %src_ready_o = llhd.sig "sig5" %2 : i1
    %dst_rst_ni = llhd.sig "sig6" %1 : i1
    %dst_clk_i = llhd.sig "sig7" %2 : i1
    %dst_data_o = llhd.sig "sig8" %0 : i32
    %dst_valid_o = llhd.sig "sig9" %2 : i1
    %dst_ready_i = llhd.sig "sig10" %2 : i1
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.sig "sig11" %2 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %3, %src_rst_ni1 after %4 : !llhd.sig<i1>
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %5 = llhd.sig "sig12" %2 : i1
    llhd.drv %5, %src_clk_i1 after %4 : !llhd.sig<i1>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %6 = llhd.sig "sig13" %0 : i32
    llhd.drv %6, %src_data_i1 after %4 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %7 = llhd.sig "sig14" %2 : i1
    llhd.drv %7, %src_valid_i1 after %4 : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %8 = llhd.sig "sig15" %2 : i1
    llhd.drv %8, %dst_rst_ni1 after %4 : !llhd.sig<i1>
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %9 = llhd.sig "sig16" %2 : i1
    llhd.drv %9, %dst_clk_i1 after %4 : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %10 = llhd.sig "sig17" %2 : i1
    llhd.drv %10, %dst_ready_i1 after %4 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_fifo_gray.param1(%3, %5, %6, %7, %8, %9, %10) -> (%src_ready_o, %dst_data_o, %dst_valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @cdc_fifo_gray_tb.initial.1006.0(%src_ready_o) -> (%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst2" @cdc_fifo_gray_tb.initial.1154.0(%dst_data_o, %dst_valid_o) -> (%ERRORS, %dst_rst_ni, %dst_clk_i, %dst_ready_i) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
