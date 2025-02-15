#!/bin/bash

# Function to start services with multiple compose files
start_services() {
  compose_files=("$@")
  docker-compose "${compose_files[@]}" up -d
}

# Main script logic
compose_files=(-f ../docker-compose.yml)

# Check for additional services to start
if [ "$1" == "--with" ]; then
  shift
  for service in "$@"; do
    compose_files+=(-f ../docker-compose.${service}.yml)
  done
fi

echo "Starting services with compose files: ${compose_files[*]}"
start_services "${compose_files[@]}"

echo "Initialization complete."
