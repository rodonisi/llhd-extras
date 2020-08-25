func @test_array(%ci1 : i1, %ci32 : i32) {
  %0 = llhd.array %ci1, %ci1, %ci1 : !llhd.array<3xi1>
  %1 = llhd.array %ci32, %ci32, %ci32, %ci32 : !llhd.array<4xi32>

  return
}

func @test_array_uniform(%ci1 : i1, %ci32 : i32) {
  %0 = llhd.array_uniform %ci1 : !llhd.array<3xi1>
  %1 = llhd.array_uniform %ci32 : !llhd.array<4xi32>

  return
}
