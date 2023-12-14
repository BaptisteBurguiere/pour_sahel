NAME=inception

${NAME}:
	mkdir -p ~/data
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	sudo docker-compose -f srcs/docker-compose.yml up -d --build
# 	sleep 15
# 	make logs

all: ${NAME}

clean:
	sudo docker-compose -f srcs/docker-compose.yml down -v
	sudo docker system prune --force --volumes --all
	sudo rm -rf ~/data

fclean: clean

re: clean all

logs:
	@echo "---------- MARIADB -----------\n"
	@sudo docker-compose -f srcs/docker-compose.yml logs mariadb
	@echo "\n-------- WORDPRESS ----------\n"
	@sudo docker-compose -f srcs/docker-compose.yml logs wordpress
	@echo "\n---------- NGINX ------------\n"
	@sudo docker-compose -f srcs/docker-compose.yml logs nginx