#!/bin/zsh

bin=~/workspaces/thesis/circt-martin/build/bin/llhd-sim
graycode=~/workspaces/thesis/llhd-extras/examples/graycode.mlir
graycodecanon=~/workspaces/thesis/llhd-extras/examples/graycode_canon.mlir
lfsr=~/workspaces/thesis/llhd-extras/examples/lfsr_16bit.mlir
cdc2=~/workspaces/thesis/llhd-extras/examples/cdc_2phase.mlir
stream_delay=~/workspaces/thesis/llhd-extras/examples/stream_delay.mlir
fifo_v3=~/workspaces/thesis/llhd-extras/examples/fifo_v3.mlir
END=5

echo "fifo" > time.txt
echo "running fifo"

for i in $( seq 1 $END )
do
    flags='trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $fifo_v3 -o $flags ; } 2>> time.txt
done


#for i in 1 2 3 4 5
#do
    #echo "stdout loop "$i"..."
    #{ time $bin $dut ; } 2>> time.txt
#done
