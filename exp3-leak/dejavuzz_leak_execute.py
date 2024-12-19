import random
import os
import time
import signal
import threading
import subprocess

ITER_NUM = 5
LEAK_MAX_TIME = 30 * 60
EXAMINE_INTERVAL = 1 * 60
TARGET_LEAK_NUM = 20000

def execute_command(stop_event:threading.Event, command:str, sleep_interval):
    print(command)
    process = subprocess.Popen(command, shell=True, preexec_fn=os.setpgrp)
    while not stop_event.is_set():
        if process.poll() is not None:
            break
        time.sleep(sleep_interval)
    os.killpg(process.pid, signal.SIGTERM)
    print("process terminal")
    time.sleep(1)

def dejavuzz_execute_and_analysis(repo_prefix, group_prefix):
    current_path = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_path)
    repo_path = os.path.join(current_folder, repo_prefix)
    if not os.path.exists(repo_path):
        os.mkdir(repo_path)

    fuzz_path = os.path.join(current_folder, '..', 'build', f'BOOM_{group_prefix}')
    assert not os.path.exists(fuzz_path), f"the repo {fuzz_path} has existed, please delete that repo or execute script again"
    command = f'make -C .. do-fuzz TARGET_CORE=BOOM PREFIX={group_prefix}'
    stop_event = threading.Event()
    fuzz_thread = threading.Thread(target=execute_command, args=(stop_event, command, EXAMINE_INTERVAL/4))
    fuzz_thread.start()

    leak_iter_num_path = os.path.join(fuzz_path, 'template_repo', 'leak_iter_num')

    run_time_summary = 0
    leak_time_counter = 0
    leak_iter_num = 0
    execute_result = False
    while fuzz_thread.is_alive():
        time.sleep(EXAMINE_INTERVAL)
        run_time_summary += EXAMINE_INTERVAL
        leak_time_counter += EXAMINE_INTERVAL

        old_leak_iter_num = leak_iter_num
        if os.path.exists(leak_iter_num_path):
            with open(leak_iter_num_path, 'rt') as file:
                leak_iter_num = int(file.read())
        new_leak_iter_num = leak_iter_num - old_leak_iter_num

        if leak_time_counter >= LEAK_MAX_TIME:
            if new_leak_iter_num == 0:
                print("leak fuzz time out")
                break
            leak_time_counter %= LEAK_MAX_TIME

        if leak_iter_num >= TARGET_LEAK_NUM - 1:
            print("fuzz success!!!")
            execute_result = True
            break

    stop_event.set()
    fuzz_thread.join()

    if execute_result:
        command = f'make -C .. analysis TARGET_CORE=BOOM PREFIX={group_prefix}'
        assert not os.system(command), f"fails to analysis {group_prefix}"
        from_path = os.path.join(fuzz_path, 'analysis_result', 'full_curve')
        to_path = os.path.join(repo_path, group_prefix)
        command = f'cp {from_path} {to_path}'
        assert not os.system(command), f"fails to copy {from_path}"

    return execute_result

if __name__ == "__main__":
    repo_prefix = f'dejavuzz_result_{hex(random.randint(0, 2**32-1))}'
    print(f"the dejavuzz coverage info is stored in {repo_prefix}")

    iter_num = 0
    while iter_num < ITER_NUM:
        start = time.time()
        group_prefix = f'group_{hex(random.randint(0, 2**32-1))}'
        result = dejavuzz_execute_and_analysis(repo_prefix, group_prefix)
        end = time.time()
        time_interval = end - start
        print("use time:", time_interval/3600.0, "h")
        if result:
            print("dejavuzz executes successfully")
            iter_num += 1
        else:
            print("dejavuzz executed failed")