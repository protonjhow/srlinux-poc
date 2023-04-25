#!/usr/bin/env bash

# gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf1.yml
# gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf2.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf1-interfaces.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf2-interfaces.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-rack1-interfaces.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-rack1-interfaces.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-interfaces.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-interfaces.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-tunnel-interface.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-tunnel-interface.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-routing-policy-prefix-sets.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-routing-policy-prefix-sets.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-routing-policy-underlay.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-routing-policy-underlay.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf1-network-instance-vrf-default.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf2-network-instance-vrf-default.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf1-network-instance-vrf-routing.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf2-network-instance-vrf-routing.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-rack1-system-network-instance.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-rack1-system-network-instance.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-network-instance-vrf-mgmt-infra.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-network-instance-vrf-mgmt-infra.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-routing-policy-vrf-leaks.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-routing-policy-vrf-leaks.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-network-instance-vrf-frontend.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-network-instance-vrf-frontend.yml

gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-network-instance-vrf-backend.yml
gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-network-instance-vrf-backend.yml
