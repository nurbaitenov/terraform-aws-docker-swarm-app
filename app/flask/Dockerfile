FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]




# docker run   -d      --name flask-app    -p 5000:5000   flask-app:1.0

#   curl http://localhost:5000


# push to Docker Hub

# docker login

# docker push nbdevops3036/flask-app:1.0