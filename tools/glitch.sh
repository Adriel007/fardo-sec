text=$(cat ../art/glitch.txt)

terminal_width=$(tput cols)

spaces=$(( (terminal_width - ${#text}) / 2 ))

clear
printf "%*s%s%*s\n" $spaces "" "$text" $spaces ""

read -p "Press any key to start..."

while true; do
    read -r -s -n 1 key
    if [[ $key == $'\x0a' ]]; then
        break
    else
        clear
        sleep 0.5
        printf "%*s%s%*s\n" $spaces "" "$text" $spaces ""
        echo "Press any key to stop..."
        sleep 0.5
    fi
done