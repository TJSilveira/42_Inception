IMAGES = $(shell docker images -q)

nginx:
	docker build -t tjsilveira/nginx ./src/requirements/nginx/.
	docker run -it --name nginx --entrypoint sh tjsilveira/nginx

wordpress:
	docker build -t tjsilveira/wordpress ./src/requirements/wordpress/.
	docker run -it --name wordpress --entrypoint sh tjsilveira/wordpress

clean:
	docker container prune -f
	docker rmi $(IMAGES)

stop:
	docker stop wordpress
	docker stop nginx
	docker stop db

up:
	@docker-compose -f ./src/docker-compose.yml up -d