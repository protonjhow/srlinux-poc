# CI/CD tasks

.DEFAULT_GOAL := help

.PHONY: help deploy-clab-ci destroy-clab-ci run-tests build-containers

TESTS := $(shell find ./ci/ -name '*.sh')

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy-clab-ci: ## Deploy "ci" test topology
	sudo clab deploy -t zur1.yml --reconfigure
	./config_zur1.sh && sleep 5 # Give system some time to settle

destroy-clab-ci: ## Destroy "ci" test topology
	sudo clab destroy -t zur1.yml --cleanup

run-tests: $(TESTS) ## Run all CI tests under ./ci/
	#bash -c $<
	python3 test_fabric_interfaces.py
	python3 test_fabric_bgp_peers.py
	python3 test_core_interfaces.py
	python3 test_core_bgp_peers.py

build-containers: ## build each docker container locally
	cd containers/webserver && docker build . -t webserver:latest
	cd containers/haproxy && docker build . -t haproxy:latest
	cd containers/data && docker build . -t data:latest
	
