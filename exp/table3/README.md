# Experiment: Table 3

This experiment evaluates the training overhead of DejaVuzz, DejaVuzz\*, and SpecDoctor for different types of transient execution windows.

## Execution

### Step 1

We first conduct the DejaVuzz-related experiments.
To generate transient execution windows under different DejaVuzz configurations, run:

```bash
python3 step1.1_dejavuzz_execute.py
```

Then, to compute the training overhead for DejaVuzz and DejaVuzz\*, run:

```bash
python3 step1.2_dejavuzz_statistic.py
```

The results will be printed directly to the terminal.

### Step 2

To compute the training overhead for SpecDoctor, execute:

```bash
python3 step2_specdoctor_statistic.py
```

The results will also be printed in the terminal.

## Result

### DejaVuzz

The ouyput of `step1.2_dejavuzz_statistic.py` contains the training overhead for DejaVuzz and DejaVuzz\*.
A typical output looks like:

```plaintext
BOOM_trigger_dejavuzz:          # BOOM DejaVuzz
load/store access fault:        TO:0.0        ETO:0.0
load/store page fault:  TO:0.0        ETO:0.0
load/store misalign:    TO:0.0        ETO:0.0
illegal instruction:    TO:*  ETO:*
memory  disambiguation: TO:0.0        ETO:0.0
branch mispredict:      TO:86.4       ETO:3.8
indirect jump mispredict:       TO:85.7       ETO:2.8
return address mispredict:      TO:85.6       ETO:2.7
straight line speculation:      TO:0.0        ETO:0.0

BOOM_trigger_dejavuzz_rdm:      # BOOM DejaVuzz*
...

XiangShan_trigger_dejavuzz:     # XiangShan DejaVuzz
...

XiangShan_trigger_dejavuzz_rdm: # XiangShan DejaVuzz*
...
```

> If the value of `TO` or `ETO` is `*`, it indicates that the corresponding transient execution window failed to trigger.


### SpecDoctor

The output of `step2_specdoctor_statistic.py` contains the training overhead statistics for SpecDoctor:

```plaintext
# type      total case  total line         TO
page-fault:     17833,  2243508,    125.80653843997084
branch:         89107,  11173467,   125.39381866744476
jump:           6217,   777227,     125.01640662699052
Mem-Reorder:    8871,   1098528,    123.83361515049036
```

`page-fault`, `branch`, `jump`, `Mem-Reorder` are corresponding to `Load/Store Page Fault`, `Branch Mispredict`, `Indirect Jump Mispredict`, `Memory Disambiguation` in Table 3.
