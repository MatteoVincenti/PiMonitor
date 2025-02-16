#!/bin/bash

# Determina la directory di lavoro
SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# Directory di backup
BACKUP_DIR="$PROJECT_ROOT/grafana/backups"

# Elenco dei file di backup
echo "Backup disponibili:"
BACKUPS=($(ls "$BACKUP_DIR" | grep -E '^grafana_backup_.*\.tar\.gz$'))

if [ ${#BACKUPS[@]} -eq 0 ]; then
  echo "Errore: non ci sono backup disponibili."
  exit 1
fi

# Mostra l'elenco dei backup e chiedi all'utente di scegliere
select BACKUP_FILE in "${BACKUPS[@]}"; do
  if [ -n "$BACKUP_FILE" ]; then
    echo "Hai scelto il backup: $BACKUP_FILE"
    break
  else
    echo "Scelta non valida. Riprova."
  fi
done

# Ripristina il backup
docker run --rm -v grafana-data:/var/lib/grafana -v "$BACKUP_DIR":/backup alpine tar xzvf /backup/$BACKUP_FILE -C /var/lib/grafana

echo "Ripristino completato."