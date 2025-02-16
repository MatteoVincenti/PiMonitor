#!/bin/bash

# Determine the script directory
SCRIPT_DIR=$(dirname "$0")

# Set the base certificates directory relative to the script directory
CERTS_BASE_DIR="$SCRIPT_DIR/../certs"
mkdir -p $CERTS_BASE_DIR

# Function to generate certificates for a service
generate_certificates() {
  local service_name=$1
  local service_certs_dir="$CERTS_BASE_DIR/$service_name"
  mkdir -p $service_certs_dir

  # Generate a new private key
  openssl genpkey -algorithm RSA -out $service_certs_dir/$service_name.key

  # Generate a certificate signing request (CSR)
  openssl req -new -key $service_certs_dir/$service_name.key -out $service_certs_dir/$service_name.csr -subj "/CN=$service_name"

  # Generate a self-signed certificate
  openssl x509 -req -days 365 -in $service_certs_dir/$service_name.csr -signkey $service_certs_dir/$service_name.key -out $service_certs_dir/$service_name.crt

  # Clean up the CSR
  rm $service_certs_dir/$service_name.csr

  echo "Certificates generated for $service_name in $service_certs_dir"
}

# Check if a service name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi

generate_certificates "$1"
