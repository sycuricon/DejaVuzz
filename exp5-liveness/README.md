# Experiment E5

Experiment E5 is used to verify the effect of the liveness mask on filtering false positive. By this experiment, we can verify that DejaVuzz can filter the false pisitive identified by SpecDoctor.

## Setup

1. set up the experiment environment following the README in root directory

2. export `DEJAVUZZ` shell variant to directory of toolchian

```sh
    export DEJAVUZZ=/path/to/toolchain
```

You can construct your toolchain by the steps in root directory's README.

3. download dataset to exp5-liveness/liveness_dataset path.

```
TODO:
```

4. create soft link to `exp3-leak/specdoctor` as DejaVuzz with liveness mask.

```
ln -s ../exp3-leak/specdoctor BOOM
```

the `exp5-liveness/BOOM_without_mask` is the DejaVuzz without liveness mask.

5. compile the DejaVuzz framework before executing.

```
make -C BOOM vcs
make -C BOOM_without_mask vcs
```

## Directory Hierarchy of Dataset

The final directory hierarchy of the `liveness_dataset` is as follows:

```
.
├── 0
├── 1
├── 2
├── ...
└── 74
```

We run 5 groups of SpecDoctor, and each group consists of 20000 rounds. Then we collect all the testcases SpecDoctor identifies leaking secret from these 5 groups to construct this `liveness_dataset`. The number of testcases in `liveness_dataset` is 75, it is the same as the number written in out paper.

## Execute experiment

1. execute `python liveness_replace_execute.py` to change the `FILE_PATH` in liveness_dataset's `swap_mem.cfg`.

2. execute `python liveness_execute.py` to execute the testcases in `liveness_dataset`. The executing result will be recored in `lieness_result_xx-xx-xx-xx-xx-xx` folder, the `xx-xx-xx-xx-xx-xx` is the start execution time of `python liveness_execute.py`. For example, the `BOOM/0.taint.live` records the compoments which DejaVuzz with liveness mask thought encoded secret when executing the `liveness_dataset/0`, while the `BOOM_without_mask/0.taint.live` is the result of the DejaVuzz without liveness mask.

liveness_result_2025-02-14-00-01-04
├── BOOM
│   ├── 0.taint.live
│   ├── ...
│   └── 74.taint.live
└── BOOM_without_mask
    ├── 0.taint.live
    ├── ...
    └── 74.taint.live

3. analysis the result of BOOM and BOOM_without_mask by executing `python liveness_analysis.py -I /path/to/liveness_result`. 

It can identify the PoC from SPecDoctor is true positive or false positive. It is used to verify the validity of diffIFT to filter false positive.
```
BOOM
case_num: 0 false positive
case_num: 1 false positive
case_num: 2 false positive
case_num: 3 false positive
case_num: 4 false positive
case_num: 5 false positive
case_num: 6 false positive
case_num: 7 false positive
case_num: 8 false positive
case_num: 9 false positive
...
```

It alse finds BOOM_without_mask finds more components encoded by secret than BOOM, which means DejaVuzz with liveness mask can filter more false positive than DejaVuzz without liveness mask.
```
BOOM_without_mask
case_num: 0
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.core.FpPipeline.fregfile._35_.unnamed$$_0 1
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.mshrs._492_.unnamed$$_0 8
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.mshrs.respq._316_.unnamed$$_0 1
case_num: 1
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.core.FpPipeline.fregfile._35_.unnamed$$_0 1
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.core.iregfile._085_.unnamed$$_0 1
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.mshrs._492_.unnamed$$_0 8
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.mshrs.respq._316_.unnamed$$_0 1
...
```

# Analysis result

The analysis result of BOOM with liveness mask is listed at the following. It identifies the true positive and false positive of testcases from SpecDoctor.
* 5 testcases from SpecDoctor are diverage of control flow becuase of load contention
* 12 testcase from SpecDoctor can leak secret in dcache
* 8 testcase from SpecDoctor seem to leak secret in loop, but we analysis assemble code and find these cases are diverage in control flow within transient windows. So the taint reports are not accurcy. All of them are false positive
* 1 testcase triggers transient window during train stage, we think it is illegal
* remaining 49 testcases cannot encode secret in component during transient windows. SO all of them are just false positive

The analysis result of BOOM without liveness mask is listed at the following. It identifies the true positive and false positive of BOOM without liveness mask.
* 15 testcases can not access secret at all, so they can be identified as true negative easily.
* 1 testcase triggers transient window during train stage, we think it is illegal, so it can be identified as true negative
* 5 testcases are diverage of control flow. The can be identified as true positive
* 8 testcase seem to leak secret in loop, but we analysis assemble code and find these cases are diverage in control flow within transient windows. So the taint reports are not accurcy. All of them are false positive
* remaining 46 testcases think more components than BOOM with liveness mask are encoded to leak secret, such as mshr, rob, Fppipline and so on. So all of them are false positive

