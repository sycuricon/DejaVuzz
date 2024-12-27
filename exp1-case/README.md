# Experiment E1

Experiment E1 is used to verify the reality of the bug in Table 3 and Table 5. 

## Setup

1. set up the experiment environment following the README in root directory

2. download dataset to exp1-case/case_dataset path.
```
TODO:
```

## Directory Hierarchy of Dataset

`case_dataset` is the dataset of the vulnerabilities listed in table3 and table5. The final directory hierarchy of the `case_dataset` is as follows:
```
.
├── leak_case
│   ├── boom_meltdown_disambiguate_dcache
│   ├── boom_meltdown_disambiguate_icache
│   ......
│   ├── boom_spectre_mispredict_ras
│   ├── xiangshan_meltdown_disambiguate_dcache
│   ├── xiangshan_meltdown_disambiguate_icache
│   ......
│   └── xiangshan_spectre_mispredict_lsu
└── trigger_case
    ├── boom_dv_access_fault
    ├── boom_dv_branch
    ......
    ├── boom_dv_return
    ├── xiangshan_dv_access_fault
    ├── xiangshan_dv_branch
    ......
    └── xiangshan_dv_return

```

### leak_case

Each folder in leak_case directory is one poc of a transient execution vulnerability listed in table 5, which can leak secret by transient execution vulnerabilities. 

For example `boom_meltdown_disambiguate_dcache` means it is a meltdown vulnerability of boom core, it triggers transient execution windows by memroy disambiguate(spectre-v4) and leaks secret by encoding dcache line. 

Your can execute each poc directly in root directory by executing `make vcs`. The `leak/swap_mem.cfg` of each folder is the memory-swap configure file of the poc.

### trigger case

Each folder in trigger_case directory is one poc of a transient execution windows trigger listed in table 5, which can trigger transient execution window. 

For example `boom_dv_access_fault` means it can trigger transient execution window of boom by triggering memory access fault. 

Your can execute each poc directly in root directory by executing `make vcs`. The `trigger/swap_mem.cfg` of each folder is the memory-swap configure file of the poc.

## Execute experiment

1. run `python case_replace.py` to change the `FILE_PATH` in case_dataset's `swap_mem.cfg`.

2. run `python case_execute.py` to execute each poc in `case_dataset/leak_case` and `case_dataset/trigger_case`.

3. analysis the simulation results in `exp1-case/BOOM/build/vcs` and `exp1-case/XiangShan/build/vcs` and verify the valication of these poc.

## Execute Result

The simulation results are in the `exp1-case/BOOM/build/vcs` and `exp1-case/XiangShan/build/vcs`:

* results of `leak_case/boom*` in `exp1-case/BOOM/build/vcs/BOOM_variant/wave`
* results of `leak_case/xiangshan*` in `exp1-case/XiangShan/build/vcs/XiangShan_variant/wave`
* results of `trigger_case/boom*` in `exp1-case/BOOM/build/vcs/BOOM_robprofile/wave`
* results of `trigger_case/XiangShan*` in `exp1-case/XiangShan/build/vcs/XiangShan_robprofile/wave`

For example, the results of `trigger_case/boom_dv_access_fault` in `exp1-case/BOOM/build/vcs/BOOM_robprofile/wave` are:

* trigger_boom_dv_access_fault.taint.cov: the coveraged state of processor by testcase
* trigger_boom_dv_access_fault.taint.csv: the summary of taint changed with time
* trigger_boom_dv_access_fault.taint.live: the liveness taint encoded in processor after transient execution attack
* trigger_boom_dv_access_fault.taint.log: the enqueue and dequeue information of label instructions

We can judge the transient execution attack successful or not and analysis the cause of this transient execution attack by above four files.

## Result Analysis

TODO






