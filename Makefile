#
# Variables
#

IMAGE = "service:v1.0"

#
# Targets
#

.PHONY: build
build:
	@echo "Building image..."
	@docker build -t $(IMAGE) -f ./src/Service/Dockerfile ./src/Service

.PHONY: remove
remove:
	@echo "Removing image..."
	@docker rmi $(IMAGE)

.PHONY: upload
upload:
	@echo "Uploading image..."
	@kind load docker-image $(IMAGE)

.PHONY: run
run:
	@echo "Running container..."
	@docker run -d -p 5180:5180 $(IMAGE)

.PHONY: apply
apply:
	@echo "Applying manifests..."
	@kubectl apply -f ./eng

.PHONY: delete
delete:
	@echo "Deleting manifests..."
	@kubectl delete -f ./eng

.PHONY: list
list:
	@echo "Listing resources..."
	@kubectl get all

.PHONY: logs
logs:
	@echo "Retrieving logs..."
	@kubectl logs  $(shell kubectl get pods -l app=service -o jsonpath="{.items[0].metadata.name}") service


.PHONY: export
export:
	@echo "Exporting context..."
	@kind export kubeconfig
