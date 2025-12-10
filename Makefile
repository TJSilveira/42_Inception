IMAGES = $(shell docker images -q)

nginx:
	docker build -t tjsilveira/nginx ./src/requirements/nginx/.
	docker run -it --name nginx --entrypoint sh tjsilveira/nginx

wordpress:
	docker build -t tjsilveira/wordpress ./src/requirements/wordpress/.
	docker run -it --name wordpress --entrypoint sh tjsilveira/wordpress

clean:
	docker volume rm $(shell docker volume ls -q)
	docker rmi $(IMAGES)
	docker container prune -f

stop:
	docker stop wordpress
	docker stop nginx
	docker stop db

db:
	docker build -t tjsilveira/mariadb ./src/requirements/mariadb/.
	docker run -it --name wordpress --entrypoint sh tjsilveira/mariadb

up:
	@docker-compose -f ./src/docker-compose.yml up -d
