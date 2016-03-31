#!/bin/sh

src=$1
bin=$(echo $1 | sed 's/\.asm//g')
objfile=$bin.o
elf=
ldopt=
bindir="bin/"


if [ "$2" -eq '32' ]; then
    elf='elf'
    ldopt='-melf_i386'
else
    elf='elf64'
fi

nasm -f $elf $src -o $objfile
ld -o $bindir/$bin $objfile $ldopt

rm $objfile > /dev/null
