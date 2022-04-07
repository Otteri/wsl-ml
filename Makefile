build: ## Build production image
	docker build --target dependency-stage -t wsl-ml:latest .

launch: ## Launch pointpillars application container
	docker run \
	--gpus all \
	-it \
	wsl-ml:latest

help: ## Display callable targets.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
