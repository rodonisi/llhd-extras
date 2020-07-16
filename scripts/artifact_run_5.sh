#!/bin/sh

bin=llhd-blaze
dut=graycode.llhd

echo "dump to file" > time.txt

for i in 1 2 3 4 5
do
    flags='trace_'$i'.txt'
    #time $bin $dut -o $flags
    echo "file loop "$i"..."
    { time $bin $dut -t $flags ; } 2>> time.txt
done

echo "no dump" >> time.txt

for i in 1 2 3 4 5
do
    echo "stdout loop "$i"..."
    { time $bin $dut ; } 2>> time.txt
done

echo "opt dump" >> time.txt

for i in 1 2 3 4 5
do
    flags='trace_'$i'.txt'
    echo "stdout loop "$i"..."
    { time $bin $dut -t flags -O2 ; } 2>> time.txt
done
