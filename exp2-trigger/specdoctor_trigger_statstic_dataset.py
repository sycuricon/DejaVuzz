import copy
import os, re, subprocess

start_label = ["fn0.entry:", "fn1.entry:", "fn2.entry:", "fn3.entry:", "fn4.entry:", "pre_attack0:", "pre_attack1:"]
end_label = ["fn0.exit:", "fn1.exit:", "fn2.exit:", "fn3.exit:", "fn4.exit:", "pre_attack0_end:", "pre_attack1_end:"]

def get_case_dataset():
    current_file = os.path.abspath(__file__)
    current_folder = os.path.dirname(current_file)
    case_dataset = os.path.join(current_folder, 'trigger_dataset', 'specdoctor')
    assert os.path.exists(case_dataset), f"the {case_dataset} does not exists!!!"
    return case_dataset

def get_train_inst(file_path):
    totoal_sum = 0
    in_target = False
    with open(file_path, 'r') as f:
        for line in f:
            line = line.strip()
            if line in start_label:
                in_target = True
                
            elif line in end_label:
                in_target = False
            if in_target:
                match = re.search(r"\s*(\w+\.\w*|\w+)\s+([\w,() +-]+)\s*", line)
                if match:
                    # print(match.group(1))
                    if (match.group(1) == "la" or match.group(1) == "li"):
                        totoal_sum += 2
                    else:
                        totoal_sum += 1
            # print(f"!!!!!!!!! {line} @@@@@@ {totoal_sum}")
    return totoal_sum

if __name__ == "__main__":
    case_dataset = get_case_dataset()
    target_directory = [os.path.join(case_dataset, folder_name) for folder_name in os.listdir(case_dataset)]

    total_case = dict()
    total_inst = dict()

    for directory_path in target_directory:
        files = ([f for f in os.listdir(directory_path) if f.startswith('t') and f.endswith('.S')])
        for file_name in files:
            file_path = os.path.join(directory_path, file_name)
            pattern = r"_(mispredict_[\w+-]+|excpt_[\w+-]+)\.S$"
            match = re.search(pattern, file_name)
            if match:
                group_type = match.group(1).split("_")[0]
                detail_type = match.group(1).split("_")[1]
                real_type = detail_type

                if "page-fault" in real_type:
                    real_type = "page-fault"

                if group_type == "mispredict":
                    if detail_type.split("-")[0][0] == 'b':
                        real_type = "branch"
                    elif detail_type.split("-")[0][0] == 'j':
                        real_type = "jump"
                        if detail_type.split("-")[1] == 'ra' or detail_type.split("-")[1] == 'x2':
                            real_type = "ret"
                    else:
                        real_type = detail_type.split("-")[0]
                
                total_case[real_type] = total_case.get(real_type, 0) + 1
                total_inst[real_type] = total_inst.get(real_type, 0) + get_train_inst(file_path)
        
    for key in total_case:
        print(f"{key}: {total_case[key]}, {total_inst[key]}, {total_inst[key] / total_case[key]}")


