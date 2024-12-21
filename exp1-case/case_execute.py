from case_replace import *

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