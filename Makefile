.PHONY: up
up:
	docker compose up lambda-local -d --build --force-recreate

.PHONY: down
down:
	docker compose down lambda-local -v

.PHONY: logs
logs:
	docker compose logs -f lambda-local

.PHONY: curl
curl:
	curl -X POST "http://localhost:9000/2015-03-31/functions/function/invocations" \
		-H "Content-Type: application/json" \
		-d '{"name": "Rintarooo"}'
