# Introduction

This repository contains instructions and necessary files to set up and run an instance of Shoutrrr, Watchtower, and Grafana on a Raspberry Pi using Docker. Shoutrrr is a service for sending notifications to various instant messaging platforms like Discord and Slack, while Watchtower is a service for monitoring and automatically updating Docker containers. Grafana is used for visualizing and analyzing the vital statistics of the Raspberry Pi.

By Matteo Vincenti

## Prerequisites

Before proceeding with the installation and deployment of services, ensure that Docker is installed on your Raspberry Pi. If Docker is not installed, follow the official Docker [installation guide](https://docs.docker.com/engine/install/raspberry-pi-os/) available on the Docker website.

Additionally, you need to generate tokens for Telegram and/or Slack bots and configure any other necessary endpoints for notifications.

## Installation Instructions

Clone the repository onto your Raspberry Pi:

```bash
git clone <repository_URL>
```

Navigate to the project directory:

```bash
cd <project_folder_name>
```

Copy the `.env.example` file to `.env`:

```bash
cp .env.example .env
```

Populate the `.env` file with your configurations:
generate a key for `DOCKER_INFLUXDB_INIT_ADMIN_TOKEN`:

```bash
openssl rand --hex 32
```

This key can also be used to generate the password for `DOCKER_INFLUXDB_INIT_PASSWORD`.

## Start and Stop Scripts

You can use the provided scripts to start and stop the services:

To start the services:

```bash
./scripts/start.sh
```

To stop the services:

```bash
./scripts/stop.sh
```

## Grafana Configuration

After launching the services, you can configure Grafana to visualize the data from InfluxDB.

1. Access Grafana by navigating to `http://<raspberry_pi_ip>:3000` in your web browser. Log in using the default credentials (`admin/admin`).

2. Click on "Add data source" and choose "InfluxDB".

3. Configure the InfluxDB data source with the following details:
   - **URL:** `http://influxdb:8086`
   - **Token:** `<your InfluxDB admin token>`
   - **Organization:** `<organization>`
   - **Bucket:** `telegraf`

4. Save the data source.

5. Now you can import and customize dashboards to visualize your Raspberry Pi's vital statistics.

6. Navigate to the folder `grafana/dashboards` within your project repository.

7. Locate the JSON file containing the dashboard you wish to import.

## Watchtower Configuration and Run

In the `.env` file, you can copy, paste and edit the following configurations or create your own by following the [documentation](https://containrrr.dev/watchtower/arguments/):

```ini
WATCHTOWER_NOTIFICATION_URL="discord://token@channel"
WATCHTOWER_CLEANUP=true
WATCHTOWER_REMOVE_VOLUMES=true
WATCHTOWER_INCLUDE_STOPPED=true
WATCHTOWER_NO_STARTUP_MESSAGE=false
```

To start the container run

```bash
docker compose -f docker-compose.watchtower.yml up -d
```

## Portainer Up and Running

To start the container run

```bash
docker compose -f docker-compose.portainer.yml up -d
```

Now you can go to `https://localhost:9443` and follow the initial setup.

## Homarr Configuration and Run

Generate a token for Homarr:

```bash
openssl rand --hex 32
```

Add the generated token to the `.env` file under `SECRET_ENCRYPTION_KEY`.

To start the container run

```bash
docker compose -f docker-compose.homarr.yml up -d
```