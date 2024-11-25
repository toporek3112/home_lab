# Speedtest
The https://github.com/jeanralphaviles/prometheus_speedtest is an implemenatation of the speedtest cli which executes a speedtest command each time the endpoint it accessed/scraped

Because the speedtest command takes a certain amount of time the endpoint should not be scraped too often but rather each 10min. This intervall is subjective to change.

The scraping of the endpoint should be configured via a seperate serviceMonitor which configures the intervall and other stuff.

## Deployment

| Image                                | version                                                                        |
| ------------------------------------ | ------------------------------------------------------------------------------ |
| jeanralphaviles/prometheus_speedtest | [0.9.14](https://github.com/jeanralphaviles/prometheus_speedtest/tree/v0.9.14) |

## Issues
- https://github.com/toporek3112/home_lab/issues/22
	+ https://github.com/toporek3112/home_lab/issues/23
	+ https://github.com/toporek3112/home_lab/issues/24