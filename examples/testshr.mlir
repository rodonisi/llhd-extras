func @test(%0 : !llhd.array<3xi5>, %amnt : i32) {
    %1 = llhd.shr %0, %0, %amnt : ( !llhd.array<3xi5>,  !llhd.array<3xi5>, i32) -> !llhd.array<3xi5>
    return
}
