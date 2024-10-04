def construct_vul_tree(vul_tree, vul_file):
    for line in open(vul_file):
        class_list = list(line.strip().split())
        class_dict = vul_tree
        for element in class_list:
            class_dict[element] = class_dict.get(element, {})
            class_dict = class_dict[element]
    return vul_tree       

def print_vul_tree(vul_tree):
    line_list = []
    for large_class, large_class_value in vul_tree.items():
        line_list.append(f'{large_class}\n')
        for trigger_class, trigger_class_value in large_class_value.items():
            line_list.append(f'\t{trigger_class}\n')
            for access_class, access_class_value in trigger_class_value.items():
                line_list.append(f'\t\t{access_class}\n')
                for encode_class, encode_class_value in access_class_value.items():
                    line_list.append(f'\t\t\t{encode_class}\n')
    with open('vul_stat.md', 'wt') as file:
        file.writelines(line_list)   
    

file_list = [
    './build/BOOM_leak_final_1.template_repo/statistic.md',
    './build/BOOM_leak_final_2.template_repo/statistic.md',
    './build/BOOM_leak_final_3.template_repo/statistic.md',
    './build/BOOM_leak_final_4.template_repo/statistic.md',
]

vul_tree = {}
for file in file_list:
    vul_tree = construct_vul_tree(vul_tree, file)

print_vul_tree(vul_tree)

