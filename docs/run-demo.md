Now that the mechanics of the environment are understood, it is time to use it.

--8<-- "snippets/bizevent-run-demo.js"

## Start Collector

Run the following command to start the collector:

``` { "name": "[background] run otel collector" }
. /workspaces/$RepositoryName/.env
/workspaces/$RepositoryName/dynatrace-otel-collector --config=/workspaces/$RepositoryName/config.yaml
```

## Generate syslog Data

Open a new terminal and generate a single syslog message and send to the collector:

``` {"name": "send log to collector"}
logger -n 127.0.0.1 -P 54526 "Test syslog message"
```

<div class="grid cards" markdown>
- [Click here to continue :octicons-arrow-right-24:](view-data.md)
</div>
