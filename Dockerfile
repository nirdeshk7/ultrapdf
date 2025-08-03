FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    libreoffice \
    ghostscript \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY templates/ ./templates/

RUN mkdir -p uploads converted_pdfs temp_outputs

EXPOSE 5000

CMD ["gunicorn", "-w", "3", "-b", "0.0.0.0:5000", "app:app"]
