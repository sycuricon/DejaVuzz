import os
import libconf

from ptm import include

inhouse_deps = include("../common/inhouse_dep.ptm")

def get_case_dataset():
    case_dataset = os.path.join(inhouse_deps.dep_root, 'dataset', 'table5')
    assert os.path.exists(case_dataset), "the cell_dataset does not exists!!!"
    return case_dataset

def get_case_list(case_dir):
    case_list = []

    for case_folder_name in os.listdir(case_dir):
        case_folder_path = os.path.join(case_dir, case_folder_name)
        if not os.path.isdir(case_folder_path):
            continue
        case_list.append(case_folder_path)
    
    return case_list

def replace_cfg_path(case_list):
    for case_folder_path in case_list:
        print(f"Setup testcase {case_folder_path}")
        for sub_folder_name in os.listdir(case_folder_path):
            if sub_folder_name not in ['trigger', 'leak']:
                continue
            sub_folder_path = os.path.join(case_folder_path, sub_folder_name)
            swap_conf_path = os.path.join(sub_folder_path, 'swap_mem.cfg')
            with open(swap_conf_path) as file:
                swap_mem_conf = libconf.loads(file.read())
            for mem_region in swap_mem_conf['memory_regions']:
                init_file_path = mem_region['init_file']
                init_file_path_token = init_file_path.split('/')
                file_name = init_file_path_token[-1]
                folder_name = init_file_path_token[-2]
                if folder_name not in ['frame', 'leak', 'trigger']:
                    raise Exception('the folder name in swap_mem.cfg is wrong')
                new_init_file_path = os.path.join(case_folder_path, folder_name, file_name)
                mem_region['init_file'] = new_init_file_path

            with open(swap_conf_path, "wt") as file:
                libconf.dump_dict(swap_mem_conf, file)

if __name__ == "__main__":
    case_dataset = get_case_dataset()
    case_list = get_case_list(case_dataset)
    replace_cfg_path(case_list)
