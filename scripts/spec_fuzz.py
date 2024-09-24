import argparse
import os
import threading
import libconf
import time

def system_call(string):
    print(string)
    for i in range(3):
        if os.system(string) != 0:
            time.sleep(10)
        else:
            return
    else:
        raise Exception('cannot handle this system call by delay')

def testcase_run(file_name, output_name, index, log_index, log_path, mode):
    cur_path = os.path.abspath(os.curdir)

    dut_file_name = file_name
    dut_file_bin = os.path.join(cur_path, f'dut_{index}.bin')
    vnt_file_name = file_name.replace('s1', 's0')
    vnt_file_bin = os.path.join(cur_path, f'vnt_{index}.bin')
    system_call(f'riscv64-unknown-elf-objcopy -O binary {dut_file_name} {dut_file_bin}')
    system_call(f'riscv64-unknown-elf-objcopy -O binary {vnt_file_name} {vnt_file_bin}')

    variant_template = {
        'start_addr': libconf.LibconfInt64(0x8000_0000),
        'max_mem_size': libconf.LibconfInt64(0x8000_0000),
        'memory_regions': (
            {
                'type': 'dut',
                'start_addr': libconf.LibconfInt64(0x8000_0000),
                'max_len': libconf.LibconfInt64(0x8000_0000),
                'init_file': dut_file_bin,
            },
            {
                'type': 'vnt',
                'start_addr': libconf.LibconfInt64(0x8000_0000),
                'max_len': libconf.LibconfInt64(0x8000_0000),
                'init_file': vnt_file_bin,
            }
        )
    }
    
    config_name = os.path.join(cur_path, f'spec_{index}.cfg')
    with open(config_name, 'wt') as file:
        libconf.dump(variant_template, file)

    system_call(f'make vcs STARSHIP_TESTCASE={config_name} SIMULATION_LABEL=spec_{index}')
    match mode:
        case 'cov':
            cov_name = os.path.join(log_path, f'spec_{index}.taint.cov')
            system_call(f'cp {cov_name} {output_name}/{log_index}.taint.cov')
        case 'live':
            for suffix in ['.live', '.csv', '.log', '.cov']:
                live_name = os.path.join(log_path, f'spec_{index}.taint{suffix}')
                system_call(f'cp {live_name} {output_name}/{log_index}.taint{suffix}')
            system_call(f'make vcs STARSHIP_TESTCASE={config_name} SIMULATION_LABEL=spec_{index} VCS_EARLY_EXIT=1')
            for suffix in ['.live', '.csv', '.log', '.cov']:
                live_name = os.path.join(log_path, f'spec_{index}.taint{suffix}')
                system_call(f'cp {live_name} {output_name}/{log_index}.taint{suffix}.early')
            print("live_log", file_name, log_index)
        case _:
            raise Exception('mode must be cov or live')


def spec_fuzz(dirname, output_name, thread_num, log_path, start, mode):
    assert mode in ['cov','live'], "the mode must be cov or live"

    thread_num = int(thread_num)
    start = int(start)
    if not os.path.exists(output_name):
        os.mkdir(output_name)
    raw_dir_list = os.listdir(dirname)
    dir_list = []
    
    match mode:
        case 'cov':
            for file in raw_dir_list:
                if file.endswith('s0.riscv') and file.startswith('.t3'):
                    dir_list.append(file)
        case 'live':
            live_log_path = os.path.join(dirname, 'diff', 'log')
            log_index = set()
            for filename in os.listdir(live_log_path):
                filename = filename[:-4]
                tokens = filename.split('_')
                log_index.add((int(tokens[3]),int(tokens[8]),int(tokens[9])))
            # print(log_index)
            for filename in raw_dir_list:
                if filename.startswith('.t3') and filename.endswith('.log'):
                    filename = filename[:-4]
                    tokens = filename.split('_')
                    if len(tokens) < 8:
                        continue
                    elif (int(tokens[8]),int(tokens[13]),int(tokens[14])) in log_index:
                        dir_list.append(f'.t3_input_{tokens[2]}_{tokens[3]}_s0.riscv')
        case _:
            raise Exception('mode must be live or cov')

    index = start
    log_index = start
    while index < len(dir_list):
        file_name_list = []
        for i in range(thread_num):
            if index >= len(dir_list):
                break
            file_name = os.path.join(dirname, dir_list[index])
            index += 1
            file_name_list.append(file_name)

        thread_list = []
        for i,file_name in enumerate(file_name_list):
            thread = threading.Thread(target=testcase_run, args=(file_name, output_name, i, log_index, log_path, mode))
            log_index += 1
            thread.start()
            thread_list.append(thread)
        for thread in thread_list:
            thread.join()


parser = argparse.ArgumentParser()
parser.add_argument("-I", "--input", dest="input", required=True, help="dirname of the testcase from specdoctor")
parser.add_argument("-O", "--output", dest="output", required=True, help="dirname to store the coverage of the specdoctor")
parser.add_argument("--thread", dest="thread", required=True, help="the number of thread to fuzz testcase")
parser.add_argument("--log_path", dest="log_path", required=True, help="the log path of the fuzz")
parser.add_argument("--start", dest="start", required=True, help="the index beginning to fuzz")
parser.add_argument("--mode", dest="mode", required=True, help="the work mode for specdoctor")


args = parser.parse_args()
spec_fuzz(args.input, args.output, args.thread, args.log_path, args.start, args.mode)




