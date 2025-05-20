import argparse
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.ticker import *

def draw_taint_curve(result_path):
    cellift_info = [
        ["Spectre-V1",  f"{result_path}/cellift_BOOM/spectre-v1.taint.csv",  658, "#F27970"],
        ["Spectre-V2",  f"{result_path}/cellift_BOOM/spectre-v2.taint.csv",  894, "#54B345"],
        ["Meltdown",    f"{result_path}/cellift_BOOM/spectre-v3.taint.csv",  835, "#32B897"],
        ["Spectre-V4",  f"{result_path}/cellift_BOOM/spectre-v4.taint.csv",  695, "#8983BF"],
        ["Spectre-RSB", f"{result_path}/cellift_BOOM/spectre-rsb.taint.csv", 704, "#C76DA2"],
    ]

    diffift_info = [
        ["Spectre-V1",  f"{result_path}/diffift_BOOM/spectre-v1.taint.csv",  658, "#F27970"],
        ["Spectre-V2",  f"{result_path}/diffift_BOOM/spectre-v2.taint.csv",  894, "#54B345"],
        ["Meltdown",    f"{result_path}/diffift_BOOM/spectre-v3.taint.csv",  835, "#32B897"],
        ["Spectre-V4",  f"{result_path}/diffift_BOOM/spectre-v4.taint.csv",  695, "#8983BF"],
        ["Spectre-RSB", f"{result_path}/diffift_BOOM/spectre-rsb.taint.csv", 704, "#C76DA2"],
    ]

    fp_info = [
        ["Spectre-V1",  f"{result_path}/diffift_fn_BOOM/spectre-v1.taint.csv",  658, "#F27970"],
        ["Spectre-V2",  f"{result_path}/diffift_fn_BOOM/spectre-v2.taint.csv",  894, "#54B345"],
        ["Meltdown",    f"{result_path}/diffift_fn_BOOM/spectre-v3.taint.csv",  835, "#32B897"],
        ["Spectre-V4",  f"{result_path}/diffift_fn_BOOM/spectre-v4.taint.csv",  695, "#8983BF"],
        ["Spectre-RSB", f"{result_path}/diffift_fn_BOOM/spectre-rsb.taint.csv", 704, "#C76DA2"],
    ]

    plt.rcParams['axes.labelsize'] = 10
    plt.rcParams['axes.titlesize'] = 10
    plt.figure(figsize=(4, 2.2))

    def plot_and_save(info_list, title):
        for info in info_list:
            data = pd.read_csv(info[1])           
            plt.plot(data['time'], data['dut'], label=info[0], color=info[3])
            plt.axvline(info[2], linestyle="--", color=info[3], linewidth=0.5)
        
        plt.xlabel('Cycle', fontsize=10)
        plt.ylabel('Taint Sum', fontsize=10)
        plt.xlim(600, 1200)
        plt.ylim(0)
        plt.title(title, fontsize=12, fontname='FreeSerif', x=0.8, y=0)

    ax = plt.subplot(2, 2, 1)
    plot_and_save(diffift_info, "diffIFT")
    plt.gca().xaxis.set_major_formatter(FuncFormatter(lambda x, pos : f"{(x / 1000)}k"))
    plt.gca().yaxis.set_major_locator(MultipleLocator(20))
    plt.ylim(0, 70)

    ax = plt.subplot(2, 2, 2)
    plot_and_save(fp_info, "diffIFT$^\mathregular{FN}$")
    plt.gca().xaxis.set_major_formatter(FuncFormatter(lambda x, pos : f"{(x / 1000)}k"))
    plt.gca().yaxis.set_major_locator(MultipleLocator(20))
    plt.ylim(0, 70)

    ax = plt.subplot(2, 2, 3)
    plot_and_save(cellift_info, "CellIFT")
    plt.gca().xaxis.set_major_formatter(FuncFormatter(lambda x, pos : f"{(x / 1000)}k"))
    plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, pos : f"{int(x // 1000)}k"))
    plt.gca().yaxis.set_major_locator(MultipleLocator(200000))

    handles, labels = plt.gca().get_legend_handles_labels()
    plt.figlegend(handles, labels, fontsize=10, loc='lower right', bbox_to_anchor=(0.95, -0.05), ncol=1, labelspacing=0.1, columnspacing=0.8, frameon=True)

    plt.subplots_adjust(top = 1, bottom = 0, right = 1, left = 0, hspace = 0.55, wspace = 0.35)
    plt.margins(0,0)

    # plt.tight_layout()
    plt.savefig(f"{result_path}/Taint.pdf", bbox_inches = 'tight', pad_inches = 0)
    plt.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--taint", dest="taint", required=True, help="the path of taint log files")
    args = parser.parse_args()

    draw_taint_curve(args.taint)