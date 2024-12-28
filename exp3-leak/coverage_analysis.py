import datetime
import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
import numpy as np
import os
import argparse
import scipy.stats as stats

CURVE_LEN = 20000

def draw_plot(cov_list, label, color):
    ave_list = []
    upper_list = []
    lower_list = []

    cov_list = np.array(cov_list).T
    for data in cov_list:
        ave = np.mean(data)
        # data = np.concatenate([data,np.array([ave])])
        lower, upper = stats.t.interval(confidence=0.95, df=len(data) - 1, loc=ave, scale=stats.sem(data))
        ave_list.append(ave)
        upper_list.append(upper)
        lower_list.append(lower)
    
    plt.plot(ave_list, label=label, color=color)
    print(ave_list[-1])
    plt.fill_between(range(len(lower_list)), lower_list, upper_list, alpha=0.2, color=color)
    # for num in ave_list:
    #     print(num)

def get_spec_cov_list(dirname):
    def get_index(filename):
        index = filename.split('.')[0]
        try:
            index = int(index)
        except ValueError:
            index = -1
        return index

    file_in_dir = os.listdir(dirname)
    file_in_dir.sort(key=get_index)
    path_in_dir = [os.path.join(dirname, file) for file in file_in_dir if file.endswith('.cov')]
    return path_in_dir

def spec_get_curve(spec_cov_list):
    curve = [0]
    cov_set = set()
    cov_num = []
    cov_contr = []
    file_list = []
    for filename in spec_cov_list:
        coverage = set()
        for line in open(filename, "r"):
            line = line.strip()
            line = list(line.split())
            comp = line[0][:-1]
            if 'l2' in comp:
                continue
            hash_value = line[1:]
            for value in hash_value:
                value = int(value, base=16)
                coverage.update({(comp, value)})
        old_num = len(cov_set)
        cov_set.update(coverage)
        new_num = len(cov_set)

        cov_num.append(new_num - old_num)
        cov_contr.append(len(coverage))
        file_list.append(filename)

        curve.append(new_num)
    return curve

def dejavuzz_get_curve(filename):
    with open(filename) as file:
        lines = file.readlines()
    curve = []
    for line in lines:
        line = line.strip().split()
        coverage = int(line[-1])
        curve.append(coverage)

    return curve

def analysis_and_draw(specdoctor_path, dejavuzz_path):
    assert os.path.exists(specdoctor_path), f'{specdoctor_path} doesn\'t exist'
    assert os.path.exists(dejavuzz_path), f'{dejavuzz_path} doesn\'t exist'

    dejavuzz_curve = []
    for dejavuzz_curve_file in os.listdir(dejavuzz_path):
        if dejavuzz_curve_file == 'fuzz.log':
            continue
        dejavuzz_curve_file_path = os.path.join(dejavuzz_path, dejavuzz_curve_file)
        dejavuzz_curve.append(dejavuzz_get_curve(dejavuzz_curve_file_path))
    dejavuzz_curve_len = min(min([len(curve) for curve in dejavuzz_curve]), CURVE_LEN)
    dejavuzz_curve = [curve[:dejavuzz_curve_len] for curve in dejavuzz_curve]

    specdoctor_curve = []
    for specdoctor_cov_folder in os.listdir(specdoctor_path):
        if os.path.isfile(specdoctor_cov_folder):
            continue
        file_in_dir = get_spec_cov_list(os.path.join(specdoctor_path, specdoctor_cov_folder))
        curve = spec_get_curve(file_in_dir)
        specdoctor_curve.append(curve)
    specdoctor_curve_len = min(min([len(curve) for curve in specdoctor_curve]), CURVE_LEN)
    specdoctor_curve = [curve[:specdoctor_curve_len] for curve in specdoctor_curve]

    draw_plot(dejavuzz_curve, label='DejaVuzz', color="#2878b5")
    draw_plot(specdoctor_curve, label='SpecDoctor', color="#ffbe7a")

    plt.legend(loc="center right", bbox_to_anchor=(1, 0.45), fontsize=10 , frameon=False)
    plt.axis([0, CURVE_LEN, 0, 3200])
    plt.yticks(np.arange(0, 3200, 1000))
    plt.xlabel('Iteration', fontsize=10)
    plt.ylabel('Coverage', fontsize=10)

    plt.gca().xaxis.set_major_formatter(FuncFormatter(lambda x, pos : f"{int(x / 1000)}k"))
    plt.gca().yaxis.set_major_formatter(FuncFormatter(lambda x, pos : f"{int(x / 1000)}k"))

    plt.tight_layout()

    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    coverage_name = f'Exp3_Coverage_{time_str}.pdf'
    plt.savefig(coverage_name, bbox_inches = 'tight', pad_inches = 0)
    print(f'store coverage figure in {coverage_name}')

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--dejavuzz", dest="dejavuzz_path", required=True, help="the path of dejavuzz result")
    parser.add_argument("--specdoctor", dest="specdoctor_path", required=True, help="the path of secdoctor result")
    args = parser.parse_args()

    current_path = os.path.dirname(os.path.abspath(__file__))
    dejavuzz_folder = os.path.basename(args.dejavuzz_path)
    specdoctor_folder = os.path.basename(args.specdoctor_path)
    dejavuzz_path = os.path.join(current_path, dejavuzz_folder)
    specdoctor_path = os.path.join(current_path, specdoctor_folder)
    analysis_and_draw(specdoctor_path, dejavuzz_path)