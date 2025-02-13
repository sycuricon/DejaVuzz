import os
import libconf

def get_liveness_dataset():
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    liveness_dataset = os.path.join(current_folder, 'liveness_dataset')
    assert os.path.exists(liveness_dataset), "the liveness_dataset does not exists!!!"
    return liveness_dataset

def get_case_list(case_dir):
    case_list = []

    for case_folder_name in os.listdir(case_dir):
        case_folder_path = os.path.join(case_dir, case_folder_name)
        if not os.path.isdir(case_folder_path):
            continue
        case_list.append(case_folder_path)
    
    return case_list

def replace_cfg_path(case_list, folder_path):
    for case_folder_path in case_list:
        swap_cfg_path = os.path.join(case_folder_path, 'spec.cfg')
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

if __name__ == "__main__":
    liveness_dataset = get_liveness_dataset()
    print(f'the path of liveness_dataset is {liveness_dataset}')

    liveness_case_list = get_case_list(liveness_dataset)
    replace_cfg_path(liveness_case_list, liveness_dataset)
    print(f"finish {liveness_dataset}")