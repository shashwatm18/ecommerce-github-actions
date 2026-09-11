# Use a slim Python image to keep the container lightweight
FROM python:3.11-slim

# Set environment variables to optimize Python behavior in Docker
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory inside the container
WORKDIR /app

# Copy only requirements first to leverage Docker's build cache layers
COPY requirements.txt .

# Install dependencies without saving cache to minimize image size
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files into the container
COPY . .

# Expose the port your application will listen on
EXPOSE 8000

# Run the application using uvicorn (FastAPI) or gunicorn (Flask)
# Change this command depending on which framework you choose below
CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]

