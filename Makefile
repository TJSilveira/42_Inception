IMAGES = $(shell docker images -q)

nginx:
	docker build -t tjsilveira/nginx ./src/requirements/nginx/.
	docker run -it --name nginx --entrypoint sh tjsilveira/nginx

clean:
	docker container prune -f
	docker rmi $(IMAGES)

up:
	@docker-compose -f ./src/docker-compose.yml up -d