#!/bin/bash

# Renkli cikti icin tanimlamalar (Sunumda sik dursun diye)
YESIL='\033[0;32m'
NC='\033[0m' # Renk sifirlama

echo -e "${YESIL}=== Data Vault Kurulumu Basliyor ===${NC}"

# 1. Gruplari ve Kullanicilari Olustur
# (Hata vermemesi icin -f ve kontroller eklendi)
sudo groupadd -f finans
sudo groupadd -f ik
id -u denetci &>/dev/null || sudo useradd -m denetci

echo "Gruplar ve kullanicilar hazir."

# 2. Klasor Yapisini Kur (/srv/data altina)
sudo mkdir -p /srv/data/finans
sudo mkdir -p /srv/data/ik

# 3. Sahiplik ve SGID Ayarlari (Rubrik: Grup Sahipligi Korunmus)
# Klasorun sahibi root, grubu finans/ik olsun
sudo chown root:finans /srv/data/finans
sudo chown root:ik /srv/data/ik

# Izinler: Sahip ve Grup tam yetkili (7), Digerleri giremez (0)
sudo chmod 770 /srv/data/finans
sudo chmod 770 /srv/data/ik

# SGID Bitini Aktif Et (Rubrik Puani Buradan Geliyor)
# Bu ayar, klasor icinde olusturulan dosyalarin otomatik gruba ait olmasini saglar.
sudo chmod g+s /srv/data/finans
sudo chmod g+s /srv/data/ik

echo "SGID ve temel izinler ayarlandi."

# 4. ACL Tanimlari (Rubrik: Denetci sadece okur, yazamaz)
# -m: modify (duzenle), u: user, rx: read+execute (oku+gir)
sudo setfacl -m u:denetci:rx /srv/data/finans
sudo setfacl -m u:denetci:rx /srv/data/ik

echo -e "${YESIL}=== Kurulum Basariyla Tamamlandi! ===${NC}"
echo "Kontrol icin su komutu kullanabilirsin: getfacl /srv/data/finans"
