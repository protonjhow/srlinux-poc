#!/usr/bin/env bash

CFG_DIR=./configs

configure_SRL() {
  OUT=$(gnmic -a clab-zur1-pods-$1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file $CFG_DIR/$1.yml 2>&1)
  echo $OUT | grep -q -e '\"operation\": \"UPDATE\"'
  if [ $? -eq 0 ]; then
    docker exec clab-zur1-pods-$1 sr_cli "save startup" > /dev/null
  else
    echo "Error: Unable to push config into clab-zur1-pods-$1."
  fi
  echo $OUT > /dev/null
}

configure_WEBSRV() {
  docker exec clab-zur1-pods-$1 /usr/sbin/ifup -- bond0 2>/dev/null
  docker exec clab-zur1-pods-$1 /usr/sbin/ifup -- vlan200 2>/dev/null
}

configure_HAPSRV() {
  docker exec clab-zur1-pods-$1 /usr/sbin/ifup -- bond0 2>/dev/null
  docker exec clab-zur1-pods-$1 /usr/sbin/ifup -- vlan900 2>/dev/null
}

configure_DBSRV() {
  docker exec clab-zur1-pods-$1 /usr/sbin/ifup -- bond0 2>/dev/null
  docker exec clab-zur1-pods-$1 /usr/sbin/ifup -- vlan900 2>/dev/null
}

echo
PIDS=""
NE=("pod1-sp1" "pod1-sp2" "pod1-sp3" "pod1-lf1" "pod1-lf2" "pod1-lf3" "pod1-lf4" "pod1-lf5" "pod1-lf6" "cr1" "cr2" "cr3")
WEBSRV=("pod1-cab1-websrv1" "pod1-cab2-websrv2" "pod1-cab3-websrv3")
HAPSRV=("pod1-cab1-hapsrv1" "pod1-cab2-hapsrv2" "pod1-cab3-hapsrv3")
DBSRV=("pod1-cab1-dbsrv1" "pod1-cab2-dbsrv2" "pod1-cab3-dbsrv3")

for VARIANT in ${NE[@]}; do
  ( configure_SRL $VARIANT ) &
  REF=$!
  echo "[$REF] Configuring $VARIANT..."
  PIDS+=" $REF"
done

for VARIANT in ${WEBSRV[@]}; do
  ( configure_WEBSRV $VARIANT ) &
  REF=$!
  echo "[$REF] Configuring $VARIANT..."
  PIDS+=" $REF"
done

for VARIANT in ${HAPSRV[@]}; do
  ( configure_HAPSRV $VARIANT ) &
  REF=$!
  echo "[$REF] Configuring $VARIANT..."
  PIDS+=" $REF"
done

for VARIANT in ${DBSRV[@]}; do
  ( configure_DBSRV $VARIANT ) &
  REF=$!
  echo "[$REF] Configuring $VARIANT..."
  PIDS+=" $REF"
done

echo
for p in $PIDS; do
  if wait $p; then
    echo "Process $p success"
  else
    echo "Process $p fail"
  fi
done
echo

## manual commands
# core
# gnmic -a clab-zur1-pods-cr1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/cr1.yml
# gnmic -a clab-zur1-pods-cr2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/cr2.yml
# gnmic -a clab-zur1-pods-cr3 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/cr3.yml
# spine
# gnmic -a clab-zur1-pods-pod1-sp1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-sp1.yml
# gnmic -a clab-zur1-pods-pod1-sp2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-sp2.yml
 #gnmic -a clab-zur1-pods-pod1-sp3 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-sp3.yml
# leaf
# gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf1.yml
# gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf2.yml
# gnmic -a clab-zur1-pods-pod1-lf3 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf3.yml
# gnmic -a clab-zur1-pods-pod1-lf4 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf4.yml
# gnmic -a clab-zur1-pods-pod1-lf5 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf5.yml
# gnmic -a clab-zur1-pods-pod1-lf6 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf6.yml
