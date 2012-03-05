#!/usr/bin/env python
#

import subprocess
import sys

def GetVersion():
    cmd = "hg parents --template 'hgid: {node|short}'"

if __name__ == '__main__':
    pass
