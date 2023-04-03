#!/usr/bin/env python3
# coding: utf-8

# Modules
import datetime
import logging
import os
from nornir.init_nornir import InitNornir
from nornir_utils.plugins.functions import print_result
from nornir_pygnmi.tasks import gnmi_capabilities, gnmi_get, gnmi_set

# Statics
NORNIR_CONFIG = "./config.yaml"
PATH = ["srl_nokia-interfaces:interface[name=ethernet-1/3]/admin-state"]
CONFIG_MSG = [
    (
        "/",
        {"srl_nokia-interfaces:interface":[{"name": "ethernet-1/3", "admin-state": "enable"}]}
    )
]

# Body
if __name__ == "__main__":
    # Get initial timestamp
    start_time = datetime.datetime.now()
    print(f"Execition started at {start_time}")

    # Initialise Nornir
    nrn = InitNornir(config_file=NORNIR_CONFIG)

    # Perform action
    # result1 = nrn.run(task=gnmi_capabilities)
    # print_result(result1)
    result2 = nrn.run(task=gnmi_get, encoding="JSON_IETF", path=PATH)
    print_result(result2)
    result3 = nrn.run(task=gnmi_set, encoding="JSON_IETF", update=CONFIG_MSG)
    print_result(result3, severity_level=logging.DEBUG)
    result4 = nrn.run(task=gnmi_get, encoding="JSON_IETF", path=PATH)
    print_result(result4)

    # Get final timestamp
    end_time = datetime.datetime.now()
    print(f"Execution took {end_time - start_time} and completed at {end_time}")
