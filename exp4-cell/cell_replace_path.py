import os
import libconf

def get_case_dataset():
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    case_dataset = os.path.join(current_folder, 'cell_dataset')
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
        swap_conf_path = os.path.join(case_folder_path, 'swap_mem.cfg')
        with open(swap_conf_path) as file:
            swap_mem_conf = libconf.loads(file.read())
        for mem_region in swap_mem_conf['memory_regions']:
            init_file_path = mem_region['init_file']
            init_file_path_token = init_file_path.split('/')
            file_name = init_file_path_token[-1]
            base_name = case_folder_path
            new_init_file_path = os.path.join(base_name, file_name)
            mem_region['init_file'] = new_init_file_path
        with open(swap_conf_path, "wt") as file:
            libconf.dump_dict(swap_mem_conf, file)

if __name__ == "__main__":
    case_dataset = get_case_dataset()
    print(f'the path of case_dataset is {case_dataset}')

    case_list = get_case_list(case_dataset)
    replace_cfg_path(case_list)
    print(f"finish {case_dataset}")