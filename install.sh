#!/data/data/com.termux/files/usr/bin/sh

clear

echo "=================================="
echo "     VERUS TERMUX INSTALLER"
echo "        by muflikhudin"
echo "=================================="
echo

pkg update -y
pkg install wget libjansson -y

mkdir -p ~/ccminer
cd ~/ccminer

wget -O ccminer https://raw.githubusercontent.com/muflikhudin/verus-termux/main/ccminer
wget -O config.json https://raw.githubusercontent.com/muflikhudin/verus-termux/main/config.json
wget -O start.sh https://raw.githubusercontent.com/muflikhudin/verus-termux/main/start.sh

chmod +x ccminer
chmod +x start.sh

echo
read -p "Masukkan Wallet Verus Anda: " WALLET
