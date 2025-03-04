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

def specdoctor_illegal(file):
    first_spec_tsx_begin = 0
    last_spec_victim_begin = 0
    for line in open(file, 'rt'):
        exec_time, exec_info, _, is_dut = list(map(str.strip ,line.strip().split(',')))
        exec_time = int(exec_time)
        exec_info = exec_info.strip()
        is_dut = True if int(is_dut) == 1 else False
        if is_dut and exec_info == 'SPEC_TSX_BEGIN_ENQ' and first_spec_tsx_begin == 0:
            first_spec_tsx_begin = exec_time
        if is_dut and exec_info == 'SPEC_VICTIM_BEGIN_ENQ':
            last_spec_victim_begin = exec_time
    if first_spec_tsx_begin == 0:
        return False
    else:
        return last_spec_victim_begin > first_spec_tsx_begin

def specdoctor_diverage(file):
    dut_label_list = []
    vnt_label_list = []
    for line in open(file, 'rt'):
        exec_time, exec_info, _, is_dut = list(map(str.strip ,line.strip().split(',')))
        exec_time = int(exec_time)
        exec_info = exec_info.strip()
        is_dut = True if int(is_dut) == 1 else False
        if is_dut:
            dut_label_list.append((exec_info, exec_time))
        else:
            vnt_label_list.append((exec_info, exec_time))
    if len(dut_label_list) != len(vnt_label_list):
        return True
    for dut_line, vnt_line in zip(dut_label_list, vnt_label_list):
        if dut_line[0] != vnt_line[0]:
            return True
        if dut_line[1] != vnt_line[1]:
            return True
    else:
        return False

def spec_get_curve(spec_cov_list, index, specdoctor_path):
    curve = [0]
    cov_set = set()
    cov_num = []
    cov_contr = []
    file_list = []
    cov_comp = {}
    for filename in spec_cov_list:
        log_name = filename.replace('.cov', '.log')
        coverage = set()
        is_illegal = specdoctor_illegal(log_name)
        if not is_illegal:
            is_diverage = specdoctor_diverage(log_name)
            if not is_diverage:
                for line in open(filename, "r"):
                    line = line.strip()
                    if line == '':
                        continue
                    line = list(line.split())
                    comp = line[0][:-1]
                    if not comp.startswith('Testbench'):
                        print(filename)
                        continue
                    if 'l2' in comp:
                        continue
                    hash_value = line[1:]
                    for value in hash_value:
                        value = int(value, base=16)
                        coverage.update({(comp, value)})
                        cov_comp[comp] = cov_comp.get(comp, {})
                        cov_comp[comp][value] = cov_comp[comp].get(value, 0) + 1
            else:
                print('diverage', log_name)
        else:
            print('illegal', log_name)
        old_num = len(cov_set)
        cov_set.update(coverage)
        new_num = len(cov_set)

        cov_num.append(new_num - old_num)
        cov_contr.append(len(coverage))
        file_list.append(filename)

        curve.append(new_num)
    
    with open(f'{specdoctor_path}/spec_{index}.log', 'wt') as file:
        for j, cov in enumerate(curve):
            file.write(f'{j} {cov}\n')
    with open(f'{specdoctor_path}/cov_comp_{index}', 'wt') as file:
        comp_name = list(cov_comp.keys())
        comp_name.sort()
        for comp in comp_name:
            file.write(f'{comp}:')
            comp_values = list(cov_comp[comp].keys())
            comp_values.sort()
            for value in comp_values:
                file.write(f' {value}({cov_comp[comp][value]})')
            file.write('\n')

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
    dejavuzz_no_cov_curve = []
    for dejavuzz_curve_file in os.listdir(dejavuzz_path):
        if dejavuzz_curve_file == 'fuzz.log':
            continue
        dejavuzz_curve_file_path = os.path.join(dejavuzz_path, dejavuzz_curve_file)
        curve = dejavuzz_get_curve(dejavuzz_curve_file_path)
        if dejavuzz_curve_file.startswith('no_cov'):
            dejavuzz_no_cov_curve.append(curve)
        else:
            dejavuzz_curve.append(curve)
    dejavuzz_curve_len = min(min([len(curve) for curve in dejavuzz_curve]), CURVE_LEN)
    dejavuzz_curve = [curve[:dejavuzz_curve_len] for curve in dejavuzz_curve]
    dejavuzz_no_cov_curve_len = min(min([len(curve) for curve in dejavuzz_no_cov_curve]), CURVE_LEN)
    dejavuzz_no_cov_curve = [curve[:dejavuzz_no_cov_curve_len] for curve in dejavuzz_no_cov_curve]

    specdoctor_curve = []
    specdoctor_cov_folder_list = [file_name for file_name in os.listdir(specdoctor_path) \
        if os.path.isdir(os.path.join(specdoctor_path, file_name))]
    specdoctor_cov_folder_list.sort()
    for i, specdoctor_cov_folder in enumerate(specdoctor_cov_folder_list):
        file_in_dir = get_spec_cov_list(os.path.join(specdoctor_path, specdoctor_cov_folder))
        curve = spec_get_curve(file_in_dir, i, specdoctor_path)
        specdoctor_curve.append(curve)
    specdoctor_curve_len = min(min([len(curve) for curve in specdoctor_curve]), CURVE_LEN)
    specdoctor_curve = [curve[:specdoctor_curve_len] for curve in specdoctor_curve]

    # draw_plot(dejavuzz_curve, label='DejaVuzz', color="#2878b5")
    for curve in dejavuzz_curve:
        plt.plot(curve, label='DejaVuzz', color="#2878b5")
    for curve in dejavuzz_no_cov_curve:
        plt.plot(curve, label='DejaVuzz-', color="#28ff28")
    draw_plot(specdoctor_curve, label='SpecDoctor', color="#ffbe7a")

    high_dejavuzz_number = max([curve[-1] for curve in dejavuzz_curve])
    high_dejavuzz_no_cov_number = max([curve[-1] for curve in dejavuzz_no_cov_curve])
    high_number = max(high_dejavuzz_number, high_dejavuzz_no_cov_number)

    plt.legend(loc="center right", bbox_to_anchor=(1, 0.45), fontsize=10 , frameon=False)
    plt.axis([0, CURVE_LEN, 0, high_number])
    plt.yticks(np.arange(0, high_number, 1000))
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