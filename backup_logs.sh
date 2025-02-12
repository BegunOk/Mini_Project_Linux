#!/bin/bash


LOG_DIR=/var/log/httpd
FILENAME=access_log
BACKUP_DIR=/var/log/httpd/backups  
TIMESTAMP=$(date +"%Y%m%d")
BACKUP_FILE="log_${TIMESTAMP}.tar.gz"
TARGET_FILE="$BACKUP_DIR/$BACKUP_FILE"


mkdir -p "$BACKUP_DIR"


if [ -f "$LOG_DIR/$FILENAME" ]; then
    tar -czf "$TARGET_FILE" -C "$LOG_DIR" "$FILENAME"
    echo "Backup создан: $TARGET_FILE"
else
    echo "Файл логов не найден: $LOG_DIR/$FILENAME"
    exit 1
fi


find "$BACKUP_DIR" -type f -name "log_*.tar.gz" -mtime +3 -delete


echo "Очистка завершена. Актуальные бэкапы:" 
ls -l "$BACKUP_DIR"

