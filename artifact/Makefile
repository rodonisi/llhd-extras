# This is an example makefile that steps through the compilation and execution
# of the circuits described in the LLHD paper.

# Executable paths
MOORE      ?= moore
LLHD_SIM   ?= llhd-sim
LLHD_BLAZE ?= llhd-blaze
LLHD_EST   ?= llhd-est

# Designs
DESIGNS += graycode
DESIGNS += fir
DESIGNS += lfsr_16bit
DESIGNS += lzc
DESIGNS += fifo_v3
DESIGNS += cdc_2phase
DESIGNS += cdc_fifo_gray
DESIGNS += rr_arb_tree
DESIGNS += stream_delay
DESIGNS += snitch

# Show some help.
help:
	@echo "Usage:"
	@echo "  make help         Show this message"
	@echo "  make readme       Show the README"
	@echo "  make versions     Show installed tool versions"
	@echo "  make llhd         Compile SV to LLHD with moore"
	@echo "  make vcd          Simulate designs with llhd-sim"
	@echo "  make blaze        Simulate designs with llhd-blaze"
	@echo "  make blaze-trace  Produce llhd-blaze change trace"
	@echo "  make blaze-time   Measure llhd-blaze simulation time"
	@echo "  make size-sv      Print SystemVerilog input size"
	@echo "  make size-asm     Print LLHD assembly size"
	@echo "  make size-bc      Estimate LLHD bitcode size"
	@echo "  make size-mem     Print LLHD in-memory size"
	@echo
	@echo "Individual Designs:"
	@echo "  make llhd/DESIGN.llhd"
	@echo "  make vcd/DESIGN.vcd"
	@echo "  make blaze/DESIGN.log"
	@echo "  make blaze/DESIGN.trace"

# Dump the installed tool versions.
versions:
	@$(MOORE) --version
	@$(LLHD_SIM) --version
	@$(LLHD_BLAZE) --version

# Show the README file.
readme:
	@less README.md


# Compilation from SV to LLHD using the moore compiler.
llhd/%.llhd: src/%.sv src/%_tb.sv
	@mkdir -p llhd
	$(MOORE) $^ -e $*_tb > $@
	@if [ $* = cdc_fifo_gray ]; then patch $@ src/cdc_fifo_gray.patch; fi

llhd/cdc_fifo_gray.llhd: src/graycode.sv
llhd/stream_delay.llhd: src/counter.sv src/delta_counter.sv src/lfsr_16bit.sv
llhd/lzc.llhd: src/lfsr_16bit.sv

llhd: $(patsubst %, llhd/%.llhd, $(DESIGNS))


# Generate VCD traces using the llhd-sim reference simulator.
#
# The -N 20000 option limits the output to the first 20000 cycles. Some of the
# test cases are fairly long-running, and llhd-sim is pretty slow. Increase this
# number at your own risk.
vcd/%.vcd: llhd/%.llhd
	@mkdir -p vcd
	$(LLHD_SIM) $^ -N 20000 -o $@

vcd: $(patsubst %, vcd/%.vcd, $(DESIGNS))


# Simulate the design using the LLVM-accelerated LLHD simulator.
#
# See considerations for -N 20000 above.
blaze/%.log: llhd/%.llhd
	@mkdir -p blaze
	time -- $(LLHD_BLAZE) $^ -vvv | tee $@ 2>&1

blaze/%.trace: llhd/%.llhd
	$(LLHD_BLAZE) $^ -vvv -t $@ -N 20000

blaze: $(patsubst %, blaze/%.log, $(DESIGNS))
blaze-trace: $(patsubst %, blaze/%.trace, $(DESIGNS))

blaze-time: llhd
	@for d in $(DESIGNS); do \
		printf '%-14s %5.2f\n' $$d $$(/usr/bin/time -f '%e' -- $(LLHD_BLAZE) llhd/$$d.llhd 2>&1); \
	done


# Evaluate the size of the SystemVerilog source files.
size-sv:
	@for d in $(DESIGNS); do \
		printf '%-14s %5.1f\n' $$d $$(cat src/$${d}.sv src/$${d}_tb.sv | wc -c | awk '{print $$1/1000}'); \
	done

# Evaluate the size of the LLHD human-readable assembly.
size-asm: llhd
	@for d in $(DESIGNS); do \
		printf '%-14s %5.1f\n' $$d $$(cat llhd/$$d.llhd | wc -c | awk '{print $$1/1000}'); \
	done

# Estimate the size of the LLHD bitcode.
size-bc: llhd
	@for d in $(DESIGNS); do \
		printf '%-14s %6.1f\n' $$d $$($(LLHD_EST) llhd/$$d.llhd | head -n1 | awk '{print $$3/1000}'); \
	done

# Estimate the size of the LLHD in-memory representation.
size-mem: llhd
	@for d in $(DESIGNS); do \
		printf '%-14s %6.1f\n' $$d $$($(LLHD_EST) llhd/$$d.llhd | tail -n1 | awk '{print $$2/1000}'); \
	done

.PHONY: help versions readme llhd vcd blaze blaze-trace blaze-time size-sv size-asm size-bc size-mem
