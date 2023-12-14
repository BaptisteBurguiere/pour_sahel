FROM debian:buster

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y mariadb-server
RUN apt-get install -y procps

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./conf/config_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config_db.sh
ENTRYPOINT ["sh", "-c", "/usr/local/bin/config_db.sh"]
