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

.PHONY: invoke-deployed-lambda
invoke-deployed-lambda: ## Invoke deployed lambda
	perman-aws-vault exec \
		aws lambda invoke \
		--function-name sample-lambda-cicd-dev-lambda \
		--payload '{"name":"Rintarooo"}' \
		--cli-binary-format raw-in-base64-out \
		--output json /dev/stdout
