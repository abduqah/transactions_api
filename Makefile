compose_up:
	docker-compose -f docker-compose.yml -p FX-transactions up

compose_down:
	docker-compose -f docker-compose.yml -p FX-transactions down
