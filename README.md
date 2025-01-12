# DejaVuzz: Disclosing Transient Execution Bugs with Dynamic Swappable Memory and Differential Information Flow Tracking assisted Processor Fuzzing

DejaVuzz is a pre-silicon stage processor transient execution bug fuzzer.
By leveraging two novel operating primitives (i.e., dynamic swappable memory and differential information flow tracking) to improve the microarchitectural controllability and observability, DejaVuzz can effectively and efficiently trigger transient execution windows and identify secret leakages.
DejaVuzz was evaluated on two RISCV out-of-order processors (i.e., BOOM and XiangShan), and it discovered 5 new transient execution vulnerability variants.
For more details, please see our ASPLOS 2025 paper.

This repository contains the source code and scripts for four experiments:

- Exp1: Training Overhead (Table 3)
- Exp2: Instrument Overhead (Table 4) and Taint Comparison (Figure 5)
- Exp3: Coverage Comparison (Figure 6)
- Exp4: Bug Replay (Table 5)


## Setup

### Mandatory Dependencies

DejaVuzz is evaluated on Rocky Linux release 8.10 with the following dependencies:

```bash
sudo yum -y groupinstall "Development Tools"
sudo yum -y install redhat-lsb libXScrnSaver scl-utils dtc
sudo yum -y install gcc-toolset-11
```

First, DejaVuzz uses Synopsys VCS for RTL simulation, therefore you need to subscribe a license from Synopsys to run the experiments in this repository.

Besides, you need to download several external dependencies from [zenodo](#TODO) and uncompress them into the `deps` directory.
Please refer to the description of each tool for their setup instructions.
The following tools are required for the experiments:

- `deps/razzle`: Razzle Instruction Generator, [upstream version](#TODO).
- `deps/yosys-diffift`: Yosys with diffIFT patch, [upstream version](#TODO).
- `deps/yosys-cellift`: Yosys with CELLIFT patch, [upstream version](#TODO).
- `deps/starship-dejavuzz`: Starship with DejaVuzz patch, [upstream version](#TODO).
- `deps/xiangshan-dejavuzz`: XiangShan with DejaVuzz patch, [upstream version](#TODO).
- `deps/dataset`: The SpecDoctor and Bug datasets used in the paper.

Next, this artifact uses python to manage the build process and generate the graphs, so you need to install the following python dependencies:

```bash
pip3 install -r requirements.txt
```

Finally, the directory hierarchy of the artifact is as follows:

```
.
├── deps
│   ├── InstGenerator
│   └── yosys-pift
├── exp1-case
├── exp2-trigger
├── exp3-leak
└── scripts
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
- Exp4: compare the compile time and execute time between CELLIFT and our diff IFT
- Exp5: verify the effect of the liveness mask on filtering false positive
- Exp6: verify the effect of the different secret pair when a false negative occurs

The direcctories exp1-case, exp2-trigger, exp3-leak, exp4-cell, exp5-liveness, exp6-diff are the workspace of the Exp1, Exp2, Exp3, Exp4, Exp5 and Exp6 respectively. Please do three artification evalution experiments in corresponding workspace.
