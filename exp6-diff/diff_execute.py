import os
import time
import datetime
import threading

THREAD_NUM = 64

def system_call(string):
    print(string)
    for i in range(3):
        if os.system(string) != 0:
            time.sleep(10)
        else:
            return
    else:
        raise Exception('cannot handle this system call by delay')

def case_execute(swap_cfg_path, output_directory, wave_directory, case_label):
    system_call(f'make -C BOOM vcs STARSHIP_TESTCASE={swap_cfg_path} SIMULATION_LABEL={case_label} SIMULATION_MODE=variant')
    
    for suffix in ['live', 'csv', 'log', 'cov']:
        live_name = os.path.join(wave_directory, f'{case_label}.taint.{suffix}')
        output_path = os.path.join(output_directory, f'{case_label}.taint.{suffix}')
        system_call(f'cp {live_name} {output_path}')

def casedataset_execute(repo_prefix):
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    case_dataset_path = os.path.join(current_folder, 'cell_dataset')

    repo_path = os.path.join(current_folder, repo_prefix)
    if not os.path.exists(repo_path):
        os.mkdir(repo_path)

    target_core = 'BOOM'
    for swap_type in ['no_diff', 'diff']:
        result_output_path = os.path.join(repo_path, swap_type)
        if not os.path.exists(result_output_path):
            os.mkdir(result_output_path)

        wave_path = os.path.join(current_folder, target_core,\
            'build', 'vcs', 'BOOM_variant', 'wave')
        
        for case_path in os.listdir(case_dataset_path):
            swap_cfg_path = os.path.join(case_dataset_path, case_path, 'swap_mem.cfg' if swap_type == 'diff' else 'no_diff.cfg')
            case_execute(swap_cfg_path, result_output_path, wave_path, case_path)


if __name__ == "__main__":
    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'diff_result_{time_str}'
    casedataset_execute(repo_prefix)

