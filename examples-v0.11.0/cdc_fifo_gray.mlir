llhd.entity @binary_to_gray.param2(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %A.prb = llhd.prb %A : !llhd.sig<i4>
    %0 = llhd.extract_slice %A.prb, 1 : i4 -> i3
    %1 = llhd.const 0 : i4
    %2 = llhd.insert_slice %1, %0, 0 : i4, i3
    %3 = llhd.xor %A.prb, %2 : i4
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i4>
}

llhd.entity @binary_to_gray.param3(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %A.prb = llhd.prb %A : !llhd.sig<i4>
    %0 = llhd.extract_slice %A.prb, 1 : i4 -> i3
    %1 = llhd.const 0 : i4
    %2 = llhd.insert_slice %1, %0, 0 : i4, i3
    %3 = llhd.xor %A.prb, %2 : i4
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i4>
}

llhd.entity @gray_to_binary.param4(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %0 = llhd.extract_slice %Z, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A.prb = llhd.prb %A : !llhd.sig<i4>
    %1 = llhd.extract_slice %A.prb, 0 : i4 -> i1
    %2 = llhd.extract_slice %A.prb, 1 : i4 -> i1
    %3 = llhd.xor %1, %2 : i1
    %4 = llhd.extract_slice %A.prb, 2 : i4 -> i1
    %5 = llhd.xor %3, %4 : i1
    %6 = llhd.extract_slice %A.prb, 3 : i4 -> i1
    %7 = llhd.xor %5, %6 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %0, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const 1 : i32
    %10 = llhd.const 0 : i4
    %11 = llhd.sig "11" %10 : i4
    %12 = llhd.shr %Z, %11, %9 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %13 = llhd.extract_slice %12, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %14 = llhd.extract_slice %A.prb, 1 : i4 -> i3
    %15 = llhd.insert_slice %10, %14, 0 : i4, i3
    %16 = llhd.extract_slice %15, 0 : i4 -> i3
    %17 = llhd.extract_slice %16, 0 : i3 -> i1
    %18 = llhd.extract_slice %16, 1 : i3 -> i1
    %19 = llhd.xor %17, %18 : i1
    %20 = llhd.extract_slice %16, 2 : i3 -> i1
    %21 = llhd.xor %19, %20 : i1
    llhd.drv %13, %21 after %8 : !llhd.sig<i1>
    %22 = llhd.const 2 : i32
    %23 = llhd.sig "23" %10 : i4
    %24 = llhd.shr %Z, %23, %22 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %25 = llhd.extract_slice %24, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %26 = llhd.extract_slice %A.prb, 2 : i4 -> i2
    %27 = llhd.insert_slice %10, %26, 0 : i4, i2
    %28 = llhd.extract_slice %27, 0 : i4 -> i2
    %29 = llhd.extract_slice %28, 0 : i2 -> i1
    %30 = llhd.extract_slice %28, 1 : i2 -> i1
    %31 = llhd.xor %29, %30 : i1
    llhd.drv %25, %31 after %8 : !llhd.sig<i1>
    %32 = llhd.const 3 : i32
    %33 = llhd.sig "33" %10 : i4
    %34 = llhd.shr %Z, %33, %32 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %35 = llhd.extract_slice %34, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %36 = llhd.insert_slice %10, %6, 0 : i4, i1
    %37 = llhd.extract_slice %36, 0 : i4 -> i1
    llhd.drv %35, %37 after %8 : !llhd.sig<i1>
    // %38 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %Z, %10 after %38 : !llhd.sig<i4>
}

