#!/bin/sh

sc=$(objdump -d $1 | grep '[0-9a-f]:' | grep -v 'file format' | cut -f2 -d: | cut -f1-6 -d' ' | tr '\t' ' ' | sed 's/ $//g' | sed 's/ /\\x/g' | sed 's/x\\//g' | sed 's/x$//g' | sed 's/\\$//g' | paste -d '' -s)
sc0x=$(echo $sc | sed 's/\\x/\\0x/g')
scparsed=$(echo $sc | sed 's/\\x/ /g')
len=0

for i in $scparsed
do 
    let len+=1 
done

echo -e "\nshellcode length: $len bytes\n"
         
echo "$sc"
echo "$sc0x"
echo -e "$scparsed\n\n"
