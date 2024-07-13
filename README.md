# DejaVuzz

## Usage

1. Install our customized yosys from the yosys-pift repository, compile and place the directory in your `PATH`.

```bash
git clone https://github.com/sycuricon/yosys-pift.git
cd yosys-pift
make config-gcc
make
export PATH=$PATH:$(pwd)
```

2. Back to the repository root directory, and set up razzle.

```bash
# cd ..
git clone https://github.com/sycuricon/InstGenerator.git
cd InstGenerator
pip3 install -r requirements.txt
```

3. Back to the repository root directory, and set up starship.

```bash
# cd ..
git clone https://github.com/sycuricon/starship-parafuzz.git
cd starship-parafuzz
git submodule update --init --recursive --progress
make patch
```

> Notice: We dont't need to execute `make verilog-instrument` anymore.

4. Back to the repository root directory, and set up spike

```bash
git clone https://github.com/sycuricon/riscv-isa-cosim.git
cd riscv-isa-cosim
autoconf
make
make install
```

4. Back to the repository root directory, and test the workflow. Argument PREFIX is the prefix of the folder and file of fuzz result.

```bash
make do-fuzz PREFIX=xxxx
```

## Customization

execute `make vcs` to simulate a program on the starship.
- Overwrite the `TARGET_CORE` to customize the target core
- Overwrite the `SIM_MODE` to customize the simulaton mode, such as `normal`, `robprofile` and `variant`
- Overwrite the `SIMULATION_LABEL` to customize the prefix of the file name of the result
- Overwrite the `STARSHIP_TESTCASE` to customize the simulation program's configure file

execute `make vcs-wave` to dump the wave of the simlution.

execute `make vcs-debug` to dump the commit information of the program execution

execute `make cov_draw_iter` to draw the coverage figure using iteration as x axis

execute `make cov_draw_time` to draw the coverage figure using time as x axis
