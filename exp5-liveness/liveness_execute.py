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

def case_execute(input_directory, output_directory, wave_directory, index, target_core):
    input_path = os.path.join(input_directory, str(index))
    swap_cfg_path = os.path.join(input_path, 'spec.cfg')

    temp_file = os.path.join(wave_directory, f'.{index}_temp')
    system_call(f'nm {input_path}/dut.riscv | grep spdoc > {temp_file}')
    for line in open(temp_file):
        addr, _, _ = line.split()
        addr = int(addr, base=16)
        break
    system_call(f'rm {temp_file}')
    
    system_call(f'make -C {target_core} vcs STARSHIP_TESTCASE={swap_cfg_path} SIMULATION_LABEL=spec_{index%THREAD_NUM} SIMULATION_MODE=variant VCS_SPDOC_ADDR={addr}')
    for suffix in ['.live', '.csv', '.log', '.cov']:
        live_name = os.path.join(wave_directory, f'spec_{index%THREAD_NUM}.taint{suffix}')
        output_path = os.path.join(output_directory, f'{index}.taint{suffix}')
        system_call(f'cp {live_name} {output_path}')

    system_call(f'make -C {target_core} vcs STARSHIP_TESTCASE={swap_cfg_path} SIMULATION_LABEL=spec_{index%THREAD_NUM} SIMULATION_MODE=variant VCS_EARLY_EXIT=1')
    for suffix in ['.live', '.csv', '.log', '.cov']:
        live_name = os.path.join(wave_directory, f'spec_{index%THREAD_NUM}.taint{suffix}')
        output_path = os.path.join(output_directory, f'{index}.taint{suffix}.early')
        system_call(f'cp {live_name} {output_path}')

def casedataset_execute(repo_prefix):
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    case_dataset_path = os.path.join(current_folder, 'liveness_dataset')

    repo_path = os.path.join(current_folder, repo_prefix)
    if not os.path.exists(repo_path):
        os.mkdir(repo_path)

    for target_core in ['BOOM', 'BOOM_without_mask']:
        result_output_path = os.path.join(repo_path, target_core)
        if not os.path.exists(result_output_path):
            os.mkdir(result_output_path)

        wave_path = os.path.join(current_folder, target_core,\
            'build', 'vcs', 'BOOM_variant', 'wave')

        index_sum = len(os.listdir(case_dataset_path))
        index = 0
        while index < index_sum:
            index_list = []
            for i in range(THREAD_NUM):
                if index >= index_sum:
                    break
                index_list.append(index)
                index += 1

            thread_list = []
            for file_index in index_list:
                thread = threading.Thread(target=case_execute, \
                    args=(case_dataset_path, result_output_path, wave_path, file_index, target_core))
                thread.start()
                thread_list.append(thread)
            for thread in thread_list:
                thread.join()


if __name__ == "__main__":
    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'liveness_result_{time_str}'
    casedataset_execute(repo_prefix)

