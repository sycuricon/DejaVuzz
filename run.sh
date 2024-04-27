#!/bin/zsh

set -vx

PWD=`pwd`

SIMULATOR=vcs

TESTCASE_HOME=/work/riscv-tests/build/benchmarks
STARSHIP_HOME=$PWD/starship-parafuzz

TARGET=(
        spectre-v1
        spectre-v2
        spectre-v3
        spectre-v4
        spectre-rsb
        spectre-rewind
        spectre-frozen
	spectre-ctrl-failed
	spectre-specret
)

GUESS=( 100 101 )

make -C $STARSHIP_HOME $SIMULATOR-dummy

mkdir -p $PWD/build/regress

for target in "${TARGET[@]}"
do

for guess in "${GUESS[@]}"
do
        python3 scripts/gen_cfg.py \
                --dut_init_file $TESTCASE_HOME/$target.guess$guess.riscv.bin \
                --vnt_init_file $TESTCASE_HOME/$target.guess$guess.riscv.variant.bin \
                --output_file $PWD/build/regress/$target.$guess.cfg
	make -C $STARSHIP_HOME $SIMULATOR STARSHIP_TESTCASE=$PWD/build/regress/$target.$guess.cfg SIMULATION_LABEL=$target.$guess &
done

done

wait

make -C $STARSHIP_HOME plot_${SIMULATOR}_taint

