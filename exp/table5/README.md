# Experiment: Table 5

This experiment contains representative vulnerabilities identified in Table 5.
By replaying the test cases that triggered vulnerabilities during the fuzzing, we prove that DejaVuzz is able to utilize taint liveness annotations and execution traces to identify leakages.

## Execution

To run the experiment, you first need to set up the dataset by executing the following command:

```bash
python3 step0_dataset_setup.py
```

After the dataset is set up, you can run the experiment by executing the following command:

```bash
python3 step1_dataset_execute.py
```

## Result

After running the experiment, you can find the results in a directory starting with `ae_` and a timestamp in the current directory, like `ae_2025-05-16-13-20-24`.
For cases that violate constant time execution property, we identify them using execution traces from the `.log` files.
For cases that do not exhibit constant time execution violations, we further use the taint liveness generated `.live` files to identify potential leakages.

### BOOM

#### B1: Meltdown Type - Memory Exception based Transient Execution Window - Cache/TLB based Side Channel

We discovered that in BOOM core, an attacker can encode sensitive data into memory related side channels (such as the [I/D]Cache or (L2)TLB) during the transient execution window triggered by a memory exception.
In `boom_b1.live`, it can be observed that components such as the dcache and tlb are tainted.

```plaintext
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.data.array_3_0.array_0_0_ext._23_.unnamed$$_0:    8
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.lsu.dtlb._1008_
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.ptw.l2_tlb_ram.l2_tlb_ram_ext._23_.unnamed$$_0:    1
```

#### B2: Meltdown Type - Memory Exception based Transient Execution Window - Port Contention based Side Channel

We discovered that in BOOM core, an attacker can exploit port contention in the load store unit to influence the duration of the transient execution window triggered by a memory exception.
In `boom_b2.log`, we can observe a timing difference between two instances that use different secret values.

```plaintext
#   cycle     event          commit_port   instance_id
    3498, DELAY_END_DEQ,           0,           1
    3507, DELAY_END_DEQ,           0,           0
```

#### B3: Meltdown Type - Memory Disambiguation based Transient Execution Window - Cache/TLB based Side Channel

Similar to B1, except that in this case, the transient execution window is caused by a memory disambiguation.
In `boom_b3.live`, we can observe that dcache and tlb are tainted.

```plaintext
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.data.array_3_0.array_0_0_ext._23_.unnamed$$_0:   10
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.meta_0.tag_array.tag_array_ext._092_.unnamed$$_0:   2
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.lsu.dtlb._0996_
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.ptw.l2_tlb_ram.l2_tlb_ram_ext._23_.unnamed$$_0:    2
```

#### B4: Spectre Type - Memory Exception based Transient Execution Window - Cache based Side Channel

Similarly, an attacker can also launch a Spectre type attack by leveraging cache based side channels within the transient window triggered by a memory exception.
In `boom_b4.live`, we observe that the dcache is tainted.

```plaintext
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.data.array_2_0.array_0_0_ext._23_.unnamed$$_0:    8
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.dcache.meta_0.tag_array.tag_array_ext._092_.unnamed$$_0:   2
```

#### B5, B6: Spectre Type - Memory Exception based Transient Execution Window - Predictor based Side Channel

We also found that BOOM allows some predictors to be updated during transient execution.
`boom_b5.live` and `boom_b6.live` demonstrate that the btb and ras modules can be encoded with sensitive data, respectively.

```plaintext
# b5.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.frontend.bpd.banked_predictors_0.btb.btb_0.btb_0_ext._086_.unnamed$$_0:   1
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.frontend.bpd.banked_predictors_0.ubtb._2483_

# b6.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_boom_tile.frontend.ras._297_
```

#### B7: Spectre Type - Memory Exception based Transient Execution Window - Port Contention based Side Channel

We discovered that in BOOM core, an attacker can exploit the timing differences in the transient execution duration caused by contention in the fetch unit to infer secrets.
In `boom_b7.log`, we can observe the timing difference.

```plaintext
#   cycle     event          commit_port   instance_id
    3371, VCTM_END_ENQ,           0,           1
    3378, VCTM_END_DEQ,           0,           1
```

#### B8, B9: Spectre Type - Misprediction based Transient Execution Window - Port Contention based Side Channel

Similar to B2, both the floating-point unit and load store unit can also be exploited to launch Spectre type port contention based leakages.
In `boom_b8.log` and `boom_b9.log`, we observe timing differences.

```plaintext
# b8.log
#   cycle     event          commit_port   instance_id
    3865, DELAY_END_DEQ,           0,           1
    3874, DELAY_END_DEQ,           0,           0

# b9.log
#   cycle     event          commit_port   instance_id
    3925, DELAY_END_DEQ,           0,           1
    3934, DELAY_END_DEQ,           0,           0
```

### XiangShan

#### B10, B11, B12, B13: Meltdown Type - Arbitary Transient Execution Window - Cache based Side Channel

We found that in XiangShan core, an attacker can sample and leak secrets through cache side channels during arbitrary transient execution windows (memory exception, illegal instruction exception, misprediction, and memory disambiguation).
We can observe that the dcache is tainted in `xiangshan_b10.live`, `xiangshan_b11.live`, `xiangshan_b12.live`, and `xiangshan_b13.live`.

```plaintext
# b10.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate.array_0.array_0_12_ext._23_.unnamed$$_0:   3

# b11.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate.array_0.array_0_12_ext._23_.unnamed$$_0:   2

# b12.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate.array_0.array_0_12_ext._23_.unnamed$$_0:   1

# b13.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate_1.array_0.array_0_12_ext._23_.unnamed$$_0:   1
```

#### B14, B15, B16, B17: Spectre Type - Arbitary Transient Execution Window - Cache based Side Channel

Similar to B10-B13, an attacker can also launch Spectre type attacks through cache side channels during arbitrary transient execution windows.
We can observe that the dcache is tainted in `xiangshan_b14.live`, `xiangshan_b15.live`, `xiangshan_b16.live`, and `xiangshan_b17.live`.

```plaintext
# b14.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate_1.array_0.array_0_12_ext._23_.unnamed$$_0:   1

# b15.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate_1.array_0.array_0_12_ext._23_.unnamed$$_0:   1

# b16.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate.array_0.array_0_12_ext._23_.unnamed$$_0:   1

# b17.live
Testbench.testHarness.ldut.tile_prci_domain.tile_reset_domain_xiangshan_tile.core.core.memBlock.dcache.dcache.bankedDataArray.data_banks_0_7.SRAMTemplate_1.array_0.array_0_12_ext._23_.unnamed$$_0:   1
```

#### B18, B19, B20: Spectre Type - Arbitary Transient Execution Window - Port Contention based Side Channel

Similarly, an attacker can also exploit port contention in the fetch unit, load store unit, and floating-point unit on XiangShan to leak information.
In `xiangshan_b18.log`, `xiangshan_b19.log`, and `xiangshan_b20.log`, we can observe timing differences.

```plaintext
# b18.log
#   cycle     event          commit_port   instance_id
    5068, VCTM_END_ENQ,           0,           1
    5069, VCTM_END_ENQ,           0,           0

# b19.log
#   cycle     event          commit_port   instance_id
    5182, DELAY_END_DEQ,           1,           1
    5185, DELAY_END_DEQ,           1,           0

# b20.log
#   cycle     event          commit_port   instance_id
    5006, DELAY_END_DEQ,           1,           1
    5008, DELAY_END_DEQ,           0,           0
```
