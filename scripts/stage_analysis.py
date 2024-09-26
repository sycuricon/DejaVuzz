import argparse
from enum import Enum, auto

class FuzzFSM(Enum):
    IDLE = auto()
    MUTATE_TRIGGER = auto()
    MUTATE_ACCESS = auto()
    ACCUMULATE = auto()
    MUTATE_LEAK = auto()
    STOP = auto()

def fuzz_log_analysis(filename):
    state = None
    last_state_time = 0
    now_state_time = 0
    state_time = {}
    for value in FuzzFSM:
        state_time[value] = 0
    for line in open(filename):
        last_state_time = now_state_time
        line_token = line.strip().split()
        if line_token[1] != 'state_switch':
            continue
        now_state_time = float(line_token[0])
        state = eval(line_token[2][1:-1])
        state_time[state] += now_state_time - last_state_time
    for key, value in state_time.items():
        print(f'{key}:\t{value}')

parser = argparse.ArgumentParser()
parser.add_argument("-I", "--input", dest="input", required=True, help="filename of fuzz log")

args = parser.parse_args()
fuzz_log_analysis(args.input)