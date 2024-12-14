import os
import libconf

def get_case_dataset():
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    case_dataset = os.path.join(current_folder, 'case_dataset')
    assert os.path.exists(case_dataset), "the case_dataset does not exists!!!"
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
                for name in ['frame', 'leak', 'trigger']:
                    if name in folder_name:
                        folder_name = name
                        break
                else:
                    raise Exception('the folder name in swap_mem.cfg is wrong')
                base_name = case_folder_path
                new_init_file_path = os.path.join(base_name, folder_name, file_name)
                mem_region['init_file'] = new_init_file_path
            with open(swap_conf_path, "wt") as file:
                libconf.dump_dict(swap_mem_conf, file)

def traversal_case_execute():
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    makefile_folder = os.path.dirname(current_folder)

    case_dataset = get_case_dataset()
    print(f'the path of case_dataset is {case_dataset}')

    trigger_case_dataset = os.path.join(case_dataset, 'trigger_case')
    trigger_case_list = get_case_list(trigger_case_dataset)
    replace_cfg_path(trigger_case_list)
    for trigger_case in trigger_case_list:
        case_type = trigger_case.split('/')[-1]
        swap_mem_cfg = os.path.join(trigger_case, 'trigger', 'swap_mem.cfg')
        prefix = f'trigger_{case_type}'
        core = 'BOOM' if 'boom' in case_type.lower() else 'XiangShan'
        mode = 'robprofile'
        command = f'make vcs -C {makefile_folder} SIM_MODE={mode} TARGET_CORE={core} STARSHIP_TESTCASE={swap_mem_cfg} SIMULATION_LABEL={prefix}'
        if os.system(command):
            raise Exception(f'{command} fails to execute')
    exit(0)

    leak_case_dataset = os.path.join(case_dataset, 'leak_case')
    leak_case_list = get_case_list(leak_case_dataset)
    replace_cfg_path(leak_case_list)
    for leak_case in leak_case_list:
        case_type = leak_case.split('/')[-1]
        swap_mem_cfg = os.path.join(leak_case, 'leak', 'swap_mem.cfg')
        prefix = f'leak_{case_type}'
        core = 'BOOM' if 'boom' in case_type.lower() else 'XiangShan'
        mode = 'variant'
        command = f'make vcs -C {makefile_folder} SIM_MODE={mode} TARGET_CORE={core} STARSHIP_TESTCASE={swap_mem_cfg} SIMULATION_LABEL={prefix}'
        os.system(command)
        if os.system(command):
            raise Exception(f'{command} fails to execute')

if __name__ == "__main__":
    traversal_case_execute()