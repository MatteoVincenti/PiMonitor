#!/bin/bash

# Determine the script's directory
SCRIPT_DIR=$(dirname "$(realpath "$0")")
PROJECT_ROOT=$(realpath "$SCRIPT_DIR/..")

# Function to check if a service is running
is_service_running() {
  docker ps --filter "name=$1" --filter "status=running" | grep -q "$1"
}

# Function to stop a service if it is running
stop_service_if_running() {
  service_name=$1
  compose_file=$2
  if is_service_running "$service_name"; then
    docker compose -f "$compose_file" down
  else
    echo "$service_name is not running."
  fi
}

# Main script logic
echo "Stopping all services..."

stop_service_if_running "host.telegraf" "$PROJECT_ROOT/docker-compose.yaml"
stop_service_if_running "host.influxdb" "$PROJECT_ROOT/docker-compose.yaml"
stop_service_if_running "host.grafana" "$PROJECT_ROOT/docker-compose.yaml"
stop_service_if_running "watchtower" "$PROJECT_ROOT/docker-compose.watchtower.yaml"
stop_service_if_running "portainer" "$PROJECT_ROOT/docker-compose.portainer.yaml"
stop_service_if_running "homarr" "$PROJECT_ROOT/docker-compose.homarr.yaml"

echo "Shutdown complete."