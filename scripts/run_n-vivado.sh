#!/bin/zsh

opt=~/workspaces/thesis/circt-martin/build/bin/circt-opt
bin=~/workspaces/thesis/circt-martin/build/bin/llhd-sim
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
        t='-T=100000'
        trace='--trace-format=named-only'
        root='--root='$example

        # flags='--trace-format=merged '+ '-n=1000 '  + ' -o=trace_${example}.txt'
        # flags='--trace-format=no-trace'
        # { time $bin $example_path --trace-format=merged -n 1000 -o trace_${example}.txt ; } 2>> time.txt
        #echo "\n" >> time.txt
        tmp=tmp.txt
        python $py $vcd_path -o $tmp $t

        diff $tmp <($bin $example_path $t $trace $root) >> diff.txt
    done

done

# echo "graycode_tb" > time.txt
# echo "running graycode_tb"

# for i in $( seq 1 $END )
# do
#     flags='-o=trace_graycode.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $graycode_tb $flags ; } 2>> time.txt
# done
# echo "lfsr_16bit_tb" >> time.txt
# echo "running lfsr_16bit_tb"

# for i in $( seq 1 $END )
# do
#     flags='trace_lfsr.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $lfsr_16bit_tb -o $flags ; } 2>> time.txt
# done

# echo "cdc_2phase_tb" >> time.txt
# echo "running cdc_2phase"

# for i in $( seq 1 $END )
# do
#     flags='trace_cdc2.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $cdc_2phase_tb -o $flags ; } 2>> time.txt
# done

# echo "stream_delay_tb" >> time.txt
# echo "running stream_delay_tb"

# for i in $( seq 1 $END )
# do
#     flags='trace_stream_delay.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $stream_delay_tb -o $flags ; } 2>> time.txt
# done

# echo "fifo" >> time.txt
# echo "running fifo"

# for i in $( seq 1 $END )
# do
#     flags='trace_fifo.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $fifo_v3_tb -o $flags ; } 2>> time.txt
# done

# echo "lzc_tb" >> time.txt
# echo "running lzc_tb"

# for i in $( seq 1 $END )
# do
#     flags='trace_lzc.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $lzc_tb -o $flags ; } 2>> time.txt
# done

# echo "rr_arb_tree_tb" >> time.txt
# echo "running rr_arb_tree_tb"

# for i in $( seq 1 $END )
# do
#     flags='trace_rr.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $rr_arb_tree_tb -o $flags ; } 2>> time.txt
# done

# echo "fir_tb" >> time.txt
# echo "running fir_tb"

# for i in $( seq 1 $END )
# do
#     flags='trace_fir.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $fir_tb -o $flags ; } 2>> time.txt
# done

# echo "cdc_fifo_gray_tb" >> time.txt
# echo "running cdc_fifo_gray_tb"

# for i in $( seq 1 $END )
# do
#     flags='trace_cdcf.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $cdc_fifo_gray_tb -o $flags ; } 2>> time.txt
# done
# #for i in 1 2 3 4 5
# #do
#     #echo "stdout loop "$i"..."
#     #{ time $bin $dut ; } 2>> time.txt
# #done
