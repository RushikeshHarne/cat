# Use official Apache (HTTPD) base image
FROM httpd:latest

# Copy your HTML file into the default Apache directory
COPY index.html /usr/local/apache2/htdocs/

# Expose port 80 for web traffic
EXPOSE 80

# Default command to start Apache
CMD ["httpd-foreground"]
