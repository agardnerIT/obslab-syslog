# Observability Lab: Syslog Ingest

* TODO: Architecture diagram
* TODO: Documentation
* TODO: Friendly startup image / link
* TODO: Startup pings

* Format DT URL
* Create API token with `logs.ingest` permissions
* Start codespace using form
* Start collector
    * Explain that collector binary is downloaded and extracted at startup
    * Explain that env vars are alread set at startup
    * Walkthrough config.yaml to explain

```
./dynatrace-otel-collector --config=config.yaml
```

* Send a single test syslog message
    * Explain how Python uses sample_log_lines.log to seend and randomly generate data

```
python syslog_generator.py --host 127.0.0.1 --port 54526 --file sample_log_lines.log --count 1
```
