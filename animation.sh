#!/data/data/com.termux/files/usr/bin/bash

diretorio=$1

total=$(ls -1 "$diretorio"/*.txt 2>/dev/null | wc -l)

while true; do
    for ((i = 0; i < total; i++)); do
        arquivo="$diretorio/$i.txt"
        if [ -f "$arquivo" ]; then
            cat "$arquivo"
            sleep 0.2
            clear
        fi
    done
done
