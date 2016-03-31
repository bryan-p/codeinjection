#!/bin/env python

import sys

arg=sys.argv[1]

revarg = arg[::-1].encode('hex')
print(revarg)
