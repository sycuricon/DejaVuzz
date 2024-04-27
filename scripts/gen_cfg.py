import libconf
from io import StringIO
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('--dut_init_file', type=str)
parser.add_argument('--vnt_init_file', type=str)
parser.add_argument('--output_file', type=str, default='build/config.cfg')

args = parser.parse_args()

normal_template = {
    'start_addr': libconf.LibconfInt64(0x8000_0000),
    'max_mem_size': libconf.LibconfInt64(0x8000_0000),
    'memory_regions': (
        {
            'type': 'dut',
            'start_addr': libconf.LibconfInt64(0x8000_0000),
            'max_len': libconf.LibconfInt64(0x8000_0000),
            'init_file': args.dut_init_file,
        }
    )
}

variant_template = {
    'start_addr': libconf.LibconfInt64(0x8000_0000),
    'max_mem_size': libconf.LibconfInt64(0x8000_0000),
    'memory_regions': (
        {
            'type': 'dut',
            'start_addr': libconf.LibconfInt64(0x8000_0000),
            'max_len': libconf.LibconfInt64(0x8000_0000),
            'init_file': args.dut_init_file,
        },
        {
            'type': 'vnt',
            'start_addr': libconf.LibconfInt64(0x8000_0000),
            'max_len': libconf.LibconfInt64(0x8000_0000),
            'init_file': args.vnt_init_file,
        }
    )
}

with StringIO() as s:
    if (args.dut_init_file is not None) and (args.vnt_init_file is None):
        libconf.dump(normal_template, s)
    elif (args.dut_init_file is not None) and (args.vnt_init_file is not None):
        libconf.dump(variant_template, s)
    else:
        raise ValueError('Invalid input arguments')
    config_content = s.getvalue()

with open(args.output_file, 'w') as config_file:
    config_file.write(config_content)
