# srlinux-poc
Playing about with Nokia SRLinux

### pre-req
this uses a SROS image for the edge router. this requires a licence file to work. make sure you add the licence file as `sros-vm.lic` and that this is __NEVER__ committed to the repo. Alternatively, comment out all the edge* lines

## How to use me!
1. install containerlab
2. `make build-containers` to ensure you have the base container images we use for "servers" in the topology. Skipping this will mean the "servers" dont work and may stop the topology being deployed.
3. stand up the lab instance

`sudo containerlab deploy --topo dc1.yml`

```
+----+-------------------------------+--------------+----------------------------------------+-------+---------+-----------------+-----------------------+
| #  |             Name              | Container ID |                 Image                  | Kind  |  State  |  IPv4 Address   |     IPv6 Address      |
+----+-------------------------------+--------------+----------------------------------------+-------+---------+-----------------+-----------------------+
|  1 | clab-dc1-pods-cr1            | be255e03427b | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.7/24  | 2001:172:20:20::7/64  |
|  2 | clab-dc1-pods-cr2            | 30422041d98f | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.14/24 | 2001:172:20:20::e/64  |
|  3 | clab-dc1-pods-cr3            | e4e69fa7af9e | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.11/24 | 2001:172:20:20::b/64  |
|  4 | clab-dc1-pods-pod1-cab1-srv1 | 279110513cbc | ghcr.io/hellt/network-multitool:latest | linux | running | 172.20.20.4/24  | 2001:172:20:20::4/64  |
|  5 | clab-dc1-pods-pod1-cab2-srv1 | acb6e5c86956 | ghcr.io/hellt/network-multitool:latest | linux | running | 172.20.20.5/24  | 2001:172:20:20::5/64  |
|  6 | clab-dc1-pods-pod1-cab3-srv1 | dd77ca034a71 | ghcr.io/hellt/network-multitool:latest | linux | running | 172.20.20.12/24 | 2001:172:20:20::c/64  |
|  7 | clab-dc1-pods-pod1-lf1       | 9042d96a9b0c | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.6/24  | 2001:172:20:20::6/64  |
|  8 | clab-dc1-pods-pod1-lf2       | 0a9f01d9fc4e | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.15/24 | 2001:172:20:20::f/64  |
|  9 | clab-dc1-pods-pod1-lf3       | d376aaab3349 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.16/24 | 2001:172:20:20::10/64 |
| 10 | clab-dc1-pods-pod1-lf4       | 183bfb29149d | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.10/24 | 2001:172:20:20::a/64  |
| 11 | clab-dc1-pods-pod1-lf5       | bf871385fa6c | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.9/24  | 2001:172:20:20::9/64  |
| 12 | clab-dc1-pods-pod1-lf6       | db36c52b9e65 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.8/24  | 2001:172:20:20::8/64  |
| 13 | clab-dc1-pods-pod1-sp1       | 62c1383183a2 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.13/24 | 2001:172:20:20::d/64  |
| 14 | clab-dc1-pods-pod1-sp2       | e12066ff0d40 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.2/24  | 2001:172:20:20::2/64  |
| 15 | clab-dc1-pods-pod1-sp3       | 37b23e311b4b | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.3/24  | 2001:172:20:20::3/64  |
+----+-------------------------------+--------------+----------------------------------------+-------+---------+-----------------+-----------------------+
```

3. deploy the configs

`./config_dc1.sh`

4. check underlay is working

`show network-instance default route-table`

```
A:pod1-lf1# show network-instance default route-table
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IPv4 unicast route table of network instance default
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+--------------------------------------------+-------+------------+----------------------+----------------------+----------+---------+---------------------------+---------------------------+
|                   Prefix                   |  ID   | Route Type |     Route Owner      |        Active        |  Metric  |  Pref   |      Next-hop (Type)      |    Next-hop Interface     |
+============================================+=======+============+======================+======================+==========+=========+===========================+===========================+
| 169.254.1.0/30                             | 3     | local      | net_inst_mgr         | True                 | 0        | 0       | 169.254.1.2 (direct)      | ethernet-1/49.0           |
| 169.254.1.2/32                             | 3     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)            | None                      |
| 169.254.1.3/32                             | 3     | host       | net_inst_mgr         | True                 | 0        | 0       | None (broadcast)          |                           |
| 169.254.1.254/32                           | 6     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)            | None                      |
| 169.254.1.255/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.1.0/30            | ethernet-1/49.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.2.0/30                             | 4     | local      | net_inst_mgr         | True                 | 0        | 0       | 169.254.2.2 (direct)      | ethernet-1/50.0           |
| 169.254.2.2/32                             | 4     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)            | None                      |
| 169.254.2.3/32                             | 4     | host       | net_inst_mgr         | True                 | 0        | 0       | None (broadcast)          |                           |
| 169.254.2.254/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.1.0/30            | ethernet-1/49.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          | ethernet-1/50.0           |
|                                            |       |            |                      |                      |          |         | 169.254.2.0/30            | ethernet-1/51.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
|                                            |       |            |                      |                      |          |         | 169.254.3.0/30            |                           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.2.255/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.2.0/30            | ethernet-1/50.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.3.0/30                             | 5     | local      | net_inst_mgr         | True                 | 0        | 0       | 169.254.3.2 (direct)      | ethernet-1/51.0           |
| 169.254.3.2/32                             | 5     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)            | None                      |
| 169.254.3.3/32                             | 5     | host       | net_inst_mgr         | True                 | 0        | 0       | None (broadcast)          |                           |
| 169.254.3.254/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.1.0/30            | ethernet-1/49.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          | ethernet-1/50.0           |
|                                            |       |            |                      |                      |          |         | 169.254.2.0/30            | ethernet-1/51.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
|                                            |       |            |                      |                      |          |         | 169.254.3.0/30            |                           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.3.255/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.3.0/30            | ethernet-1/51.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.4.254/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.1.0/30            | ethernet-1/49.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          | ethernet-1/50.0           |
|                                            |       |            |                      |                      |          |         | 169.254.2.0/30            | ethernet-1/51.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
|                                            |       |            |                      |                      |          |         | 169.254.3.0/30            |                           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.5.254/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.1.0/30            | ethernet-1/49.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          | ethernet-1/50.0           |
|                                            |       |            |                      |                      |          |         | 169.254.2.0/30            | ethernet-1/51.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
|                                            |       |            |                      |                      |          |         | 169.254.3.0/30            |                           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
| 169.254.6.254/32                           | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | 169.254.1.0/30            | ethernet-1/49.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          | ethernet-1/50.0           |
|                                            |       |            |                      |                      |          |         | 169.254.2.0/30            | ethernet-1/51.0           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
|                                            |       |            |                      |                      |          |         | 169.254.3.0/30            |                           |
|                                            |       |            |                      |                      |          |         | (indirect/local)          |                           |
+--------------------------------------------+-------+------------+----------------------+----------------------+----------+---------+---------------------------+---------------------------+
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IPv4 routes total                    : 18
IPv4 prefixes with active routes     : 18
IPv4 prefixes with active ECMP routes: 5
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```
5. check ibgp overlay-l2

