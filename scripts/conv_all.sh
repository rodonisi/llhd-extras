#!/bin/zsh

bin=llhd-conv
v6_path=~/workspaces/thesis/llhd-extras/examples-llhd-v0.6.0
v6_dst=~/workspaces/thesis/llhd-extras/examples
v10_path=~/workspaces/thesis/llhd-extras/examples-llhd-v0.10.0
v10_dst=~/workspaces/thesis/llhd-extras/examples-v0.10.0

examples=(
    graycode
    lfsr_16bit
    cdc_2phase
    stream_delay
    fifo_v3
    lzc
    rr_arb_tree
    fir
    cdc_fifo_gray
    snitch
)


for example in "${examples[@]}"; do
    $bin --output-format="mlir" -i $v6_path/$example.llhd -o $v6_dst/$example.mlir
done

for example in "${examples[@]}"; do
    $bin --output-format="mlir" -i $v10_path/$example.llhd -o $v10_dst/$example.mlir
done
