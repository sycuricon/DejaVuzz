import os

def trigger_analysis(build_path, target_core, prefix_list):
    trigger_statistic = {}

    for prefix in prefix_list:
        repo_path = os.path.join(build_path, f'{target_core}_{prefix}.template_repo', 'trigger_analysis_result.md')
        with open(repo_path) as file:
            lines = file.readlines()[2::2]
        for line in lines:
            trigger_type, train_type, summary, success, rate = line.strip().strip('|').split('|')
            summary = int(summary)
            success = int(success)
            rate = float(rate)
            if trigger_type in trigger_statistic:
                trigger_statistic[trigger_type]['summary'] += summary
                trigger_statistic[trigger_type]['success'] += success
            else:
                trigger_statistic[trigger_type] = {
                    'summary': summary,
                    'success': success,
                }

    table_entry = [
        'access fault',
        'page fault',
        'illegal',
        'misalign',
        'load store bypass',
        'branch mispredict',
        'indirect jump mispredict',
        'return address mispredict',
    ]

    table = {}
    summary = 0
    for head in table_entry:
        table[head] = {
            'success':0,
            'summary':0,
            'success_rate':0,
            'summary_rate':0
        }

    for trigger_type, content in trigger_statistic.items():
        entry = None
        match trigger_type:
            case 'jalr':
                entry = 'indirect jump mispredict'
            case 'store_page_fault'|'load_page_fault':
                entry = 'page fault'
            case 'load_access_fault'|'store_access_fault':
                entry = 'access fault'
            case 'load_misalign'|'store_misalign':
                entry = 'misalign'
            case 'v4':
                entry = 'load store bypass'
            case 'branch':
                entry = 'branch mispredict'
            case 'return':
                entry = 'return address mispredict'
            case 'illegal':
                entry = 'illegal'
            case _:
                raise Exception(f'{trigger_type} can not be statisted')
        table[entry]['success'] += content['success']
        table[entry]['summary'] += content['summary']
        summary += content['success']

    for entry in table.keys():
        try:
            table[entry]['success_rate'] = table[entry]['success']/table[entry]['summary']
        except ZeroDivisionError:
            table[entry]['success_rate'] = 0
        try:
            table[entry]['summary_rate'] = table[entry]['success']/summary
        except ZeroDivisionError:
            table[entry]['summary_rate'] = 0
    
    sum_line = 0
    sum_valid = 0
    sum_case = 0
    for prefix in prefix_list:
        repo_path = os.path.join(build_path, f'{target_core}_{prefix}.template_repo', 'reduce_analysis_result.md')
        with open(repo_path, "rt") as file:
            lines = file.readlines()
            line_num = float(lines[0].strip().split()[-1])
            valid_num = float(lines[1].strip().split()[-1])
        repo_path = os.path.join(build_path, f'{target_core}_{prefix}.template_repo', 'trigger_template')
        case_num = len(os.listdir(repo_path))
        sum_line += case_num * line_num
        sum_valid += case_num * valid_num
        sum_case += case_num
        print(case_num, line_num, valid_num)
    print()
    table['overhead'] = {'line_num':sum_line/sum_case, 'valid_num':sum_valid/sum_case}
    return table

final_table = {}

build_path = 'build'
target_core = 'BOOM'
prefix_list = [
    'trigger_test_00',
    'trigger_test_03',
]
final_table['BOOM-I'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'unalign_trigger_test_00',
    'unalign_trigger_test_01',
    'unalign_trigger_test_02',
    'unalign_trigger_test_03',
]
final_table['BOOM-II'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'random_trigger_test_00',
    'random_trigger_test_01',
    'random_trigger_test_02',
    'random_trigger_test_03',
]
final_table['BOOM-III'] = trigger_analysis(build_path, target_core, prefix_list)

target_core = 'XiangShan'
prefix_list = [
    'trigger_test_01',
    'trigger_test_02',
    'trigger_test_03',
]
final_table['XiangShan-I'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'unalign_trigger_test_00',
    'unalign_trigger_test_02',
    'unalign_trigger_test_03',
]
final_table['XiangShan-II'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'random_trigger_test_01',
    'random_trigger_test_02',
    'random_trigger_test_03',
]
final_table['XiangShan-III'] = trigger_analysis(build_path, target_core, prefix_list)

table_entry = [
        'access fault',
        'page fault',
        'illegal',
        'misalign',
        'load store bypass',
        'branch mispredict',
        'indirect jump mispredict',
        'return address mispredict',
    ]
with open('trigger_statstic.md', 'wt') as file:
    file.write('|type|')
    for entry in table_entry:
        file.write(f'{entry}|')
    file.write('overhead|\n')
    
    file.write('|')
    for _ in range(len(table_entry)+2):
        file.write('----|')
    file.write('\n')

    for trigger_type, sub_table in final_table.items():
        file.write(f'|{trigger_type}|')
        for entry in table_entry:
            file.write(f"{round(sub_table[entry]['summary_rate']*100, 2)}%({round(sub_table[entry]['success_rate']*100, 2)}%)|")
        file.write(f"{round(sub_table['overhead']['line_num'], 2)}({round(sub_table['overhead']['valid_num'], 2)})|\n")
        
