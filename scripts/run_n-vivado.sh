#!/bin/zsh

opt=~/workspaces/thesis/circt-m/build/bin/circt-opt
bin=~/workspaces/thesis/circt-m/build/bin/llhd-sim
py=~/workspaces/thesis/llhd-extras/convert_vcd/convert_vcd.py
python=/Users/simon/.pyenv/shims/python
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

graycode_v=~/workspaces/thesis/llhd-extras/vivado-vcd/graycode.vcd
lfsr_16bit_v=~/workspaces/thesis/llhd-extras/vivado-vcd/lfsr.vcd
cdc_2phase_v=~/workspaces/thesis/llhd-extras/vivado-vcd/cdc_2phase.vcd
stream_delay_v=~/workspaces/thesis/llhd-extras/vivado-vcd/stream_delay.vcd
fifo_v3_v=~/workspaces/thesis/llhd-extras/vivado-vcd/fifo_v3.vcd
lzc_v=~/workspaces/thesis/llhd-extras/vivado-vcd/lzc.vcd
rr_arb_tree_v=~/workspaces/thesis/llhd-extras/vivado-vcd/rr_arb_tree.vcd
fir_v=~/workspaces/thesis/llhd-extras/vivado-vcd/fir.vcd
cdc_fifo_gray_v=~/workspaces/thesis/llhd-extras/vivado-vcd/cdc_fifo.vcd
snitch_v=~/workspaces/thesis/llhd-extras/vivado-vcd/snitch.vcd

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

echo "" > diff.txt

for example in "${examples[@]}"; do
    echo '==----------------------------------------------------==' >> diff.txt
    echo '== '$example >> diff.txt
    echo '==----------------------------------------------------==' >> diff.txt
    eval example_path="\${$example}"
    eval vcd=${example:0:$((${#example}-2))}v
    eval vcd_path="\${$vcd}"
    echo "Running $example"
    for i in {1..$END}
    do
        echo "iteration "$i"..."
        echo "===--------------------------------------------------------------" >> diff.txt
        t='-T=1000000'
        trace='--trace-format=named-only'
        root='--root='$example

        # flags='--trace-format=merged '+ '-n=1000 '  + ' -o=trace_${example}.txt'
        # flags='--trace-format=no-trace'
        # { time $bin $example_path --trace-format=merged -n 1000 -o trace_${example}.txt ; } 2>> time.txt
        #echo "\n" >> time.txt
        tmp=tmp.txt
        python $py $vcd_path -o $tmp $t

        diff <($bin $example_path $t $trace $root) $tmp >> diff.txt
    done

done
