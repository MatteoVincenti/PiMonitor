FROM alpine:latest AS builder

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
