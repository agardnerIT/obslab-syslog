Now that the mechanics of the environment are understood, it is time to use it.

## Start Collector

Run the following command to start the collector:

```
./dynatrace-otel-collector --config=config.yaml
```

## Generate syslog Data

Open a new terminal and generate a single syslog message and send to the collector:

```
python syslog_generator.py --host 127.0.0.1 --port 54526 --file sample_log_lines.log --count 1
```

Output like this will be shown:

```
[+] Sending 1 messages to 127.0.0.1 on port 54526
[+] Sent: Aug 28 00:48:56: Log line 2
```

Switch to the collector terminal window and you should see output like this which proves the data was received by the collector and sent to Dynatrace:

```
2024-08-28T00:48:56.934Z        info    ResourceLog #0
Resource SchemaURL: 
ScopeLogs #0
ScopeLogs SchemaURL: 
InstrumentationScope  
LogRecord #0
ObservedTimestamp: 2024-08-28 00:48:56.875906606 +0000 UTC
Timestamp: 2024-08-28 00:48:56 +0000 UTC
SeverityText: info
SeverityNumber: Info(9)
Body: Str(<14>Aug 28 00:48:56 host7.example.com python[3968]: Log line 2)
Attributes:
     -> hostname: Str(host7.example.com)
     -> appname: Str(python)
     -> message: Str(Log line 2)
     -> proc_id: Str(3968)
     -> priority: Int(14)
     -> facility: Int(1)
Trace ID: 
Span ID: 
Flags: 0
        {"kind": "exporter", "data_type": "logs", "name": "debug"}
```

## [>> Click here to continue](view-data.md)