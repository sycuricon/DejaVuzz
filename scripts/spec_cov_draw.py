import os
import matplotlib.pyplot as plt
import numpy as np
import scipy.stats as stats


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
    
    plt.plot(ave_list, label=label)
    print(ave_list[-1])
    plt.fill_between(range(len(lower_list)), lower_list, upper_list, alpha=0.2)

if not os.path.exists('./spec_coverage'):
    os.mkdir('./spec_coverage')

cov_dir = [
    './cov_0',
    './cov_1',
    './cov_2',
    './cov_3',
    './cov_4',
    './cov_5',
    './cov_6',
]
legend = [
    'U2M_ATTACKER', 
    'S2M_ATTACKER',
    'U2S_ATTACKER',
    'U2S_VICTIM',
    'S2M_VICTIM',
    'S2M_VICTIM_2',
    'U2S_VICTIM_2',
]
file_in_dir_list = [get_file_list(filename)[:19999] for filename in cov_dir]
file_cross_list = [[0 for i in range(19999)] for j in range(len(cov_dir))]
for i in range(len(cov_dir)):
    for j in range(len(cov_dir)):
        # file_cross_list[i][j*4000:j*4000+4000] = file_in_dir_list[j][i*4000:i*4000+4000]
        file_cross_list[i][j:19999:len(cov_dir)] = file_in_dir_list[j][i:19999:len(cov_dir)]
file_in_dir_list = file_cross_list
curve_list = [get_curve(file_in_dir, i)[:19999] for i, file_in_dir in enumerate(file_in_dir_list)]

for cov, leg in zip(curve_list, legend):
    # plt.plot(cov, label = leg)
    pass
# draw_plot(curve_list[0:3], label='spec_attack')
draw_plot(curve_list, label='SpecDoctor')