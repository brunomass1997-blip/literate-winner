FROM python:3.11-slim

# Install unzip utility
RUN apt-get update \
    && apt-get install -y --no-install-recommends unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the zipped project into the image
COPY "WeTravel-Lanka-Railway-Ready (1).zip" /app/app.zip

# Extract the archive and clean up the zip file
RUN unzip -o /app/app.zip -d /app \
    && rm /app/app.zip

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the default port (Railway will inject PORT at runtime)
EXPOSE 8000

# Run the FastAPI application with uvicorn, honoring the PORT env var
CMD ["sh", "-c", "uvicorn backend.app.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
