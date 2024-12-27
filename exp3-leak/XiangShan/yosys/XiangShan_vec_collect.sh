#! /usr/bin/env sh

set -x

yosys/collect_array.py \
    -i  vsrc/XiangShan.$YOSYS_TOP.$YOSYS_CONFIG.top.v \
        vsrc/XiangShan.$YOSYS_TOP.$YOSYS_CONFIG.behav_srams.top.v \
        vsrc/rtl/XSTop.v \
        vsrc/rtl/array_0_0_ext.v \
        vsrc/rtl/array_0_10_ext.v \
        vsrc/rtl/array_0_11_ext.v \
        vsrc/rtl/array_0_12_ext.v \
        vsrc/rtl/array_0_13_ext.v \
        vsrc/rtl/array_0_14_ext.v \
        vsrc/rtl/array_0_15_ext.v \
        vsrc/rtl/array_0_16_ext.v \
        vsrc/rtl/array_0_17_ext.v \
        vsrc/rtl/array_0_18_ext.v \
        vsrc/rtl/array_0_19_ext.v \
        vsrc/rtl/array_0_1_ext.v \
        vsrc/rtl/array_0_20_ext.v \
        vsrc/rtl/array_0_21_ext.v \
        vsrc/rtl/array_0_22_ext.v \
        vsrc/rtl/array_0_23_ext.v \
        vsrc/rtl/array_0_24_ext.v \
        vsrc/rtl/array_0_25_ext.v \
        vsrc/rtl/array_0_26_ext.v \
        vsrc/rtl/array_0_2_ext.v \
        vsrc/rtl/array_0_3_ext.v \
        vsrc/rtl/array_0_4_ext.v \
        vsrc/rtl/array_0_5_ext.v \
        vsrc/rtl/array_0_6_ext.v \
        vsrc/rtl/array_0_7_ext.v \
        vsrc/rtl/array_0_8_ext.v \
        vsrc/rtl/array_0_9_ext.v \
        vsrc/rtl/array_0_ext.v \
    -o  vsrc/XiangShan.$YOSYS_TOP.$YOSYS_CONFIG.vec
