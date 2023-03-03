# srlinux-poc
Playing about with Nokia SRLinux

## How to use me!
1. install containerlab
2. stand up the lab instance

`sudo containerlab deploy --topo zur1.yml`

```
+----+-------------------------------+--------------+----------------------------------------+-------+---------+-----------------+-----------------------+
| #  |             Name              | Container ID |                 Image                  | Kind  |  State  |  IPv4 Address   |     IPv6 Address      |
+----+-------------------------------+--------------+----------------------------------------+-------+---------+-----------------+-----------------------+
|  1 | clab-zur1-pods-cr1            | be255e03427b | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.7/24  | 2001:172:20:20::7/64  |
|  2 | clab-zur1-pods-cr2            | 30422041d98f | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.14/24 | 2001:172:20:20::e/64  |
|  3 | clab-zur1-pods-cr3            | e4e69fa7af9e | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.11/24 | 2001:172:20:20::b/64  |
|  4 | clab-zur1-pods-pod1-cab1-srv1 | 279110513cbc | ghcr.io/hellt/network-multitool:latest | linux | running | 172.20.20.4/24  | 2001:172:20:20::4/64  |
|  5 | clab-zur1-pods-pod1-cab2-srv1 | acb6e5c86956 | ghcr.io/hellt/network-multitool:latest | linux | running | 172.20.20.5/24  | 2001:172:20:20::5/64  |
|  6 | clab-zur1-pods-pod1-cab3-srv1 | dd77ca034a71 | ghcr.io/hellt/network-multitool:latest | linux | running | 172.20.20.12/24 | 2001:172:20:20::c/64  |
|  7 | clab-zur1-pods-pod1-lf1       | 9042d96a9b0c | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.6/24  | 2001:172:20:20::6/64  |
|  8 | clab-zur1-pods-pod1-lf2       | 0a9f01d9fc4e | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.15/24 | 2001:172:20:20::f/64  |
|  9 | clab-zur1-pods-pod1-lf3       | d376aaab3349 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.16/24 | 2001:172:20:20::10/64 |
| 10 | clab-zur1-pods-pod1-lf4       | 183bfb29149d | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.10/24 | 2001:172:20:20::a/64  |
| 11 | clab-zur1-pods-pod1-lf5       | bf871385fa6c | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.9/24  | 2001:172:20:20::9/64  |
| 12 | clab-zur1-pods-pod1-lf6       | db36c52b9e65 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.8/24  | 2001:172:20:20::8/64  |
| 13 | clab-zur1-pods-pod1-sp1       | 62c1383183a2 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.13/24 | 2001:172:20:20::d/64  |
| 14 | clab-zur1-pods-pod1-sp2       | e12066ff0d40 | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.2/24  | 2001:172:20:20::2/64  |
| 15 | clab-zur1-pods-pod1-sp3       | 37b23e311b4b | ghcr.io/nokia/srlinux:latest           | srl   | running | 172.20.20.3/24  | 2001:172:20:20::3/64  |
+----+-------------------------------+--------------+----------------------------------------+-------+---------+-----------------+-----------------------+
```

3. deploy the configs

`./config_zur1.sh`

4. check underlay is working

`show network-instance default route-table`

```
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IPv4 unicast route table of network instance default
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+-------------------------------------+-------+------------+----------------------+----------------------+----------+---------+-----------------------+-----------------------+
|               Prefix                |  ID   | Route Type |     Route Owner      |        Active        |  Metric  |  Pref   |    Next-hop (Type)    |  Next-hop Interface   |
+=====================================+=======+============+======================+======================+==========+=========+=======================+=======================+
| 169.254.2.254/32                    | 5     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)        | None                  |
+-------------------------------------+-------+------------+----------------------+----------------------+----------+---------+-----------------------+-----------------------+
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IPv4 routes total                    : 1
IPv4 prefixes with active routes     : 1
IPv4 prefixes with active ECMP routes: 0
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IPv6 unicast route table of network instance default
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+-------------------------------------+-------+------------+----------------------+----------------------+----------+---------+-----------------------+-----------------------+
|               Prefix                |  ID   | Route Type |     Route Owner      |        Active        |  Metric  |  Pref   |    Next-hop (Type)    |  Next-hop Interface   |
+=====================================+=======+============+======================+======================+==========+=========+=======================+=======================+
| fccf:112::2:49:0/127                | 2     | local      | net_inst_mgr         | True                 | 0        | 0       | fccf:112::2:49:0      | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (direct)              |                       |
| fccf:112::2:49:0/128                | 2     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)        | None                  |
| fccf:122::2:50:0/127                | 3     | local      | net_inst_mgr         | True                 | 0        | 0       | fccf:122::2:50:0      | ethernet-1/50.0       |
|                                     |       |            |                      |                      |          |         | (direct)              |                       |
| fccf:122::2:50:0/128                | 3     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)        | None                  |
| fccf:132::2:51:0/127                | 4     | local      | net_inst_mgr         | True                 | 0        | 0       | fccf:132::2:51:0      | ethernet-1/51.0       |
|                                     |       |            |                      |                      |          |         | (direct)              |                       |
| fccf:132::2:51:0/128                | 4     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)        | None                  |
| fded:127::1:1:254/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:112::2:49:0/127  | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:1:255/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:112::2:49:0/127  | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:2:254/128               | 5     | host       | net_inst_mgr         | True                 | 0        | 0       | None (extract)        | None                  |
| fded:127::1:2:255/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:122::2:50:0/127  | ethernet-1/50.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:3:254/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:112::2:49:0/127  | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:3:255/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:132::2:51:0/127  | ethernet-1/51.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:4:254/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:112::2:49:0/127  | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:5:254/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:112::2:49:0/127  | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
| fded:127::1:6:254/128               | 0     | bgp        | bgp_mgr              | True                 | 0        | 170     | fccf:112::2:49:0/127  | ethernet-1/49.0       |
|                                     |       |            |                      |                      |          |         | (indirect/local)      |                       |
+-------------------------------------+-------+------------+----------------------+----------------------+----------+---------+-----------------------+-----------------------+
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
IPv6 routes total                    : 15
IPv6 prefixes with active routes     : 15
IPv6 prefixes with active ECMP routes: 0
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```
5. check ibgp overlay-l2
6. check ibgp overlay-l3
7. check erb gateways are reachable
8. check leaf to core adjacencies are up
9. check reachability
