func @test() {
    %int = llhd.const 0 : i32
    %int1 = llhd.const 1 : i32
    %arr = constant dense<[1,2,3]> : vector<3xi32>

    %iPtr = llhd.var %int : i32
    //%arrPtr = llhd.var %arr : vector<3xi32>


    %iLd = llhd.load %iPtr : !llhd.ptr<i32>
    //%arrLd = llhd.load %arrPtr : !llhd.ptr<vector<3xi32>>
call @dummy(%iLd) : (i32) -> ()

    llhd.store %iPtr, %int1 : !llhd.ptr<i32>
    //llhd.store %arrPtr, %arr : !llhd.ptr<vector<3xi32>>

    return
}

func @dummy(%0 : i32) {
    return
}

llhd.entity @root() -> () {}
