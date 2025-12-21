#!/bin/bash
# Data Vault Projesi - Temel Kurulum ve Yetkilendirme Betiği (setup.sh)
# Güncel Kullanıcılar: Ahmet (Finans), İrem (İK), Kontrol (mufettis)

echo "--- 1. Gerekli Paketlerin Kurulumu (ACL ve SMB) ---"
sudo apt update
# ACL ve Samba servisi kurulumu (Hafta 3 gereksinimi dahil)
sudo apt install acl samba -y

echo "--- 2. Grup ve Kullanıcıların Oluşturulması ---"
# Departman grupları
sudo groupadd finans
sudo groupadd ik
# kontrol grubu
sudo groupadd kontrol

# Kullanıcılar
sudo useradd -m ahmet
sudo useradd -m irem
sudo useradd -m mufettis

# Kullanıcılara parola atama (Güvenlik için manuel yapılmalıdır)
echo "Lütfen ahmet, irem ve mufettis kullanıcılarına parola atayın:"
sudo passwd ahmet
sudo passwd irem
sudo passwd mufettis

# Kullanıcıları gruplara atama
sudo usermod -aG finans ahmet # Ahmet FINANS grubunda
sudo usermod -aG ik irem     # İrem IK grubunda
sudo usermod -aG mufettis kontrol # Kontrol mufettis  grubunda

echo "--- 3. Klasör Oluşturma ve Gelişmiş İzinler (ACL & SGID) ---"
# Yetkilendirme yapılacak klasörleri oluşturma
sudo mkdir -p /data/finance
sudo mkdir -p /data/ik

# FINANS Klasörü Yetkilendirmesi
# 1. Grup sahipliğini finans olarak ayarla
sudo chown root:finans /data/finance
# 2. SGID (2) ve Güvenli İzin (770) uygula
sudo chmod 2770 /data/finance
# 3. ACL ile denetci grubuna sadece okuma izni ver (r-x)
sudo setfacl -m g:denetci:r-x /data/finance

# IK Klasörü Yetkilendirmesi
# Aynı adımlar IK klasörü için
sudo chown root:ik /data/ik
sudo chmod 2770 /data/ik
sudo setfacl -m g:denetci:r-x /data/ik

echo "--- Kurulum Tamamlandı. İzin Kanıtları: ---"
# Kanıt komutları
ls -ld /data/finance
getfacl /data/finance
