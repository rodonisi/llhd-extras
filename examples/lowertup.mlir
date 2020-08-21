llhd.entity @root () -> () {
    %7 = llhd.const 0 : i5
    %8 = llhd.const 0 : i1
    %9 = llhd.const 0 : i3
    %10 = llhd.const 0 : i2
    %11 = llhd.tuple %7, %8, %9, %10 : tuple<i5, i1, i3, i2>
    %12 = llhd.array %11 : !llhd.array<1xtuple<i5, i1, i3, i2>>
    %mem_n = llhd.sig "sig7" %12 : !llhd.array<1xtuple<i5, i1, i3, i2>>   %0 = llhd.const 0 : i1
    llhd.inst "i" @root () -> () : () -> ()
}

func @test (%0 : tuple<i1, i2, i3>)  {
    return
}
