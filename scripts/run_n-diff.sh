#!/bin/zsh

opt=~/workspaces/thesis/circt-martin/build/bin/circt-opt
bin=~/workspaces/thesis/circt-martin/build/bin/llhd-sim
acc=~/workspaces/thesis/llhd-extras/examples/acc.mlir
graycode=~/workspaces/thesis/llhd-extras/examples/graycode.mlir
graycodecanon=~/workspaces/thesis/llhd-extras/examples/graycode_canon.mlir
lfsr=~/workspaces/thesis/llhd-extras/examples/lfsr_16bit.mlir
cdc2=~/workspaces/thesis/llhd-extras/examples/cdc_2phase.mlir
stream_delay=~/workspaces/thesis/llhd-extras/examples/stream_delay.mlir
fifo_v3=~/workspaces/thesis/llhd-extras/examples/fifo_v3.mlir
lzc=~/workspaces/thesis/llhd-extras/examples/lzc.mlir
rr=~/workspaces/thesis/llhd-extras/examples/rr_arb_tree.mlir
fir=~/workspaces/thesis/llhd-extras/examples/fir.mlir
cdcf=~/workspaces/thesis/llhd-extras/examples/cdc_fifo_gray.mlir

examples=(
    acc
    graycode
    lfsr
    cdc2
    stream_delay
    fifo_v3
    lzc
    rr
    fir
    cdcf
)

END=$1

echo "" > diff.txt

for example in "${examples[@]}"; do
    eval path="\${$example}"
    echo "Running $example"
    for i in {1..$END}
    do
        echo "iteration "$i"..."
        time='-n=1000'
        # flags='--trace-format=merged '+ '-n=1000 '  + ' -o=trace_${example}.txt'
        # flags='--trace-format=no-trace'
        #{ time $bin $path --trace-format=merged -n 1000 -o trace_${example}.txt ; } 2>> time.txt
        #echo "\n" >> time.txt
        /usr/bin/diff <($opt $path | $bin $time) <($bin $path $time) -q >> diff.txt
    done

done

# echo "graycode" > time.txt
# echo "running graycode"

# for i in $( seq 1 $END )
# do
#     flags='-o=trace_graycode.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $graycode $flags ; } 2>> time.txt
# done
# echo "lfsr" >> time.txt
# echo "running lfsr"

# for i in $( seq 1 $END )
# do
#     flags='trace_lfsr.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $lfsr -o $flags ; } 2>> time.txt
# done

# echo "cdc2" >> time.txt
# echo "running cdc_2phase"

# for i in $( seq 1 $END )
# do
#     flags='trace_cdc2.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $cdc2 -o $flags ; } 2>> time.txt
# done

# echo "stream_delay" >> time.txt
# echo "running stream_delay"

# for i in $( seq 1 $END )
# do
#     flags='trace_stream_delay.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $stream_delay -o $flags ; } 2>> time.txt
# done

# echo "fifo" >> time.txt
# echo "running fifo"

# for i in $( seq 1 $END )
# do
#     flags='trace_fifo.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $fifo_v3 -o $flags ; } 2>> time.txt
# done

# echo "lzc" >> time.txt
# echo "running lzc"

# for i in $( seq 1 $END )
# do
#     flags='trace_lzc.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $lzc -o $flags ; } 2>> time.txt
# done

# echo "rr" >> time.txt
# echo "running rr"

# for i in $( seq 1 $END )
# do
#     flags='trace_rr.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $rr -o $flags ; } 2>> time.txt
# done

# echo "fir" >> time.txt
# echo "running fir"

# for i in $( seq 1 $END )
# do
#     flags='trace_fir.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $fir -o $flags ; } 2>> time.txt
# done

# echo "cdcf" >> time.txt
# echo "running cdcf"

# for i in $( seq 1 $END )
# do
#     flags='trace_cdcf.txt'
#     #time $bin $dut -o $flags
#     echo "file loop "$i"..."
#     { time $bin $cdcf -o $flags ; } 2>> time.txt
# done
# #for i in 1 2 3 4 5
# #do
#     #echo "stdout loop "$i"..."
#     #{ time $bin $dut ; } 2>> time.txt
# #done
