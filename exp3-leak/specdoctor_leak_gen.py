import argparse
import os
import threading
import libconf
import time

def system_call(string):
    print(string)
    if os.system(string):
        exit()

def spec_fuzz(dirname:str):
    raw_dir_list = os.listdir(dirname)
    dir_list = []
    
    for file in raw_dir_list:
        if file.endswith('s0.riscv') and file.startswith('.t3'):
            dir_list.append(os.path.join(dirname, file))

    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    dataset_path = os.path.join(current_folder, 'leak_dataset', 'specdoctor', dirname.split('/')[-1])
    if not os.path.exists(dataset_path):
        os.mkdir(dataset_path)

    for index,file_name in enumerate(dir_list):
        case_path = os.path.join(dataset_path, str(index))
        if not os.path.exists(case_path):
            os.mkdir(case_path)

        dut_file_name = file_name
        dut_file_bin = os.path.join(case_path, f'dut.bin')
        vnt_file_name = file_name.replace('s0', 's1')
        vnt_file_bin = os.path.join(case_path, f'vnt.bin')
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
        
        config_name = os.path.join(case_path, f'spec.cfg')
        with open(config_name, 'wt') as file:
            libconf.dump(variant_template, file)

if __name__ == "__main__":
    directory = [
        # "/eda/specdoc-eval/S2M_ATTACKER",
        "/eda/specdoc-eval/S2M_VICTIM",
        # "/eda/specdoc-eval/S2M_VICTIM_2",
        "/eda/specdoc-eval/U2M_ATTACKER",
        "/eda/specdoc-eval/U2S_ATTACKER",
        "/eda/specdoc-eval/U2S_VICTIM",
        # "/eda/specdoc-eval/U2S_VICTIM_2",
    ]

    for dir_name in directory:
        spec_fuzz(dir_name)
    


    




