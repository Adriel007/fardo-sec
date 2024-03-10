#!/bin/bash
SSID="Nome_da_rede_Wi-Fi"
PASSWORD="Senha_da_rede_Wi-Fi"

iwlist wlan0 scan

wpa_passphrase "$SSID" "$PASSWORD" >> /data/misc/wifi/wpa_supplicant.conf

ifconfig wlan0 up

wpa_supplicant -B -i wlan0 -c /data/misc/wifi/wpa_supplicant.conf

timeout=30
start_time=$(date +%s)
while ! ifconfig wlan0 | grep -q "inet "; do
    current_time=$(date +%s)
    elapsed_time=$((current_time - start_time))
    if [ $elapsed_time -ge $timeout ]; then
        echo "Falha ao conectar à rede Wi-Fi: Tempo limite excedido."
        exit 1
    fi
    sleep 1
done

echo "Conectado à rede Wi-Fi!"6:58 AM