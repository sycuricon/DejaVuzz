import os
import time
import datetime
import threading

THREAD_NUM = 96

def system_call(string):
    print(string)
    for i in range(3):
        if os.system(string) != 0:
            time.sleep(10)
        else:
            return
    else:
        raise Exception('cannot handle this system call by delay')

def specdoctor_case_execute(input_directory, output_directory, wave_directory, index, repo_prefix):
    input_path = os.path.join(input_directory, str(index))
    temp_file = os.path.join(output_directory, f'.{repo_prefix}_{index}_temp')
    system_call(f'nm {os.path.join(input_path, "dut.elf")} | grep spdoc > {temp_file}')
    for line in open(temp_file):
        spec_addr, _, _ = line.split()
        spec_addr = int(spec_addr, base=16)
        break
    system_call(f'nm {os.path.join(input_path, "dut.elf")} | grep transient$ > {temp_file}')
    for line in open(temp_file):
        tsx_addr, _, _ = line.split()
        tsx_addr = int(tsx_addr, base=16)
        break
    system_call(f'rm {temp_file}')
    
    swap_cfg_path = os.path.join(input_path, 'spec.cfg')
    system_call(f'make -C specdoctor vcs STARSHIP_TESTCASE={swap_cfg_path} SIMULATION_LABEL={repo_prefix}_{index%THREAD_NUM} SIMULATION_MODE=variant VCS_SPDOC_ADDR={spec_addr} VCS_TSX_ADDR={tsx_addr}')
    for suffix in ['.live', '.csv', '.log', '.cov']:
        cov_name = os.path.join(wave_directory, f'{repo_prefix}_{index%THREAD_NUM}.taint{suffix}')
        output_path = os.path.join(output_directory, f'{index}.taint{suffix}')
        system_call(f'cp {cov_name} {output_path}')

def specdoctor_casedataset_execute(target_dataset, repo_prefix):
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    leak_dataset_path = os.path.join(current_folder, 'leak_dataset')
    specdoctor_path = os.path.join(leak_dataset_path, 'specdoctor')
    case_dataset_path = os.path.join(specdoctor_path, target_dataset)

    repo_path = os.path.join(current_folder, repo_prefix)
    if not os.path.exists(repo_path):
        os.mkdir(repo_path)
    result_output_path = os.path.join(repo_path, target_dataset)
    if not os.path.exists(result_output_path):
        os.mkdir(result_output_path)

    wave_path = os.path.join(current_folder, 'specdoctor',\
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
            thread = threading.Thread(target=specdoctor_case_execute, \
                args=(case_dataset_path, result_output_path, wave_path, file_index, repo_prefix))
            thread.start()
            thread_list.append(thread)
        for thread in thread_list:
            thread.join()


if __name__ == "__main__":
    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'specdoctor_result_{time_str}'

    target_dataset = [
        'spec_0', 
        'spec_1',
        'spec_2',
        'spec_3',
        'spec_4',
    ]
    for case_dataset in target_dataset:
        specdoctor_casedataset_execute(case_dataset, repo_prefix)

