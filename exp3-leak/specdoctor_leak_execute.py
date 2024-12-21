import os
import time
import random
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

def specdoctor_case_execute(input_directory, output_directory, wave_directory, index):
    input_path = os.path.join(input_directory, str(index))
    swap_cfg_path = os.path.join(input_path, 'spec.cfg')
    cov_name = os.path.join(wave_directory, f'spec_{index%THREAD_NUM}.taint.cov')
    output_path = os.path.join(output_directory, f'{index}.taint.cov')
    system_call(f'make -C .. vcs STARSHIP_TESTCASE={swap_cfg_path} SIMULATION_LABEL=spec_{index%THREAD_NUM}')
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

    wave_path = os.path.join(current_folder, '..', 'starship-parafuzz',\
        'build', 'vcs', 'starship.asic.StarshipSimMiniConfig_BOOM_variant', 'wave')

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
                args=(case_dataset_path, result_output_path, wave_path, file_index))
            thread.start()
            thread_list.append(thread)
        for thread in thread_list:
            thread.join()


if __name__ == "__main__":
    repo_prefix = f'specdoctor_result_{hex(random.randint(0, 2**32-1))}'

    target_dataset = [
        'U2M_ATTACKER', 
        'S2M_ATTACKER',
        'U2S_ATTACKER',
        'U2S_VICTIM',
        'S2M_VICTIM',
    ]
    for case_dataset in target_dataset:
        specdoctor_casedataset_execute(case_dataset, repo_prefix)

