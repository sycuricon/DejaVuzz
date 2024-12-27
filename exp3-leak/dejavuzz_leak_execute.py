import datetime
import os
import time
import signal
import threading
import subprocess

LEAK_MAX_TIME = 30 * 60
EXAMINE_INTERVAL = 1 * 60
TARGET_LEAK_NUM = 20000

log_file = ""

start_time = time.time()

def record_log(filename, log_string):
    end_time = time.time()
    with open(filename, "a+") as file:
        file.write(f'{end_time - start_time}\t{log_string}\n')

def dejavuzz_record_log(log_string):
    record_log(log_file, log_string)

def execute_command(stop_event:threading.Event, command:str, sleep_interval):
    process = subprocess.Popen(command, shell=True, preexec_fn=os.setpgrp)
    while not stop_event.is_set():
        if process.poll() is not None:
            dejavuzz_record_log('fuzz process died')
            break
        time.sleep(sleep_interval)
    if process.poll() is None:
        os.killpg(process.pid, signal.SIGTERM)

def dejavuzz_execute_and_analysis(repo_prefix, group_prefix):
    current_path = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_path)
    repo_path = os.path.join(current_folder, repo_prefix)
    global log_file
    log_file = os.path.join(repo_path, 'fuzz.log')
    if not os.path.exists(repo_path):
        os.mkdir(repo_path)
    if not os.path.exists(log_file):
        dejavuzz_record_log(f'create {log_file}')
    dejavuzz_record_log(f'fuzz {group_prefix}')

    fuzz_path = os.path.join(current_folder, 'build', f'BOOM_{group_prefix}')
    assert not os.path.exists(fuzz_path), f"the repo {fuzz_path} has existed, please delete that repo or execute script again"
    command = f'make do-fuzz TARGET_CORE=BOOM PREFIX={group_prefix}'
    stop_event = threading.Event()
    fuzz_thread = threading.Thread(target=execute_command, args=(stop_event, command, EXAMINE_INTERVAL/4))
    fuzz_thread.start()

    leak_iter_num_path = os.path.join(fuzz_path, 'template_repo', 'leak_iter_num')

    run_time_summary = 0
    leak_time_counter = 0
    leak_iter_num = 0
    last_leak_iter_num = 0
    execute_result = False
    while fuzz_thread.is_alive():
        time.sleep(EXAMINE_INTERVAL)
        run_time_summary += EXAMINE_INTERVAL
        leak_time_counter += EXAMINE_INTERVAL

        if os.path.exists(leak_iter_num_path):
            with open(leak_iter_num_path, 'rt') as file:
                leak_iter_num = int(file.read())

        if leak_time_counter >= LEAK_MAX_TIME:
            new_leak_iter_num = leak_iter_num - last_leak_iter_num
            dejavuzz_record_log(f'leak_time:{leak_time_counter}\tleak_num:{leak_iter_num}\tlast_leak_num:{last_leak_iter_num}\tnew_leak_num:{new_leak_iter_num}')
            if new_leak_iter_num == 0:
                dejavuzz_record_log(f'fuzz {group_prefix} fails, because new leak time out')
                # print("leak fuzz time out")
                break 
            leak_time_counter %= LEAK_MAX_TIME
            last_leak_iter_num = leak_iter_num
        
        if leak_iter_num >= TARGET_LEAK_NUM - 1:
            dejavuzz_record_log(f"fuzz {group_prefix} success")
            # print("fuzz success!!!")
            execute_result = True
            break
    else:
        dejavuzz_record_log(f"fuzz thread died")

    stop_event.set()
    fuzz_working_flag = os.path.join(current_folder, f'build/BOOM_{group_prefix}/template_repo/fuzz_working_flag')
    if os.path.exists(fuzz_working_flag):
        os.system(f'rm {fuzz_working_flag}')
    fuzz_thread.join()

    if execute_result:
        command = f'make analysis TARGET_CORE=BOOM PREFIX={group_prefix}'
        assert not os.system(command), f"fails to analysis {group_prefix}"
        from_path = os.path.join(fuzz_path, 'analysis_result', 'full_curve')
        to_path = os.path.join(repo_path, group_prefix)
        command = f'cp {from_path} {to_path}'
        assert not os.system(command), f"fails to copy {from_path}"
        dejavuzz_record_log(f'store coverage of {group_prefix}')

    return execute_result

if __name__ == "__main__":
    current_time = datetime.datetime.now()
    time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    repo_prefix = f'dejavuzz_result_{time_str}'

    try:
        while True:
            group_prefix = time_str
            result = dejavuzz_execute_and_analysis(repo_prefix, group_prefix)
            if result:
                break
            current_time = datetime.datetime.now()
            time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
    except Exception as e:
        dejavuzz_record_log('main program died')
        current_path = os.path.abspath(__file__)
        current_folder = os.path.dirname(current_path)
        fuzz_working_flag = os.path.join(current_folder, f'build/BOOM_{group_prefix}/template_repo/fuzz_working_flag')
        if os.path.exists(fuzz_working_flag):
            os.system(f'rm {fuzz_working_flag}')
        raise e