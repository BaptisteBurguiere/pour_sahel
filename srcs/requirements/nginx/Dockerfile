FROM debian:buster

RUN apt-get update
RUN apt-get install -y nginx
RUN apt-get install -y openssl

RUN mkdir /etc/nginx/ssl

RUN openssl genrsa -out /etc/nginx/ssl/server.key 2048

RUN openssl req \
    -new -key /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.csr -subj \
    "/C=FR/ST=Normandie/L=LeHavre/O=42/OU=42/CN=bburguie/emailAddress= bburguie@student.42lehavre.fr"

RUN openssl x509 -req -days 365 \
    -in /etc/nginx/ssl/server.csr \
    -signkey /etc/nginx/ssl/server.key \
    -out /etc/nginx/ssl/server.crt

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]