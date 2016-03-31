#!/bin/bash

prevAddr="0"

for i in {1..64}; do
    len=$i
    ./vulnerable "$(perl -e 'print "A" x '$len'')" > str
    addr=$(cat str | awk '{print $2}')
    if [ "$prevAddr" != "$addr" ]; then
        echo "$len: $addr"
    fi

    prevAddr=$addr
done

rm str
