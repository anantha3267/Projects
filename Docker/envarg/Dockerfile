# Dockerfile (in root)
FROM python:3.9-slim

# Define build argument
ARG APP_VERSION=1.0.0

# Set environment variable using ARG
ENV APP_VERSION=$APP_VERSION

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

# Print the app version when the container runs
CMD echo "Running app version: $APP_VERSION" && python app.py
