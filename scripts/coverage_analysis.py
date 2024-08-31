import matplotlib.pyplot as plt
import numpy as np
from spec_cov_draw import *

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

def get_curve(filename):
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

leak_list = [
    './coverage/leak_00_curve',
    './coverage/leak_01_curve',
    './coverage/leak_02_curve',
    './coverage/leak_03_curve',
    './coverage/leak_04_curve',
]

cov_list = [get_curve(leak_file)[:20000] for leak_file in leak_list]
# for cov_item in cov_list:
    # plt.plot(cov_item)

draw_plot(cov_list, label='DejaVuzz')

plt.legend(bbox_to_anchor=(1,0.17))
plt.axis([0, 20000, 0, 4600])
plt.xlabel('Iteration', fontsize=13)
plt.ylabel('Coverage', fontsize=13)
plt.savefig('./spec_coverage/spec_cov.pdf')
