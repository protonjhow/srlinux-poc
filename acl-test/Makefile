# CI/CD tasks

.DEFAULT_GOAL := help

.PHONY: help deploy-acl-test destroy-acl-test run-tests

TESTS := $(shell find ./ci/ -name '*.sh')

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy-clab-ci: ## Deploy ACL test topology
	sudo clab deploy -t acl-test-topo.yml --reconfigure
	poetry run python3 baseline_acl_test_topo.py
	sleep 10 && ./add-saved-objects.sh

destroy-clab-ci: ## Destroy ACL test topology
	sudo clab destroy -t acl-test-topo.yml --cleanup

run-tests: $(TESTS) ## Run all CI tests under 
	#bash -c $<
	sleep 1	
