import os

def trigger_analysis(build_path, target_core, prefix_list):
    trigger_statistic = {}

    for prefix in prefix_list:
        # os.system(f'make analysis PREFIX={prefix} TARGET_CORE={target_core}')
        repo_path = os.path.join(build_path, f'{target_core}_{prefix}.template_repo', 'trigger_analysis_result.md')
        with open(repo_path) as file:
            lines = file.readlines()[2::2]
        for line in lines:
            trigger_type, train_type, summary, success, rate, line_num, valid_num, case_num = line.strip().strip('|').split('|')
            summary = int(summary)
            success = int(success)
            rate = float(rate)
            line_num = int(line_num)
            valid_num = int(valid_num)
            case_num = int(case_num)
            if trigger_type in trigger_statistic:
                trigger_statistic[trigger_type]['summary'] += summary
                trigger_statistic[trigger_type]['success'] += success
                trigger_statistic[trigger_type]['line_num'] += line_num
                trigger_statistic[trigger_type]['valid_num'] += valid_num
                trigger_statistic[trigger_type]['case_num'] += case_num
            else:
                trigger_statistic[trigger_type] = {
                    'summary': summary,
                    'success': success,
                    'line_num': line_num,
                    'valid_num': valid_num,
                    'case_num': case_num,
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
            'line_num':0,
            'valid_num':0,
            'case_num':0,
            'success_rate':0,
            'summary_rate':0,
            'ave_line_num':0,
            'ave_valid_num':0
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
        table[entry]['line_num'] += content['line_num']
        table[entry]['valid_num'] += content['valid_num']
        table[entry]['case_num'] += content['case_num']
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
        try:
            table[entry]['ave_line_num'] = table[entry]['line_num']/table[entry]['case_num']
        except ZeroDivisionError:
            table[entry]['ave_line_num'] = 0
        try:
            table[entry]['ave_valid_num'] = table[entry]['valid_num']/table[entry]['case_num']
        except ZeroDivisionError:
            table[entry]['ave_valid_num'] = 0
    
    return table

final_table = {}

build_path = 'build'
target_core = 'BOOM'
prefix_list = [
    'trigger_test_00',
    'trigger_test_01',
    'trigger_test_02',
    'trigger_test_03',
    'trigger_test_04',
]
final_table['BOOM*'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'unalign_trigger_test_00',
    'unalign_trigger_test_01',
    'unalign_trigger_test_02',
    'unalign_trigger_test_03',
]
final_table['BOOM-unalign'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'random_trigger_test_00',
    'random_trigger_test_01',
    'random_trigger_test_02',
    'random_trigger_test_03',
]
final_table['BOOM-random'] = trigger_analysis(build_path, target_core, prefix_list)

target_core = 'XiangShan'
prefix_list = [
    'trigger_test_00',
    'trigger_test_01',
    'trigger_test_02',
    'trigger_test_03',
]
final_table['XiangShan*'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'unalign_trigger_test_00',
    'unalign_trigger_test_01',
    'unalign_trigger_test_02',
    'unalign_trigger_test_03',
]
final_table['XiangShan-unalign'] = trigger_analysis(build_path, target_core, prefix_list)

prefix_list = [
    'random_trigger_test_00',
    'random_trigger_test_01',
    'random_trigger_test_02',
    'random_trigger_test_03',
]
final_table['XiangShan-random'] = trigger_analysis(build_path, target_core, prefix_list)

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
    file.write('\\begin{table*}[h]\n')
    file.write('\\centering')
    file.write('\\caption{Evaluation for Trigger Stage}\n')
    file.write('\\label{table1}\n')
    file.write('\\resizebox{\\textwidth}{!}{\n')
    file.write('\\begin{tabular}{')
    for _ in range(1 + 2*len(table_entry) + 1):
        file.write('|c')
    file.write('|}\n')

    file.write('\\hline\n')
    file.write('\\multirow{2}{1cm}{type} &')
    for entry in table_entry:
        file.write(f' \\multicolumn{{2}}{{c|}}{{{entry}}} &')
    file.write('\\multirow{2}{1cm}{overhead} \\\\\n')
    file.write(f'\\cline{{{2}-{1+2*len(table_entry)}}}\n')

    file.write('&')
    for entry in table_entry:
        file.write(f' S & O &')
    file.write('\\\\\n')
    file.write('\\hline\n')

    for trigger_type, sub_table in final_table.items():
        file.write(f'{trigger_type} & ')
        line_num_sum = 0
        valid_num_sum = 0
        case_num = 0
        for entry in table_entry:
            line_num = round(sub_table[entry]['ave_line_num'], 1)
            valid_num = round(sub_table[entry]['ave_valid_num'], 2)
            line_num_sum += line_num
            valid_num_sum += valid_num
            case_num += 1
            file.write(f"{round(sub_table[entry]['success_rate']*100, 1)}\% & {line_num}({valid_num}) &")
        file.write(f"{round(line_num_sum/case_num,1)}({round(valid_num_sum/case_num,2)}) \\\\\n")
    file.write('\\hline\n')

    file.write('\\end{tabular}\n')
    file.write('}\n')
    file.write('\\end{table*}')
        
