IMAGES = $(shell docker images -q)

nginx:
	docker build -t tjsilveira/nginx ./src/requirements/nginx/.
	docker run -it --name nginx --entrypoint sh tjsilveira/nginx

wordpress:
	docker build -t tjsilveira/wordpress ./src/requirements/wordpress/.
	docker run -it --name wordpress --entrypoint sh tjsilveira/wordpress

redis:
	docker build -t tjsilveira/redis ./src/requirements/bonus/redis/.
	docker run -it --name redis --entrypoint sh tjsilveira/redis

clean1: 
	docker container prune -f
	docker volume rm $(shell docker volume ls -q)
	docker rmi $(IMAGES)

clean2: stop clean1 

clean_images: 
	docker rmi $(IMAGES)

stop:
	docker stop wordpress
	docker stop nginx
	docker stop mariadb

vol_clean:
	@sudo chown -R $(whoami):$(whoami) /home/tiago/data/mariadb/ && rm -rf /home/tiago/data/mariadb/*

db:
	docker build -t tjsilveira/mariadb ./src/requirements/mariadb/.
	docker run -it --name wordpress --entrypoint sh tjsilveira/mariadb

up:
	@docker-compose -f ./src/docker-compose.yml up -d

down:
	@docker-compose -f ./src/docker-compose.yml down -v
