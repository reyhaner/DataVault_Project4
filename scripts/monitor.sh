#!/bin/bash
# Data Vault Projesi - Sistem Analizi ve Kaynak İzleme Betiği (monitor.sh)

echo "=================================================="
echo "      2. HAFTA: SÜREÇ VE KAYNAK İZLEME RAPORU"
echo "=================================================="

echo "--- 1.1. En Çok CPU Tüketen 10 Süreç ---"
# Kanıt: Süreçler CPU kullanımına göre sıralanmıştır.
ps aux --sort=-%cpu | head -n 10

echo ""
echo "--- 1.2. En Çok BELLEK Tüketen 10 Süreç ---"
# Kanıt: Süreçler belleğe göre sıralanmıştır.
ps aux --sort=-%mem | head -n 10

echo ""
echo "--- 1.3. Disk I/O Yoğunluğu (iotop Filtresi) ---"
# Kanıt: Sadece disk G/Ç (I/O) yapan süreçler görünür.
iotop -o -b -n 1

echo ""
echo "--- 1.4. Zombie Süreç Kontrolü ---"
# Kanıt: "Z" durumundaki süreçler filtrelenir.
ps aux | awk '{ if ($8 == "Z") print "ZOMBIE: " $0 }'

echo "=================================================="
echo "      2. DİSK KULLANIM RAPORU VE PIPELINE ANALİZİ"
echo "=================================================="

echo "--- 2.1. /data Klasöründeki En Büyük 10 Öğe (du + sort pipeline) ---"
# Kanıt: En büyük dosyaları/klasörleri bulan ve sıralayan pipeline.
du -h /data --max-depth=1 | sort -hr | head -n 10

echo ""
echo "--- 2.2. dpkg.log Dosyasındaki Son 10 İşlem (Metin İşleme) ---"
# Kanıt: Log dosyasının filtrelenmesi ve işlenmesi.
grep "status" /var/log/dpkg.log | tail

echo ""
echo "--- ANALİZ TAMAMLANDI ---"
