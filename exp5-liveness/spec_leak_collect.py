import argparse
import os
import threading
import libconf
import time

liveness_index = 0

def system_call(string):
    print(string)
    if os.system(string):
        exit()

def store_spec_liveness(filename, live_log):
    global liveness_index
    current_path = os.path.dirname(os.path.abspath(__file__))
    dataset_path = os.path.join(current_path, 'liveness_dataset')
    case_path = os.path.join(dataset_path, str(liveness_index))
    if not os.path.exists(case_path):
        os.mkdir(case_path)

    dut_file_name = filename
    dut_file_bin = os.path.join(case_path, f'dut.bin')
    vnt_file_name = filename.replace('s0', 's1')
    vnt_file_bin = os.path.join(case_path, f'vnt.bin')
    system_call(f'riscv64-unknown-elf-objcopy -O binary {dut_file_name} {dut_file_bin}')
    system_call(f'riscv64-unknown-elf-objcopy -O binary {vnt_file_name} {vnt_file_bin}')
    system_call(f'cp {dut_file_name} {case_path}/dut.riscv')
    system_call(f'cp {vnt_file_name} {case_path}/vnt.riscv')
    system_call(f'cp {live_log} {case_path}')

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
    
    config_name = os.path.join(case_path, f'spec.cfg')
    with open(config_name, 'wt') as file:
        libconf.dump(variant_template, file)
    
    # variant_template['memory_regions'][1]['init_file'] = dut_file_bin
    # config_name = os.path.join(case_path, f'no_diff.cfg')
    # with open(config_name, 'wt') as file:
    #     libconf.dump(variant_template, file)
    
    liveness_index += 1

def spec_leak_collect(dirname):
    raw_dir_list = os.listdir(dirname)
    dir_list = []
    live_log_path = os.path.join(dirname, 'diff', 'log')
    log_index = set()
    log_table = {}
    for filename in os.listdir(live_log_path):
        if not filename.endswith('.log'):
            continue
        logname = filename
        tokens = filename[:-4].split('_')
        log_index.add((int(tokens[3]),int(tokens[8]),int(tokens[9])))
        log_table[f'{tokens[3]}_{tokens[8]}_{tokens[9]}'] = os.path.join(live_log_path, logname)
    # print(log_index)
    for filename in raw_dir_list:
        if filename.startswith('.t3') and filename.endswith('.log'):
            filename = filename[:-4]
            tokens = filename.split('_')
            if len(tokens) < 8:
                continue
            elif (int(tokens[8]),int(tokens[13]),int(tokens[14])) in log_index:
                leakname = os.path.join(dirname, f'.t3_input_{tokens[2]}_{tokens[3]}_s0.riscv')
                if os.path.exists(leakname):
                    store_spec_liveness(leakname, log_table[f'{tokens[8]}_{tokens[13]}_{tokens[14]}'])
                else:
                    pass

def all_spec_leak_collect():
    if not os.path.exists('liveness_dataset'):
        os.mkdir('liveness_dataset')
    dir_list = []
    spec_eval_dir_list = [
        "/eda/specdoc-eval/S2M_ATTACKER",
        "/eda/specdoc-eval/U2S_ATTACKER",
        "/eda/specdoc-eval/U2M_ATTACKER",
        "/eda/specdoc-eval/S2M_VICTIM",
        "/eda/specdoc-eval/U2S_VICTIM",
        # "/eda/specdoc-eval/S2M_VICTIM_2",
        # "/eda/specdoc-eval/U2S_VICTIM_2",
    ]
    for spec_eval_dir in spec_eval_dir_list:
        spec_leak_collect(spec_eval_dir)

all_spec_leak_collect()

    


