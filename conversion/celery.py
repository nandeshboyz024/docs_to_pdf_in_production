import os
from celery import Celery

# Set the default Django settings module
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'conversion.settings')

app = Celery('conversion')

# Load broker and backend from environment variables
# Fallback values are optional — useful for local dev
app.conf.broker_url = os.getenv(
    'CELERY_BROKER_URL',
    'amqp://guest:guest@localhost:5672//'  # default for local RabbitMQ
)
app.conf.result_backend = os.getenv(
    'CELERY_RESULT_BACKEND',
    'rpc://'  # default simple backend
)

# Auto-discover tasks from installed apps
app.autodiscover_tasks()