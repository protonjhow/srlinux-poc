#!/usr/bin/env python3
# coding: utf-8

# Modules
from nornir.init_nornir import InitNornir
from nornir.core.filter import F
from nornir_utils.plugins.functions import print_result
from nornir_pygnmi.tasks import gnmi_get, gnmi_set

# Statics
NORNIR_CONFIG = "./config.yaml"
PATH = ["interface[name=ethernet-1/3]/admin-state"]
CONFIG_MSG = [
    (
        "/",
        {
            "srl_nokia-interfaces:interface": [
                {"name": "ethernet-1/3", "admin-state": "disable"}
            ]
        },
    )
]

# Body
if __name__ == "__main__":
    # Initialise Nornir
    nr = InitNornir(config_file=NORNIR_CONFIG)

    # filter to just Cores
    cores = nr.filter(F(groups__contains="core"))

    # Check before
    interfaces_state_before = cores.run(task=gnmi_get, encoding="json_ietf", path=PATH)
    print_result(interfaces_state_before)

    # change it
    interfaces_state_change = cores.run(
        task=gnmi_set, encoding="json_ietf", update=CONFIG_MSG
    )
    print_result(interfaces_state_change)

    # check it
    interfaces_state_after = cores.run(task=gnmi_get, encoding="json_ietf", path=PATH)
    print_result(interfaces_state_after)
