FROM alpine:latest AS builder

ARG INFLUXDB_HOST
ARG INFLUXDB_PORT
ARG PROMETHEUS_HOST
ARG PROMETHEUS_PORT
ARG DOCKER_INFLUXDB_INIT_ORG
ARG DOCKER_INFLUXDB_INIT_BUCKET
ARG DOCKER_INFLUXDB_INIT_ADMIN_TOKEN

RUN apk update \
    && apk add --no-cache curl gettext \
    && rm -rf /var/cache/apk/*

WORKDIR /provisioning

COPY ./provisioning /provisioning

RUN chmod +x /provisioning/generate-provisioning.sh \
    && /provisioning/generate-provisioning.sh

FROM grafana/grafana-oss:latest

COPY --from=builder /provisioning/datasources /etc/grafana/provisioning/datasources
