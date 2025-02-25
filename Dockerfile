# Use Ubuntu as base image
FROM ubuntu:latest

# Install required system packages
RUN apt update && apt install -y python3 python3-pip python3-venv

# Set working directory inside container
WORKDIR /app

# Copy application files
COPY . /app

# Create a virtual environment
RUN python3 -m venv venv

# Install dependencies using the virtual environment's pip
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Command to run the FastAPI app
CMD ["/app/venv/bin/python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
