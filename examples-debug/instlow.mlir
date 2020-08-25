llhd.entity @root () -> () {
  %0 = llhd.const 1 : i1
  %1 = llhd.sig "toggle" %0 : i1
    llhd.inst "0" @root () -> () : () -> ()
    llhd.inst "1" @onein (%1) -> () : (!llhd.sig<i1>) -> ()
    llhd.inst "proc" @p () -> (%1) : () -> (!llhd.sig<i1>)
}

llhd.entity @onein (%0 : !llhd.sig<i1>) -> () {}

llhd.proc @p () -> (%a : !llhd.sig<i1>) {
  br ^end
^end:
  llhd.halt
}
