#!/bin/bash

# Rapor dosyasinin adi
RAPOR="sistem_raporu.txt"

echo "=== SISTEM IZLEME VE DISK ANALIZI RAPORU ===" > $RAPOR
date >> $RAPOR
echo "-------------------------------------------" >> $RAPOR

echo "[1] DISK KULLANIMI (En Buyuk 5 Dosya/Klasor)" >> $RAPOR
# [cite_start]Rubrik: En buyuk dosyalari bulan ve siralayan (du, sort -nr) komutu [cite: 9]
# /srv/data klasorundeki en buyukleri bulup rapora yazar
du -ah /srv/data 2>/dev/null | sort -hr | head -n 5 >> $RAPOR
echo "" >> $RAPOR

echo "[2] RAM CANAVARLARI (Bellek Kullanimina Gore)" >> $RAPOR
# [cite_start]Rubrik: Surecler bellege gore siralanmis [cite: 9]
ps aux --sort=-%mem | head -n 6 >> $RAPOR
echo "" >> $RAPOR

echo "[3] CPU CANAVARLARI (Islemciye Gore)" >> $RAPOR
# [cite_start]Rubrik: Surecler CPU'ya gore siralanmis [cite: 9]
ps aux --sort=-%cpu | head -n 6 >> $RAPOR
echo "" >> $RAPOR

echo "[4] ZOMBIE PROCESS KONTROLU" >> $RAPOR
# [cite_start]Rubrik: Zombie process kontrolu yapilmis [cite: 9]
zombie_sayisi=$(ps aux | grep 'Z' | grep -v grep | wc -l)

if [ $zombie_sayisi -gt 0 ]; then
    echo "UYARI: $zombie_sayisi adet Zombie surec var!" >> $RAPOR
else
    echo "Sistem temiz. Zombie surec yok." >> $RAPOR
fi

echo "Rapor olusturuldu: $RAPOR"
echo "Icerigi gormek icin: cat $RAPOR"
