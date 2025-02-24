#!/bin/sh
set -e

echo "Replacing environment variables in provisioning files..."

# Find all files with .yaml.template extension within /provisioning and its subdirectories
find /provisioning -type f -name "*.yaml.template" | while read -r file; do
  # Calculate the relative path of the file from /provisioning
  relative_path="${file#/provisioning/}"
  
  # Construct the target file path by removing the .template extension
  target_file="/provisioning/${relative_path%.template}"

  # Create the target directory if it doesn't exist, preserving the subdirectory structure
  mkdir -p "$(dirname "$target_file")"

  # Replace environment variables in the template file and write to the target file
  envsubst < "$file" > "$target_file"

  # Print a message indicating the processed files
  echo "Processed: $file -> $target_file"
done

# Print a success message
echo "Environment variables replaced successfully."