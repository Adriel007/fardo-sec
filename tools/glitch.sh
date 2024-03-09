FONT_GREEN="\e[32m"
FONT_RED="\e[31m"
FONT_RESET="\e[0m"

terminal_width=$(tput cols)
text=$(<./fardo-sec/tools/glitch.txt)
spaces=$(( (terminal_width - ${#text}) / 2 ))

clear
printf "%*s%s\n" $spaces '' "$(echo "$text")"

read -p "Press any key to start..."

for i in {9..1}; do
    clear
    if [ $((i % 2)) -eq 1 ]; then
        printf "%*s%s\n" $spaces '' "$(echo "$text")"
    else
        printf "%*s${FONT_RED}%s${FONT_RESET}%*s\n" $spaces "" "$text" $spaces ""
    fi
    sleep 0.$i
done

read -p "Press any key to stop..."