

  llhd.entity @acc (%arg0 : !llhd.sig<i1>, %arg1 : !llhd.sig<i32>, %arg2 : !llhd.sig<i1>) -> (%arg3 : !llhd.sig<i32>) {
    %0 = llhd.const 0 : i32
    %1 = llhd.sig "d" %0 : i32
    llhd.inst "acc_ff" @acc_ff(%arg0, %1) -> (%arg3) : (!llhd.sig<i1>, !llhd.sig<i32>) -> !llhd.sig<i32>
    llhd.inst "acc_comb" @acc_comb(%arg3, %arg1, %arg2) -> (%1) : (!llhd.sig<i32>, !llhd.sig<i32>, !llhd.sig<i1>) -> !llhd.sig<i32>
  }
  llhd.entity @acc_ff (%arg0 : !llhd.sig<i1>, %arg1 : !llhd.sig<i32>) -> (%arg2 : !llhd.sig<i32>) {
    %0 = llhd.const #llhd.time<1ns, 0d, 0e> : !llhd.time
    %1 = llhd.prb %arg0 : !llhd.sig<i1>
    %2 = llhd.prb %arg1 : !llhd.sig<i32>
    llhd.reg %arg2, (%2, "rise" %1 after %0 : i32) : !llhd.sig<i32>
  }
  llhd.entity @acc_comb (%arg0 : !llhd.sig<i32>, %arg1 : !llhd.sig<i32>, %arg2 : !llhd.sig<i1>) -> (%arg3 : !llhd.sig<i32>) {
    %0 = llhd.const #llhd.time<2ns, 0d, 0e> : !llhd.time
    %1 = llhd.prb %arg0 : !llhd.sig<i32>
    %2 = llhd.prb %arg2 : !llhd.sig<i1>
    %3 = llhd.prb %arg1 : !llhd.sig<i32>
    %4 = addi %1, %3 : i32
    %5 = select %2, %4, %1 : i32
    llhd.drv %arg3, %5 after %0 : !llhd.sig<i32>
  }
}
