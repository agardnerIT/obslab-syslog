#!/bin/bash

COLLECTOR_VERSION=0.12.0

# Possible modes are otel or ag
# Default mode to otel if it is unset or empty
if [ -z "${DT_MODE_SYSLOG}" ]; then
  DT_MODE_SYSLOG=otel
fi

if test "${DT_MODE_SYSLOG}" == "otel"; then
    # Download Collector
    wget https://github.com/Dynatrace/dynatrace-otel-collector/releases/download/v${COLLECTOR_VERSION}/dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
    tar -xf dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
    rm dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
else
    # Install ActiveGate
    wget -O Dynatrace-ActiveGate-Linux-x86.sh "$DT_ENDPOINT_SYSLOG/api/v1/deployment/installer/gateway/unix/latest?arch=x86" --header="Authorization: Api-Token $DT_API_TOKEN_SYSLOG"
    sudo /bin/bash Dynatrace-ActiveGate-Linux-x86.sh
fi

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