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

.PHONY: build
build: ## Build docker image
	docker build \
		--platform linux/arm64 \
		--provenance=false \
		--target runner \
		-t $(IMAGE) \
		-f docker/lambda/Dockerfile .

.PHONY: push
push: build ## Push docker image to ECR
	@echo "Logging in to ECR ..."
	perman-aws-vault exec \
		aws ecr get-login-password --region ap-northeast-1 | \
		docker login --username AWS --password-stdin $(ECR_REPOSITORY)

	@echo "Tagging image ..."
	docker tag $(IMAGE):latest $(ECR_REPOSITORY)/$(IMAGE):$(IMAGE_TAG)
	docker tag $(IMAGE):latest $(ECR_REPOSITORY)/$(IMAGE):latest

	@echo "Pushing image ..."
	perman-aws-vault exec \
		docker push $(ECR_REPOSITORY)/$(IMAGE):$(IMAGE_TAG) && docker push $(ECR_REPOSITORY)/$(IMAGE):latest

	@echo "Pushing image completed."
