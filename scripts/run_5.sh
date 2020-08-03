#!/bin/zsh

bin=~/workspaces/thesis/circt-martin/build/bin/llhd-sim
graycode=~/workspaces/thesis/llhd-extras/examples/graycode.mlir
graycodecanon=~/workspaces/thesis/llhd-extras/examples/graycode_canon.mlir
lfsr=~/workspaces/thesis/llhd-extras/examples/lfsr_16bit.mlir
cdc2=~/workspaces/thesis/llhd-extras/examples/cdc_2phase.mlir
stream_delay=~/workspaces/thesis/llhd-extras/examples/stream_delay.mlir
END=5

echo "graycode" > time.txt
echo "running graycode"

for i in $( seq 1 $END )
do
    flags='-o=trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $graycode $flags ; } 2>> time.txt
done

echo "lfsr" >> time.txt
echo "running lfsr"

for i in $( seq 1 $END )
do
    flags='trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $lfsr -o $flags ; } 2>> time.txt
done

echo "cdc2" >> time.txt
echo "running cdc_2phase"

for i in $( seq 1 $END )
do
    flags='trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $cdc2 -o $flags ; } 2>> time.txt
done

echo "stream_delay" >> time.txt
echo "running stream_delay"

for i in $( seq 1 $END )
do
    flags='trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $stream_delay -o $flags ; } 2>> time.txt
done



#for i in 1 2 3 4 5
#do
    #echo "stdout loop "$i"..."
    #{ time $bin $dut ; } 2>> time.txt
#done
