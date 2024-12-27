#! /usr/bin/env sh

set -x

yosys/collect_array.py \
    -i  vsrc/BOOM.$YOSYS_TOP.$YOSYS_CONFIG.top.v \
        vsrc/BOOM.$YOSYS_TOP.$YOSYS_CONFIG.behav_srams.top.v \
    -o  vsrc/BOOM.$YOSYS_TOP.$YOSYS_CONFIG.vec
