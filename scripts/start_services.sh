#!/bin/bash

# Function to start services with multiple compose files
start_services() {
  compose_files=("$@")
  docker compose "${compose_files[@]}" up -d
}

# Main script logic
compose_files=(-f ../docker-compose.yml)

# Function to prompt user for service selection
prompt_service() {
  local service_name=$1
  local compose_file=$2
  read -p "Do you want to include $service_name? (y/n): " choice
  if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    compose_files+=(-f "$compose_file")
    # Generate certificates using the generate_certs.sh script
    bash "$(dirname "$0")/generate_certs.sh" "$service_name"
  fi
}

# Prompt user to select additional services to start
echo "Select additional services to start:"
prompt_service "homarr" "../docker-compose.homarr.yml"
prompt_service "portainer" "../docker-compose.portainer.yml"
prompt_service "watchtower" "../docker-compose.watchtower.yml"

echo "Starting services with compose files: ${compose_files[*]}"
start_services "${compose_files[@]}"

echo "Initialization complete."