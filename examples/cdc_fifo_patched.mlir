llhd.entity @binary_to_gray.param2(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %A2 = llhd.prb %A : !llhd.sig<i4>
    %0 = llhd.const 1 : i32
    %1 = llhd.const 0 : i4
    %2 = llhd.shr %A2, %1, %0 : (i4, i4, i32) -> i4
    %3 = llhd.xor %A1, %2 : i4
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i4>
}

llhd.entity @binary_to_gray.param3(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %A2 = llhd.prb %A : !llhd.sig<i4>
    %0 = llhd.const 1 : i32
    %1 = llhd.const 0 : i4
    %2 = llhd.shr %A2, %1, %0 : (i4, i4, i32) -> i4
    %3 = llhd.xor %A1, %2 : i4
    %4 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %Z, %3 after %4 : !llhd.sig<i4>
}

llhd.entity @gray_to_binary.param4(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %0 = llhd.const 0 : i32
    %1 = llhd.const 0 : i4
    %2 = llhd.sig "sig" %1 : i4
    %3 = llhd.shr %Z, %2, %0 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %4 = llhd.extract_slice %3, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %5 = llhd.const 0 : i1
    %6 = llhd.const 0 : i4
    %7 = llhd.shr %A1, %6, %5 : (i4, i4, i1) -> i4
    %8 = llhd.extract_slice %7, 0 : i4 -> i4
    %9 = llhd.extract_slice %8, 0 : i4 -> i1
    %10 = llhd.extract_slice %8, 1 : i4 -> i1
    %11 = llhd.xor %9, %10 : i1
    %12 = llhd.extract_slice %8, 2 : i4 -> i1
    %13 = llhd.xor %11, %12 : i1
    %14 = llhd.extract_slice %8, 3 : i4 -> i1
    %15 = llhd.xor %13, %14 : i1
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %15 after %16 : !llhd.sig<i1>
    %17 = llhd.const 1 : i32
    %18 = llhd.const 0 : i4
    %19 = llhd.sig "sig1" %18 : i4
    %20 = llhd.shr %Z, %19, %17 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %21 = llhd.extract_slice %20, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A2 = llhd.prb %A : !llhd.sig<i4>
    %22 = llhd.const 1 : i1
    %23 = llhd.const 0 : i4
    %24 = llhd.shr %A2, %23, %22 : (i4, i4, i1) -> i4
    %25 = llhd.extract_slice %24, 0 : i4 -> i3
    %26 = llhd.extract_slice %25, 0 : i3 -> i1
    %27 = llhd.extract_slice %25, 1 : i3 -> i1
    %28 = llhd.xor %26, %27 : i1
    %29 = llhd.extract_slice %25, 2 : i3 -> i1
    %30 = llhd.xor %28, %29 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %21, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const 2 : i32
    %33 = llhd.const 0 : i4
    %34 = llhd.sig "sig2" %33 : i4
    %35 = llhd.shr %Z, %34, %32 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %36 = llhd.extract_slice %35, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A3 = llhd.prb %A : !llhd.sig<i4>
    %37 = llhd.const 2 : i2
    %38 = llhd.const 0 : i4
    %39 = llhd.shr %A3, %38, %37 : (i4, i4, i2) -> i4
    %40 = llhd.extract_slice %39, 0 : i4 -> i2
    %41 = llhd.extract_slice %40, 0 : i2 -> i1
    %42 = llhd.extract_slice %40, 1 : i2 -> i1
    %43 = llhd.xor %41, %42 : i1
    %44 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %36, %43 after %44 : !llhd.sig<i1>
    %45 = llhd.const 3 : i32
    %46 = llhd.const 0 : i4
    %47 = llhd.sig "sig3" %46 : i4
    %48 = llhd.shr %Z, %47, %45 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %49 = llhd.extract_slice %48, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A4 = llhd.prb %A : !llhd.sig<i4>
    %50 = llhd.const 3 : i2
    %51 = llhd.const 0 : i4
    %52 = llhd.shr %A4, %51, %50 : (i4, i4, i2) -> i4
    %53 = llhd.extract_slice %52, 0 : i4 -> i1
    %54 = llhd.extract_slice %53, 0 : i1 -> i1
    %55 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %49, %54 after %55 : !llhd.sig<i1>
}

