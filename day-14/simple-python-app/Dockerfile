# ✅ Use base image from AWS Public ECR instead of Docker Hub
FROM public.ecr.aws/docker/library/python:3.8

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the port the Flask application will be listening on
EXPOSE 5000

# Run the Flask application (make sure it binds to 0.0.0.0)
CMD ["python", "app.py"]
