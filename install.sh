#!/data/data/com.termux/files/usr/bin/sh

clear

echo "========================================="
echo "        VERUS TERMUX INSTALLER"
echo "========================================="
echo "             by muflikhudin"
echo "========================================="
echo
echo "Selamat datang di Verus Termux Installer."
echo "Installer ini GRATIS digunakan."
echo
echo "Jika installer ini bermanfaat,"
echo "Anda dapat mendukung pengembangan proyek"
echo "dengan mengaktifkan DONASI."
echo
read -p "Aktifkan donasi untuk mendukung proyek? (Y/n): " DONASI
if [ "$DONASI" = "Y" ] || [ "$DONASI" = "y" ]; then
    echo
    echo "======================================="
    echo "Terima kasih telah mendukung proyek ❤️"
    echo
    echo "Wallet donasi Verus:"
    echo "RCifYPWunGQna28DpzbPakNE5L8fftkjVd"
    echo "======================================="
    echo
fi
echo
read -p "Masukkan wallet Verus Anda: " WALLET
read -p "Masukkan nama worker: " WORKER
echo
echo "Menyiapkan instalasi..."
sleep 2

pkg update -y
pkg install wget libjansson -y

mkdir -p ~/ccminer
cd ~/ccminer

wget -O ccminer https://raw.githubusercontent.com/muflikhudin/verus-termux/main/ccminer
wget -O start.sh https://raw.githubusercontent.com/muflikhudin/verus-termux/main/start.sh

chmod +x ccminer
chmod +x start.sh
cat > config.json <<EOF
{
  "pools": [
    {
      "name": "US-VIPOR",
      "url": "stratum+tcp://us.vipor.net:5040",
      "timeout": 180,
      "disabled": 0
    }
  ],
  "user": "${WALLET}.${WORKER}",
  "pass": "",
  "algo": "verus",
  "threads": 8,
  "cpu-priority": 1,
  "cpu-affinity": -1,
  "retry-pause": 10,
  "api-allow": "192.168.0.0/16",
  "api-bind": "0.0.0.0:4068"
}
EOF
echo
echo "========================================="
echo "Instalasi selesai!"
echo "========================================="
echo
echo "Jalankan miner dengan:"
echo
echo "cd ~/ccminer && ./start.sh"
echo


