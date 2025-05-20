import datetime
import os
import time

from ptm import include, builder

inhouse_deps = include("../common/inhouse_dep.ptm")
sota_deps = include("../common/competitor_dep.ptm")

current_time = datetime.datetime.now()
time_str = current_time.strftime("%Y-%m-%d-%H-%M-%S")
current_path = os.path.dirname(os.path.abspath(__file__))
record_file = os.path.join(current_path, f'ae_cmp_{time_str}.log')
if os.path.exists(record_file):
    print(f'{record_file} has been existed')
else:
    os.system(f'touch {record_file}')

def execute_command(command):
    if os.system(command):
        print(f'{command} fails to execute')
        exit()

def compile_test(target):
    start = time.time()
    builder.build(target)
    finish = time.time()
    with open(record_file, 'a+') as file:
        file.write(f'{target} compile:\t{finish-start:.2f}s\n')

if __name__ == "__main__":
    # Setup the environment variable and dependencies
    builder.build(inhouse_deps.yosys_target)
    builder.build(sota_deps.cellift_yosys_target)

    builder.build(sota_deps.diffift_clean)
    compile_test(sota_deps.normal_boom_target)
    
    builder.build(sota_deps.diffift_clean)
    compile_test(sota_deps.diffift_boom_target)

    builder.build(sota_deps.cellift_clean)
    compile_test(sota_deps.cellift_boom_target)

    builder.build(sota_deps.diffift_clean)
    builder.build(sota_deps.xiangshan_clean)
    compile_test(sota_deps.normal_xiangshan_target)
    
    builder.build(sota_deps.diffift_clean)
    builder.build(sota_deps.xiangshan_clean)
    compile_test(sota_deps.diffift_xiangshan_target)

    builder.build(sota_deps.cellift_clean)
    builder.build(sota_deps.xiangshan_clean)
    compile_test(sota_deps.cellift_xiangshan_target)
