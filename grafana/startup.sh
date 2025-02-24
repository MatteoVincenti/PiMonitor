#!/bin/sh
set -e

echo "Replacing environment variables in provisioning files..."
find /etc/grafana/provisioning/ -type f -name "*.yaml.template" | while read -r file; do
  target_file="${file%.template}"
  envsubst < "$file" > "$target_file"
  echo "Processed: $file -> $target_file"
done

echo "Starting Grafana..."
exec /run.sh