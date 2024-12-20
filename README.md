# DejaVuzz

DejaVuzz is a novel pre-silicon stage processor transient execution bug fuzzer. Differented from existing work, it uses stimulus template generator `razzle` to generate effetive and diverse stimulus, use swappable memory model to improve the microarchitectural controllability, use differential information flow tracking to improve the microarchitectural observability and idenetifies the transient execution vulnerabilities. DejaVuzz was evaluated on two famous RISCV open-source processors(i.e., BOOM and XiangShan)

This repository only contains libraries and scripts for artifact evaluation. You can get the source code of the [starship soc](https://github.com/sycuricon/starship-parafuzz.git), the [xiangshan soc](https://github.com/sycuricon/xiangshan-dejavuzz.git), the [customized sythensis tooler](https://github.com/sycuricon/yosys-pift.git) and the [stimulus template generator](https://github.com/sycuricon/InstGenerator.git) from their respective repositories.

## Setup

> MorFuzz uses Synopsys VCS for RTL simulation, therefore you need to obtain a license to run the scripts in this repository.

DejaVuzz is evaluated on Rocky Linux release 8.10 with the following dependencies:

```bash
TODO:
```

Then you need to install the dependencies by cloning the reposities and executing the setup scripts.

1. Install our customized yosys from the yosys-pift repository, compile and place the directory in your `PATH`. Yosys is used to add hardware instrumentation in RTL to support differential information flow tracking.

```bash
git clone https://github.com/sycuricon/yosys-pift.git
cd yosys-pift
make config-gcc
make
export PATH=$PATH:$(pwd)
```

2. Back to the repository root directory, and set up the starship soc. Starship provides the design of BOOM soc and the swappable memory model for processor.

```bash
# cd ..
git clone https://github.com/sycuricon/starship-parafuzz.git
cd starship-parafuzz
git submodule update --init --recursive --progress
make patch
make verilog
```

3. Install our customized mill from the mill repository, compile and place the directory in your `PATH`. It is used to compile XiangShan processor.

```bash
git clone https://github.com/com-lihaoyi/mill.git
cd mill
export PATH=$PATH:$(pwd)
```

4. Back to the repository root directory, and set up Xiangshan. It provides the design of XiangShan processor fitting our fuzzing framework. 

```bash
git clone https://github.com/sycuricon/xiangshan-dejavuzz.git
cd xiangshan-dejavuzz
git submodule update --init --recursive --progress
./generate.sh
```

5. Back to the repository root directory, and set up the stimulus template generator `razzle`. Razzle is used to generate simulation stimulus for RTL and to provide the fuzzing framework.

```bash
# cd ..
git clone https://github.com/sycuricon/InstGenerator.git
cd InstGenerator
pip3 install -r requirements.txt
```

The final directory hierarchy of the project is as follows:

```
.
├── exp1-case              
├── exp2-trigger           
├── exp3-leak              
├── InstGenerator
├── Makefile
├── mill
├── README.md
├── scripts
├── starship-parafuzz
├── xiangshan-dejavuzz
└── yosys-pift
```

## Execute

If you want to execute transient execution vulnerabilities fuzzing, back to the repository root directory and execute command `make do-fuzz`. It will begin to fuzz and store the fuzzing result in `build` directory.
- Overwrite the `TARGET_CORE` to customize the target core
    - `TARGET_CORE=BOOM`: fuzzing for BOOM processor in `starship-parafuzz`
    - `TARGET_CORE=XiangShan`: fuzzing for XiangShan processor in `xiangshan-dejavuzz`
    - The default value of `TARGET_CORE` is `BOOM`
- Overwrite the `PREFIX` to customize the prefix of the generated filename during fuzzing
    - If two fuzzing process use the same `PREFIX`, their producing files will overwrite each other. So different fuzzing process should be given different prefix.
    - The default value of `PREFIX` is the vaule of the `TARGET_CORE`
- Overwrite the `THREAD_NUM` to customize the maximum thread number to execute the simulation of RTL
    - Because the number of VCS license is only 32 in our servers, so the `THREAD_NUM` cannot be larger than 32
    - The default value of `THREAD_NUM` is 16

For example we execute:
```sh
make do-fuzz PREFIX=group_0x6c28e89 TARGET_CORE=BOOM THREAD_NUM=8
```
Then the DejaVuzz will execute fuzzing test for BOOM processor by 8 threads. The fuzzing result is stored in the `build/BOOM_group_0x6c28e89`, the path consists of the `TARGET_CORE` and the `PREFIX`. The fuzzing will not stop until you kill the process handly. The final directory hierarchy of it is as follows:

```
.
├── analysis_result         # the analysis result of the fuzzing
├── fuzz_code               # the simulation stimulus during fuzzing
├── script_workspace        # the temporary script during fuzzing
└── template_repo           # the information of fuzz code and the poc found during fuzzing
```

then execute
```sh
make analysis PREFIX=group_0x6c28e89 TARGET_CORE=BOOM
```
It will analysis the fuzzing product in the `build/BOOM_group_0x6c28e89` and store the analysis result in `analysis_result` directory.

## AE Experience

We design three experience to artification evalution:

- Exp1: verify each simulation stimulus for transient execution vulnerabilities listed in Paper's Table 5
- Exp2: compare the instruction overhead for triggering transient execution windows between DejaVuzz and SpecDoctor
- Exp3: compare the fuzzing coverage between DejaVuzz and SpecDoctor

The direcctories exp1-case, exp2-trigger and exp3-leak are the workspace of the Exp1, Exp2 and Exp3, respectively. Please do three artification evalution experiments in corresponding workspace.