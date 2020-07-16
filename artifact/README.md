# LLHD PLDI Artifact

This is the LLHD PLDI Artifact submission. We provide a docker container to simplify execution of the source code. The enclosed Makefile provides targets that guide through the evaluation process.

Also visit http://llhd.io/.


## Contents

- `llhd-blaze/`: Source code of the LLVM-accelerated LLHD simulator
- `src/`: HDL source files
- `Makefile`: Steps to evaluate the code

The docker image contains the following relevant binaries in the PATH:

- `moore`: The SystemVerilog to LLHD compiler
- `llhd-sim`: The LLHD reference simulator
- `llhd-blaze`: The LLVM-accelerated LLHD simulator


## Getting Started

Build and run the docker image as follows. This will drop you into a bash console.
```sh
$ docker image build -t llhd .
$ docker run -it llhd
```

Inspect the environment and the installed tool versions as follows:
```sh
$ make versions
```

To compile the provided SV source code to LLHD, run the following command. This produces a corresponding `llhd/*.llhd` for each design.
```sh
$ make llhd
```

To run the generated LLHD files through the LLHD reference simulator, and generate a VCD trace, run the following command. This produces a corresponding `vcd/*.vcd` file for each design. Note that only the first few cycles are simulated to keep runtimes down. Adjust the Makefile as desired to change this.
```sh
$ make vcd
```

You can view these VCD files with tools such as `gtkwave`, which is not provided as part of the artifact.

To run the generated LLHD files through the LLVM-accelerated LLHD simulator, run the following commands. The first does not produce any output to report execution times. The latter produces a simulation trace for the first few cycles.
```sh
$ make blaze        # timed
$ make blaze-trace  # with trace
```


## Outputs

These runs generate outputs in:

- `llhd/`: The output of the moore compiler.
- `vcd/`: The VCD traces of the reference simulator.
- `blaze/`: The execution log and debug trace of the llhd-blaze simulator. *Note that log files are expected to be empty unless a simulation error occurred.*

Feel free to toy with the files in `src/` to see how they translate to LLHD, and how they simulate with llhd-sim and llhd-blaze.


## Reproducing Paper Results Step-by-Step

This artifact can be used to reproduce the following numerical results from our paper:
- Table 2: Simulation time with `llhd-sim` (column 5)
- Table 4: Data sizes in LLHD (columns 2 to 5)

The reproduction of VCD traces exactly matching those of commercial simulators is beyond the scope of this artifact due to the quickly-changing nature of the prototype implementation.

The only other numerical result not supported by this artifact is the simulation time with a commercial simulator (column 4 in Table 2), because that would require a license for such a simulator, which we cannot provide.

Instructions for reproducing results follow. See the end of this file for a dump of `lscpu` on the reference machine.


### Simulation Time (Table 2, Column 5)

The `llhd-blaze` simulation time table, indicating the wall clock execution time (in seconds) of the JIT-accelerated simualtor, can be reproduced as follows:
```sh
$ make blaze-time
```

Note that the execution times differ from the ones present in the original paper submission due to the bug fixes and further evolution of the prototype, and adjustment of the simulation ranges, as outlined in the rebuttal.

The simulation time naturally depends on the execution environment (i.e., processor and memory architecture as well as software stack). We notice that execution time within the docker image on our reference machine is between 10%-30% higher than when executed outside of docker. We reproduce both of our execution times here for your reference.

The final camera-ready paper will reflect these up-to-date execution times.

#### On Reference Machine (without docker)
```
graycode        6.33
fir            10.35
lfsr_16bit     14.53
lzc             3.23
fifo_v3         5.92
cdc_2phase      9.39
cdc_fifo_gray   8.72
rr_arb_tree    10.92
stream_delay    4.28
snitch         23.44
```

#### On Reference Machine (within docker)
```
graycode        8.73
fir            16.22
lfsr_16bit     22.81
lzc             4.77
fifo_v3         9.62
cdc_2phase     15.18
cdc_fifo_gray  14.45
rr_arb_tree    15.09
stream_delay    7.45
snitch         38.47
```


### Data Sizes in LLHD (Table 4)

The sizes reported in each row of Table 4 correspond to a design that can be simulated in isolation. As such, the sizes comprise both the implementation and the testbench of a module.

