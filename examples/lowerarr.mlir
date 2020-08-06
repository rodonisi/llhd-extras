//func@test (%0 : !llhd.array<3xi32>) -> (!llhd.array<2xi1>, !llhd.array<10xi1>) {
    //%1 = llhd.const 0 : i1
    //%2 = llhd.array %1, %1 : !llhd.array<2xi1>
    //%3 = llhd.array_uniform %1 : !llhd.array<10xi1>
    //return %2, %3 : !llhd.array<2xi1>, !llhd.array<10xi1>
//}

llhd.entity @root () -> () {
    %0 = llhd.const 0 : i32
    %1 = llhd.array %0, %0, %0, %0 : !llhd.array<4xi32>
    %2 = llhd.sig "s" %1 : !llhd.array<4xi32>
    %s2 = llhd.sig "s2" %1 : !llhd.array<4xi32>
    %3 = llhd.const 0xff : i32
    %4 = llhd.array_uniform %3 : !llhd.array<4xi32>
    %t = llhd.const #llhd.time<0ns, 0d, 1e> : !llhd.time
    llhd.drv %2, %4 after %t : !llhd.sig<!llhd.array<4xi32>>
    %5 = llhd.prb %2 : !llhd.sig<!llhd.array<4xi32>>
    llhd.drv %s2, %5 after %t : !llhd.sig<!llhd.array<4xi32>>
    //%6 = llhd.extract_element %1, 0 : !llhd.array<4xi32> -> i32
    //%7 = llhd.extract_element %2, 0 : !llhd.sig<!llhd.array<4xi32>> -> !llhd.sig<i32>
    llhd.inst "root" @root () -> () : () -> ()
    %8 = llhd.dyn_extract_element %1, %0 : (!llhd.array<4xi32>, i32) -> i32
    %9 = llhd.extract_slice %1, 1 : !llhd.array<4xi32> -> !llhd.array<2xi32>
    %10 = llhd.insert_slice %1, %9, 1 : !llhd.array<4xi32>, !llhd.array<2xi32>
}

