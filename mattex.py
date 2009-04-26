#!/usr/bin/env python
import sys, re

output = open(sys.argv[1])
output = output.read()
output = re.split('thisisalinebreak =',output)

f = open(sys.argv[2])
i = 1
matlab = False
for line in f:
    if line == "<?ml\n":
        matlab = True
        j = 0
        for oline in output[i].split('\n'):
            if (j > 2) & (re.match('^(\s+[^\s]+|[^=]+)$',oline) != None):
                if oline.strip() != '':
                    print oline
            j += 1
        i += 1
    if line == "?>\n":
        matlab = False
        continue
    if not matlab:
        print line,

