llhd.entity @root () -> () {
    %0 = llhd.const 1 : i1
    %1 = llhd.const 2 : i9
    %2 = llhd.const 3 : i9
    %3 = llhd.tuple %0, %1, %2 : tuple<i1, i9, i9>
    %4 = llhd.sig "s" %3 : tuple<i1, i9, i9>
    %6 = llhd.extract_element %4, 0 : !llhd.sig<tuple<i1, i9, i9>> -> !llhd.sig<i1>
    %7 = llhd.prb %6 : !llhd.sig<i1>
    %8 = llhd.not %7 : i1
    %9 = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %6, %8 after %9 : !llhd.sig<i1>
}
