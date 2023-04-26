# ACL Test

This is a trimmed repo that deploys a minimal topology for testing ACLs.

## How does this work then?

You need to setup your env a bit first. ideal would be to have `poetry` working from the parent repo.

If you dont have poetry at all, then try this:

`curl -sSL https://install.python-poetry.org | python3 -`

If you do, you can prefix all the `python` commands below with `poetry run`.

If somehow, you dont (there is a weird thing with poetry 1.4.2 at time of writing), then you can use the requirements.txt in this repo as follows:

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

Now you have a working env (or poetry working) here is the basics (all from within the `acl-test` folder):

Option1: simply `make deploy-clab-ci` (we assume you have `jq` installed btw. who doesnt?)

Option2:

1. `sudo containerlab deploy -c --topo acl-test-topo.yml`
2. `cp clab-acl-test/ansible-inventory.yml acl-test-inventory.yml`
3. `python3 baseline_acl_test_topo.py`
4. `./add-saved-objects.sh`
5. Check the docker hosts have the correct static MAC Addrs and IPs:
   1. `docker exec clab-acl-test-srv1 /sbin/ip -- addr show dev eth1`
   2. `docker exec clab-acl-test-srv2 /sbin/ip -- addr show dev eth1`
   3. If the IPs are not correct, you can fix them with these commands:
      1. `docker exec clab-acl-test-srv1 /sbin/ip -- link set address 00:c1:ab:00:00:01 dev eth1 2>/dev/null`
      2. `docker exec clab-acl-test-srv1 /sbin/ip -- addr add 192.168.0.1/24 dev eth1 2>/dev/null`
      3. `docker exec clab-acl-test-srv2 /sbin/ip -- link set address 00:c1:ab:00:00:02 dev eth1 2>/dev/null`
      4. `docker exec clab-acl-test-srv2 /sbin/ip -- addr add 192.168.0.2/24 dev eth1 2>/dev/null`

### Basic ops

To access the Servers:

   1. `docker exec -it clab-acl-test-srv1 bash`
   2. `docker exec -it clab-acl-test-srv2 bash`

To access the leaves:

   1. `docker exec -it clab-acl-test-leaf1 sr_cli`
   2. `docker exec -it clab-acl-test-leaf2 sr_cli`

### Tests

1. Make sure the servers can reach the anycast GW:
   1. Both: `ping 192.168.0.254`
2. Make sure the servers can reach each other:
   1. SRV1: `ping 192.168.0.2`
   2. SRV2: `ping 192.168.0.1`
3. Test TCP ports:
   1. SRV1: `nc -l 80`
   2. SRV2: `nc -vw2 192.168.0.1 80`
