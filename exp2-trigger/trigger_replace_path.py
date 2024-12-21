import os
import time
import libconf
import threading

THREAD_NUM = 32

def get_case_dataset():
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    case_dataset = os.path.join(current_folder, 'trigger_dataset', 'dejavuzz')
    assert os.path.exists(case_dataset), f"the {case_dataset} does not exists!!!"
    return case_dataset

def replace_one_cfg_path(case_path, folder_path):
    swap_cfg_path = os.path.join(case_path, 'swap_mem.cfg')
    with open(swap_cfg_path, 'rt') as file:
        swap_cfg = libconf.loads(file.read())
    
    for mem_region in swap_cfg['memory_regions']:
        init_file_path = mem_region['init_file']
        init_file_path_token = init_file_path.split('/')
        final_file_name = init_file_path_token[-1]
        sub_folder_name = init_file_path_token[-2]
        mem_region['init_file'] = os.path.join(folder_path, sub_folder_name, final_file_name)
    
    with open(swap_cfg_path, 'wt') as file:
        libconf.dump(swap_cfg, file)

def replace_cfg_path(folder_path, thread_num):
    file_name_list = os.listdir(folder_path)
    
    index = 0
    index_sum = len(file_name_list)
    while index < index_sum:
        case_path_list = []
        for _ in range(thread_num):
            if index >= index_sum:
                break
            file_name = file_name_list[index]
            index += 1
            if file_name == 'frame':
                continue
            case_path = os.path.join(folder_path, file_name)
            if os.path.isfile(case_path):
                continue
            case_path_list.append(case_path)

        thread_list = []
        for case_path in case_path_list:
            thread = threading.Thread(target=replace_one_cfg_path, args=(case_path, folder_path))
            thread.start()
            thread_list.append(thread)
        for thread in thread_list:
            thread.join()

if __name__ == "__main__":
    case_dataset = get_case_dataset()
    for group_name in os.listdir(case_dataset):
        group_path = os.path.join(case_dataset, group_name)
        case_path = os.path.join(group_path, 'fuzz_code')
        print(f"start replace {group_path}")
        start = time.time()
        replace_cfg_path(case_path, THREAD_NUM)
        end = time.time()
        print(f"finish replace {group_path}")
        print(f"use time: {(end-start):.2f}")