import argparse
import csv
import os

def compute_comp(taint_file):
    taint_comp = {}
    for line in open(taint_file, "r"):
        line = line.strip()
        if ':' in line:
            line = list(line.split())
            comp = line[0][:-1]
            if 'l2' in comp:
                continue
            if 'dcache.data' in comp:
                continue
            hash_value = int(line[1])
            taint_comp[comp] = hash_value
        else:
            comp = line
            if 'l2' in comp:
                continue
            if 'dcache.data' in comp:
                continue
            taint_comp[comp] = 1
    return taint_comp

def diff_comp(comp1, comp2):
    keys = list(comp1.keys())
    for key in keys:
        if key in comp2:
            if comp1[key] > comp2[key]:
                comp1[key] -= comp2[key]
            else:
                comp1.pop(key)
    return comp1

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
    return  last_spec_victim_begin > first_spec_tsx_begin

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

def liveness_analysis(folder_path, case_num):
    if not os.path.exists(folder_path):
        raise Exception(f"the path {folder_path} doesn't exist")
    
    print('BOOM')
    boom_folder = os.path.join(folder_path, 'BOOM')
    live_list = []
    for i in range(case_num):
        live_path = os.path.join(boom_folder, f'{i}.taint.live')
        live_comp = compute_comp(live_path)
        live_early_path = os.path.join(boom_folder, f'{i}.taint.live.early')
        live_early_comp = compute_comp(live_early_path)
        live_comp = diff_comp(live_comp, live_early_comp)
        live_list.append(live_comp)
        log_path = os.path.join(boom_folder, f'{i}.taint.log')
        is_illegal = specdoctor_illegal(log_path)
        if is_illegal:
            print(f'case_num: {i} false positive')
            print('illegal')
            continue
        is_diverage = specdoctor_diverage(log_path)
        if is_diverage:
            print(f'case_num: {i} true positive')
            print('diverage')
            continue
        if len(live_comp.keys()) != 0:
            print(f'case_num: {i} true positive')
            for key, value in live_comp.items():
                print(key, value)
        else:
            print(f'case_num: {i} false positive')

    print('BOOM_without_mask')
    boom_folder = os.path.join(folder_path, 'BOOM_without_mask')
    for i in range(case_num):
        live_path = os.path.join(boom_folder, f'{i}.taint.live')
        live_comp = compute_comp(live_path)
        live_early_path = os.path.join(boom_folder, f'{i}.taint.live.early')
        live_early_comp = compute_comp(live_early_path)
        live_comp = diff_comp(live_comp, live_early_comp)
        if len(live_comp.keys()) == 0:
            print(f'case_num: {i} false positive')
            continue
        live_comp = diff_comp(live_comp, live_list[i])
        if len(live_comp.keys()) != 0:
            print(f'case_num: {i} false positive')
            for key,value in live_comp.items():
                print(key, value)


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("-I", "--input", dest="input", required=True, help="time suffix")
    args = parser.parse_args()
    current_folder_path = os.path.dirname(os.path.realpath(__file__))
    folder_path = os.path.join(current_folder_path, f'{args.input}')
    dataset_path = os.path.join(current_folder_path, 'liveness_dataset')
    case_num = len(os.listdir(dataset_path))
    liveness_analysis(folder_path, case_num)
