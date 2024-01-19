# CI/CD tasks

.DEFAULT_GOAL := help

.PHONY: help deploy-full destroy-full deploy-no-edge destroy-no-edge run-tests build-containers

TESTS := $(shell find ./ci/ -name '*.sh')
spines := pod1-sp1,pod1-sp2,pod1-sp3
leaves := pod1-lf1,pod1-lf2,pod1-lf3,pod1-lf4,pod1-lf5,pod1-lf6
cores := cr1,cr2,cr3
edges := ed1,ed2
webservers := pod1-cab1-websrv1,pod1-cab2-websrv2,pod1-cab3-websrv3
hapservers := pod1-cab1-hapsrv1,pod1-cab2-hapsrv2,pod1-cab3-hapsrv3
dbservers := pod1-cab1-dbsrv1,pod1-cab2-dbsrv2,pod1-cab3-dbsrv3

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy-full: ## Deploy full topology
	sudo clab deploy -t dc1.yml --reconfigure 
	cp clab-dc1-pods/ansible-inventory.yml .
	./config_dc1.sh && sleep 5 # Give system some time to settle
	poetry run python3 scripts/push_leaf_configs.py

destroy-full: ## Destroy full topology
	sudo clab destroy -t dc1.yml --cleanup
	rm ansible-inventory.yml

deploy-no-edge: ## Deploy topology without SROS Edges
	sudo clab deploy -t dc1.yml --reconfigure --node-filter ${spines},${leaves},${cores},${webservers},${hapservers},${dbservers}
	cp clab-dc1-pods/ansible-inventory.yml .
	./config_dc1.sh && sleep 5 # Give system some time to settle
	poetry run python3 scripts/push_leaf_configs.py

destroy-no-edge: ## Destroy topology without SROS Edges
	sudo clab destroy -t dc1.yml --cleanup --node-filter ${spines},${leaves},${cores},${webservers},${hapservers},${dbservers}
	rm ansible-inventory.yml

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
	
