from ptm import *
import subprocess

include("exp/common/extern_dep.ptm")
inhouse_deps = include("exp/common/inhouse_dep.ptm")

if __name__ == '__main__':
    builder.build(inhouse_deps.setup_dependencies)
