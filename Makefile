#
# Variables
#

SERVICES := Basket Catalog Order Web
NAMESPACE := sample

#
# Targets
#

.PHONY: build
build:
	@echo "Building images..."
	@for service in $(SERVICES); do \
		docker build -t sample/$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1 -f ./Dockerfile --build-arg DLL_NAME=$$service.dll ./src/$$service; \
	done

.PHONY: clean
clean:
	@echo "Cleaning images..."
	@for service in $(SERVICES); do \
		docker rmi sample/$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1; \
	done

.PHONY: upload
upload:
	@echo "Uploading image..."
	@for service in $(SERVICES); do \
		kind load docker-image sample/$$(echo $$service | tr '[:upper:]' '[:lower:]'):v1; \
	done

.PHONY: apply
apply:
	@echo "Applying manifests..."
	@kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	@kubectl apply -k ./eng/manifests

.PHONY: delete
delete:
	@echo "Deleting manifests..."
	@kubectl delete ns $(NAMESPACE)

.PHONY: set
set:
	@echo "Setting context..."
	@kubectl config set-context --current --namespace=$(NAMESPACE)

.PHONY: list
list:
	@echo "Listing namespace resources..."
	@watch -n 1 'kubectl get all -n $(NAMESPACE)'

.PHONY: list-all
list-all:
	@echo "List all resources..."
	@watch -n 1 'kubectl get all -A'

.PHONY: config
config:
	@echo "Exporting context..."
	@kind export kubeconfig
