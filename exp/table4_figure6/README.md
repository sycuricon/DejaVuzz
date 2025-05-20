# Experiment: Table 4 & Figure 6

This experiment evaluates the compilation and runtime overhead of diffIFT.
It also evaluates the taint curve of diffIFT and CellIFT on the BOOM core.

## Execution

### Step 0

To begin the experiment, set up the dataset by executing the following command:

```bash
python3 step0_dataset_setup.py
```

### Step 1

To generate Table 4, run the following commands individually:

```bash
python3 step1.1_compilation_time.py
python3 step1.2_simulation_time.py
```

Upon completion, a new log file and a result directory will be created in the current directory:

- The compilation time log file begins with `ae_cmp_` and ends with a timestamp (e.g., `ae_cmp_2025-05-17-11-04-42.log`).
- The simulation result directory begins with `ae_sim_` and ends with a timestamp (e.g., `ae_sim_2025-05-19-14-54-13`).

### Step 2

To generate Figure 6, execute the following command:

```bash
python3 step2_draw_taint_curve.py --taint <simulation time result directory>
```

## Result

### Compilation Time and Simulation Time

The compilation time for each configuration is recorded in the compilation log.
The mapping between different configurations and the corresponding entries in Table 5 is as follows:

```plaintext
.../starship-diffift/.../starship.asic.StarshipSimMiniConfig_BOOM_robprofile/...        -> BOOM - Base
.../starship-diffift/.../starship.asic.StarshipSimMiniConfig_BOOM_variant/...           -> BOOM - diffIFT
.../starship-cellift/.../starship.asic.StarshipSimMiniConfig_BOOM_taint/...             -> BOOM - CellIFT
.../starship-diffift/.../starship.asic.StarshipSimMiniConfig_XiangShan_robprofile/...   -> XiangShan - Base
.../starship-diffift/.../starship.asic.StarshipSimMiniConfig_XiangShan_variant/...      -> XiangShan - diffIFT
.../starship-cellift/.../starship.asic.StarshipSimMiniConfig_XiangShan_taint/...        -> XiangShan - CellIFT
```

In the simulation result directory, the file named `time.log` contains the simulation time for each configuration. The mapping to Table 5 is:

```plaintext
base_BOOM       -> BOOM - Base
base_XS         -> XiangShan - Base
diffift_BOOM    -> BOOM - diffIFT
diffift_XS      -> XiangShan - diffIFT
cellift_BOOM    -> BOOM - CellIFT
```

### Taint Curve

The taint curve is also generated in the simulation result directory. You can find it in the file named `Taint.pdf`.