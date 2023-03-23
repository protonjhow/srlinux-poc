#!/usr/bin/env python3
import requests
import json

DEVICE_LIST = ["clab-zur1-pods-cr1", "clab-zur1-pods-cr2", "clab-zur1-pods-cr3"]
VRF = "Routing"
BGP_PEERS = {"ebgp_edge": 2, "ebgp_fabric": 6}
BGP_GROUPS = ["ebgp_edge", "ebgp_fabric"]
PREFIX_COUNTS = {"recieved": {"ebgp_edge": 6, "ebgp_fabric": 48}}

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


def assert_bgp_peer_status(response: requests.models.Response, bgp_group: str) -> tuple:
    if response.json()["result"][0] == {}:
        state_str = f"peers expected {BGP_PEERS[bgp_group]} ... cfgd 0 / 0 up"
        state_bool = False
    else: 
        peer_status = response.json()["result"][0]

        if peer_status["total-peers"] == BGP_PEERS[bgp_group]:
            if peer_status["up-peers"] == BGP_PEERS[bgp_group]:
                state_str = f"peers expected {BGP_PEERS[bgp_group]} ... cfgd {peer_status['total-peers']} / {peer_status['up-peers']} up"
                state_bool = True
            else:
                state_str = f"peers expected {BGP_PEERS[bgp_group]} ... cfgd {peer_status['total-peers']} / {peer_status['up-peers']} up"
                state_bool = False
        else:
            state_str = f"peers expected {BGP_PEERS[bgp_group]} ... cfgd {peer_status['total-peers']} / {peer_status['up-peers']} up"
            state_bool = False
    return (state_bool, state_str)


for group in BGP_GROUPS:
    for device in DEVICE_LIST:
        url = f"https://{device}{jsonrpc_path}"
        response = requests.post(
            url,
            data=json.dumps(
                build_rpc_request(
                    path=f"/network-instance[name={VRF}]/protocols/bgp/group[group-name={group}]/statistics",
                    datastore="state",
                )
            ),
            headers=headers,
            auth=requests.auth.HTTPBasicAuth(*default_cred),
            verify="clab-zur1-pods/.tls/ca/ca.pem",
        )
        success, result = assert_bgp_peer_status(response, group)

        if success:
            print(f"\U00002705 {device}: {group}: {result}")
        else:
            print(f"\U0000274C {device}: {group}: {result}")
