#!/usr/bin/env python3
# coding: utf-8

# Modules
import datetime
import logging
from nornir.init_nornir import InitNornir
from nornir_utils.plugins.functions import print_result
from nornir_pygnmi.tasks import gnmi_get, gnmi_set

# Statics
NORNIR_CONFIG = "./config.yaml"

# Body
if __name__ == "__main__":
    # Get initial timestamp
    nr = InitNornir(config_file=NORNIR_CONFIG)

    print(nr.inventory.hosts)
    print(nr.inventory.groups)