llhd.entity @gray_to_binary.param9(%A: !llhd.sig<i4>) -> (%Z: !llhd.sig<i4> ) {
    %0 = llhd.const 0 : i32
    %1 = llhd.const 0 : i4
    %2 = llhd.sig "sig" %1 : i4
    %3 = llhd.shr %Z, %2, %0 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %4 = llhd.extract_slice %3, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A1 = llhd.prb %A : !llhd.sig<i4>
    %5 = llhd.const 0 : i1
    %6 = llhd.const 0 : i4
    %7 = llhd.shr %A1, %6, %5 : (i4, i4, i1) -> i4
    %8 = llhd.extract_slice %7, 0 : i4 -> i4
    %9 = llhd.extract_slice %8, 0 : i4 -> i1
    %10 = llhd.extract_slice %8, 1 : i4 -> i1
    %11 = llhd.xor %9, %10 : i1
    %12 = llhd.extract_slice %8, 2 : i4 -> i1
    %13 = llhd.xor %11, %12 : i1
    %14 = llhd.extract_slice %8, 3 : i4 -> i1
    %15 = llhd.xor %13, %14 : i1
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %4, %15 after %16 : !llhd.sig<i1>
    %17 = llhd.const 1 : i32
    %18 = llhd.const 0 : i4
    %19 = llhd.sig "sig1" %18 : i4
    %20 = llhd.shr %Z, %19, %17 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %21 = llhd.extract_slice %20, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A2 = llhd.prb %A : !llhd.sig<i4>
    %22 = llhd.const 1 : i1
    %23 = llhd.const 0 : i4
    %24 = llhd.shr %A2, %23, %22 : (i4, i4, i1) -> i4
    %25 = llhd.extract_slice %24, 0 : i4 -> i3
    %26 = llhd.extract_slice %25, 0 : i3 -> i1
    %27 = llhd.extract_slice %25, 1 : i3 -> i1
    %28 = llhd.xor %26, %27 : i1
    %29 = llhd.extract_slice %25, 2 : i3 -> i1
    %30 = llhd.xor %28, %29 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %21, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const 2 : i32
    %33 = llhd.const 0 : i4
    %34 = llhd.sig "sig2" %33 : i4
    %35 = llhd.shr %Z, %34, %32 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %36 = llhd.extract_slice %35, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A3 = llhd.prb %A : !llhd.sig<i4>
    %37 = llhd.const 2 : i2
    %38 = llhd.const 0 : i4
    %39 = llhd.shr %A3, %38, %37 : (i4, i4, i2) -> i4
    %40 = llhd.extract_slice %39, 0 : i4 -> i2
    %41 = llhd.extract_slice %40, 0 : i2 -> i1
    %42 = llhd.extract_slice %40, 1 : i2 -> i1
    %43 = llhd.xor %41, %42 : i1
    %44 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %36, %43 after %44 : !llhd.sig<i1>
    %45 = llhd.const 3 : i32
    %46 = llhd.const 0 : i4
    %47 = llhd.sig "sig3" %46 : i4
    %48 = llhd.shr %Z, %47, %45 : (!llhd.sig<i4>, !llhd.sig<i4>, i32) -> !llhd.sig<i4>
    %49 = llhd.extract_slice %48, 0 : !llhd.sig<i4> -> !llhd.sig<i1>
    %A4 = llhd.prb %A : !llhd.sig<i4>
    %50 = llhd.const 3 : i2
    %51 = llhd.const 0 : i4
    %52 = llhd.shr %A4, %51, %50 : (i4, i4, i2) -> i4
    %53 = llhd.extract_slice %52, 0 : i4 -> i1
    %54 = llhd.extract_slice %53, 0 : i1 -> i1
    %55 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %49, %54 after %55 : !llhd.sig<i1>
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 0 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 0 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 0 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.14(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 1 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 1 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 1 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.15(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 2 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 2 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 2 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.16(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 3 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 3 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 3 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.17(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 4 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 4 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 4 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.18(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 5 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 5 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 5 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.19(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 6 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 6 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 6 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.378.20(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %fifo_widx: !llhd.sig<i3>, %fifo_write: !llhd.sig<i1>, %fifo_wdata: !llhd.sig<i32>) -> (%fifo_data_q: !llhd.sig<!llhd.array<8xi32>> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %fifo_write1 = llhd.prb %fifo_write : !llhd.sig<i1>
    %8 = llhd.const 0 : i32
    %fifo_widx1 = llhd.prb %fifo_widx : !llhd.sig<i3>
    %9 = llhd.insert_slice %8, %fifo_widx1, 0 : i32, i3
    %10 = llhd.const 7 : i32
    %11 = llhd.eq %9, %10 : i32
    %12 = llhd.and %fifo_write1, %11 : i1
    cond_br %12, ^if_true1, ^if_false1
^if_true:
    %13 = llhd.const 7 : i32
    %14 = llhd.const 0 : i32
    %15 = llhd.array_uniform %14 : !llhd.array<8xi32>
    %16 = llhd.dyn_extract_element %fifo_data_q, %13 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.const 0 : i1
    %19 = llhd.insert_slice %17, %18, 0 : i32, i1
    %20 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %16, %19 after %20 : !llhd.sig<i32>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %21 = llhd.const 7 : i32
    %22 = llhd.const 0 : i32
    %23 = llhd.array_uniform %22 : !llhd.array<8xi32>
    %24 = llhd.dyn_extract_element %fifo_data_q, %21 : (!llhd.sig<!llhd.array<8xi32>>, i32) -> !llhd.sig<i32>
    %fifo_wdata1 = llhd.prb %fifo_wdata : !llhd.sig<i32>
    %25 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %24, %fifo_wdata1 after %25 : !llhd.sig<i32>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.initial.279.1() -> () {
    br ^0
^0:
    llhd.halt
}

llhd.proc @cdc_fifo_gray.param1.always_ff.313.1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_valid_i: !llhd.sig<i1>, %src_ready_o: !llhd.sig<i1>, %src_wptr_bin_d: !llhd.sig<i4>, %src_wptr_gray_d: !llhd.sig<i4>) -> (%src_wptr_bin_q: !llhd.sig<i4> , %src_wptr_gray_q: !llhd.sig<i4> ) {
    br ^0
^0:
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %src_clk_i1, %1 : i1
    %3 = llhd.neq %src_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %src_rst_ni1, %4 : i1
    %6 = llhd.eq %src_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %src_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %8 = llhd.and %src_valid_i1, %src_ready_o1 : i1
    cond_br %8, ^if_true1, ^if_false1
^if_true:
    %9 = llhd.const 0 : i4
    %10 = llhd.const 0 : i1
    %11 = llhd.insert_slice %9, %10, 0 : i4, i1
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_wptr_bin_q, %11 after %12 : !llhd.sig<i4>
    %13 = llhd.const 0 : i4
    %14 = llhd.const 0 : i1
    %15 = llhd.insert_slice %13, %14, 0 : i4, i1
    %16 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_wptr_gray_q, %15 after %16 : !llhd.sig<i4>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %src_wptr_bin_d1 = llhd.prb %src_wptr_bin_d : !llhd.sig<i4>
    %17 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_wptr_bin_q, %src_wptr_bin_d1 after %17 : !llhd.sig<i4>
    %src_wptr_gray_d1 = llhd.prb %src_wptr_gray_d : !llhd.sig<i4>
    %18 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_wptr_gray_q, %src_wptr_gray_d1 after %18 : !llhd.sig<i4>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.314.1(%dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_valid_o: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>, %dst_rptr_bin_d: !llhd.sig<i4>, %dst_rptr_gray_d: !llhd.sig<i4>) -> (%dst_rptr_bin_q: !llhd.sig<i4> , %dst_rptr_gray_q: !llhd.sig<i4> ) {
    br ^0
^0:
    br ^init
^init:
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    llhd.wait (%dst_clk_i, %dst_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %dst_clk_i2 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %1 = llhd.const 0 : i1
    %2 = llhd.eq %dst_clk_i1, %1 : i1
    %3 = llhd.neq %dst_clk_i2, %1 : i1
    %posedge = llhd.and %2, %3 : i1
    %dst_rst_ni2 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %4 = llhd.const 0 : i1
    %5 = llhd.neq %dst_rst_ni1, %4 : i1
    %6 = llhd.eq %dst_rst_ni2, %4 : i1
    %negedge = llhd.and %6, %5 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %dst_rst_ni3 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %7 = llhd.not %dst_rst_ni3 : i1
    cond_br %7, ^if_true, ^if_false
^if_false:
    %dst_valid_o1 = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %8 = llhd.and %dst_valid_o1, %dst_ready_i1 : i1
    cond_br %8, ^if_true1, ^if_false1
^if_true:
    %9 = llhd.const 0 : i4
    %10 = llhd.const 0 : i1
    %11 = llhd.insert_slice %9, %10, 0 : i4, i1
    %12 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_rptr_bin_q, %11 after %12 : !llhd.sig<i4>
    %13 = llhd.const 0 : i4
    %14 = llhd.const 0 : i1
    %15 = llhd.insert_slice %13, %14, 0 : i4, i1
    %16 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_rptr_gray_q, %15 after %16 : !llhd.sig<i4>
    br ^if_exit
^if_exit:
    br ^0
^if_false1:
    br ^if_exit1
^if_true1:
    %dst_rptr_bin_d1 = llhd.prb %dst_rptr_bin_d : !llhd.sig<i4>
    %17 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_rptr_bin_q, %dst_rptr_bin_d1 after %17 : !llhd.sig<i4>
    %dst_rptr_gray_d1 = llhd.prb %dst_rptr_gray_d : !llhd.sig<i4>
    %18 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_rptr_gray_q, %dst_rptr_gray_d1 after %18 : !llhd.sig<i4>
    br ^if_exit1
^if_exit1:
    br ^if_exit
}

llhd.proc @cdc_fifo_gray.param1.always_ff.321.1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %dst_rptr_gray_q: !llhd.sig<i4>, %src_rptr_gray_q: !llhd.sig<i4>) -> (%src_rptr_gray_q1: !llhd.sig<i4> , %src_rptr_gray_q2: !llhd.sig<i4> ) {
    br ^0
^0:
    %1 = llhd.prb %src_rptr_gray_q1 : !llhd.sig<i4>
    %src_rptr_gray_q.shadow = llhd.var %1 : i4
    br ^init
^init:
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    llhd.wait (%src_clk_i, %src_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %src_rptr_gray_q1 : !llhd.sig<i4>
    llhd.store %src_rptr_gray_q.shadow, %2 : !llhd.ptr<i4>
    %src_clk_i2 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %src_clk_i1, %3 : i1
    %5 = llhd.neq %src_clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %src_rst_ni2 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.neq %src_rst_ni1, %6 : i1
    %8 = llhd.eq %src_rst_ni2, %6 : i1
    %negedge = llhd.and %8, %7 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %src_rst_ni3 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %9 = llhd.not %src_rst_ni3 : i1
    cond_br %9, ^if_true, ^if_false
^if_false:
    %dst_rptr_gray_q1 = llhd.prb %dst_rptr_gray_q : !llhd.sig<i4>
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_rptr_gray_q1, %dst_rptr_gray_q1 after %10 : !llhd.sig<i4>
    %src_rptr_gray_q3 = llhd.load %src_rptr_gray_q.shadow : !llhd.ptr<i4>
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_rptr_gray_q2, %src_rptr_gray_q3 after %11 : !llhd.sig<i4>
    br ^if_exit
^if_true:
    %12 = llhd.const 0 : i4
    %13 = llhd.const 0 : i1
    %14 = llhd.insert_slice %12, %13, 0 : i4, i1
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_rptr_gray_q1, %14 after %15 : !llhd.sig<i4>
    %16 = llhd.const 0 : i4
    %17 = llhd.const 0 : i1
    %18 = llhd.insert_slice %16, %17, 0 : i4, i1
    %19 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %src_rptr_gray_q2, %18 after %19 : !llhd.sig<i4>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.proc @cdc_fifo_gray.param1.always_ff.322.1(%dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %src_wptr_gray_q: !llhd.sig<i4>, %dst_wptr_gray_q: !llhd.sig<i4>) -> (%dst_wptr_gray_q1: !llhd.sig<i4> , %dst_wptr_gray_q2: !llhd.sig<i4> ) {
    br ^0
^0:
    %1 = llhd.prb %dst_wptr_gray_q1 : !llhd.sig<i4>
    %dst_wptr_gray_q.shadow = llhd.var %1 : i4
    br ^init
^init:
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    llhd.wait (%dst_clk_i, %dst_rst_ni : !llhd.sig<i1>, !llhd.sig<i1>), ^check
^check:
    %2 = llhd.prb %dst_wptr_gray_q1 : !llhd.sig<i4>
    llhd.store %dst_wptr_gray_q.shadow, %2 : !llhd.ptr<i4>
    %dst_clk_i2 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %3 = llhd.const 0 : i1
    %4 = llhd.eq %dst_clk_i1, %3 : i1
    %5 = llhd.neq %dst_clk_i2, %3 : i1
    %posedge = llhd.and %4, %5 : i1
    %dst_rst_ni2 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %6 = llhd.const 0 : i1
    %7 = llhd.neq %dst_rst_ni1, %6 : i1
    %8 = llhd.eq %dst_rst_ni2, %6 : i1
    %negedge = llhd.and %8, %7 : i1
    %event_or = llhd.or %posedge, %negedge : i1
    cond_br %event_or, ^event, ^init
^event:
    %dst_rst_ni3 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %9 = llhd.not %dst_rst_ni3 : i1
    cond_br %9, ^if_true, ^if_false
^if_false:
    %src_wptr_gray_q1 = llhd.prb %src_wptr_gray_q : !llhd.sig<i4>
    %10 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_wptr_gray_q1, %src_wptr_gray_q1 after %10 : !llhd.sig<i4>
    %dst_wptr_gray_q3 = llhd.load %dst_wptr_gray_q.shadow : !llhd.ptr<i4>
    %11 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_wptr_gray_q2, %dst_wptr_gray_q3 after %11 : !llhd.sig<i4>
    br ^if_exit
^if_true:
    %12 = llhd.const 0 : i4
    %13 = llhd.const 0 : i1
    %14 = llhd.insert_slice %12, %13, 0 : i4, i1
    %15 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_wptr_gray_q1, %14 after %15 : !llhd.sig<i4>
    %16 = llhd.const 0 : i4
    %17 = llhd.const 0 : i1
    %18 = llhd.insert_slice %16, %17, 0 : i4, i1
    %19 = llhd.const #llhd.time<0s, 1d, 0e> : !llhd.time
    llhd.drv %dst_wptr_gray_q2, %18 after %19 : !llhd.sig<i4>
    br ^if_exit
^if_exit:
    br ^0
}

llhd.entity @cdc_fifo_gray.param1(%src_rst_ni: !llhd.sig<i1>, %src_clk_i: !llhd.sig<i1>, %src_data_i: !llhd.sig<i32>, %src_valid_i: !llhd.sig<i1>, %dst_rst_ni: !llhd.sig<i1>, %dst_clk_i: !llhd.sig<i1>, %dst_ready_i: !llhd.sig<i1>) -> (%src_ready_o: !llhd.sig<i1> , %dst_data_o: !llhd.sig<i32> , %dst_valid_o: !llhd.sig<i1> ) {
    %0 = llhd.const 0 : i3
    %fifo_widx = llhd.sig "sig" %0 : i3
    %1 = llhd.const 0 : i3
    %fifo_ridx = llhd.sig "sig1" %1 : i3
    %2 = llhd.const 0 : i1
    %fifo_write = llhd.sig "sig2" %2 : i1
    %3 = llhd.const 0 : i32
    %fifo_wdata = llhd.sig "sig3" %3 : i32
    %4 = llhd.const 0 : i32
    %fifo_rdata = llhd.sig "sig4" %4 : i32
    %5 = llhd.const 0 : i32
    %6 = llhd.const 0 : i32
    %7 = llhd.const 0 : i32
    %8 = llhd.const 0 : i32
    %9 = llhd.const 0 : i32
    %10 = llhd.const 0 : i32
    %11 = llhd.const 0 : i32
    %12 = llhd.const 0 : i32
    %13 = llhd.array %5, %6, %7, %8, %9, %10, %11, %12 : !llhd.array<8xi32>
    %fifo_data_q = llhd.sig "sig5" %13 : !llhd.array<8xi32>
    %14 = llhd.const 0 : i4
    %src_wptr_bin_q = llhd.sig "sig6" %14 : i4
    %15 = llhd.const 0 : i4
    %src_wptr_gray_q = llhd.sig "sig7" %15 : i4
    %16 = llhd.const 0 : i4
    %dst_rptr_bin_q = llhd.sig "sig8" %16 : i4
    %17 = llhd.const 0 : i4
    %dst_rptr_gray_q = llhd.sig "sig9" %17 : i4
    %18 = llhd.const 0 : i4
    %src_wptr_bin_d = llhd.sig "sig10" %18 : i4
    %19 = llhd.const 0 : i4
    %src_wptr_gray_d = llhd.sig "sig11" %19 : i4
    %20 = llhd.const 0 : i4
    %dst_rptr_bin_d = llhd.sig "sig12" %20 : i4
    %21 = llhd.const 0 : i4
    %dst_rptr_gray_d = llhd.sig "sig13" %21 : i4
    %22 = llhd.const 0 : i4
    %src_rptr_gray_q = llhd.sig "sig14" %22 : i4
    %23 = llhd.const 0 : i4
    %src_rptr_gray_q2 = llhd.sig "sig15" %23 : i4
    %24 = llhd.const 0 : i4
    %dst_wptr_gray_q = llhd.sig "sig16" %24 : i4
    %25 = llhd.const 0 : i4
    %dst_wptr_gray_q2 = llhd.sig "sig17" %25 : i4
    %26 = llhd.const 0 : i4
    %src_rptr_bin = llhd.sig "sig18" %26 : i4
    %27 = llhd.const 0 : i4
    %dst_wptr_bin = llhd.sig "sig19" %27 : i4
    %fifo_data_q1 = llhd.prb %fifo_data_q : !llhd.sig<!llhd.array<8xi32>>
    %fifo_ridx1 = llhd.prb %fifo_ridx : !llhd.sig<i3>
    %28 = llhd.const 0 : i32
    %29 = llhd.array_uniform %28 : !llhd.array<8xi32>
    %30 = llhd.shr %fifo_data_q1, %29, %fifo_ridx1 : (!llhd.array<8xi32>, !llhd.array<8xi32>, i3) -> !llhd.array<8xi32>
    %31 = llhd.extract_element %30, 0 : !llhd.array<8xi32> -> i32
    %32 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_rdata, %31 after %32 : !llhd.sig<i32>
    %33 = llhd.const 0 : i32
    %src_wptr_bin_q1 = llhd.prb %src_wptr_bin_q : !llhd.sig<i4>
    %34 = llhd.insert_slice %33, %src_wptr_bin_q1, 0 : i32, i4
    %35 = llhd.const 1 : i32
    %36 = addi %34, %35 : i32
    %37 = llhd.extract_slice %36, 0 : i32 -> i4
    %38 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_wptr_bin_d, %37 after %38 : !llhd.sig<i4>
    %39 = llhd.const 0 : i32
    %dst_rptr_bin_q1 = llhd.prb %dst_rptr_bin_q : !llhd.sig<i4>
    %40 = llhd.insert_slice %39, %dst_rptr_bin_q1, 0 : i32, i4
    %41 = llhd.const 1 : i32
    %42 = addi %40, %41 : i32
    %43 = llhd.extract_slice %42, 0 : i32 -> i4
    %44 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rptr_bin_d, %43 after %44 : !llhd.sig<i4>
    %src_wptr_bin_q2 = llhd.prb %src_wptr_bin_q : !llhd.sig<i4>
    %src_rptr_bin1 = llhd.prb %src_rptr_bin : !llhd.sig<i4>
    %45 = llhd.xor %src_wptr_bin_q2, %src_rptr_bin1 : i4
    %46 = llhd.const 8 : i32
    %47 = llhd.extract_slice %46, 0 : i32 -> i4
    %48 = llhd.neq %45, %47 : i4
    %49 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_ready_o, %48 after %49 : !llhd.sig<i1>
    %dst_rptr_bin_q2 = llhd.prb %dst_rptr_bin_q : !llhd.sig<i4>
    %dst_wptr_bin1 = llhd.prb %dst_wptr_bin : !llhd.sig<i4>
    %50 = llhd.xor %dst_rptr_bin_q2, %dst_wptr_bin1 : i4
    %51 = llhd.const 0 : i4
    %52 = llhd.const 0 : i1
    %53 = llhd.insert_slice %51, %52, 0 : i4, i1
    %54 = llhd.neq %50, %53 : i4
    %55 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_valid_o, %54 after %55 : !llhd.sig<i1>
    %src_wptr_bin_q3 = llhd.prb %src_wptr_bin_q : !llhd.sig<i4>
    %56 = llhd.extract_slice %src_wptr_bin_q3, 0 : i4 -> i3
    %57 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_widx, %56 after %57 : !llhd.sig<i3>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %58 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_wdata, %src_data_i1 after %58 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %59 = llhd.and %src_valid_i1, %src_ready_o1 : i1
    %60 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_write, %59 after %60 : !llhd.sig<i1>
    %dst_rptr_bin_q3 = llhd.prb %dst_rptr_bin_q : !llhd.sig<i4>
    %61 = llhd.extract_slice %dst_rptr_bin_q3, 0 : i4 -> i3
    %62 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %fifo_ridx, %61 after %62 : !llhd.sig<i3>
    %fifo_rdata1 = llhd.prb %fifo_rdata : !llhd.sig<i32>
    %63 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_data_o, %fifo_rdata1 after %63 : !llhd.sig<i32>
    %src_wptr_bin_d1 = llhd.prb %src_wptr_bin_d : !llhd.sig<i4>
    %64 = llhd.const 0 : i4
    %65 = llhd.sig "sig20" %64 : i4
    %66 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %65, %src_wptr_bin_d1 after %66 : !llhd.sig<i4>
    llhd.inst "inst" @binary_to_gray.param2(%65) -> (%src_wptr_gray_d) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    %dst_rptr_bin_d1 = llhd.prb %dst_rptr_bin_d : !llhd.sig<i4>
    %67 = llhd.const 0 : i4
    %68 = llhd.sig "sig21" %67 : i4
    %69 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %68, %dst_rptr_bin_d1 after %69 : !llhd.sig<i4>
    llhd.inst "inst1" @binary_to_gray.param3(%68) -> (%dst_rptr_gray_d) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    %src_rptr_gray_q21 = llhd.prb %src_rptr_gray_q2 : !llhd.sig<i4>
    %70 = llhd.const 0 : i4
    %71 = llhd.sig "sig22" %70 : i4
    %72 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %71, %src_rptr_gray_q21 after %72 : !llhd.sig<i4>
    llhd.inst "inst2" @gray_to_binary.param4(%71) -> (%src_rptr_bin) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    %dst_wptr_gray_q21 = llhd.prb %dst_wptr_gray_q2 : !llhd.sig<i4>
    %73 = llhd.const 0 : i4
    %74 = llhd.sig "sig23" %73 : i4
    %75 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %74, %dst_wptr_gray_q21 after %75 : !llhd.sig<i4>
    llhd.inst "inst3" @gray_to_binary.param9(%74) -> (%dst_wptr_bin) : (!llhd.sig<i4>) -> (!llhd.sig<i4>)
    llhd.inst "inst4" @cdc_fifo_gray.param1.always_ff.378.1(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst5" @cdc_fifo_gray.param1.always_ff.378.14(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst6" @cdc_fifo_gray.param1.always_ff.378.15(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst7" @cdc_fifo_gray.param1.always_ff.378.16(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst8" @cdc_fifo_gray.param1.always_ff.378.17(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst9" @cdc_fifo_gray.param1.always_ff.378.18(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst10" @cdc_fifo_gray.param1.always_ff.378.19(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst11" @cdc_fifo_gray.param1.always_ff.378.20(%src_rst_ni, %src_clk_i, %fifo_widx, %fifo_write, %fifo_wdata) -> (%fifo_data_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i3>, !llhd.sig<i1>, !llhd.sig<i32>) -> (!llhd.sig<!llhd.array<8xi32>>)
    llhd.inst "inst12" @cdc_fifo_gray.param1.initial.279.1() -> () : () -> ()
    llhd.inst "inst13" @cdc_fifo_gray.param1.always_ff.313.1(%src_rst_ni, %src_clk_i, %src_valid_i, %src_ready_o, %src_wptr_bin_d, %src_wptr_gray_d) -> (%src_wptr_bin_q, %src_wptr_gray_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst14" @cdc_fifo_gray.param1.always_ff.314.1(%dst_rst_ni, %dst_clk_i, %dst_valid_o, %dst_ready_i, %dst_rptr_bin_d, %dst_rptr_gray_d) -> (%dst_rptr_bin_q, %dst_rptr_gray_q) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst15" @cdc_fifo_gray.param1.always_ff.321.1(%src_rst_ni, %src_clk_i, %dst_rptr_gray_q, %src_rptr_gray_q) -> (%src_rptr_gray_q, %src_rptr_gray_q2) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
    llhd.inst "inst16" @cdc_fifo_gray.param1.always_ff.322.1(%dst_rst_ni, %dst_clk_i, %src_wptr_gray_q, %dst_wptr_gray_q) -> (%dst_wptr_gray_q, %dst_wptr_gray_q2) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i4>, !llhd.sig<i4>) -> (!llhd.sig<i4>, !llhd.sig<i4>)
}

llhd.proc @cdc_fifo_gray_tb.initial.250.0(%src_ready_o: !llhd.sig<i1>) -> (%src_rst_ni: !llhd.sig<i1> , %src_clk_i: !llhd.sig<i1> , %src_data_i: !llhd.sig<i32> , %src_valid_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const 0 : i32
    %2 = llhd.extract_slice %1, 0 : i32 -> i1
    %3 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %2 after %3 : !llhd.sig<i1>
    %4 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %4, ^5
^5:
    %6 = llhd.const 1 : i32
    %7 = llhd.extract_slice %6, 0 : i32 -> i1
    %8 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_rst_ni, %7 after %8 : !llhd.sig<i1>
    %9 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %9, ^10
^10:
    %11 = llhd.const 0 : i32
    %i = llhd.var %11 : i32
    br ^loop_body
^loop_body:
    %i1 = llhd.load %i : !llhd.ptr<i32>
    %12 = llhd.const 1000000 : i32
    %13 = cmpi "slt", %i1, %12 : i32
    cond_br %13, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    br ^loop_body1
^loop_body1:
    %src_ready_o1 = llhd.prb %src_ready_o : !llhd.sig<i1>
    %14 = llhd.not %src_ready_o1 : i1
    cond_br %14, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %i2 = llhd.load %i : !llhd.ptr<i32>
    %15 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_data_i, %i2 after %15 : !llhd.sig<i32>
    %16 = llhd.const 1 : i32
    %17 = llhd.extract_slice %16, 0 : i32 -> i1
    %18 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_valid_i, %17 after %18 : !llhd.sig<i1>
    %19 = llhd.const 1 : i32
    %20 = llhd.extract_slice %19, 0 : i32 -> i1
    %21 = llhd.const #llhd.time<1ps, 0d, 0e> : !llhd.time
    llhd.drv %src_clk_i, %20 after %21 : !llhd.sig<i1>
    %22 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %22, ^23
^loop_continue1:
    %24 = llhd.const 1 : i32
    %25 = llhd.extract_slice %24, 0 : i32 -> i1
    %26 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %25 after %26 : !llhd.sig<i1>
    %27 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %27, ^28
^23:
    %29 = llhd.const 0 : i32
    %30 = llhd.extract_slice %29, 0 : i32 -> i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %30 after %31 : !llhd.sig<i1>
    %32 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %32, ^33
^28:
    %34 = llhd.const 0 : i32
    %35 = llhd.extract_slice %34, 0 : i32 -> i1
    %36 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %src_clk_i, %35 after %36 : !llhd.sig<i1>
    %37 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %37, ^38
^38:
    br ^loop_body1
^33:
    %i3 = llhd.load %i : !llhd.ptr<i32>
    %39 = llhd.const 1 : i32
    %40 = addi %i3, %39 : i32
    llhd.store %i, %40 : !llhd.ptr<i32>
    %i4 = llhd.load %i : !llhd.ptr<i32>
    %41 = llhd.const 1 : i32
    %42 = addi %i4, %41 : i32
    %43 = llhd.const 0 : i32
    %44 = llhd.neq %42, %43 : i32
    br ^loop_body
}

llhd.proc @cdc_fifo_gray_tb.initial.251.0(%dst_data_o: !llhd.sig<i32>, %dst_valid_o: !llhd.sig<i1>) -> (%ERRORS: !llhd.sig<i32> , %dst_rst_ni: !llhd.sig<i1> , %dst_clk_i: !llhd.sig<i1> , %dst_ready_i: !llhd.sig<i1> ) {
    br ^0
^0:
    %1 = llhd.const #llhd.time<250ps, 0d, 0e> : !llhd.time
    llhd.wait  for %1, ^2
^2:
    %3 = llhd.const 0 : i32
    %4 = llhd.extract_slice %3, 0 : i32 -> i1
    %5 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %4 after %5 : !llhd.sig<i1>
    %6 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %6, ^7
^7:
    %8 = llhd.const 1 : i32
    %9 = llhd.extract_slice %8, 0 : i32 -> i1
    %10 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_rst_ni, %9 after %10 : !llhd.sig<i1>
    %11 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %11, ^12
^12:
    %13 = llhd.const 1 : i32
    %14 = llhd.extract_slice %13, 0 : i32 -> i1
    %15 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_ready_i, %14 after %15 : !llhd.sig<i1>
    %16 = llhd.const 0 : i32
    %i = llhd.var %16 : i32
    br ^loop_body
^loop_body:
    %i1 = llhd.load %i : !llhd.ptr<i32>
    %17 = llhd.const 1000000 : i32
    %18 = cmpi "slt", %i1, %17 : i32
    cond_br %18, ^loop_continue, ^loop_exit
^loop_exit:
    llhd.halt
^loop_continue:
    br ^loop_body1
^loop_body1:
    %dst_valid_o1 = llhd.prb %dst_valid_o : !llhd.sig<i1>
    %19 = llhd.not %dst_valid_o1 : i1
    cond_br %19, ^loop_continue1, ^loop_exit1
^loop_exit1:
    %20 = llhd.const 1 : i32
    %21 = llhd.extract_slice %20, 0 : i32 -> i1
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %21 after %22 : !llhd.sig<i1>
    %23 = llhd.const 0 : i32
    %i2 = llhd.load %i : !llhd.ptr<i32>
    %dst_data_o1 = llhd.prb %dst_data_o : !llhd.sig<i32>
    %24 = llhd.neq %i2, %dst_data_o1 : i32
    %25 = llhd.insert_slice %23, %24, 0 : i32, i1
    %ERRORS1 = llhd.prb %ERRORS : !llhd.sig<i32>
    %26 = addi %ERRORS1, %25 : i32
    %27 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %ERRORS, %26 after %27 : !llhd.sig<i32>
    %28 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %28, ^29
^loop_continue1:
    %30 = llhd.const 1 : i32
    %31 = llhd.extract_slice %30, 0 : i32 -> i1
    %32 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %31 after %32 : !llhd.sig<i1>
    %33 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %33, ^34
^29:
    %35 = llhd.const 0 : i32
    %36 = llhd.extract_slice %35, 0 : i32 -> i1
    %37 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %36 after %37 : !llhd.sig<i1>
    %38 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %38, ^39
^34:
    %40 = llhd.const 0 : i32
    %41 = llhd.extract_slice %40, 0 : i32 -> i1
    %42 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %dst_clk_i, %41 after %42 : !llhd.sig<i1>
    %43 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    llhd.wait  for %43, ^44
^44:
    br ^loop_body1
^39:
    %i3 = llhd.load %i : !llhd.ptr<i32>
    %45 = llhd.const 1 : i32
    %46 = addi %i3, %45 : i32
    llhd.store %i, %46 : !llhd.ptr<i32>
    %i4 = llhd.load %i : !llhd.ptr<i32>
    %47 = llhd.const 1 : i32
    %48 = addi %i4, %47 : i32
    %49 = llhd.const 0 : i32
    %50 = llhd.neq %48, %49 : i32
    br ^loop_body
}

llhd.entity @root() -> () {
    %0 = llhd.const 0 : i32
    %ERRORS = llhd.sig "ERRORS" %0 : i32
    %1 = llhd.const 1 : i1
    %src_rst_ni = llhd.sig "src_rst_ni" %1 : i1
    %2 = llhd.const 0 : i1
    %src_clk_i = llhd.sig "src_clk_i" %2 : i1
    %3 = llhd.const 0 : i32
    %src_data_i = llhd.sig "src_data_i" %3 : i32
    %4 = llhd.const 0 : i1
    %src_valid_i = llhd.sig "src_valid_i" %4 : i1
    %5 = llhd.const 0 : i1
    %src_ready_o = llhd.sig "src_ready_o" %5 : i1
    %6 = llhd.const 1 : i1
    %dst_rst_ni = llhd.sig "dst_rst_ni" %6 : i1
    %7 = llhd.const 0 : i1
    %dst_clk_i = llhd.sig "dst_clk_i" %7 : i1
    %8 = llhd.const 0 : i32
    %dst_data_o = llhd.sig "dst_data_o" %8 : i32
    %9 = llhd.const 0 : i1
    %dst_valid_o = llhd.sig "dst_valid_o" %9 : i1
    %10 = llhd.const 0 : i1
    %dst_ready_i = llhd.sig "dst_ready_i" %10 : i1
    %src_rst_ni1 = llhd.prb %src_rst_ni : !llhd.sig<i1>
    %11 = llhd.const 0 : i1
    %12 = llhd.sig "sig11" %11 : i1
    %13 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %12, %src_rst_ni1 after %13 : !llhd.sig<i1>
    %src_clk_i1 = llhd.prb %src_clk_i : !llhd.sig<i1>
    %14 = llhd.const 0 : i1
    %15 = llhd.sig "sig12" %14 : i1
    %16 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %15, %src_clk_i1 after %16 : !llhd.sig<i1>
    %src_data_i1 = llhd.prb %src_data_i : !llhd.sig<i32>
    %17 = llhd.const 0 : i32
    %18 = llhd.sig "sig13" %17 : i32
    %19 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %18, %src_data_i1 after %19 : !llhd.sig<i32>
    %src_valid_i1 = llhd.prb %src_valid_i : !llhd.sig<i1>
    %20 = llhd.const 0 : i1
    %21 = llhd.sig "sig14" %20 : i1
    %22 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %21, %src_valid_i1 after %22 : !llhd.sig<i1>
    %dst_rst_ni1 = llhd.prb %dst_rst_ni : !llhd.sig<i1>
    %23 = llhd.const 0 : i1
    %24 = llhd.sig "sig15" %23 : i1
    %25 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %24, %dst_rst_ni1 after %25 : !llhd.sig<i1>
    %dst_clk_i1 = llhd.prb %dst_clk_i : !llhd.sig<i1>
    %26 = llhd.const 0 : i1
    %27 = llhd.sig "sig16" %26 : i1
    %28 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %27, %dst_clk_i1 after %28 : !llhd.sig<i1>
    %dst_ready_i1 = llhd.prb %dst_ready_i : !llhd.sig<i1>
    %29 = llhd.const 0 : i1
    %30 = llhd.sig "sig17" %29 : i1
    %31 = llhd.const #llhd.time<0s, 0d, 1e> : !llhd.time
    llhd.drv %30, %dst_ready_i1 after %31 : !llhd.sig<i1>
    llhd.inst "inst" @cdc_fifo_gray.param1(%12, %15, %18, %21, %24, %27, %30) -> (%src_ready_o, %dst_data_o, %dst_valid_o) : (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst1" @cdc_fifo_gray_tb.initial.250.0(%src_ready_o) -> (%src_rst_ni, %src_clk_i, %src_data_i, %src_valid_i) : (!llhd.sig<i1>) -> (!llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i32>, !llhd.sig<i1>)
    llhd.inst "inst2" @cdc_fifo_gray_tb.initial.251.0(%dst_data_o, %dst_valid_o) -> (%ERRORS, %dst_rst_ni, %dst_clk_i, %dst_ready_i) : (!llhd.sig<i32>, !llhd.sig<i1>) -> (!llhd.sig<i32>, !llhd.sig<i1>, !llhd.sig<i1>, !llhd.sig<i1>)
}
