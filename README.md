# DejaVuzz: Disclosing Transient Execution Bugs with Dynamic Swappable Memory and Differential Information Flow Tracking assisted Processor Fuzzing

DejaVuzz is a pre-silicon processor fuzzer designed to uncover transient execution bugs.
By introducing two novel operating primitives (i.e., dynamic swappable memory and differential information flow tracking), DejaVuzz significantly enhances microarchitectural controllability and observability, enabling it to efficiently trigger transient execution windows and detect potential secret leakages.
DejaVuzz has been evaluated on two out-of-order RISC-V processors, BOOM and XiangShan, and successfully discovered five previously unknown variants of transient execution vulnerabilities.
For full technical details, please refer to our [ASPLOS 2025 paper](https://arxiv.org/abs/2504.20934).

This repository includes the source code and scripts for reproducing four experiments:

- Exp1: Training Overhead (Table 3)
- Exp2: Instrument Overhead (Table 4) and Taint Comparison (Figure 6)
- Exp3: Coverage Comparison (Figure 7)
- Exp4: Replaying Discovered Bugs (Table 5)


## Requirements

### Dependencies

DejaVuzz is evaluated on Rocky Linux release 8.10 with the following dependencies:

```bash
sudo yum -y groupinstall "Development Tools"
sudo yum -y install redhat-lsb libXScrnSaver scl-utils dtc
sudo yum -y install gcc-toolset-11
```

Besides, To cross-compile RISC-V programs, install the official toolchain from the official [riscv-gnu-toolchain repository](https://github.com/riscv-collab/riscv-gnu-toolchain).
DejaVuzz also relies on Synopsys VCS for RTL simulation. A valid Synopsys license is required to run these experiments.

Python is used to manage the build process and generate figures. Install Python dependencies with:

```bash
pip3 install -r requirements.txt
```

Next, you need to download several external dependencies from [zenodo](#TODO) and extracted into the `dep/` directory.
Once everything is set up, the directory structure should resemble the following:

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

## Execute

### Setup

To initialize the environment variables and configure required paths, run the following script from the root of the repository:

```bash
python3 setup.py
```

### Experiments

To reproduce the results presented in the paper, refer to the `README.md` files in the corresponding subdirectories under `exp/`.
Execute the commands provided in each directory to run the associated experiment:

- `exp/table3`: Training Overhead (Table 3)
- `exp/table4_figure6`: Instrumentation Overhead and Taint Curve (Table 4 & Figure 6)
- `exp/figure7`: Coverage Comparison (Figure 7)
- `exp/table5`: Bug Replay (Table 5)

## Attribution

```
@article{xu2025dejavuzz,
  title={DejaVuzz: Disclosing Transient Execution Bugs with Dynamic Swappable Memory and Differential Information Flow Tracking assisted Processor Fuzzing},
  author={Xu, Jinyan and Zhou, Yangye and Zhang, Xingzhi and Li, Yinshuai and Tan, Qinhan and Zhang, Yinqian and Zhou, Yajin and Chang, Rui and Shen, Wenbo},
  journal={arXiv preprint arXiv:2504.20934},
  year={2025}
}
```
