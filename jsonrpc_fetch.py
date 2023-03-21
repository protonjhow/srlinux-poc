#!/usr/bin/env python3
import requests
import json

device_list = [
    "clab-zur1-pods-cr1",
    "clab-zur1-pods-cr2",
    "clab-zur1-pods-cr3",
    "clab-zur1-pods-pod1-sp1",
    "clab-zur1-pods-pod1-sp2",
    "clab-zur1-pods-pod1-sp3",
    "clab-zur1-pods-pod1-lf1",
    "clab-zur1-pods-pod1-lf2",
    "clab-zur1-pods-pod1-lf3",
    "clab-zur1-pods-pod1-lf4",
    "clab-zur1-pods-pod1-lf5",
    "clab-zur1-pods-pod1-lf6",
]
jsonrpc_path = "/jsonrpc"
default_cred = ("admin", "NokiaSrl1!")
headers = {"Content-type": "application/json"}

def build_rpc_request(path: str, datastore: str) -> str:
    body = {
        "jsonrpc": "2.0",
        "id": 0,
        "method": "get",
        "params": {
            "commands": [{"path": path, "datastore": datastore}]
        },
    }
    return body


for device in device_list:
    url = f"https://{device}{jsonrpc_path}"
    version_req = requests.post(
        url,
        data=json.dumps(build_rpc_request("/system/information/version", "state")),
        headers=headers,
        auth=requests.auth.HTTPBasicAuth(*default_cred),
        verify="clab-zur1-pods/.tls/ca/ca.pem",
    )

    print(f"{device}: {version_req.json()['result'][0]}")
