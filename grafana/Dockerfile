FROM alpine:latest AS builder

ARG GRAFANA_MAIN_FOLDER_NAME
ARG INFLUXDB_HOST
ARG INFLUXDB_PORT
ARG INFLUXDB_HOST
ARG INFLUXDB_PORT
ARG DOCKER_INFLUXDB_INIT_ORG
ARG DOCKER_INFLUXDB_INIT_BUCKET
ARG DOCKER_INFLUXDB_INIT_ADMIN_TOKEN

RUN apk update && apk add --no-cache curl gettext && rm -rf /var/cache/apk/*

WORKDIR /workspace

COPY ./provisioning /workspace/provisioning
COPY ./dashboards /workspace/dashboards
COPY ./scripts /workspace/scripts

RUN chmod +x /workspace/scripts/*.sh

RUN /workspace/scripts/build-provisioning.sh

FROM grafana/grafana-oss:latest

COPY --from=builder /workspace/provisioning /etc/grafana/provisioning/
COPY --from=builder /workspace/dashboards /var/lib/grafana/dashboards/
