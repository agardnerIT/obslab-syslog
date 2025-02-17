It is time to view the data in Dynatrace.

--8<-- "snippets/bizevent-view-data.js"

In Dynatrace:

* Press `ctrl + k` search for `notebooks`
* Add a new section for `logs`
* Search for:

```{ "name": "fetch log line" }
fetch logs
| filter matchesPhrase(content, "Log line")
```

![dynatrace notebook syslog](images/dt-notebook-1.png)

Scroll to the right on the log line. Notice that Dynatrace natively understands syslog and has automatically mapped the fields to their human readable names.

![dynatrace syslog mapping](images/dt-notebook-2.png)

These fields can be used to filter, group or parse log data further.

For example, the following query shows all log lines containing the text `Log line` split by the `priority`, `hostname` and `proc_id` fields:

```
fetch logs
| filter contains(content, "Log line")
| summarize logCount = count(), by:{priority, hostname, proc_id}
| sort logCount desc
```

![syslog split by fields](images/dt-notebook-3.png)

## Congratulations

You have succesfully ingested syslog data into Dynatrace.

This Observability lab is now complete.

<div class="grid cards" markdown>
- [Click here to cleanup your environment :octicons-arrow-right-24:](cleanup.md)
</div>
