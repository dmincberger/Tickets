# Use the official NGINX image
FROM nginx:latest

# Remove the default config to avoid conflicts
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom NGINX configuration into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 inside the container
EXPOSE 80

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]