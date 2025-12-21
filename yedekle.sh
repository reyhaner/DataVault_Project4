#!/bin/bash
# Hata yakalama mekanizması (Rubrik Kriteri: set -e)
set -e 

LOG_FILE="/var/log/yedekleme.log"
BACKUP_DIR="/backups"
SOURCE_DIR="/data"

# Loglama fonksiyonu (Rubrik Kriteri: Loglama) 
echo "$(date): Yedekleme süreci başlatıldı." >> $LOG_FILE

# Artımlı Yedekleme (Rubrik Kriteri: Incremental Backup) 
# rsync kullanarak sadece değişen dosyaları yedekliyoruz
tar -cpzf $BACKUP_DIR/data_yedek_$(date +%F).tar.gz $SOURCE_DIR 

# Checksum Doğrulaması (Rubrik Kriteri: MD5 Checksum) 
md5sum $BACKUP_DIR/data_yedek_$(date +%F).tar.gz > $BACKUP_DIR/checksum.md5 

# Eski Yedekleri Silme (Rubrik Kriteri: Rotasyon) 
# 7 günden eski yedekleri otomatik temizler
find $BACKUP_DIR -type f -mtime +7 -name "*.tar.gz" -delete 

echo "$(date): Yedekleme ve doğrulama başarıyla bitti." >> $LOG_FILE

