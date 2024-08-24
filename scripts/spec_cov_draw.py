import os
import matplotlib.pyplot as plt
import numpy as np
import coverage_analysis

def get_file_list(dirname):
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

def get_curve(file_in_dir, index):
    curve = [0]
    cov_set = set()
    cov_num = []
    cov_contr = []
    file_list = []
    for filename in file_in_dir:
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

    with open(f'./spec_coverage/spec_{index}.log', 'wt') as file:
        for num, contr,filename in zip(cov_num, cov_contr, file_list):
            file.write(f'{num} {contr} {filename}\n')
    return curve

def draw_plot(cov_list, label):
    cov_list = np.array(cov_list).T
    ave_list = np.mean(cov_list, axis=1).T
    std_list = np.std(cov_list, axis=1).T

    ci = std_list * 1.96
    ci[ave_list - ci < 0] = ave_list[ave_list - ci < 0]
    plt.plot(ave_list, label=label)
    plt.errorbar(range(20000)[::1250], ave_list[::1250], yerr=ci[::1250], fmt='o')

if not os.path.exists('./spec_coverage'):
    os.mkdir('./spec_coverage')

cov_dir = [
    './cov_0',
    './cov_1',
    './cov_2',
    './cov_3',
    './cov_4',
]
legend = [
    'U2M_ATTACKER', 
    'S2M_ATTACKER',
    'U2S_ATTACKER',
    'U2S_VICTIM',
    'S2M_VICTIM',
]
file_in_dir_list = [get_file_list(filename)[:20000] for filename in cov_dir]
# file_cross_list = [[0 for i in range(20000)] for j in range(5)]
# for i in range(5):
#     for j in range(5):
#         file_cross_list[i][j*4000:j*4000+4000] = file_in_dir_list[j][i*4000:i*4000+4000]
# file_in_dir_list = file_cross_list
curve_list = [get_curve(file_in_dir, i)[:20000] for i, file_in_dir in enumerate(file_in_dir_list)]

# for cov, leg in zip(curve_list, legend):
#     plt.plot(cov, label = leg)
#     pass
draw_plot(curve_list[0:3], label='spec_attack')
draw_plot(curve_list[3:5], label='spec_victim')

plt.legend(bbox_to_anchor=(1,0.75))
plt.savefig('./spec_coverage/spec_cov.png')