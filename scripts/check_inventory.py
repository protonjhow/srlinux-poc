#!/usr/bin/env python3
# coding: utf-8

# Modules
from nornir.init_nornir import InitNornir

# Statics
NORNIR_CONFIG = "./config.yaml"

# Body
if __name__ == "__main__":
    # Initialise Nornir
    nr = InitNornir(config_file=NORNIR_CONFIG)

    # show inventory hosts
    print(nr.inventory.hosts)

    # show inventory groups
    print(nr.inventory.groups)