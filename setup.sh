#!/bin/bash

echo "=== Data Vault Kurulum ve Yetkilendirme ==="

# 1. Klasorleri Olustur (Eger yoksa)
sudo mkdir -p /srv/data/finans
sudo mkdir -p /srv/data/ik

# 2. Sahiplik ve Izinler (SGID - Puan Kaynagi)
echo "Klasor izinleri ayarlaniyor..."

# Klasorlerin grubu finans ve ik olsun
sudo chown :finans /srv/data/finans
sudo chown :ik /srv/data/ik

# Izinler: Grup tam yetkili (7), Digerleri giremez (0)
sudo chmod 770 /srv/data/finans
sudo chmod 770 /srv/data/ik

# SGID Bitini Aktif Et (Klasor icine giren dosya grubun olur)
sudo chmod g+s /srv/data/finans
sudo chmod g+s /srv/data/ik

# 3. ACL Tanimlari (Mufettis sadece okur)
# Rubrikte istenen ozel yetki ayari
echo "Mufettis icin ozel okuma izni (ACL) veriliyor..."
sudo setfacl -R -m u:mufettis:rx /srv/data/finans
sudo setfacl -R -m u:mufettis:rx /srv/data/ik

echo "ISLEM TAMAM! Ahmet, Irem ve Mufettis icin sistem hazir."