llhd.entity @gray_to_binary.param5(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %0 = llhd.extract_slice %Z, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A.prb = llhd.prb %A : !llhd.sig<i4>
    %1 = llhd.extract_slice %A.prb, 0 : i4 -> i1
    %2 = llhd.extract_slice %A.prb, 1 : i4 -> i1
    %3 = llhd.xor %1, %2 : i1
    %4 = llhd.extract_slice %A.prb, 2 : i4 -> i1
    %5 = llhd.xor %3, %4 : i1
    %6 = llhd.extract_slice %A.prb, 3 : i4 -> i1
    %7 = llhd.xor %5, %6 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %0, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const 1 : i32
    %10 = llhd.const 0 : i4
    %11 = llhd.sig "11" %10 : i4
    %12 = llhd.shr %Z, %11, %9 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %13 = llhd.extract_slice %12, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %14 = llhd.extract_slice %A.prb, 1 : i4 -> i3
    %15 = llhd.insert_slice %10, %14, 0 : i4, i3
    %16 = llhd.extract_slice %15, 0 : i4 -> i3
    %17 = llhd.extract_slice %16, 0 : i3 -> i1
    %18 = llhd.extract_slice %16, 1 : i3 -> i1
    %19 = llhd.xor %17, %18 : i1
    %20 = llhd.extract_slice %16, 2 : i3 -> i1
    %21 = llhd.xor %19, %20 : i1
    llhd.drv %13, %21 after %8 : !llhd.sig<i1>
    %22 = llhd.const 2 : i32
    %23 = llhd.sig "23" %10 : i4
    %24 = llhd.shr %Z, %23, %22 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %25 = llhd.extract_slice %24, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %26 = llhd.extract_slice %A.prb, 2 : i4 -> i2
    %27 = llhd.insert_slice %10, %26, 0 : i4, i2
    %28 = llhd.extract_slice %27, 0 : i4 -> i2
    %29 = llhd.extract_slice %28, 0 : i2 -> i1
    %30 = llhd.extract_slice %28, 1 : i2 -> i1
    %31 = llhd.xor %29, %30 : i1
    llhd.drv %25, %31 after %8 : !llhd.sig<i1>
    %32 = llhd.const 3 : i32
    %33 = llhd.sig "33" %10 : i4
    %34 = llhd.shr %Z, %33, %32 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %35 = llhd.extract_slice %34, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %36 = llhd.insert_slice %10, %6, 0 : i4, i1
    %37 = llhd.extract_slice %36, 0 : i4 -> i1
    llhd.drv %35, %37 after %8 : !llhd.sig<i1>
    // %38 = llhd.const #llhd.time<0s, 0d, 0e> : !llhd.time
    // llhd.drv %Z, %10 after %38 : !llhd.sig<i4>
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.extract_element %fifo_data_q, 0 : !llhd.sig<!llhd.array<8xi32>> -> !llhd.sig<i32>
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %8 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    llhd.drv %9, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %9, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.14(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 1 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.15(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 2 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.16(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 3 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.17(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 4 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.18(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 5 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.19(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 6 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.265.20(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const 0 : i32
    %9 = llhd.const 7 : i32
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write.prb = llhd.prb %fifo_write : !llhd.sig<i1>
    %11 = llhd.neq %fifo_write.prb, %0 : i1
    %fifo_widx.prb = llhd.prb %fifo_widx : !llhd.sig<i3>
    %zext = llhd.insert_slice %8, %fifo_widx.prb, 0 : i32, i3
    %12 = llhd.eq %zext, %9 : i32
    %13 = llhd.neq %12, %0 : i1
    %14 = llhd.and %11, %13 : i1
    %15 = llhd.neq %14, %0 : i1
    cond_br %15, ^if_true1, ^init
^if_true:
    %16 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %17 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    llhd.drv %17, %8 after %10 : !llhd.sig<i32>
    br ^init
^if_true1:
    %18 = llhd.array_uniform %8 : !llhd.array<8xi32>
    %19 = llhd.dyn_extract_element %fifo_data_q, %9 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata.prb = llhd.prb %fifo_wdata : !llhd.sig<i32>
    llhd.drv %19, %fifo_wdata.prb after %10 : !llhd.sig<i32>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.initial.69.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.proc @cdc_fifo_gray.param1.always_ff.417.1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_valid_i: !llhd.sig<i1>, %src_ready_o: !llhd.sig<i1>, %src_wptr_bin_d: !llhd.sig<i4>, %src_wptr_gray_d: !llhd.sig<i4>) -> (%src_wptr_bin_q: !llhd.sig<i4> , %src_wptr_gray_q: !llhd.sig<i4> ) {
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %src_clk_i.prb, %0 : i1
    %2 = llhd.neq %src_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %src_rst_ni.prb, %0 : i1
    %4 = llhd.eq %src_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %src_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %src_valid_i.prb = llhd.prb %src_valid_i : !llhd.sig<i1>
    %9 = llhd.neq %src_valid_i.prb, %0 : i1
    %src_ready_o.prb = llhd.prb %src_ready_o : !llhd.sig<i1>
    %10 = llhd.neq %src_ready_o.prb, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = llhd.neq %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    %13 = llhd.const 0 : i4
    llhd.drv %src_wptr_bin_q, %13 after %8 : !llhd.sig<i4>
    llhd.drv %src_wptr_gray_q, %13 after %8 : !llhd.sig<i4>
    br ^init
^if_true1:
    %src_wptr_bin_d.prb = llhd.prb %src_wptr_bin_d : !llhd.sig<i4>
    llhd.drv %src_wptr_bin_q, %src_wptr_bin_d.prb after %8 : !llhd.sig<i4>
    %src_wptr_gray_d.prb = llhd.prb %src_wptr_gray_d : !llhd.sig<i4>
    llhd.drv %src_wptr_gray_q, %src_wptr_gray_d.prb after %8 : !llhd.sig<i4>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.486.1(%dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_valid_o: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>, %dst_rptr_bin_d: !llhd.sig<i4>, %dst_rptr_gray_d: !llhd.sig<i4>) -> (%dst_rptr_bin_q: !llhd.sig<i4> , %dst_rptr_gray_q: !llhd.sig<i4> ) {
    br ^init
^init:
    %dst_clk_i.prb = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %dst_rst_ni.prb = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    llhd.wait (%dst_clk_i, %dst_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %dst_clk_i.prb1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %0 = llhd.const 0 : i1
    %1 = llhd.eq %dst_clk_i.prb, %0 : i1
    %2 = llhd.neq %dst_clk_i.prb1, %0 : i1
    %posedge = llhd.and %1, %2 : i1
    %dst_rst_ni.prb1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %3 = llhd.neq %dst_rst_ni.prb, %0 : i1
    %4 = llhd.eq %dst_rst_ni.prb1, %0 : i1
    %negedge = llhd.and %4, %3 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %5 = llhd.neq %dst_rst_ni.prb1, %0 : i1
    %6 = llhd.not %5 : i1
    %7 = llhd.neq %6, %0 : i1
    %8 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %7, ^if_true, ^if_false
^if_false:
    %dst_valid_o.prb = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %9 = llhd.neq %dst_valid_o.prb, %0 : i1
    %dst_ready_i.prb = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %10 = llhd.neq %dst_ready_i.prb, %0 : i1
    %11 = llhd.and %9, %10 : i1
    %12 = llhd.neq %11, %0 : i1
    cond_br %12, ^if_true1, ^init
^if_true:
    %13 = llhd.const 0 : i4
    llhd.drv %dst_rptr_bin_q, %13 after %8 : !llhd.sig<i4>
    llhd.drv %dst_rptr_gray_q, %13 after %8 : !llhd.sig<i4>
    br ^init
^if_true1:
    %dst_rptr_bin_d.prb = llhd.prb %dst_rptr_bin_d : !llhd.sig<i4>
    llhd.drv %dst_rptr_bin_q, %dst_rptr_bin_d.prb after %8 : !llhd.sig<i4>
    %dst_rptr_gray_d.prb = llhd.prb %dst_rptr_gray_d : !llhd.sig<i4>
    llhd.drv %dst_rptr_gray_q, %dst_rptr_gray_d.prb after %8 : !llhd.sig<i4>
    br ^init
}

llhd.proc @cdc_fifo_gray.param1.always_ff.559.1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %dst_rptr_gray_q: !llhd.sig<i4>) -> (%src_rptr_gray_q: !llhd.sig<i4> , %src_rptr_gray_q2: !llhd.sig<i4> ) {
    br ^0
^0:
    %1 = llhd.prb %src_rptr_gray_q : !llhd.sig<i4>
    %src_rptr_gray_q.shadow = llhd.var %1 : i4
    br ^init
^init:
    %src_clk_i.prb = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni.prb = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %src_rptr_gray_q : !llhd.sig<i4>
    llhd.store %src_rptr_gray_q.shadow, %2 : !llhd.ptr<i4>
    %src_clk_i.prb1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %src_clk_i.prb, %3 : i1
    %5 = llhd.neq %src_clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %src_rst_ni.prb1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %6 = llhd.neq %src_rst_ni.prb, %3 : i1
    %7 = llhd.eq %src_rst_ni.prb1, %3 : i1
    %negedge = llhd.and %7, %6 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %8 = llhd.neq %src_rst_ni.prb1, %3 : i1
    %9 = llhd.not %8 : i1
    %10 = llhd.neq %9, %3 : i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %10, ^if_true, ^if_false
^if_false:
    %dst_rptr_gray_q.prb = llhd.prb %dst_rptr_gray_q : !llhd.sig<i4>
    llhd.drv %src_rptr_gray_q, %dst_rptr_gray_q.prb after %11 : !llhd.sig<i4>
    %src_rptr_gray_q.shadow.ld = llhd.load %src_rptr_gray_q.shadow : !llhd.ptr<i4>
    llhd.drv %src_rptr_gray_q2, %src_rptr_gray_q.shadow.ld after %11 : !llhd.sig<i4>
    br ^0
^if_true:
    %12 = llhd.const 0 : i4
    llhd.drv %src_rptr_gray_q, %12 after %11 : !llhd.sig<i4>
    llhd.drv %src_rptr_gray_q2, %12 after %11 : !llhd.sig<i4>
    br ^0
}

llhd.proc @cdc_fifo_gray.param1.always_ff.620.1(%dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %src_wptr_gray_q: !llhd.sig<i4>) -> (%dst_wptr_gray_q: !llhd.sig<i4> , %dst_wptr_gray_q2: !llhd.sig<i4> ) {
    br ^0
^0:
    %1 = llhd.prb %dst_wptr_gray_q : !llhd.sig<i4>
    %dst_wptr_gray_q.shadow = llhd.var %1 : i4
    br ^init
^init:
    %dst_clk_i.prb = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %dst_rst_ni.prb = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    llhd.wait (%dst_clk_i, %dst_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %dst_wptr_gray_q : !llhd.sig<i4>
    llhd.store %dst_wptr_gray_q.shadow, %2 : !llhd.ptr<i4>
    %dst_clk_i.prb1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %dst_clk_i.prb, %3 : i1
    %5 = llhd.neq %dst_clk_i.prb1, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %dst_rst_ni.prb1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %6 = llhd.neq %dst_rst_ni.prb, %3 : i1
    %7 = llhd.eq %dst_rst_ni.prb1, %3 : i1
    %negedge = llhd.and %7, %6 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %8 = llhd.neq %dst_rst_ni.prb1, %3 : i1
    %9 = llhd.not %8 : i1
    %10 = llhd.neq %9, %3 : i1
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    cond_br %10, ^if_true, ^if_false
^if_false:
    %src_wptr_gray_q.prb = llhd.prb %src_wptr_gray_q : !llhd.sig<i4>
    llhd.drv %dst_wptr_gray_q, %src_wptr_gray_q.prb after %11 : !llhd.sig<i4>
    %dst_wptr_gray_q.shadow.ld = llhd.load %dst_wptr_gray_q.shadow : !llhd.ptr<i4>
    llhd.drv %dst_wptr_gray_q2, %dst_wptr_gray_q.shadow.ld after %11 : !llhd.sig<i4>
    br ^0
^if_true:
    %12 = llhd.const 0 : i4
    llhd.drv %dst_wptr_gray_q, %12 after %11 : !llhd.sig<i4>
    llhd.drv %dst_wptr_gray_q2, %12 after %11 : !llhd.sig<i4>
    br ^0
}

llhd.entity @cdc_fifo_gray.param1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_data_i: !llhd.sig<i32>, %src_valid_i: !llhd.sig<i1>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%src_ready_o: !llhd.sig<i1> , %dst_data_o: !llhd.sig<i32> , %dst_valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i3
    %fifo_widx = llhd.sig "fifo_widx" %0 : i3
    %fifo_ridx = llhd.sig "fifo_ridx" %0 : i3
    %1 = llhd.const 0 : i1
    %fifo_write = llhd.sig "fifo_write" %1 : i1
    %2 = llhd.const 0 : i32
    %fifo_wdata = llhd.sig "fifo_wdata" %2 : i32
    %fifo_rdata = llhd.sig "fifo_rdata" %2 : i32
    %3 = llhd.array %2, %2, %2, %2, %2, %2, %2, %2 : !llhd.array<8xi32>
    %fifo_data_q = llhd.sig "fifo_data_q" %3 : !llhd.array<8xi32>
    %4 = llhd.const 0 : i4
    %src_wptr_bin_q = llhd.sig "src_wptr_bin_q" %4 : i4
    %src_wptr_gray_q = llhd.sig "src_wptr_gray_q" %4 : i4
    %dst_rptr_bin_q = llhd.sig "dst_rptr_bin_q" %4 : i4
    %dst_rptr_gray_q = llhd.sig "dst_rptr_gray_q" %4 : i4
    %src_wptr_bin_d = llhd.sig "src_wptr_bin_d" %4 : i4
    %src_wptr_gray_d = llhd.sig "src_wptr_gray_d" %4 : i4
    %dst_rptr_bin_d = llhd.sig "dst_rptr_bin_d" %4 : i4
    %dst_rptr_gray_d = llhd.sig "dst_rptr_gray_d" %4 : i4
    %src_rptr_gray_q = llhd.sig "src_rptr_gray_q" %4 : i4
    %src_rptr_gray_q2 = llhd.sig "src_rptr_gray_q2" %4 : i4
    %dst_wptr_gray_q = llhd.sig "dst_wptr_gray_q" %4 : i4
    %dst_wptr_gray_q2 = llhd.sig "dst_wptr_gray_q2" %4 : i4
    %src_rptr_bin = llhd.sig "src_rptr_bin" %4 : i4
    %dst_wptr_bin = llhd.sig "dst_wptr_bin" %4 : i4
    %fifo_data_q.prb = llhd.prb %fifo_data_q : !llhd.sig<!llhd.array<8xi32>>
    %fifo_ridx.prb = llhd.prb %fifo_ridx : !llhd.sig<i3>
    %5 = llhd.array_uniform %2 : !llhd.array<8xi32>
    %6 = llhd.shr %fifo_data_q.prb, %5, %fifo_ridx.prb : (!llhd.array<8xi32>, !llhd.array<8xi32>, i3) -> !llhd.array<8xi32>
    %7 = llhd.extract_element %6, 0 : !llhd.array<8xi32> -> i32
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_rdata, %7 after %8 : !llhd.sig<i32>
    %src_wptr_bin_q.prb = llhd.prb %src_wptr_bin_q : !llhd.sig<i4>
    %zext = llhd.insert_slice %2, %src_wptr_bin_q.prb, 0 : i32, i4
    %9 = llhd.const 1 : i32
    %10 = addi %zext, %9 : i32
    %11 = llhd.extract_slice %10, 0 : i32 -> i4
    llhd.drv %src_wptr_bin_d, %11 after %8 : !llhd.sig<i4>
    %dst_rptr_bin_q.prb = llhd.prb %dst_rptr_bin_q : !llhd.sig<i4>
    %zext1 = llhd.insert_slice %2, %dst_rptr_bin_q.prb, 0 : i32, i4
    %12 = addi %zext1, %9 : i32
    %13 = llhd.extract_slice %12, 0 : i32 -> i4
    llhd.drv %dst_rptr_bin_d, %13 after %8 : !llhd.sig<i4>
    %src_rptr_bin.prb = llhd.prb %src_rptr_bin : !llhd.sig<i4>
    %14 = llhd.xor %src_wptr_bin_q.prb, %src_rptr_bin.prb : i4
    %15 = llhd.const 8 : i4
    %16 = llhd.neq %14, %15 : i4
    llhd.drv %src_ready_o, %16 after %8 : !llhd.sig<i1>
    %dst_wptr_bin.prb = llhd.prb %dst_wptr_bin : !llhd.sig<i4>
    %17 = llhd.xor %dst_rptr_bin_q.prb, %dst_wptr_bin.prb : i4
    %18 = llhd.neq %17, %4 : i4
    llhd.drv %dst_valid_o, %18 after %8 : !llhd.sig<i1>
    %19 = llhd.extract_slice %src_wptr_bin_q.prb, 0 : i4 -> i3
    llhd.drv %fifo_widx, %19 after %8 : !llhd.sig<i3>
    %src_data_i.prb = llhd.prb %src_data_i : !llhd.sig<i32>
    llhd.drv %fifo_wdata, %src_data_i.prb after %8 : !llhd.sig<i32>
    %src_valid_i.prb = llhd.prb %src_valid_i : !llhd.sig<i1>
    %20 = llhd.neq %src_valid_i.prb, %1 : i1
    %src_ready_o.prb = llhd.prb %src_ready_o : !llhd.sig<i1>
    %21 = llhd.neq %src_ready_o.prb, %1 : i1
    %22 = llhd.and %20, %21 : i1
    llhd.drv %fifo_write, %22 after %8 : !llhd.sig<i1>
    %23 = llhd.extract_slice %dst_rptr_bin_q.prb, 0 : i4 -> i3
    llhd.drv %fifo_ridx, %23 after %8 : !llhd.sig<i3>
    %fifo_rdata.prb = llhd.prb %fifo_rdata : !llhd.sig<i32>
    llhd.drv %dst_data_o, %fifo_rdata.prb after %8 : !llhd.sig<i32>
    llhd.inst "inst" @binary_to_gray.param2(%src_wptr_bin_d) -> (%src_wptr_gray_d) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    llhd.inst "inst1" @binary_to_gray.param3(%dst_rptr_bin_d) -> (%dst_rptr_gray_d) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    llhd.inst "inst2" @gray_to_binary.param4(%src_rptr_gray_q2) -> (%src_rptr_bin) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    llhd.inst "inst3" @gray_to_binary.param5(%dst_wptr_gray_q2) -> (%dst_wptr_bin) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    llhd.inst "inst4" @cdc_fifo_gray.param1.always_ff.265.1(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst5" @cdc_fifo_gray.param1.always_ff.265.14(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst6" @cdc_fifo_gray.param1.always_ff.265.15(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst7" @cdc_fifo_gray.param1.always_ff.265.16(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst8" @cdc_fifo_gray.param1.always_ff.265.17(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst9" @cdc_fifo_gray.param1.always_ff.265.18(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst10" @cdc_fifo_gray.param1.always_ff.265.19(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst11" @cdc_fifo_gray.param1.always_ff.265.20(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst12" @cdc_fifo_gray.param1.initial.69.1() -> () : () -> ()
    llhd.inst "inst13" @cdc_fifo_gray.param1.always_ff.417.1(%src_rst_ni, %src_clk_i, %src_valid_i, %src_ready_o, %src_wptr_bin_d, %src_wptr_gray_d) -> (%src_wptr_bin_q, %src_wptr_gray_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst14" @cdc_fifo_gray.param1.always_ff.486.1(%dst_rst_ni, %dst_clk_i, %dst_valid_o, %dst_ready_i, %dst_rptr_bin_d, %dst_rptr_gray_d) -> (%dst_rptr_bin_q, %dst_rptr_gray_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst15" @cdc_fifo_gray.param1.always_ff.559.1(%src_rst_ni, %src_clk_i, %dst_rptr_gray_q) -> (%src_rptr_gray_q, %src_rptr_gray_q2) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst16" @cdc_fifo_gray.param1.always_ff.620.1(%dst_rst_ni, %dst_clk_i, %src_wptr_gray_q) -> (%dst_wptr_gray_q, %dst_wptr_gray_q2) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
}

llhd.proc @cdc_fifo_gray_tb.initial.1018.0(%src_ready_o: !llhd.sig<i1>) -> (%src_rst_ni: !llhd.sig<i1> , %src_clk_i: !llhd.sig<i1> , %src_data_i: !llhd.sig<i32> , %src_valid_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i1
    %2 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %1 after %2 : !llhd.sig<i1>
    %3 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %3, ^4
^4:
    %5 = llhd.const 1 : i1
    %6 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %5 after %6 : !llhd.sig<i1>
    %7 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %7, ^8
^8:
    %9 = llhd.const 0 : i32
    %i = llhd.var %9 : i32
    br ^loop_body
^loop_body:
    %i.ld = llhd.load %i : !llhd.ptr<i32>
    %10 = llhd.const 1000000 : i32
    %11 = cmpi "slt", %i.ld, %10 : i32
    cond_br %11, ^loop_body1, ^loop_exit
^loop_exit:
    llhd.halt
^loop_body1:
    %src_ready_o.prb = llhd.prb %src_ready_o : !llhd.sig<i1>
    %12 = llhd.const 0 : i1
    %13 = llhd.neq %src_ready_o.prb, %12 : i1
    %14 = llhd.not %13 : i1
    %15 = llhd.neq %14, %12 : i1
    %16 = llhd.const 1 : i1
    %17 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %18 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %15, ^loop_continue, ^loop_exit1
^loop_exit1:
    %i.ld1 = llhd.load %i : !llhd.ptr<i32>
    llhd.drv %src_data_i, %i.ld1 after %17 : !llhd.sig<i32>
    llhd.drv %src_valid_i, %16 after %17 : !llhd.sig<i1>
    %19 = llhd.const #llhd.time<1ps, 0d, 0e> : !llhd.time
    llhd.drv %src_clk_i, %16 after %19 : !llhd.sig<i1>
    llhd.wait  for %18, ^20
^loop_continue:
    llhd.drv %src_clk_i, %16 after %17 : !llhd.sig<i1>
    llhd.wait  for %18, ^21
^20:
    %22 = llhd.const 0 : i1
    %23 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %22 after %23 : !llhd.sig<i1>
    %24 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %24, ^25
^21:
    %26 = llhd.const 0 : i1
    %27 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %26 after %27 : !llhd.sig<i1>
    %28 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %28, ^29
^29:
    br ^loop_body1
^25:
    %i.ld2 = llhd.load %i : !llhd.ptr<i32>
    %30 = llhd.const 1 : i32
    %31 = addi %i.ld2, %30 : i32
    llhd.store %i, %31 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.proc @cdc_fifo_gray_tb.initial.1166.0(%dst_data_o: !llhd.sig<i32>, %dst_valid_o: !llhd.sig<i1>) -> (%ERRORS: !llhd.sig<i32> , %dst_rst_ni: !llhd.sig<i1> , %dst_clk_i: !llhd.sig<i1> , %dst_ready_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.wait  for %1, ^2
^2:
    %3 = llhd.const 0 : i1
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %3 after %4 : !llhd.sig<i1>
    %5 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %5, ^6
^6:
    %7 = llhd.const 1 : i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %9, ^10
^10:
    %11 = llhd.const 1 : i1
    %12 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_ready_i, %11 after %12 : !llhd.sig<i1>
    %13 = llhd.const 0 : i32
    %i = llhd.var %13 : i32
    br ^loop_body
^loop_body:
    %i.ld = llhd.load %i : !llhd.ptr<i32>
    %14 = llhd.const 1000000 : i32
    %15 = cmpi "slt", %i.ld, %14 : i32
    cond_br %15, ^loop_body1, ^loop_exit
^loop_exit:
    llhd.halt
^loop_body1:
    %dst_valid_o.prb = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %16 = llhd.const 0 : i1
    %17 = llhd.neq %dst_valid_o.prb, %16 : i1
    %18 = llhd.not %17 : i1
    %19 = llhd.neq %18, %16 : i1
    %20 = llhd.const 1 : i1
    %21 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    %22 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    cond_br %19, ^loop_continue, ^loop_exit1
^loop_exit1:
    llhd.drv %dst_clk_i, %20 after %21 : !llhd.sig<i1>
    %23 = llhd.const 0 : i32
    %i.ld1 = llhd.load %i : !llhd.ptr<i32>
    %dst_data_o.prb = llhd.prb %dst_data_o : !llhd.sig<i32>
    %24 = llhd.neq %i.ld1, %dst_data_o.prb : i32
    %zext = llhd.insert_slice %23, %24, 0 : i32, i1
    %ERRORS.prb = llhd.prb %ERRORS : !llhd.sig<i32>
    %25 = addi %ERRORS.prb, %zext : i32
    llhd.drv %ERRORS, %25 after %21 : !llhd.sig<i32>
    llhd.wait  for %22, ^26
^loop_continue:
    llhd.drv %dst_clk_i, %20 after %21 : !llhd.sig<i1>
    llhd.wait  for %22, ^27
^26:
    %28 = llhd.const 0 : i1
    %29 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %28 after %29 : !llhd.sig<i1>
    %30 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %30, ^31
^27:
    %32 = llhd.const 0 : i1
    %33 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %32 after %33 : !llhd.sig<i1>
    %34 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %34, ^35
^35:
    br ^loop_body1
^31:
    %i.ld2 = llhd.load %i : !llhd.ptr<i32>
    %36 = llhd.const 1 : i32
    %37 = addi %i.ld2, %36 : i32
    llhd.store %i, %37 : !llhd.ptr<i32>
    br ^loop_body
}

llhd.entity @cdc_fifo_gray_tb() -> () {
    %0 = llhd.const 0 : i32
    %ERRORS = llhd.sig "ERRORS" %0 : i32
    %1 = llhd.const 1 : i1
    %src_rst_ni = llhd.sig "src_rst_ni" %1 : i1
    %2 = llhd.const 0 : i1
    %src_clk_i = llhd.sig "src_clk_i" %2 : i1
    %src_data_i = llhd.sig "src_data_i" %0 : i32
    %src_valid_i = llhd.sig "src_valid_i" %2 : i1
    %src_ready_o = llhd.sig "src_ready_o" %2 : i1
    %dst_rst_ni = llhd.sig "dst_rst_ni" %1 : i1
    %dst_clk_i = llhd.sig "dst_clk_i" %2 : i1
    %dst_data_o = llhd.sig "dst_data_o" %0 : i32
    %dst_valid_o = llhd.sig "dst_valid_o" %2 : i1
    %dst_ready_i = llhd.sig "dst_ready_i" %2 : i1
    llhd.inst "inst" @cdc_fifo_gray.param1(%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i, %dst_rst_ni, %dst_clk_i, %dst_ready_i) -> (%src_ready_o, %dst_data_o, %dst_valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @cdc_fifo_gray_tb.initial.1018.0(%src_ready_o) -> (%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst2" @cdc_fifo_gray_tb.initial.1166.0(%dst_data_o, %dst_valid_o) -> (%ERRORS, %dst_rst_ni, %dst_clk_i, %dst_ready_i) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
