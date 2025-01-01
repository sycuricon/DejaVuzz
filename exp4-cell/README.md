# Experiment E4

Experiment E4 is used to compare the compile and execution time between DejaVuzz and SpecDoctor listed in Table 4.

## Setup

1. set up the experiment environment following the README in root directory

2. export `DEJAVUZZ` shell variant to directory of toolchian

```sh
    export DEJAVUZZ=/path/to/toolchain
```

You can construct your toolchain by the steps in root directory's README.

3. set up starship to compile BOOM and XiangShan instrumented by diffift.
```sh
git clone https://github.com/sycuricon/starship-parafuzz.git
cd starship-parafuzz  
git submodule update --init --recursive 
make patch
```

4. set up starship to compile BOOM and XiangShan instrumented by cellift.
```sh
git clone https://github.com/sycuricon/starship-parafuzz.git starship-parafuzz-cellift
cd starship-parafuzz-cellift
git checkout cellift
git submodule update --init --recursive 
make patch
```

5. set up xiangshan to provide the rtl design of xiangshan
```sh
git clone https://github.com/sycuricon/xiangshan-dejavuzz.git
cd xiangshan-dejavuzz
git submodule update --init --recursive 
```

6. download dataset to exp4-cell/cell_dataset path.

```
TODO:
```

## Directory Hierarchy of Dataset

The final directory hierarchy of the `cell_dataset` is as follows:

```
.
├── spectre-rsb
├── spectre-v1
├── spectre-v2
├── spectre-v3
└── spectre-v4
```

## Execute experiment

1. execute `python cell_replace_execute.py` to change the `FILE_PATH` in cell_dataset's `swap_mem.cfg`.

2. execute `python cell_measure.py` to compile BOOM and XiangShan design instrumented by diffift or cellift and execute testcase in cell_dataset in order. The compile and execution time will be record in `cell_result_xx-xx-xx-xx-xx-xx`, the `xx-xx-xx-xx-xx-xx` is the start execution time of `python cell_measure.py`.

For example:
```sh
BOOM diffift
BOOM diffift compile:	216.11s
BOOM diffift spectre-v1:	5.07s
BOOM diffift spectre-rsb:	5.13s
BOOM diffift spectre-v2:	5.59s
BOOM diffift spectre-v4:	5.02s
BOOM diffift spectre-v3:	5.26s
BOOM cellift
BOOM cellift compile:	1857.39s
BOOM cellift spectre-v1:	194.13s
BOOM cellift spectre-rsb:	198.06s
BOOM cellift spectre-v2:	195.14s
BOOM cellift spectre-v4:	204.58s
BOOM cellift spectre-v3:	184.58s
XiangShan diffift
XiangShan diffift compile:	1388.69s
XiangShan diffift spectre-v1:	15.54s
XiangShan diffift spectre-rsb:	15.99s
XiangShan diffift spectre-v2:	17.31s
XiangShan diffift spectre-v4:	16.26s
XiangShan diffift spectre-v3:	16.21s
XiangShan cellift
XiangShan cellift compile:	37713.61s
XiangShan cellift spectre-v1:	20899.89s
XiangShan cellift spectre-rsb:	20023.68s
...
```

The instrument for XiangShan RTL by cellift need more than 10 hour. So you'd better stop this script handly after waiting for a enough long time, such as 4-8 hours. It can prove the instrument XiangShan by cellift is time out.

