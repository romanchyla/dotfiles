#!/usr/bin/env python

import os
import sys

os.chdir('%s/.provision.secret' % os.environ.get("HOME"))
targets = os.listdir('.')

if 'last_run' in targets:
    last_run = int(open(targets['last_run'], 'r').read())
    del targets['last_run']
else:
    last_run = -1

for t in sorted(targets):
    try:
        n = int(t.split('_')[0])
    except:
        continue
    if n < last_run:
        continue
    print('executing', t)
    if t.endswith('.sh'):
        assert(os.system('bash %s' % t) == 0)
    elif t.endswith('.py'):
        assert(os.system('python %s' % t) == 0)
    else:
        print ('unknown target', t)
    last_run = n

with open('last_run', 'w') as f:
    f.write(str(last_run))

print('Done installation')
