# FROM rust
FROM ubuntu:18.04 as toolchain

ENV USER=root
ENV PATH=/root/.cargo/bin:$PATH

# Install dependencies
RUN apt-get update && apt-get install -y build-essential curl

# Install Rust
RUN curl -sSf https://sh.rustup.rs | sh -s -- -y

# Install moore and llhd-sim
RUN cargo install --git https://github.com/fabianschuiki/moore.git --rev a579ce7
RUN cargo install --git https://github.com/fabianschuiki/llhd-sim.git --rev 58d895e

# Install LLVM 8
RUN apt-get install -y llvm-8
RUN apt-get install -y zlib1g-dev

# Setup a working directory
WORKDIR /home/root

# Install llhd-blaze
COPY llhd-blaze llhd-blaze
RUN cargo install --path llhd-blaze

# Install llhd-est
COPY llhd-est llhd-est
RUN cargo install --path llhd-est

# Install some additional convenience tools.
RUN apt-get install -y less vim time

# Copy the rest of the input.
COPY src src/
COPY Makefile README.md ./

ENTRYPOINT /bin/bash
