#!/data/data/com.termux/files/usr/bin/sh

echo "=================================="
echo "   Verus Miner Installer"
echo "   by muflikhudin"
echo "=================================="

pkg update -y
pkg install wget libjansson -y

mkdir -p ~/ccminer
cd ~/ccminer

wget -O ccminer https://raw.githubusercontent.com/muflikhudin/verus-termux/main/ccminer
wget -O config.json https://raw.githubusercontent.com/muflikhudin/verus-termux/main/config.json
wget -O start.sh https://raw.githubusercontent.com/muflikhudin/verus-termux/main/start.sh

chmod +x ccminer
chmod +x start.sh

echo ""
echo "Instalasi selesai."
echo "Jalankan miner dengan:"
echo "cd ~/ccminer && ./start.sh"
