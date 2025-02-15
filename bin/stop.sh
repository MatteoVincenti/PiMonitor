#!/bin/bash

# Function to check if a service is running
is_service_running() {
  docker ps --filter "name=$1" --filter "status=running" | grep -q "$1"
}

# Function to stop a service if it is running
stop_service_if_running() {
  service_name=$1
  compose_file=$2
  if is_service_running "$service_name"; then
    docker-compose -f "$compose_file" down
  else
    echo "$service_name is not running."
  fi
}

# Main script logic
echo "Stopping all services..."

stop_service_if_running "host.telegraf" "../docker-compose.yml"
stop_service_if_running "host.influxdb" "../docker-compose.yml"
stop_service_if_running "host.grafana" "../docker-compose.yml"
stop_service_if_running "watchtower" "../docker-compose.watchtower.yml"
stop_service_if_running "portainer" "../docker-compose.portainer.yml"
stop_service_if_running "homarr" "../docker-compose.homarr.yml"

echo "Shutdown complete."
