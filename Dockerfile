FROM python:3.6-slim

RUN apt-get update -y
RUN apt-get install -y nginx && apt-get install -y curl

RUN apt-get install -y supervisor

RUN rm /etc/nginx/nginx.conf
COPY ./config/nginx.conf /etc/nginx/
# COPY ./config/default.conf /etc/nginx/sites-available/
# COPY ./config/default.conf /etc/nginx/sites-enabled/

RUN nginx -t
# RUN service nginx stop
RUN service nginx restart


COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
COPY config/test.conf /etc/supervisor/conf.d/
COPY config/app.sh /src/supervisor/scripts/

RUN chmod 777 /src/supervisor/scripts/app.sh

RUN service supervisor stop

WORKDIR /app
ADD . /app

EXPOSE 80

RUN service nginx start

CMD  service supervisor start && tail -f /dev/null
