Define and configure plugin:
{
  "checks": {
    "process_metrics": {
      "type": "metric",
      "command": "package-process.rb",
      "standalone":true,
      "interval": 60,
      "handler":"hostcollector"
    }
  }
}

