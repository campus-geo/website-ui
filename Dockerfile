# Grab the X_VERSION build argument
ARG X_VERSION=unknown-development

# Stage 1: Build the static site using Node.js on Alpine
FROM node:alpine AS build

# Retrieve the X_VERSION arg
ARG X_VERSION

# Set the X_VERSION runtime environment variable
ENV X_VERSION=$X_VERSION

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

# Retrieve the X_VERSION arg
ARG X_VERSION

# Set the X_VERSION runtime environment variable
ENV X_VERSION=$X_VERSION

# Copy your Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf.template

RUN envsubst '$X_VERSION' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Copy the built site from the build stage
COPY --from=build /app/www /usr/share/nginx/html