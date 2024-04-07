# ParaFuzz

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
make verilog-instrument
```

4. Back to the repository root directory, and test the workflow.

```bash
make fuzz
```
