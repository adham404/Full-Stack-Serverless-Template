#!/bin/bash
set -e

# Use PORT environment variable if available, otherwise default to 8080
PORT=${PORT:-8080}

# Start the FastAPI application
exec fastapi run --workers 4 --port $PORT app/main.py 