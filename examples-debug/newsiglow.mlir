llhd.entity @root (%0 : !llhd.sig<i32>, %1 : !llhd.sig<i32>) -> (%2 : !llhd.sig<i10>) {
    %a = llhd.const 0 : i1
    %b = llhd.sig "sig" %a : i1
    %p0 = llhd.prb %0 : !llhd.sig<i32>
    //%p1 = llhd.prb %1 : !llhd.sig<i32>
    //%p2 = llhd.prb %2 : !llhd.sig<i10>
    //%p3 = llhd.prb %b : !llhd.sig<i1>
}
