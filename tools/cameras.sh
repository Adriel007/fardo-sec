clear

echo "Choose an camera by index:"
echo "1) Santos"
echo "2) Itararé"

echo "0) exit"

read -p "Your choice: " choice

case $choice in
    0)
        cd ..
        ./fardo-sec.sh
        ;;
    1)
        xdg-open 'https://egov.santos.sp.gov.br/santosmapeada/Gestao/Cameras/MapaCamera/'
        ;;
    2)
        xdg-open 'https://dinamicadoar.com.br/p/61/-cameras-ao-vivo-sao-vicente-sp-itarare/'
        ;;
    *)
        ./cameras.sh
        ;;
esac
