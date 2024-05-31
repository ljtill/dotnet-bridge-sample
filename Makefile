
SRC_DIR = ./src/Service
ENG_DIR = ./eng/platform
IMAGE = service:v1.0

build:
	@echo "Building image..."
	@docker build -t $(IMAGE) -f $(SRC_DIR)/Dockerfile $(SRC_DIR)

remove:
	@echo "Removing image..."
	docker rmi $(IMAGE)

upload:
	@echo "Uploading image..."
	kind load docker-image $(IMAGE)

run:
	@echo "Running container..."
	docker run -d -p 5180:5180 $(IMAGE)

deploy:
	@echo "Deploying manifest..."
	kubectl create configmap dotnet-monitor-triggers --from-file=$(ENG_DIR)/settings.json
	kubectl apply -f $(ENG_DIR)/deployment.yaml

delete:
	@echo "Deleting manifest..."
	kubectl delete -f $(ENG_DIR)/deployment.yaml

logs:
	@echo "Retrieving logs..."
	kubectl logs  $(shell kubectl get pods -l app=service -o jsonpath="{.items[0].metadata.name}") service
