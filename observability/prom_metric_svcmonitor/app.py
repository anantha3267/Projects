from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
import prometheus_client

app = Flask(__name__)

# Define a Counter metric
http_hits = Counter('http_hits_total', 'Total number of HTTP hits')

@app.route('/')
def index():
    http_hits.inc()  # Increment the counter on each request
    return "Hello! You've hit this endpoint."

@app.route('/metrics')
def metrics():
    return generate_latest(prometheus_client.REGISTRY), 200, {'Content-Type': CONTENT_TYPE_LATEST}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
