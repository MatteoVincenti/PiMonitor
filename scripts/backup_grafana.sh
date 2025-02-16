#!/bin/bash

# Determina la directory di lavoro
SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# Crea la directory di backup se non esiste
BACKUP_DIR="$PROJECT_ROOT/grafana/backups"
mkdir -p "$BACKUP_DIR"

# Crea il backup
docker run --rm -v grafana-data:/var/lib/grafana -v "$BACKUP_DIR":/backup alpine tar czvf /backup/grafana_backup_$(date +%Y%m%d%H%M%S).tar.gz -C /var/lib/grafana .