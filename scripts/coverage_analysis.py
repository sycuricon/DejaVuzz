import matplotlib.pyplot as plt
import numpy as np
import os
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

def spec_get_curve(file_in_dir, index):
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

if not os.path.exists('./spec_coverage'):
    os.mkdir('./spec_coverage')

plt.subplot(2,1,1)

cov_dir = [
    './cov_0',
    './cov_1',
    './cov_2',
    './cov_3',
    './cov_4',
    # './cov_5',
    # './cov_6',
]
legend = [
    'U2M_ATTACKER', 
    'S2M_ATTACKER',
    'U2S_ATTACKER',
    'U2S_VICTIM',
    'S2M_VICTIM',
    # 'S2M_VICTIM_2',
    # 'U2S_VICTIM_2',
]
file_len = 20000
file_in_dir_list = [get_file_list(filename)[:file_len] for filename in cov_dir]
file_cross_list = [[0 for i in range(file_len)] for j in range(len(cov_dir))]
for i in range(len(cov_dir)):
    for j in range(len(cov_dir)):
        # file_cross_list[i][j*4000:j*4000+4000] = file_in_dir_list[j][i*4000:i*4000+4000]
        file_cross_list[i][j:file_len:len(cov_dir)] = file_in_dir_list[j][i:file_len:len(cov_dir)]
file_in_dir_list = file_cross_list
curve_list = [spec_get_curve(file_in_dir, i)[:file_len] for i, file_in_dir in enumerate(file_in_dir_list)]

for cov, leg in zip(curve_list, legend):
    # plt.plot(cov, label = leg)
    pass
# draw_plot(curve_list[0:3], label='spec_attack')
draw_plot(curve_list, label='SpecDoctor')

leak_list = [
    # './coverage/leak_00_curve',
    # './coverage/leak_01_curve',
    './coverage/leak_02_curve',
    './coverage/leak_03_curve',
    './coverage/leak_04_curve',
    './coverage/leak_05_curve',
    './coverage/leak_08_curve',
]

cov_list = [dejavuzz_get_curve(leak_file)[:20000] for leak_file in leak_list]
for cov_item in cov_list:
    # plt.plot(cov_item)
    pass

draw_plot(cov_list, label='DejaVuzz')

plt.legend(bbox_to_anchor=(1,0.4))
plt.axis([0, 20000, 0, 5000])
plt.xlabel('Iteration', fontsize=13)
plt.ylabel('Coverage', fontsize=13)
plt.savefig('./spec_coverage/spec_cov.pdf')

plt.subplot(2,1,2)

