import os

root_path = '/eda/specdoc-eval'
spec_path = ['S2M_ATTACKER', 'U2S_ATTACKER', 'U2M_ATTACKER', 'S2M_VICTIM', 'U2S_VICTIM']

liveness_record = {}

for spec in spec_path:
    path = os.path.join(root_path, spec, 'diff', 'log')
    for log in os.listdir(path):
        log_name = os.path.join(path, log)
        for line in open(log_name):
            line = line.strip()
            line = line.strip('%')
            token_1 = line.find('(')
            token_2 = line.find(' ')
            mod_name = line[0:token_1]
            reg_name = line[token_2+1:]
            name = f'{mod_name}.{reg_name}'
            liveness_record[name] = liveness_record.get(name, 0) + 1

with open('./spec_coverage/spec_liveness', 'wt') as file:
    for name, value in liveness_record.items():
        file.write(f'{name} {value}\n')