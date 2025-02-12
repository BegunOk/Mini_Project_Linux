#!/bin/bash

# Настройки
LOG_DIR=/var/log/httpd
FILENAME=access_log
BACKUP_DIR=/var/log/httpd/backups  # Папка для хранения бэкапов
TIMESTAMP=$(date +"%Y%m%d")
BACKUP_FILE="log_${TIMESTAMP}.tar.gz"
TARGET_FILE="$BACKUP_DIR/$BACKUP_FILE"

# Создание папки для бэкапов, если её нет
mkdir -p "$BACKUP_DIR"

# Архивирование и сжатие
if [ -f "$LOG_DIR/$FILENAME" ]; then
    tar -czf "$TARGET_FILE" -C "$LOG_DIR" "$FILENAME"
    echo "Backup создан: $TARGET_FILE"
else
    echo "Файл логов не найден: $LOG_DIR/$FILENAME"
    exit 1
fi

# Удаление старых бэкапов (храним только 3 дня)
find "$BACKUP_DIR" -type f -name "log_*.tar.gz" -mtime +3 -delete

# Вывод завершения
echo "Очистка завершена. Актуальные бэкапы:" 
ls -l "$BACKUP_DIR"

