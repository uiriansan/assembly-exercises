#!/bin/bash
if [ "$#" -lt 1 ]; then
    echo -e "Missing <file>"
    exit
fi

RUN=0
GCC=0
LINK=0
LINK_PROG=""
for arg in "$@"; do
    if [[ "$arg" =~ ^(-r|-run|r|run|--run)$ ]]; then
        RUN=1
    elif [[ "$arg" =~ ^(-g|-gcc|--gcc|-c|-cc)$ ]]; then
        GCC=1
    fi
done

FILE="$1"
BASE_FILE=$(basename "$FILE" | cut -d"." -f1)
nasm -f elf -o "$BASE_FILE".o "$FILE"

if [[ $GCC -eq 1 ]]; then
    gcc -no-pie -m32 "$BASE_FILE".o -o "$BASE_FILE"
else
    ld -m elf_i386 -o "$BASE_FILE" "$BASE_FILE".o
fi

if [[ $RUN -eq 1 ]]; then
    ./"$BASE_FILE"
fi
