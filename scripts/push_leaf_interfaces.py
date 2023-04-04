#!/usr/bin/env python3
# coding: utf-8

# Modules
from nornir.init_nornir import InitNornir
from nornir.core.filter import F
from nornir_utils.plugins.functions import print_result
from nornir_pygnmi.tasks import gnmi_get, gnmi_set
from ruamel.yaml import YAML
from rich import print

yaml = YAML(typ='safe')
with open('configs/pod1-interfaces.yml', 'r') as file:
    content = yaml.load(file)

# Statics
NORNIR_CONFIG = "./config.yaml"
PATH = ["interface[name=ethernet-1/3]/admin-state"]
CONFIG_MSG = [
    (
        "/",
        content,
    )
]
POD1_RACKS = ["rack1-leaf", "rack2-leaf", "rack3-leaf"]

# Body
if __name__ == "__main__":
    # Initialise Nornir
    nr = InitNornir(config_file=NORNIR_CONFIG)

    # filter to just leaves 
    leaves = nr.filter(F(groups__any=POD1_RACKS))
    
    # Check before
    # interfaces_state_before = leaves.run(task=gnmi_get, encoding="json_ietf", path=PATH)
    # print_result(interfaces_state_before)
    
    # change it
    interfaces_state_change = leaves.run(task=gnmi_set, encoding="json_ietf", update=CONFIG_MSG)
    print_result(interfaces_state_change)
    
    # check it
    # interfaces_state_after = leaves.run(task=gnmi_get, encoding="json_ietf", path=PATH)
    # print_result(interfaces_state_after)
