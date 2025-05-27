# Experiment: Figure 7

This experiment compares the taint coverage of DejaVuzz, DejaVuzz-, and SpecDoctor.

## Execution

### Step 0

Start by setting up the dataset using the following command:

```bash
python3 step0_specdoctor_setup.py
```

### Step 1

> Note: The following two sub-steps can be executed in parallel.

To run DejaVuzz and DejaVuzz-, execute the following command:

```bash
python3 step1.1_dejavuzz_execute.py
```

The results will be saved in a directory that begins with `ae_djv_` and ends with a timestamp (e.g., `ae_djv_2025-05-25-14-07-40`).

To reply SpecDoctor, execute the following command:

```bash
python3 step1.2_specdoctor_execute.py
```

Similarly, the results will be saved in a directory that begins with `ae_spd_` and ends with a timestamp (e.g., `ae_spd_2025-05-22-03-56-23`).


### Step 2

To draw the coverage comparison figure, run:

```bash
python3 step2_draw_coverage_curve.py --dejavuzz <dejavuzz result directory> --specdoctor <specdoctor result directory>/spdoc_<dataset id>
# e.g., python3 step2_coverage_analysis.py --dejavuzz ae_djv_2025-05-25-14-07-40 --specdoctor ae_spd_2025-05-22-03-56-23/spdoc_0
```

## Result

The final coverage curve will be generated at `build/Coverage.pdf`.
