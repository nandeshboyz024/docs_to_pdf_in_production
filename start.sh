#!/bin/bash
set -e

# Apply database migrations
python manage.py migrate --noinput

# Start Celery worker in the background
celery -A conversion worker --loglevel=info &

# Start Django with Gunicorn
gunicorn conversion.wsgi:application --bind 0.0.0.0:8000 --workers 4