Note that due to the quick rate of change of the prototype, sizes have changed slightly with respect to the initial paper submission. Addition of source file location tracking and other information to the IR have generally increased the in-memory footprint since.

The final camera-ready paper will reflect these up-to-date sizes.

#### Size of SystemVerilog Source Code (Column 2)

This reports the size of the source code of each design in kilobytes:
```sh
$ make size-sv
```

The sizes are machine-independent and should report as follows:
```
graycode         3.0
fir              1.2
lfsr_16bit       2.4
lzc              4.6
fifo_v3          7.1
cdc_2phase       6.3
cdc_fifo_gray    7.1
rr_arb_tree     11.2
stream_delay     5.9
snitch         174.1
```

#### Size of LLHD Text (Column 3)

Use the following command to report the size of the LLHD IR text of each design in kilobytes:
```sh
$ make size-asm
```

We obtain the following sizes:
```
graycode        23.4
fir             12.9
lfsr_16bit       4.9
lzc             59.4
fifo_v3         20.5
cdc_2phase      17.7
cdc_fifo_gray   37.0
rr_arb_tree     39.4
stream_delay    18.7
snitch         348.4
```

#### Size of LLHD Bitcode (Column 4)

Use the following command to estimate the size of the LLHD IR bitcode of each design in kilobytes. Note that this is an estimate, since the actual bitcode is not yet implemented. The final camera-ready paper will reflect this information.
```sh
$ make size-bc
```

We obtain the following sizes:
```
graycode          7.6
fir               3.8
lfsr_16bit        1.8
lzc              14.1
fifo_v3           6.5
cdc_2phase        6.0
cdc_fifo_gray    12.0
rr_arb_tree       9.9
stream_delay      6.7
snitch           93.2
```

#### Size of LLHD in Memory (Column 5)

Use the following command to determine the size of the LLHD in-memory representation of each design in kilobytes:
```sh
$ make size-mem
```

We obtain the following sizes:
```
graycode         86.3
fir              52.0
lfsr_16bit       20.3
lzc             215.4
fifo_v3          78.8
cdc_2phase       69.8
cdc_fifo_gray   138.7
rr_arb_tree     145.5
stream_delay     75.7
snitch         1216.9
```


### Reference Machine `lscpu`

The output of `lscpu` on the reference machine used to benchmark in the paper is as follows:
```
Architecture:                    x86_64
CPU op-mode(s):                  32-bit, 64-bit
Byte Order:                      Little Endian
Address sizes:                   39 bits physical, 48 bits virtual
CPU(s):                          8
On-line CPU(s) list:             0-7
Thread(s) per core:              2
Core(s) per socket:              4
Socket(s):                       1
NUMA node(s):                    1
Vendor ID:                       GenuineIntel
CPU family:                      6
Model:                           60
Model name:                      Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz
Stepping:                        3
CPU MHz:                         1310.776
CPU max MHz:                     3900.0000
CPU min MHz:                     800.0000
BogoMIPS:                        7006.05
Virtualization:                  VT-x
L1d cache:                       128 KiB
L1i cache:                       128 KiB
L2 cache:                        1 MiB
L3 cache:                        8 MiB
NUMA node0 CPU(s):               0-7
Vulnerability Itlb multihit:     KVM: Mitigation: Split huge pages
Vulnerability L1tf:              Mitigation; PTE Inversion; VMX conditional cache flushes, SMT vulnerable
Vulnerability Mds:               Mitigation; Clear CPU buffers; SMT vulnerable
Vulnerability Meltdown:          Mitigation; PTI
Vulnerability Spec store bypass: Mitigation; Speculative Store Bypass disabled via prctl and seccomp
Vulnerability Spectre v1:        Mitigation; usercopy/swapgs barriers and __user pointer sanitization
Vulnerability Spectre v2:        Mitigation; Full generic retpoline, IBPB conditional, IBRS_FW, STIBP condition
                                 al, RSB filling
Vulnerability Tsx async abort:   Not affected
Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflus
                                 h dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constan
                                 t_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmpe
                                 rf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtp
                                 r pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx
                                  f16c rdrand lahf_lm abm cpuid_fault epb invpcid_single pti ssbd ibrs ibpb sti
                                 bp tpr_shadow vnmi flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2
                                 smep bmi2 erms invpcid xsaveopt dtherm ida arat pln pts md_clear flush_l1d
```