_this is showing the three (one per leaf pair) servers in vrf-1. this works when you first spawn the lab, but since there is no persistent traffic, these will age out. you might have to jump on one srv1 and ping another one to put traffic on the fabric_

```docker exec -it clab-dc1-pods-pod1-cab1-srv1 ping -c3 192.168.0.2```

```
A:pod1-lf1# show network-instance vrf-1 bridge-table mac-table all
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Mac-table of network instance vrf-1
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+--------------------+----------------------------------------------------+------------+----------------+---------+--------+----------------------------------------------------+
|      Address       |                    Destination                     | Dest Index |      Type      | Active  | Aging  |                    Last Update                     |
+====================+====================================================+============+================+=========+========+====================================================+
| AA:C1:AB:16:41:9E  | vxlan-interface:vxlan1.1 vtep:169.254.5.254 vni:1  | 1846748785 | evpn           | true    | N/A    | 2023-03-06T21:03:47.000Z                           |
|                    |                                                    | 40         |                |         |        |                                                    |
| AA:C1:AB:3A:2A:59  | vxlan-interface:vxlan1.1 vtep:169.254.3.254 vni:1  | 1846748785 | evpn           | true    | N/A    | 2023-03-06T21:07:28.000Z                           |
|                    |                                                    | 42         |                |         |        |                                                    |
| AA:C1:AB:9E:BC:9B  | ethernet-1/1.0                                     | 2          | learnt         | true    | 300    | 2023-03-06T21:07:25.000Z                           |
+--------------------+----------------------------------------------------+------------+----------------+---------+--------+----------------------------------------------------+
Total Irb Macs                 :    0 Total    0 Active
Total Static Macs              :    0 Total    0 Active
Total Duplicate Macs           :    0 Total    0 Active
Total Learnt Macs              :    1 Total    1 Active
Total Evpn Macs                :    2 Total    2 Active
Total Evpn static Macs         :    0 Total    0 Active
Total Irb anycast Macs         :    0 Total    0 Active
Total Proxy Antispoof Macs     :    0 Total    0 Active
Total Reserved Macs            :    0 Total    0 Active
Total Eth-cfm Macs             :    0 Total    0 Active
```

6. check ibgp overlay-l3
7. check erb gateways are reachable
8. check leaf to core adjacencies are up
9. check reachability


10. Check MC-LAG status
```
A:pod1-lf2# /show lag  

=======================================================================================================================================================================
lag1 is up, Aggregate speed 25000 Mbps, min links 1

+-----------------+------------+---------------------------+

|   Member Name   | oper-state |     oper-down-reason      |

+=================+============+===========================+

| ethernet-1/1    | up         |                           |

+-----------------+------------+---------------------------+

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
=======================================================================================================================================================================
Summary

  1 LAG interfaces are up, 0 are down

=======================================================================================================================================================================
--{ running }--[ network-instance default ]--

A:pod1-lf2# show /system network-instance ethernet-segments 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

cab1-srv1_bond0 is up, all-active

  ESI      : 00:12:12:12:12:12:12:00:00:01
  Alg      : default
  Peers    : 169.254.1.254
  Interface: lag1
  Next-hop : N/A
  evi      : N/A
  Network-instances:
     mac-vrf-1
      Candidates : 169.254.1.254, 169.254.2.254 (DF)
      Interface : lag1.0

  Network-instances:
     mac-vrf-200
      Candidates : 169.254.1.254 (DF), 169.254.2.254
      Interface : lag1.200
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Summary
 1 Ethernet Segments Up
 0 Ethernet Segments Down
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--{ running }--[ network-instance default ]--
```
Note how the Designated Forwarder (DF) is alternatingly chosen for each VLAN

---

# helpful commands!

## talk to the env
### get to a shell
#### srl box cli
`docker exec -it clab-dc1-pods-pod1-sp1 sr_cli`

#### srv shell
`docker exec -it clab-dc1-pods-pod1-cab1-srv1 bash`

### config management
#### "manually" push a yaml config to an srl box
`gnmic -a clab-dc1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf1.yml`

----

## operational commands
### check vxlan tunnels
`info from state tunnel vxlan-tunnel`

### kick bgp
#### with kaboom
`tools network-instance default protocols bgp group underlay reset-peer`

#### no kaboom
`tools network-instance default protocols bgp soft-clear`
