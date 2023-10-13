#!/usr/bin/env python3
import requests
import json

DEVICE_LIST = [
    "clab-dc1-pods-pod1-sp1",
    "clab-dc1-pods-pod1-sp2",
    "clab-dc1-pods-pod1-sp3",
]
INTERFACE_LIST = [
    "ethernet-1/1",
    "ethernet-1/2",
    "ethernet-1/3",
    "ethernet-1/4",
    "ethernet-1/5",
    "ethernet-1/6",
]

jsonrpc_path = "/jsonrpc"
default_cred = ("admin", "NokiaSrl1!")
headers = {"Content-type": "application/json"}


def build_rpc_request(path: str, datastore: str) -> str:
    body = {
        "jsonrpc": "2.0",
        "id": 0,
        "method": "get",
        "params": {"commands": [{"path": path, "datastore": datastore}]},
    }
    return body


def assert_interface_status(response: requests.models.Response) -> tuple:
    interface_state = response.json()["result"][0]
    if interface_state["admin-state"] == "enable":
        if interface_state["oper-state"] == "up":
            state_str = "up/up"
            state_bool = True
        else:
            state_str = "up/down"
            state_bool = False
    else:
        state_str = "down"
        state_bool = False
    return (state_bool, state_str)


for device in DEVICE_LIST:
    url = f"https://{device}{jsonrpc_path}"
    for interface in INTERFACE_LIST:
        response = requests.post(
            url,
            data=json.dumps(
                build_rpc_request(
                    path=f"/interface[name={interface}]", datastore="state"
                )
            ),
            headers=headers,
            auth=requests.auth.HTTPBasicAuth(*default_cred),
            verify="clab-dc1-pods/.tls/ca/ca.pem",
        )
        success, result = assert_interface_status(response)

        if success:
            print(f"\U00002705 {device}: {interface}: {result}")
        else:
            print(f"\U0000274C {device}: {interface}: {result}")
