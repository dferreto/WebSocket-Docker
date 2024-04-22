FROM python:3.11.9-alpine3.19
LABEL authors="dferreto"

# Set the working directory in the container
WORKDIR /apps/socket_01

# Copy the dependencies file to the working directory
COPY . /apps/socket_01

# Create virtual environment
RUN python -m venv venv

# Activate virtual environment
RUN . venv/bin/activate

# Install any dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port the app runs on
EXPOSE 5001

# Run the application
CMD ["python", "app.py"]
