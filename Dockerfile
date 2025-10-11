# Use your existing image as base
FROM harnempire/cat:v2

# Set working directory (optional)
WORKDIR /app

# Expose the port that the Flask app runs on (based on your previous compose file, it's 5000)
EXPOSE 5000

# Default command to start the container
CMD ["python3", "app.py"]
