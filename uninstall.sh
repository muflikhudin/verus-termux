#!/data/data/com.termux/files/usr/bin/sh

clear

echo "========================================="
echo "      VERUS TERMUX UNINSTALLER"
echo "========================================="
echo

read -p "Yakin ingin menghapus Verus Termux? (y/N): " JAWAB

if [ "$JAWAB" = "y" ] || [ "$JAWAB" = "Y" ]; then
    rm -rf ~/ccminer
    echo
    echo "========================================="
    echo "Verus Termux berhasil dihapus."
    echo "========================================="
else
    echo
    echo "Dibatalkan."
fi
