#
# Variables
#

SERVICES := Basket Catalog Identity Order Payment Shipping

#
# Targets
#

.PHONY: build
build:
	@echo "Building images..."
	@docker build -t sample-web:v1 -f ./Dockerfile --build-arg DLL_NAME=Sample.Web.dll ./src/Sample.Web
	@for service in $(SERVICES); do \
		docker build -t sample-$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1 -f ./Dockerfile --build-arg DLL_NAME=Sample.$$service.Api.dll ./src/Sample.$$service.Api; \
	done

.PHONY: clean
clean:
	@echo "Cleaning images..."
	@docker rmi sample-web:v1
	@for service in $(SERVICES); do \
		docker rmi sample-$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1; \
	done

.PHONY: upload
upload:
	@echo "Uploading image..."
	@kind load docker-image sample-web:v1
	@for service in $(SERVICES); do \
		kind load docker-image sample-$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1; \
	done

.PHONY: apply
apply:
	@echo "Applying manifests..."
	@kubectl create namespace sample --dry-run=client -o yaml | kubectl apply -f -
	@kubectl apply -k ./eng

.PHONY: delete
delete:
	@echo "Deleting manifests..."
	@kubectl delete ns sample

.PHONY: list
list:
	@echo "Listing namespace resources..."
	@watch -n 1 'kubectl get all -n sample'

.PHONY: list-all
list-all:
	@echo "List all resources..."
	@watch -n 1 'kubectl get all -A'

.PHONY: config
config:
	@echo "Exporting context..."
	@kind export kubeconfig
