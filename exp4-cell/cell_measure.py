import datetime
import os
import time

current_time = datetime.datetime.now()
time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
current_path = os.path.dirname(os.path.abspath(__file__))
record_file = os.path.join(current_path, f'cell_result_{time_str}')
if os.path.exists(record_file):
    print(f'{record_file} has been existed')
else:
    os.system(f'touch {record_file}')

def execute_command(command):
    if os.system(command):
        print(f'{command} fails to execute')
        exit()

def compile_test(target_core, ift_tool):
    assert target_core in ['BOOM', 'XiangShan']
    assert ift_tool in ['diffift', 'cellift']

    start = time.time()
    if target_core == 'XiangShan':
        command = 'make compile-xiangshan'
        execute_command(command)
    vcs_target = 'vcs-dummy' if ift_tool == 'diffift' else 'vcs-dummy-cell'
    vcs_mode = 'variant' if ift_tool == 'diffift' else 'taint'
    command = f'make {vcs_target} TARGET_CORE={target_core} SIM_MODE={vcs_mode}'
    execute_command(command)
    finish = time.time()
    with open(record_file, 'a+') as file:
        file.write(f'{target_core} {ift_tool} compile:\t{finish-start:.2f}s\n')
    
def execute_test(target_core, ift_tool):
    assert target_core in ['BOOM', 'XiangShan']
    assert ift_tool in ['diffift', 'cellift']
    current_path = os.path.dirname(os.path.abspath(__file__))
    dataset_path = os.path.join(current_path, 'cell_dataset')
    for case_name in os.listdir(dataset_path):
        case_path = os.path.join(dataset_path, case_name)
        swap_mem_path = os.path.join(case_path, 'swap_mem.cfg')
        bin_mem_path = os.path.join(case_path, f'{case_name}.guess101.riscv.bin')
        start = time.time()
        vcs_testcase = swap_mem_path if ift_tool == 'diffift' else bin_mem_path
        vcs_target = 'vcs' if ift_tool == 'diffift' else 'vcs-cell'
        vcs_mode = 'variant' if ift_tool == 'diffift' else 'taint'
        command = f'make {vcs_target} TARGET_CORE={target_core} STARSHIP_TESTCASE={vcs_testcase} SIM_MODE={vcs_mode} SIMULATION_LABEL={case_name}'
        execute_command(command)
        finish = time.time()
        with open(record_file, 'a+') as file:
            file.write(f'{target_core} {ift_tool} {case_name}:\t{finish-start:.2f}s\n')

if __name__ == "__main__":
    execute_command('make clean')
    for target_core in ['BOOM', 'XiangShan']:
        for ift_tool in ['diffift', 'cellift']:
            with open(record_file, 'a+') as file:
                file.write(f'{target_core} {ift_tool}\n')
            compile_test(target_core, ift_tool)
            execute_test(target_core, ift_tool)