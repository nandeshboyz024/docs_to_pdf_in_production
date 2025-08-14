FROM python:3.11-slim

# Install pandoc and LaTeX for PDF conversion
RUN apt-get update && \
    apt-get install -y pandoc texlive-xetex && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project files
COPY . .

EXPOSE 8000

# Instead of runserver, use gunicorn for production
CMD ["gunicorn", "conversion.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "4"]