import requests
import time

def send_log_to_loki(loki_url, labels, line):
    timestamp = str(int(time.time() * 1e9))  # Nanosecond timestamp
    json_data = {
        "streams": [
            {
                "stream": labels,
                "values": [
                    [timestamp, line]
                ]
            }
        ]
    }
    headers = {
        "Content-Type": "application/json",
        # "Authorization": "Bearer YOUR_TOKEN_HERE"  # Uncomment and modify if auth is needed
    }
    response = requests.post(loki_url + '/loki/api/v1/push', json=json_data, headers=headers)
    print('Status Code:', response.status_code)
    print('Response:', response.text)

# Example usage
loki_url = 'http://localhost:3100'  # Change this if your Loki is hosted differently
labels = {
    "job": "test_job",
    "instance": "example_instance"
}
log_message = "Hello, Loki!"
send_log_to_loki(loki_url, labels, log_message)
