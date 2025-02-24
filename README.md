# Introduction

This repository provides the instructions and files necessary to set up a comprehensive monitoring solution for your Raspberry Pi (or Linux system) using Docker. This system leverages a powerful combination of tools:

*   **Telegraf:** As a metrics collection agent, Telegraf gathers vital statistics from your Raspberry Pi, such as CPU usage, memory, disk I/O, network traffic, and more.
*   **InfluxDB:** A time-series database, InfluxDB serves as a robust storage backend for metrics collected by Telegraf. It is well-suited for handling time-stamped data and long-term storage of monitoring information.
*   **Prometheus:** An open-source monitoring system and time-series database. Prometheus is also used to store metrics collected by Telegraf and is particularly strong in its ability to perform alerting and provide a more real-time focused view of your system's health.
*   **Grafana:** A powerful data visualization and dashboarding tool. Grafana is used to create insightful dashboards that visualize the metrics stored in both InfluxDB and Prometheus, allowing you to easily monitor and analyze your Raspberry Pi's performance and health.
*   **Optional Services (Homarr, Portainer, Watchtower):**  Beyond the core monitoring components, this setup also includes optional services to enhance your experience:
    *   **Homarr:** A customizable dashboard to organize your services and links.
    *   **Portainer:** A GUI (Graphical User Interface) to easily manage your Docker containers.
    *   **Watchtower:** A service to automatically update the Docker images of your containers.

This configuration provides a flexible and robust monitoring solution, offering both long-term data storage with InfluxDB and real-time monitoring and alerting capabilities with Prometheus, enriched by optional services for management and organization.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

*   **Docker Installed:** Docker is essential to run the services in isolated containers. If you have not yet installed Docker, please follow the official Docker [installation guide for Raspberry Pi OS](https://docs.docker.com/engine/install/raspberry-pi-os/) available on the Docker website.
*   **Notification Tokens (Optional):** If you wish to receive notifications via Telegram or Slack, you will need to generate API tokens for your respective bots. You should also configure any other notification endpoints you desire (e.g., email, webhooks) according to their specific requirements.

## Installation Instructions

Follow these steps to install and configure PiMonitor:

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/MatteoVincenti/PiMonitor.git
    ```

2.  **Navigate to the Project Directory:**
    ```bash
    cd PiMonitor
    ```

3.  **Configure Environment Variables:**
    *   Copy the example environment configuration file to `.env`:
        ```bash
        cp .env.example .env
        ```
    *   Now open the `.env` file with a text editor (like `nano` or `vim`) to populate it with your specific configurations:
        ```bash
        nano .env
        ```

    *   **Understanding `.env` Variables:**
        The `.env` file contains crucial configuration variables for various services. Here's a breakdown of key settings, now including aspects related to Prometheus and optional services:

        *   **Security Keys and Tokens:**
            *   **`DOCKER_INFLUXDB_INIT_ADMIN_TOKEN`:** The initial administrative token for InfluxDB. Fundamental for secure access to your InfluxDB instance.
            *   **`SECRET_ENCRYPTION_KEY`:** Used to encrypt sensitive data within the application (if applicable).
            *   **Generate Secure Values:** Use `openssl rand --hex 32` to generate strong, random values for these variables.

        *   **Passwords:**
            *   **`GF_SECURITY_ADMIN_PASSWORD`:** Password for the Grafana administrative user.
            *   **`DOCKER_INFLUXDB_INIT_PASSWORD`:** Password for the initial InfluxDB administrative user.
            *   **Important Security Note:** Immediately change these default passwords after the initial setup!

        *   **Service Ports (Optional, but configurable in `.env` - based on your `docker-compose.yml`):**
            *   **`GRAFANA_PORT` (Default: 3000):** Port for accessing the Grafana web interface.
            *   **`INFLUXDB_PORT` (Default: 8086):** Port for accessing the InfluxDB API and web interface.
            *   **`PROMETHEUS_PORT` (Default: 9090):** Port for accessing the Prometheus web interface and API.
            *   **`HOMARR_PORT` (Default: 7575):** Port for accessing the Homarr dashboard (if enabled).
            *   **`PORTAINER_PORT_WEB` (Default: 8000):** Port for accessing the Portainer web interface.
            *   **`PORTAINER_PORT_API` (Default: 9443):** Port for accessing the Portainer API (secure HTTPS).
            *   You can customize these ports in the `.env` file if you need to avoid conflicts or prefer different port numbers. If not set, the default values defined in `docker-compose.yml` will be used.

        *   **Additional Configuration Options:** Consult the official documentation of each service (Grafana, InfluxDB, Prometheus, Telegraf, Homarr, Portainer, Watchtower, and any notification services) for detailed explanations of all available configuration parameters in `.env` and their impact. In particular, you might find Telegraf configuration options relevant if you want to customize the collected metrics.

## Start and Stop Scripts and Optional Service Selection

The provided scripts have been improved to allow you to flexibly manage the startup of services, including the selection of optional services:

*   **Start Services:** To start Grafana, InfluxDB, Prometheus, Telegraf, and **choose which optional services (Homarr, Portainer, Watchtower) to start**, run:

    ```bash
    ./scripts/start.sh
    ```
    This script will now present an interactive menu. You will be prompted to select which optional services you want to start along with the core services (Grafana, InfluxDB, Prometheus, Telegraf) which are always started. The script uses `docker compose up -d` to start the services in detached mode (in the background), respecting service dependencies defined in `docker-compose.yml`.

*   **Stop Services:** To stop **all** running services, including optional ones, use:

    ```bash
    ./scripts/stop.sh
    ```
    This script executes `docker compose down` to gracefully stop and remove all containers. It does not offer a selection, but stops the entire PiMonitor system.

*   **Other Utilities in `scripts` Folder**

*   **Updating Grafana:**

    ```bash
    docker compose build --no-cache
    ```

## Accessing Grafana and Importing Dashboards

1.  **Access Grafana in your Browser:**
2.  **Log in to Grafana:**
3.  **Import Grafana Dashboards:**
    To visualize your Raspberry Pi's statistics from **both InfluxDB and Prometheus**, you will need to import Grafana dashboards. Dashboards are pre-configured to work with either or both of these data sources.

    *   **Locate Dashboard JSON Files:** *Is in repository in grafana folder*
    *   **Importing into Grafana**

4.  **Customize and Explore:**
    Once imported, explore the dashboards. **Note that some dashboards might be designed to visualize data from InfluxDB, others from Prometheus, or even combine data from both sources.** When customizing or creating new dashboards, you will now have the option to choose either InfluxDB or Prometheus as your data source when adding panels. Experiment with different visualizations and data sources to gain a comprehensive view of your Raspberry Pi's metrics.