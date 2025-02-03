## Backend

# MERN Stack App

This is a MERN stack application consisting of a backend built with Node/Express, a frontend built with React, and a reverse proxy set up with Nginx.

## Backend Dockerfile

```dockerfile
# Use Node.js image as base
FROM node:16

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy application code
COPY . .

# Expose backend port
EXPOSE 5000

# Start the app
CMD ["npm", "start"]
```

## Frontend

```dockerfile
# Use Node.js image as base
FROM node:16 as build

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Build React app
COPY . .
RUN npm run build

# Serve the app using Nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose frontend port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

## Nginx

```nginx
server {
    listen 80;

    location / {
        root /usr/share/nginx/html;
        try_files $uri /index.html;
    }

    location /api {
        proxy_pass http://backend:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

## Docker compose

````dockerfile

version: '3.8'
services:
  backend:
    build: ./backend
    container_name: backend
    ports:
      - "5000:5000"
    networks:
      - mern-network
    env_file:
      - .env  # Reference to the .env file

  frontend:
    build: ./frontend
    container_name: frontend
    ports:
      - "80:80"
    networks:
      - mern-network
    depends_on:
      - backend

  mongo:
    image: mongo:latest
    container_name: mongo
    volumes:
      - mongo-data:/data/db
    networks:
      - mern-network

  nginx:
    image: nginx:alpine  # Use the official Nginx image
    container_name: nginx
    ports:
      - "80:80"  # Expose port 80 to the host machine (frontend and backend reverse proxy)
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf  # Optional: Custom Nginx config file
    networks:
      - mern-network
    depends_on:
      - frontend
      - backend  # Ensure both frontend and backend are ready before starting Nginx

networks:
  mern-network:
    driver: bridge

volumes:
  mongo-data:
    driver: local
```
````
