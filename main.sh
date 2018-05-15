#!/bin/bash

lines=$(echo $(($(echo -n "quit" | gdb -q --eval="disas main" $1 | wc -l) - 3)))

shellcode=$(objdump -d $1 | grep -A${lines} "<main>" | grep -v "<main>" | cut -f 2 | xargs | sed -e "s/\s/\\\x/g")

echo "\\x${shellcode}"
