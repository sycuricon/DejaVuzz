import os

current_file = os.path.abspath(__file__)
current_folder = os.path.dirname(current_file)
case_dataset = os.path.join(current_folder, 'trigger_dataset', 'specdoctor')

directory = [
    # "S2M_ATTACKER",
    "S2M_VICTIM",
    "S2M_VICTIM_2",
    "U2M_ATTACKER",
    "U2S_ATTACKER",
    "U2S_VICTIM",
    "U2S_VICTIM_2"
]

for dir_name in directory:
    group_dir_path = os.path.join(case_dataset, dir_name)
    os.system(f'mkdir {group_dir_path}')

file_list = []
for line in open('file_list', 'rt'):
    line = line.strip()
    file_list.append(line)

for file_name in file_list:
    name_token = file_name.split('/')
    group_name = name_token[-2]
    case_name = name_token[-1]
    case_path = os.path.join(case_dataset, group_name, case_name)
    os.system(f'cp {file_name} {case_path}')