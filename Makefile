NAME			= .Inception

DOCKER_COMPOSE_FILE	= srcs/docker-compose.yml
VOLUME_DIRECTORY	= /home/hrazafia/data

DATABASE_VOLUME		= /home/hrazafia/data/mariadb
WEBSITE_VOLUME		= /home/hrazafia/data/www/hrazafia.42.fr

RM			= rm -f
UP			= up -d --build

INIT			= /home/hrazafia/scripts/init.sh

VOLUME_LIST		= $(DATABASE_VOLUME) $(WEBSITE_VOLUME)

all: $(NAME)

$(NAME):
	$(MAKE) up
	touch $(NAME)

status:
	docker compose -f $(DOCKER_COMPOSE_FILE) ps

up:
	bash $(INIT)
	sudo mkdir -p $(VOLUME_LIST)
	docker compose -f $(DOCKER_COMPOSE_FILE) $(UP)

start:
	docker compose -f $(DOCKER_COMPOSE_FILE) start

stop:
	docker compose -f $(DOCKER_COMPOSE_FILE) stop

clean:
	$(RM) $(NAME)
	docker compose -f $(DOCKER_COMPOSE_FILE) down

fclean: clean
	sudo $(RM) -r $(VOLUME_DIRECTORY)
	docker image rm $$(docker image list -aq)
	docker volume rm $$(docker volume list -q)

re: fclean all

.PHONY: all up down start stop status clean fclean re
