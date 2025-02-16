import os
import hjson
from trigger_replace_path import *

trigger_type_list = [
    'load/store access fault', 'load/store page fault', 'load/store misalign', 'illegal instruction',
    'memory  disambiguation', 'branch mispredict', 'indirect jump mispredict', 'return address mispredict', 'straight line speculation'
]

trigger_type_map = {
    'store_page_fault':'load/store page fault',
    'load_page_fault':'load/store page fault',
    'load_access_fault':'load/store access fault',
    'store_access_fault':'load/store access fault',
    'load_misalign':'load/store misalign',
    'store_misalign':'load/store misalign',
    'illegal':'illegal instruction',
    'v4':'memory  disambiguation',
    'branch':'branch mispredict',
    'jalr':'indirect jump mispredict',
    'return':'return address mispredict',
    'next':'straight line speculation'
}

def init_overhead_dict():
    return {trigger_type:{'valid_num':0, 'line_num':0, 'case_num':0} for trigger_type in trigger_type_list}

def statistic_trigger(folder_name):
    trigger_code_path = os.path.join(folder_name, 'fuzz_code')
    trigger_record_path = os.path.join(folder_name, 'trigger_iter_record')
    with open(trigger_record_path, 'rt') as file:
        trigger_record = hjson.loads(f'[{file.read()}]')

    overhead = init_overhead_dict()
    
    for record in trigger_record:
        if record['result'] != 'FuzzResult.SUCCESS':
            continue
        iter_num = record['iter_num']
        trigger_type = ((record['trans']['victim']['block_info']['trigger_block']['type']).split('.')[-1]).lower()
        trigger_type = trigger_type_map[trigger_type]
        case_path = os.path.join(trigger_code_path, f'trigger_{iter_num}')

        # print(trigger_type, len(record['trans']['train']))
        if trigger_type in ['branch mispredict', 'indirect jump mispredict', 'return address mispredict'] and len(record['trans']['train']) == 0:
            trigger_type = 'straight line speculation'


        line_num = 0
        valid_num = 0
        for filename in os.listdir(case_path):
            if filename.endswith('.S') and '1' not in filename and '2' not in filename and '3' not in filename:
                filename = os.path.join(case_path, filename)
                for line in open(filename):
                    line = line.strip()
                    if line.startswith('return_block_entry') or line.startswith('nop_ret_block_entry'):
                        break
                    if line != '' and line[0] != '.' and line[0] != '#' and line[-1] != ':':
                        if line != 'nop' and line != 'c.nop':
                            valid_num += 1
                        line_num += 1 

        overhead[trigger_type]['line_num'] += line_num
        overhead[trigger_type]['valid_num'] += valid_num
        overhead[trigger_type]['case_num'] += 1
    
    return overhead

def statstic_type(case_dataset:str, kind_name):
    overhead = init_overhead_dict()

    for group_name in os.listdir(case_dataset):
        if group_name.startswith(kind_name):
            group_path = os.path.join(case_dataset, group_name)
            group_overhead = statistic_trigger(group_path)
            for key, value in group_overhead.items():
                overhead[key]['line_num'] += value['line_num']
                overhead[key]['valid_num'] += value['valid_num']
                overhead[key]['case_num'] += value['case_num']
    
    print(f'{kind_name}:')

    for key, value in overhead.items():
        case_num = value['case_num']
        line_num = value['line_num']
        valid_num = value['valid_num']
        if case_num == 0:
            ave_line_num = '*'
            ave_valid_num = '*'
            print(f'{key}:\tave_line_num:{ave_line_num}\tave_valid_num:{ave_valid_num}')
        else:
            ave_line_num = line_num/case_num
            ave_valid_num = valid_num/case_num
            print(f'{key}:\tave_line_num:{ave_line_num:.1f}\tave_valid_num:{ave_valid_num:.1f}')

    print()
        
if __name__ == "__main__":
    case_dataset = get_case_dataset()
    statstic_type(case_dataset, 'BOOM_trigger_test')
    statstic_type(case_dataset, 'BOOM_random_trigger_test')
    statstic_type(case_dataset, 'XiangShan_trigger_test')
    statstic_type(case_dataset, 'XiangShan_random_trigger_test')