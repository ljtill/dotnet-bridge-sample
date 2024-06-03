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
	@docker build -t contoso-web:v1.0 -f ./Dockerfile --build-arg DLL_NAME=Contoso.Web.dll ./src/Contoso.Web
	@for service in $(SERVICES); do \
		docker build -t contoso-$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1.0 -f ./Dockerfile --build-arg DLL_NAME=Contoso.$$service.Api.dll ./src/Contoso.$$service.Api; \
	done

.PHONY: clean
clean:
	@echo "Cleaning images..."
	@docker rmi contoso-web:v1.0
	@for service in $(SERVICES); do \
		docker rmi contoso-$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1.0; \
	done

.PHONY: upload
upload:
	@echo "Uploading image..."
	@kind load docker-image contoso-web:v1.0
	@for service in $(SERVICES); do \
		kind load docker-image contoso-$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1.0; \
	done

.PHONY: apply
apply:
	@echo "Applying manifests..."
	@kubectl apply -f ./eng/namespace.yaml
	@kubectl apply -R -f ./eng

.PHONY: delete
delete:
	@echo "Deleting manifests..."
	@kubectl delete -f ./eng/namespace.yaml

.PHONY: list
list:
	@echo "Listing namespace resources..."
	@watch -n 1 'kubectl get all -n contoso'

.PHONY: list-all
list-all:
	@echo "List all resources..."
	@watch -n 1 'kubectl get all -A'

.PHONY: config
config:
	@echo "Exporting context..."
	@kind export kubeconfig
