#!/bin/bash

# A repo könyvtára
TARGET_DIR="/home/vagrant/Ansible-Homework"

# Ha már létezik a könyvtár, frissítjük
if [ -d "$TARGET_DIR" ]; then
    echo "Mappa már létezik. Frissítés..."
    cd "$TARGET_DIR"
    git pull origin main
else
    echo "Repository klónozása..."
    git clone https://github.com/adatfalo/Ansible-Homework.git "$TARGET_DIR"
fi

# Kiírjuk, hogy kész
echo "Git repository letöltése kész!"
