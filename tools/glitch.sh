FONT_GREEN="\e[32m"
FONT_RED="\e[31m"
FONT_RESET="\e[0m"

text=$(cat ./fardo-sec/art/glitch.txt)

terminal_width=$(tput cols)

spaces=$(( (terminal_width - ${#text}) / 2 ))

clear
printf "%*s%s%*s\n" $spaces "" "$text" $spaces ""

read -p "Press any key to start..."

for i in {1..4}; do
    clear
    if [ $((i % 2)) -eq 1 ]; then
        printf "%*s%s%*s\n" $spaces "" "$text" $spaces ""
    else
        printf "%*s${FONT_RED}%s${FONT_RESET}%*s\n" $spaces "" "$text" $spaces ""
    fi
    sleep 0.$i
done

read -p "Press any key to stop..."