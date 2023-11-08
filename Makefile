start:
	docker-compose start
stop:
	docker-compose stop
shell:
	docker-compose exec -it $(app) sh
destroy:
	docker-compose down -v --remove-orphans --rmi all 
build:
	docker-compose up -d --build --no-start
logs:
	docker-compose logs -f
ps:
	docker-compose ps