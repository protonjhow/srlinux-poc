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
NORNIR_CONFIG = "./acl-test-nornir-config.yaml"


def read_yaml_config(yaml_file):
    yaml = YAML(typ="safe")

    with open(f"tests/{yaml_file}.yml", "r") as file:
        content = yaml.load(file)

    config_msg = [
        (
            "/",
            content,
        )
    ]
    return config_msg


def send_config_update_to_group(run_name, config_name, nornir_group):
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
    leaf1 = nr.filter(F(name__endswith="leaf1"))
    leaf2 = nr.filter(F(name__endswith="leaf2"))
    spine1 = nr.filter(F(name__endswith="spine1"))
    srl = nr.filter(F(groups__contains="srl"))

    # baselines
    send_config_update_to_group(
        run_name="Configure leaf1 ipv4 http test",
        config_name="leaf1-ipv4_srv1-ipv4_srv3_dport80",
        nornir_group=leaf1,
    )
