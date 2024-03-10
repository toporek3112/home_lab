from flask import Flask, request
from prometheus_client import start_http_server, Gauge, Summary
import random
import time

app = Flask(__name__)

# Prometheus metrics with labels for location
temperature_gauge = Gauge('temperature', 'Temperature of the environment', ['location'])
humidity_gauge = Gauge('humidity', 'Humidity of the environment', ['location'])

@app.route('/post_metrics', methods=['POST'])
def post_metrics():
  data = request.json
  temperature = data['temperature']
  humidity = data['humidity']
  location = data['location']
  
  # Set metrics with labels
  temperature_gauge.labels(location=location).set(temperature)
  humidity_gauge.labels(location=location).set(humidity)
  
  return "Metrics updated", 200

if __name__ == '__main__':
  # Start up the server to expose the metrics.
  start_http_server(8000)
  app.run(host='0.0.0.0', port=5000)
