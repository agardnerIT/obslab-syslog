#!/bin/bash

COLLECTOR_VERSION=0.12.0


# Download Collector
wget https://github.com/Dynatrace/dynatrace-otel-collector/releases/download/v${COLLECTOR_VERSION}/dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
tar -xf dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
rm dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz

# Creation Ping
curl -X POST https://grzxx1q7wd.execute-api.us-east-1.amazonaws.com/default/codespace-tracker \
  -H "Content-Type: application/json" \
  -d "{
    \"tenant\": \"$DT_ENDPOINT_SYSLOG\",
    \"repo\": \"$GITHUB_REPOSITORY\",
    \"demo\": \"obslab-syslog\",
    \"codespace.name\": \"$CODESPACE_NAME\",
    \"mode\": \"$DT_MODE_SYSLOG\"
  }"