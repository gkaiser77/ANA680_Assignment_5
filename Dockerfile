# Use the official Python 3.12 image from the Docker Hub
FROM python:3.12.5

# Install system dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY . .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_APP=app.py

# Use an unprivileged user for running the application
RUN useradd -m appuser
USER appuser

# Run the application
CMD ["gunicorn", "--workers=3", "--bind=0.0.0.0:$PORT", "app:app"]
