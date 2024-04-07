#!/bin/zsh

SIMULATOR=vlt

TESTCASE_HOME=/work/riscv-tests/build/benchmarks

TARGET=(
        # spectre-v1
        # spectre-v2
        # spectre-v3
        # spectre-v4
        # spectre-rsb
        # spectre-rewind
        spectre-frozen
	    spectre-ctrl-failed
	    # spectre-specret
)

GUESS=( 100 101 )

make $SIMULATOR-dummy

for target in "${TARGET[@]}"
do

for guess in "${GUESS[@]}"
do
	make $SIMULATOR \
        STARSHIP_TESTCASE=$TESTCASE_HOME/$target.guess$guess.riscv &
done

done

wait
python3 starship-parafuzz/conf/taint_sum.py -s $SIMULATOR -q
