#!/data/data/com.termux/files/usr/bin/sh

clear

echo "========================================="
echo "        VERUS TERMUX UPDATER"
echo "========================================="
echo

cd ~/ccminer || exit

echo "Mengunduh file terbaru..."
echo

wget -O ccminer https://raw.githubusercontent.com/muflikhudin/verus-termux/main/ccminer
wget -O start.sh https://raw.githubusercontent.com/muflikhudin/verus-termux/main/start.sh

chmod +x ccminer
chmod +x start.sh

echo
echo "========================================="
echo "      UPDATE BERHASIL!"
echo "========================================="
echo
echo "Silakan jalankan kembali:"
echo
echo "./start.sh"
echo
