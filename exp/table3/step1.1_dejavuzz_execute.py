import datetime
import os
import time
import signal
import threading
import subprocess

from ptm import include, builder

include("../common/extern_dep.ptm")
inhouse_deps = include("../common/inhouse_dep.ptm")

TRIGGER_MAX_TIME = 30 * 60
EXAMINE_INTERVAL = 1 * 20
TARGET_TRIGGER_NUM = 500
TRIGGER_GROUP_NUM = 1

log_file = ""

start_time = time.time()

def record_log(filename, log_string):
    end_time = time.time()
    with open(filename, "a+") as file:
        file.write(f'{end_time - start_time}\t{log_string}\n')

def dejavuzz_record_log(log_string):
    record_log(log_file, log_string)

def execute_command(stop_event:threading.Event, command:str, sleep_interval):
    process = subprocess.Popen(command, shell=True, start_new_session=True)
    while not stop_event.is_set():
        if process.poll() is not None:
            dejavuzz_record_log('fuzz process died')
            break
        time.sleep(sleep_interval)
    if process.poll() is None:
        os.killpg(process.pid, signal.SIGTERM)

def dejavuzz_execute_and_analysis(repo_prefix, target_core, train_config, group_prefix):
    current_path = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_path)
    repo_path = os.path.join(current_folder, repo_prefix)
    global log_file
    log_file = os.path.join(repo_path, 'fuzz.log')
    if not os.path.exists(repo_path):
        os.makedirs(repo_path)
    if not os.path.exists(log_file):
        dejavuzz_record_log(f'create {log_file}')
    dejavuzz_record_log(f'fuzz {group_prefix}')

    fuzz_path = os.path.join(current_folder, 'build', f'{target_core}_{group_prefix}')
    assert not os.path.exists(fuzz_path), f"the repo {fuzz_path} has existed, please delete that repo or execute script again"
    command = f'make do-fuzz-trigger PREFIX={group_prefix} TARGET_CORE={target_core} TRAIN_CONFIG={train_config}'
    stop_event = threading.Event()
    fuzz_thread = threading.Thread(target=execute_command, args=(stop_event, command, EXAMINE_INTERVAL/4))
    fuzz_thread.start()

    trigger_iter_num_path = os.path.join(fuzz_path, 'template_repo', 'trigger_template')

    run_time_summary = 0
    trigger_time_counter = 0
    trigger_iter_num = 0
    last_trigger_iter_num = 0
    execute_result = False
    while fuzz_thread.is_alive():
        time.sleep(EXAMINE_INTERVAL)
        run_time_summary += EXAMINE_INTERVAL
        trigger_time_counter += EXAMINE_INTERVAL

        if os.path.exists(trigger_iter_num_path):
            trigger_iter_num = len(os.listdir(trigger_iter_num_path))

        if trigger_time_counter >= TRIGGER_MAX_TIME:
            new_trigger_iter_num = trigger_iter_num - last_trigger_iter_num
            dejavuzz_record_log(f'trigger_time:{trigger_time_counter}\ttrigger_num:{trigger_iter_num}\tlast_trigger_num:{last_trigger_iter_num}\tnew_trigger_num:{new_trigger_iter_num}')
            if new_trigger_iter_num == 0:
                dejavuzz_record_log(f'fuzz {group_prefix} fails, because new trigger time out')
                # print("trigger fuzz time out")
                break 
            trigger_time_counter %= TRIGGER_MAX_TIME
            last_trigger_iter_num = trigger_iter_num
        
        if trigger_iter_num >= TARGET_TRIGGER_NUM - 1:
            dejavuzz_record_log(f"fuzz {group_prefix} success")
            # print("fuzz success!!!")
            execute_result = True
            break
    else:
        dejavuzz_record_log(f"fuzz thread died")

    stop_event.set()
    fuzz_working_flag = os.path.join(current_folder, f'build/{target_core}_{group_prefix}/template_repo/fuzz_working_flag')
    if os.path.exists(fuzz_working_flag):
        os.system(f'rm {fuzz_working_flag}')
    fuzz_thread.join()

    return execute_result

def task(core, train_config, timestamp, log_dir):
    try:
        for i in range(TRIGGER_GROUP_NUM):
            while True:
                group_prefix = f'trigger_{train_config}_0{i}_{timestamp}'
                result = dejavuzz_execute_and_analysis(log_dir, core, train_config, group_prefix)
                if result:
                    break
    except Exception as e:
        dejavuzz_record_log('main program died')
        current_path = os.path.abspath(__file__)
        current_folder = os.path.dirname(current_path)
        fuzz_working_flag = os.path.join(current_folder, f'build/{core}_{group_prefix}/template_repo/fuzz_working_flag')
        if os.path.exists(fuzz_working_flag):
            os.system(f'rm {fuzz_working_flag}')
        raise e

if __name__ == "__main__":
    # Setup the environment variable and dependencies
    builder.build(inhouse_deps.setup_dependencies)

    time_str = datetime.datetime.now().strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'ae_{time_str}'

    threads = []

    cfg = [
        ('BOOM', 'dejavuzz'),
        ('XiangShan', 'dejavuzz'),
        ('BOOM', 'dejavuzz_rdm'),
        ('XiangShan', 'dejavuzz_rdm')
    ]

    for core, train_config in cfg:
        time.sleep(1)
        thread = threading.Thread(target=task, args=(core, train_config, time_str, repo_prefix))
        thread.start()
        threads.append(thread)

    for thread in threads:
        thread.join()
