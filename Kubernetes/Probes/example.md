# Kubernetes Probes Example

This example demonstrates how to configure **liveness** and **readiness** probes in Kubernetes with a simple HTTP server. The server exposes a `/healthz` endpoint, and Kubernetes uses this endpoint to check the container's health and readiness.

## Simple Python HTTP Server

The following Python application listens on port `8080` and exposes a `/healthz` endpoint. This is used by Kubernetes for both **liveness** and **readiness** checks.

### `app.py` - Simple Python Application

````python
from http.server import BaseHTTPRequestHandler, HTTPServer
import time

class HealthCheckHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/healthz':
            # Respond with HTTP 200 for health check
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(b'OK')
        else:
            self.send_response(404)
            self.end_headers()

# Start HTTP server
def run(server_class=HTTPServer, handler_class=HealthCheckHandler, port=8080):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    httpd.serve_forever()

if __name__ == '__main__':
    run()



## Configuration

Here is the full Docker configuration:

## Dockerfile

```Docker
FROM python:3.8-slim

# Copy the application code
COPY app.py /app.py

# Expose the port
EXPOSE 8080

# Run the Python app
CMD ["python", "/app.py"]

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-health-check
spec:
  containers:
  - name: simple-http-server
    image: <your-docker-image>  # Replace with your image name
    ports:
    - containerPort: 8080
    livenessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 5   # Wait 5 seconds before first probe
      periodSeconds: 5         # Check every 5 seconds
    readinessProbe:
      httpGet:
        path: /healthz
        port: 8080
      initialDelaySeconds: 10  # Wait 10 seconds before first probe
      periodSeconds: 5         # Check every 5 seconds
````
