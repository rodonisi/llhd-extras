llhd.entity @root () -> () {
    %0 = llhd.const 0 : i20
    %2 = llhd.sig "sig" %0 : i20
    llhd.inst "proc" @proc () -> (%2) : () -> (!llhd.sig<i20>)
}

llhd.proc @proc () -> (%a : !llhd.sig<i20>) {
    br ^entry
^entry:
    %1 = llhd.const 1 : i32
    %3 = llhd.var %1 : i32
    %t = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    br ^next
^next:
    %4 = llhd.load %3 : !llhd.ptr<i32>
 %24 = llhd.extract_slice %4, 0 : i32 -> i20
    llhd.drv %a, %24 after %t : !llhd.sig<i20>
    llhd.halt
}
