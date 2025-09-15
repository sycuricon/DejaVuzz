# DejaVuzz: Disclosing Transient Execution Bugs with Dynamic Swappable Memory and Differential Information Flow Tracking Assisted Processor Fuzzing

DejaVuzz is a pre-silicon processor fuzzer designed to uncover transient execution bugs.
By introducing two novel operating primitives (i.e., dynamic swappable memory and differential information flow tracking), DejaVuzz significantly enhances microarchitectural controllability and observability, enabling it to efficiently trigger transient execution windows and detect potential secret leakages.
DejaVuzz has been evaluated on two out-of-order RISC-V processors, BOOM and XiangShan, and successfully discovered five previously unknown variants of transient execution vulnerabilities.
For full technical details, please refer to our [ASPLOS 2025 paper](https://dl.acm.org/doi/abs/10.1145/3676642.3736115).

This repository includes the source code and scripts for reproducing four experiments:

- Training Overhead (Table 3)
- Instrument Overhead (Table 4) and Taint Comparison (Figure 6)
- Coverage Comparison (Figure 7)
- Replaying Discovered Bugs (Table 5)


## Requirements

### Dependencies

DejaVuzz is evaluated on Rocky Linux release 8.10 with the following dependencies:

```bash
sudo yum -y groupinstall "Development Tools"
sudo yum -y install redhat-lsb libXScrnSaver scl-utils dtc
sudo yum -y install gcc-toolset-11
```

Besides, To cross-compile RISC-V programs, install the official toolchain from the official [riscv-gnu-toolchain repository](https://github.com/riscv-collab/riscv-gnu-toolchain).
DejaVuzz also relies on Synopsys VCS for RTL simulation.
A valid Synopsys license is required to run the experiments.
Add them to your `PATH` environment variable.

Python is used to manage the build process and generate figures.
Install required Python dependencies with:

```bash
pip3 install -r requirements.txt
```

Next, several external dependencies must be downloaded from [zenodo](https://zenodo.org/records/15378560/files/dep.zip) and extracted as the `dep/` directory.
Once all dependencies are in place, your directory structure should look like this:

```
DejaVuzz
├── dep
│   ├── dataset                         # SpecDoctor and bug datasets used in the paper
│   ├── razzle                          # Input generator  
│   ├── riscv-isa-cosim                 # RISC-V ISA Simulator used for calculate operands    
│   ├── starship-cellift                # Testbench with cellift patch
│   ├── starship-specdoctor             #           with specdoctor patch
│   ├── starship-dejavuzz               #           with dejavuzz patch
│   ├── starship-dejavuzz-fn            # same as above, used for false negative evaluation
│   ├── starship-diffift                # same as above, used for complication evaluation
│   ├── xiangshan-dejavuzz              # XiangShan with DejaVuzz patch
│   ├── xiangshan-dejavuzz-diffift      # same as above, used for complication evaluation
│   ├── yosys-cellift                   # Yosys with CELLIFT patch
│   └── yosys-diffift                   #       with diffIFT patch
└── exp
    ├── common
    ├── figure7
    ├── table3
    ├── table4_figure6
    └── table5
```

### Setup

To initialize the environment variables and configure required paths, run the following script from the root of the repository:

```bash
python3 setup.py
```

If setup completes successfully, you should see the following message:

```bash
In-house dependencies are set up successfully.
```

> Note: Do not start any experiments before the setup script completes. Otherwise, the system may attempt to recompile dependencies, which could lead to conflicts.

## Experiments

To reproduce the results presented in the paper, refer to the `README.md` files in the corresponding subdirectories under `exp/`.
Execute the commands provided in each directory to run the associated experiment:

- `exp/table3`: Training Overhead (Table 3)
- `exp/table4_figure6`: Instrumentation Overhead (Table 4) and Taint Comparison (Figure 6)
- `exp/figure7`: Coverage Comparison (Figure 7)
- `exp/table5`: Bug Replay (Table 5)


## Citation

```
@inproceedings{xu2025dejavuzz,
  title={DejaVuzz: Disclosing Transient Execution Bugs with Dynamic Swappable Memory and Differential Information Flow Tracking Assisted Processor Fuzzing},
  author={Xu, Jinyan and Zhou, Yangye and Zhang, Xingzhi and Li, Yinshuai and Tan, Qinhan and Zhang, Yinqian and Zhou, Yajin and Chang, Rui and Shen, Wenbo},
  booktitle={Proceedings of the 30th ACM International Conference on Architectural Support for Programming Languages and Operating Systems, Volume 3},
  pages={64--80},
  year={2025}
}
```
