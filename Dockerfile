# Base image for Python
FROM python:3.10-slim

# Install MySQL server
# New, working line:
RUN apt-get update && apt-get install -y mariadb-server && apt-get clean
# Set working directory
WORKDIR /app

# Copy Flask app files
COPY . /app

# Install Python dependencies
#RUN pip install -r requirements.txt

# Copy init SQL script
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=user_db
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=root
ENV MYSQL_HOST=localhost
ENV FLASK_RUN_PORT=5000

# Expose Flask and MySQL ports
EXPOSE 5000 3306

# Start both MySQL and Flask together
CMD service mysql start && \
    mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS user_db;" && \
    flask run --host=0.0.0.0
