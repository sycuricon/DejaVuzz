import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter
import numpy as np
import os
import random
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

def smooth(curve, thres):
    last_protrude = 0
    new_protrude = 0
    concavity = 0

    i = 1
    while i < len(curve) - 1:
        last_grad = curve[i] - curve[i-1]
        new_grad = curve[i+1] - curve[i]
        if last_grad > thres and new_grad ==0 :
            last_protrude = i
            i += 1
            break
        else:
            i += 1

    while i < len(curve) - 1:
        while i < len(curve) - 1:
            last_grad = curve[i] - curve[i-1]
            new_grad = curve[i+1] - curve[i]
            if last_grad > thres and new_grad ==0 :
                new_protrude = i
                i += 1
                break
            else:
                i += 1

        if new_protrude > last_protrude:
            for i in range(last_protrude + 1, new_protrude):
                curve[i] = (curve[new_protrude] * (i - last_protrude) + curve[last_protrude] * (new_protrude - i))
                curve[i] /= new_protrude - last_protrude
            last_protrude = new_protrude
    
    return curve

def dejavuzz_get_curve(filename):
    with open(filename) as file:
        lines = file.readlines()
    curve = []
    for line in lines:
        line = line.strip().split()
        coverage = int(line[-1])
        curve.append(coverage)

    curve = smooth(curve, 200)
    curve = smooth(curve, 100)
    curve = smooth(curve, 50)

    return curve

if __name__ == "__main__":
    current_file_path = os.path.abspath(__file__)
    current_folder_path = os.path.dirname(current_file_path)
    dejavuzz_result_folder_list = []
    specdoctor_result_folder_list = []
    for folder in os.listdir(current_folder_path):
        if folder.startswith('dejavuzz_result'):
            dejavuzz_result_folder_list.append(os.path.join(current_folder_path, folder))
            continue
        if folder.startswith('specdoctor_result'):
            specdoctor_result_folder_list.append(os.path.join(current_folder_path, folder))
            continue

    dejavuzz_curve = []
    for folder in dejavuzz_result_folder_list:
        for dejavuzz_curve_file in os.listdir(folder):
            dejavuzz_curve_file_path = os.path.join(folder, dejavuzz_curve_file)
            dejavuzz_curve.append(dejavuzz_get_curve(dejavuzz_curve_file_path))
    dejavuzz_curve_len = min(min([len(curve) for curve in dejavuzz_curve]), CURVE_LEN)
    dejavuzz_final_curve = [curve[:dejavuzz_curve_len] for curve in dejavuzz_curve]

    specdoctor_curve = []
    for folder in specdoctor_result_folder_list:
        legend = [
            'U2M_ATTACKER', 
            'S2M_ATTACKER',
            'U2S_ATTACKER',
            'U2S_VICTIM',
            'S2M_VICTIM',
        ]
        cov_dir = [os.path.join(folder, sub_legend) for sub_legend in legend]
        specdoctor_curve_len = CURVE_LEN
        file_in_dir_list = [get_spec_cov_list(filename)[:specdoctor_curve_len] for filename in cov_dir]
        curve_list = [spec_get_curve(file_in_dir)[:specdoctor_curve_len] for file_in_dir in file_in_dir_list]
        specdoctor_curve.extend(curve_list)
        break

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
    random_prefix = hex(random.randint(0, 2**32-1))
    coverage_name = f'Exp3_Coverage_{random_prefix}.pdf'
    plt.savefig(coverage_name, bbox_inches = 'tight', pad_inches = 0)
    print(f'store coverage figure in {coverage_name}')

