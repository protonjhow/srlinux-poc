# ACL Test

This is a trimmed repo that deploys a minimal topology for testing ACLs.

## How does this work then?

You need to setup your env a bit first. ideal would be to have `poetry` working from the parent repo. if you do. you can prefix all the `python` commands below with `poetry run`. if you dont (there is a weird thing with poetry 1.4.2 at time of writing), then you can use the requirements.txt in this repo as follows:

```shell
# start in the root of the repo
# make a venv
python3 -m venv .venv
# activate it
source .venv/bin/activate
# move into the acl-test folder
cd acl-test
# install the python env
pip3 install -r requirements.txt
```

now you have a working env (or poetry working) here is the basics (all from within the `acl-test` folder):

1. `sudo containerlab deploy -c --topo acl-test-topo.yml`
2. `cp clab-acl-test/ansible-inventory.yml acl-test-inventory.yml`
3. `python3 baseline_acl_test_topo.py`
4. Setup the docker hosts with static MAC Addrs and IPs:
   1. `docker exec clab-acl-test-srv1 /sbin/ip -- link set address 00:c1:ab:00:00:01 dev eth1 2>/dev/null`
   2. `docker exec clab-acl-test-srv1 /sbin/ip -- addr add 192.168.0.1/24 dev eth1 2>/dev/null`
   3. `docker exec clab-acl-test-srv2 /sbin/ip -- link set address 00:c1:ab:00:00:02 dev eth1 2>/dev/null`
   4. `docker exec clab-acl-test-srv2 /sbin/ip -- addr add 192.168.0.2/24 dev eth1 2>/dev/null`

### Tests

