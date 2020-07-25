#!/bin/zsh

bin=~/workspaces/thesis/circt-martin/build/bin/llhd-sim
dut=~/workspaces/thesis/llhd-extras/examples/graycode.mlir

echo "" > time.txt

for i in 1 2 3 4 5
do
    flags='trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $dut -o $flags ; } 2>> time.txt
done

for i in 1 2 3 4 5
do
    echo "stdout loop "$i"..."
    { time $bin $dut ; } 2>> time.txt
done
