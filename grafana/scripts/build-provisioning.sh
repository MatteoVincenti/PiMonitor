#!/bin/sh
set -e

echo "Replacing environment variables in provisioning files..."
find /workspace/provisioning -type f -name "*.yaml.template" | while read -r file; do
  target_file="/workspace/provisioning/${file##*/}"
  target_file="${target_file%.template}"
  envsubst < "$file" > "$target_file"
  echo "Processed: $file -> $target_file"
done