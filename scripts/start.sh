#!/bin/bash
set -eux

# Determine the script's directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# Function to start services with multiple compose files
start_services() {
  compose_files=("$@")
  docker compose "${compose_files[@]}" up -d
}

# Main script logic
compose_files=(-f "$PROJECT_ROOT/docker-compose.yaml")

# Function to prompt user for service selection
prompt_service() {
  local service_name=$1
  local compose_file=$2
  read -p "Do you want to include $service_name? (y/n): " choice
  if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    compose_files+=(-f "$compose_file")
  fi
}

# Prompt user to select additional services to start
echo "Select additional services to start:"
prompt_service "homarr" "$PROJECT_ROOT/docker-compose.homarr.yaml"
prompt_service "portainer" "$PROJECT_ROOT/docker-compose.portainer.yaml"
prompt_service "watchtower" "$PROJECT_ROOT/docker-compose.watchtower.yaml"

echo "Starting services with compose files: ${compose_files[*]}"
start_services "${compose_files[@]}"

echo "Initialization complete."