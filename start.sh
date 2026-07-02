#!/data/data/com.termux/files/usr/bin/sh
while true
do
    echo "========================================="
    echo " Starting Verus Coin mining...           "
    echo "========================================="
    
    # Menjalankan ccminer langsung di depan (foreground)
    ~/ccminer/ccminer -c ~/ccminer/config.json
    
    # Jika ccminer berhenti/crash karena jaringan putus total,
    # script ini akan mendeteksinya, menunggu 10 detik, lalu membukanya lagi.
    echo "Koneksi terputus atau ccminer berhenti. Memulai ulang dalam 10 detik..."
    sleep 10
done
