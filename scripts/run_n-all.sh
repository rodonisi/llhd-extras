#!/bin/zsh

bin=~/workspaces/thesis/circt-m/build/bin/llhd-sim
acc=~/workspaces/thesis/llhd-extras/examples/acc.mlir
graycode_tb=~/workspaces/thesis/llhd-extras/examples/graycode.mlir
graycodecanon=~/workspaces/thesis/llhd-extras/examples/graycode_canon.mlir
lfsr_16bit_tb=~/workspaces/thesis/llhd-extras/examples/lfsr_16bit.mlir
cdc_2phase_tb=~/workspaces/thesis/llhd-extras/examples/cdc_2phase.mlir
stream_delay_tb=~/workspaces/thesis/llhd-extras/examples/stream_delay.mlir
fifo_v3_tb=~/workspaces/thesis/llhd-extras/examples/fifo_v3.mlir
lzc_tb=~/workspaces/thesis/llhd-extras/examples/lzc.mlir
rr_arb_tree_tb=~/workspaces/thesis/llhd-extras/examples/rr_arb_tree.mlir
fir_tb=~/workspaces/thesis/llhd-extras/examples/fir.mlir
cdc_fifo_gray_tb=~/workspaces/thesis/llhd-extras/examples/cdc_fifo_gray.mlir
snitch_tb=~/workspaces/thesis/llhd-extras/examples/snitch.mlir

examples=(
    graycode_tb
    lfsr_16bit_tb
    cdc_2phase_tb
    stream_delay_tb
    fifo_v3_tb
    lzc_tb
    rr_arb_tree_tb
    fir_tb
    cdc_fifo_gray_tb
    snitch_tb
)

END=$1

echo "" > time.txt

for example in "${examples[@]}"; do
    echo '==----------------------------------------------------==' >> diff.txt
    echo '== '$example >> time.txt
    echo '==----------------------------------------------------==' >> diff.txt
    eval example_path="\${$example}"
    echo "Running $example"
    for i in {1..$END}
    do
        echo "iteration "$i"..."
        echo "===--------------------------------------------------------------" >> diff.txt
	{ time $bin $example_path --root=$example --trace-format=no-trace --report-timing ; } 2>> time.txt
        echo "\n" >> time.txt
    done

done
