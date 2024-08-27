#!/bin/bash

COLLECTOR_VERSION=0.12.0

# if TZ env var isn't set, default to "UTC"
if [ -z "${VAR}" ]; then VAR="UTC"; fi

# Download Collector
wget https://github.com/Dynatrace/dynatrace-otel-collector/releases/download/v${COLLECTOR_VERSION}/dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
tar -xf dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz
rm dynatrace-otel-collector_${COLLECTOR_VERSION}_Linux_x86_64.tar.gz