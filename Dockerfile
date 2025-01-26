# Stage 1: Build the static site using Node.js on Alpine
FROM node:alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the static site using the provided npm run compile command
RUN npm run compile

# Stage 2: Serve the static site using Nginx on Alpine
FROM nginx:alpine

# Copy your Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/serve.conf

# Copy the built site from the build stage
COPY --from=build /app/www /usr/share/nginx/html