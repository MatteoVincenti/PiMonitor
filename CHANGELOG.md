# Changelog

All notable changes to `PiMonitor` will be documented in this file.

### Added
- Added dependency for telegraf in `docker-compose.yml`.
- Split docker compose into multiple files to start only the wanted services, updated the `README.md`.
- Added new docker compose files for specified optional services.
- Added name on docker compose file.
- Added `generate_certs.sh` script to generate certificates for services.
- Added certificate generation to `start_services.sh` script.

### Updated
- Updated telegraf config and `docker-compose.yml`.
- Updated some settings.
- Updated telegraf config and docker-compose.
- Edited `README.md`.
- Updated docker compose.
- Updated `start_services.sh` to use `generate_certs.sh` for certificate generation.

### Removed
- Removed some configs from `telegraf.conf`.

## [Initial Release]
- Initial commit.