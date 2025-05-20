import os
import time
import datetime
import threading

from ptm import include, builder

inhouse_deps = include("../common/inhouse_dep.ptm")
sota_deps = include("../common/competitor_dep.ptm")

THREAD_NUM = int(inhouse_deps.num_cores / 4)
semaphore = threading.Semaphore(THREAD_NUM)

def get_case_dataset():
    case_dataset = os.path.join(inhouse_deps.dep_root, 'dataset', 'table4_figure6')
    assert os.path.exists(case_dataset), "the cell_dataset does not exists!!!"
    return case_dataset

def system_call(string):
    print(string)
    for i in range(3):
        if os.system(string) != 0:
            time.sleep(10)
        else:
            return
    else:
        raise Exception('cannot handle this system call by delay')

def case_execute(cfg_name, core, swap_cfg_path, output_directory, wave_directory, case_label, tb_path, mode, copy_log, log_file):
    start = time.time()
    system_call(f'make -C {tb_path} vcs STARSHIP_CORE={core} STARSHIP_TESTCASE={swap_cfg_path} SIMULATION_LABEL={case_label} SIMULATION_MODE={mode}')
    finish = time.time()

    if log_file:
        with open(log_file, 'a+') as file:
            file.write(f'{cfg_name} {case_label} simulation:\t{finish-start:.2f}s\n')

    if copy_log:
        for suffix in ['live', 'csv', 'log', 'cov']:
            live_name = os.path.join(wave_directory, f'{case_label}.taint.{suffix}')
            output_path = os.path.join(output_directory, f'{case_label}.taint.{suffix}')
            system_call(f'cp {live_name} {output_path}')

def casedataset_execute(repo_prefix):
    case_dataset_path = get_case_dataset()
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    record_file = os.path.join(repo_prefix, f'time.log')

    repo_path = os.path.join(current_folder, repo_prefix)
    if not os.path.exists(repo_path):
        os.mkdir(repo_path)

    cfg = [
        ("base_BOOM", "starship-dejavuzz", "BOOM", "robprofile", False, record_file),
        ("base_XS", "starship-dejavuzz", "XiangShan", "robprofile", False, record_file),
        ("diffift_BOOM", "starship-dejavuzz", "BOOM", "variant", True, record_file),
        ("diffift_XS", "starship-dejavuzz", "XiangShan", "variant", True, record_file),
        ("cellift_BOOM", "starship-cellift", "BOOM", "taint", True, record_file),
        ("diffift_fn_BOOM", "starship-dejavuzz-fn", "BOOM", "variant", True, None)
    ]


    threads = []
    for cfg_name, tb_path, core, mode, copy_log, log_file in cfg:
        result_output_path = os.path.join(repo_path, cfg_name)
        if not os.path.exists(result_output_path):
            os.mkdir(result_output_path)

        wave_path = os.path.join(current_folder, tb_path, 'build', 'vcs', f'starship.asic.StarshipSimMiniConfig_{core}_{mode}', 'wave')
        
        for case_path in os.listdir(case_dataset_path):
            swap_cfg_path = os.path.join(case_dataset_path, case_path, 'no_diff.cfg' if "fn" in cfg_name else 'swap_mem.cfg')
            thread = threading.Thread(target=case_execute, args=(cfg_name, core, swap_cfg_path, result_output_path, wave_path, case_path, tb_path, mode, copy_log, log_file))
            thread.start()
            threads.append(thread)

    for thread in threads:
        thread.join()

    with open(record_file, 'a+') as file:
        file.write(f'\n\n')


if __name__ == "__main__":
    # Setup the environment variable and dependencies
    builder.build(inhouse_deps.setup_dependencies)
    builder.build(sota_deps.figure6_dependencies)

    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'ae_sim_{time_str}'
    for i in range(1):
        casedataset_execute(repo_prefix)
