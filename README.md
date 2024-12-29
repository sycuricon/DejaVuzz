# DejaVuzz

DejaVuzz is a novel pre-silicon stage processor transient execution bug fuzzer. Differented from existing work, it uses stimulus template generator `razzle` to generate effetive and diverse stimulus, use swappable memory model to improve the microarchitectural controllability, use differential information flow tracking to improve the microarchitectural observability and idenetifies the transient execution vulnerabilities. DejaVuzz was evaluated on two famous RISCV open-source processors(i.e., BOOM and XiangShan)

This repository only contains libraries and scripts for artifact evaluation. You can get the source code of the [starship soc](https://github.com/sycuricon/starship-parafuzz.git), the [xiangshan soc](https://github.com/sycuricon/xiangshan-dejavuzz.git), the [customized sythensis tooler](https://github.com/sycuricon/yosys-pift.git) and the [stimulus template generator](https://github.com/sycuricon/InstGenerator.git) from their respective repositories.

## Setup

> MorFuzz uses Synopsys VCS for RTL simulation, therefore you need to obtain a license to run the scripts in this repository.

DejaVuzz is evaluated on Rocky Linux release 8.10 with the following dependencies:

```bash
TODO:
```

Then you need to install the toolchains of DejaVuzz by cloning the reposities and executing the setup scripts.

We recommand to make folder `toolchain` in divafuzz-workspace reposity. Then use the absolute path of `divafuzz-workspace/toolchain` as `/path/to/toolchain` in the following script commands.

1. Install our customized yosys from the yosys-pift repository, compile and place the directory in your `PATH`. Yosys is used to add hardware instrumentation in RTL to support differential information flow tracking.

```bash
git clone https://github.com/sycuricon/yosys-pift.git
cd yosys-pift
make config-gcc
make
make install PREFIX=/path/to/toolchain
```

2. Install our customized mill from the mill repository, compile and place the directory in your `PATH`. It is used to compile XiangShan processor.

```bash
curl -L https://github.com/com-lihaoyi/mill/releases/download/0.11.12/0.11.12 > /path/to/toolchain/bin/mill && chmod +x /path/to/toolchain/bin/mill
```

3. Install cellift's yosys from the cellift-yosys-profiling repository, compile and place the directory in your `PATH`. This yosys is used to comparative experiment between cellift and our diffift.

```bash
git clone https://github.com/sycuricon/cellift-yosys-profiling.git
cd cellift-yosys-profiling
make config-gcc
make
make install PREFIX=/path/to/toolchain
```

## AE Experience

We design three experience to artification evalution:

- Exp1: verify each simulation stimulus for transient execution vulnerabilities listed in Paper's Table 5
- Exp2: compare the instruction overhead for triggering transient execution windows between DejaVuzz and SpecDoctor
- Exp3: compare the fuzzing coverage between DejaVuzz and SpecDoctor
- Exp4: compare the compile time and execute time between CELLIFT and our diff IFT

The direcctories exp1-case, exp2-trigger, exp3-leak, exp4-cell are the workspace of the Exp1, Exp2 and Exp3, respectively. Please do three artification evalution experiments in corresponding workspace.
