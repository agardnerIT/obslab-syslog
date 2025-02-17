Now that the mechanics of the environment are understood, it is time to use it.

--8<-- "snippets/bizevent-run-demo.js"

## Start Collector

Run the following command to start the collector:

``` { "name": "[background] run otel collector" }
/workspaces/$RepositoryName/dynatrace-otel-collector --config=/workspaces/$RepositoryName/config.yaml
```

## Generate syslog Data

Open a new terminal and generate a single syslog message and send to the collector:

``` {"name": "send log to collector"}
python /workspaces/$RepositoryName/syslog_generator.py --host 127.0.0.1 --port 54526 --file /workspaces/$RepositoryName/sample_log_lines.log --count 1
```

Output like this will be shown:

```
[+] Sending 1 messages to 127.0.0.1 on port 54526
[+] Sent: Aug 28 00:48:56: Log line 2
```

<div class="grid cards" markdown>
- [Click here to continue :octicons-arrow-right-24:](view-data.md)
</div>
