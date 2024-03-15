#!/data/data/com.termux/files/usr/bin/bash

dir=$1

if [ -z "$dir" ]; then
    echo "Usage: $0 <dir>"
    echo "Arts:"
    echo "ls -d $HOME/fardo-sec/art/*"
    exit 1
fi
total=$(ls -1 "$HOME/fardo-sec/art/$dir"/*.txt 2>/dev/null | wc -l)

while true; do
    for ((i = 0; i < total; i++)); do
        arquivo="$dir/$i.txt"
        if [ -f "$arquivo" ]; then
            cat "$arquivo"
            sleep 0.2
            clear
        fi
    done
done
