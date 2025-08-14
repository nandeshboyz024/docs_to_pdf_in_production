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

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8000

# Run both Celery worker and Django in the same container
CMD ["/start.sh"]