FROM python:3.11-slim
WORKDIR /app
# On pointe vers le dossier app/ de ton dépôt
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ .
EXPOSE 10000
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]
