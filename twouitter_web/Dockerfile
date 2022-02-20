FROM python:3.9.10-alpine3.15
WORKDIR /code
ENV FLASK_APP=web.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers mariadb-dev python3-dev bash
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . .
CMD ["./wait-for-it.sh" , "twouitter_database:3306" , "--strict" , "--timeout=30" , "--" , "flask","run"]
