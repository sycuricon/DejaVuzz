import os
import threading
import time
import datetime
from ptm import include, builder

include("../common/extern_dep.ptm")
inhouse_deps = include("../common/inhouse_dep.ptm")

THREAD_NUM = int(inhouse_deps.num_cores / 4)

semaphore = threading.Semaphore(THREAD_NUM)

def get_case_dataset():
    case_dataset = os.path.join(inhouse_deps.dep_root, 'dataset', 'table5')
    assert os.path.exists(case_dataset), "the cell_dataset does not exists!!!"
    return case_dataset

def run_testcase(core, cfg_path, label, result_path, output_path):
    with semaphore:
        if os.system(f'make vcs SIM_MODE=variant TARGET_CORE={core} STARSHIP_TESTCASE={cfg_path} SIMULATION_LABEL={label}'):
            raise Exception(f'Failed to simulate the testcase')

        for res_type in ["taint.live", "taint.log"]:
            if os.system(f'cp {result_path}/{label}.{res_type} {output_path}/{label}.{res_type}'):
                raise Exception(f'Failed to copy the taint result file')

def traversal_case_execute(output_prefix):
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)

    output_dir = os.path.join(current_folder, output_prefix)
    if not os.path.exists(output_dir):
        os.mkdir(output_dir)

    threads = []
    case_path = get_case_dataset()
    for testcase in os.listdir(case_path):
        swap_mem_cfg = os.path.join(case_path, testcase, 'leak', 'swap_mem.cfg')
        core = 'BOOM' if 'boom' in testcase.lower() else 'XiangShan'
        wave_path = os.path.join(current_folder, 'starship-dejavuzz', 'build', 'vcs', f'starship.asic.StarshipSimMiniConfig_{core}_variant', 'wave')
        thread = threading.Thread(target=run_testcase, args=(core, swap_mem_cfg, testcase, wave_path, output_dir))
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()

if __name__ == "__main__":
    # Setup the environment variable and dependencies
    builder.build(inhouse_deps.setup_dependencies)

    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'ae_{time_str}'
    traversal_case_execute(repo_prefix)