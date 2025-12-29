FROM python:3.12-slim

WORKDIR app

# Install system deps if needed (e.g., build-essential, etc.)
RUN pip install --no-cache-dir --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV APP_ENV=container
ENV APP_VERSION=dev

EXPOSE 5000

CMD ["python", "app.py"]

