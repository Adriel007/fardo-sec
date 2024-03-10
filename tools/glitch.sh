#!/data/data/com.termux/files/usr/bin/bash

FONT_GREEN="\e[32m"
FONT_RESET="\e[0m"
art=$(<$HOME/fardo-sec/art/interrogation.txt)

width=$(tput cols)
IFS=$'\n' read -d '' -r -a lines <<< "$art"

for line in "${lines[@]}"; do
    line_length=${#line}
    offset=$(( (width - line_length) / 2))
    padding=$(printf "%-${offset}s")
    centered_lines+=("${padding}${line}")
done

printf "%s\n" "${centered_lines[@]}"

read -p "Press ENTER to start GLITCH"

for i in {5..1}; do
    for ((j=0; j<4; j++)); do
        clear
        width=$(tput cols)

        centered_lines=()
        for line in "${lines[@]}"; do
            line_length=${#line}
            offset=$(( (width - line_length) / 2))
            padding=$(printf "%-${offset}s")

            if [ $((j % 2)) -eq 0 ]; then
                centered_lines+=("${padding}${FONT_RESET}${line}")
            else
                centered_lines+=("${padding}${FONT_GREEN}${line}${FONT_RESET}")
            fi
        done

        printf "%s\n" "${centered_lines[@]}"
        sleep 0.$i
    done
done

read -p "Press ENTER to continue..."
