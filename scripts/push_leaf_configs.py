#!/usr/bin/env python3
# coding: utf-8

# Modules
from nornir.init_nornir import InitNornir
from nornir.core.filter import F
from nornir.core.task import Task, Result
from nornir_utils.plugins.functions import print_result
from nornir_pygnmi.tasks import gnmi_set
from ruamel.yaml import YAML


# Statics
NORNIR_CONFIG = "./config.yaml"
POD1_RACKS = ["rack1-leaf", "rack2-leaf", "rack3-leaf"]


def read_yaml_config(yaml_file):
    yaml = YAML(typ="safe")

    with open(f"configs/{yaml_file}.yml", "r") as file:
        content = yaml.load(file)

    config_msg = [
        (
            "/",
            content,
        )
    ]
    return config_msg


def send_config_to_group(run_name, config_name, nornir_group):
    config_msg = read_yaml_config(config_name)
    # change it
    update_request = nornir_group.run(
        name=run_name, task=gnmi_set, encoding="json_ietf", update=config_msg
    )
    print_result(update_request)


# Body
if __name__ == "__main__":
    # Initialise Nornir
    nr = InitNornir(config_file=NORNIR_CONFIG)

    # make filters up front
    edges = nr.filter(F(groups__contains="edge"))
    cores = nr.filter(F(groups__contains="core"))
    spines = nr.filter(F(groups__contains="spine"))
    leaves = nr.filter(F(groups__any=POD1_RACKS))
    rack1 = nr.filter(F(groups__contains="rack1-leaf"))
    rack2 = nr.filter(F(groups__contains="rack2-leaf"))
    rack3 = nr.filter(F(groups__contains="rack3-leaf"))
    leaf1 = nr.filter(F(name__endswith="lf1"))
    leaf2 = nr.filter(F(name__endswith="lf2"))
    leaf3 = nr.filter(F(name__endswith="lf3"))
    leaf4 = nr.filter(F(name__endswith="lf4"))
    leaf5 = nr.filter(F(name__endswith="lf5"))
    leaf6 = nr.filter(F(name__endswith="lf6"))

    # order of things
    send_config_to_group(
        run_name="Configure interfaces - LF1",
        config_name="pod1-lf1-interfaces",
        nornir_group=leaf1,
    )
    send_config_to_group(
        run_name="Configure interfaces - LF2",
        config_name="pod1-lf2-interfaces",
        nornir_group=leaf2,
    )
    send_config_to_group(
        run_name="Configure interfaces - Rack1",
        config_name="pod1-rack1-interfaces",
        nornir_group=rack1,
    )
    send_config_to_group(
        run_name="Configure interfaces - Pod1",
        config_name="pod1-interfaces",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure tunnel interfaces - Pod1",
        config_name="pod1-tunnel-interfaces",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure routing policy prefixes - Pod1",
        config_name="pod1-routing-policy-prefix-sets",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure routing policy underlay - Pod1",
        config_name="pod1-routing-policy-underlay",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure VRF default - LF1",
        config_name="pod1-lf1-network-instance-vrf-default",
        nornir_group=leaf1,
    )
    send_config_to_group(
        run_name="Configure VRF default - LF2",
        config_name="pod1-lf2-network-instance-vrf-default",
        nornir_group=leaf2,
    )
    send_config_to_group(
        run_name="Configure VRF Routing - LF1",
        config_name="pod1-lf1-network-instance-vrf-routing",
        nornir_group=leaf1,
    )
    send_config_to_group(
        run_name="Configure VRF Routing - LF2",
        config_name="pod1-lf2-network-instance-vrf-routing",
        nornir_group=leaf2,
    )
    send_config_to_group(
        run_name="Configure network-instance system - Pod1",
        config_name="pod1-rack1-system-network-instance",
        nornir_group=rack1,
    )
    send_config_to_group(
        run_name="Configure VRF MGMT_Infra - Pod1",
        config_name="pod1-network-instance-vrf-mgmt-infra",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure routing policy VRF Leaking - Pod1",
        config_name="pod1-routing-policy-vrf-leaks",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure VRF Frontend - Pod1",
        config_name="pod1-network-instance-vrf-frontend",
        nornir_group=leaves,
    )
    send_config_to_group(
        run_name="Configure VRF Backend - Pod1",
        config_name="pod1-network-instance-vrf-backend",
        nornir_group=leaves,
    )
