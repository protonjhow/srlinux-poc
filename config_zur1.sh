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

# configure_SRV() {
#   docker cp $CFG_DIR/$1.sh clab-zur1-pods-$1:/tmp/
#   docker exec clab-zur1-pods-$1 bash /tmp/$1.sh 2>/dev/null
# }

echo
PIDS=""
NE=("pod1-sp1" "pod1-sp2" "pod1-sp3" "pod1-lf1" "pod1-lf2" "pod1-lf3" "pod1-lf4" "pod1-lf5" "pod1-lf6" "cr1" "cr2" "cr3")
# SRV=("pod1-cab1-srv1" "pod1-cab2-srv1" "pod1-cab3-srv1")

for VARIANT in ${NE[@]}; do
  ( configure_SRL $VARIANT ) &
  REF=$!
  echo "[$REF] Configuring $VARIANT..."
  PIDS+=" $REF"
done

# for VARIANT in ${SRV[@]}; do
#   ( configure_SRV $VARIANT ) &
#   REF=$!
#   echo "[$REF] Configuring $VARIANT..."
#   PIDS+=" $REF"
# done

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
