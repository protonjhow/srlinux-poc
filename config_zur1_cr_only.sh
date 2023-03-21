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

echo
PIDS=""
NE=("cr1" "cr2" "cr3")

for VARIANT in ${NE[@]}; do
  ( configure_SRL $VARIANT ) &
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

#gnmic -a clab-zur1-pods-cr1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/cr1.yml
#gnmic -a clab-zur1-pods-cr2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-sp02.yml
#gnmic -a clab-zur1-pods-cr3 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-sp03.yml
#gnmic -a clab-zur1-pods-pod1-lf1 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf01.yml
#gnmic -a clab-zur1-pods-pod1-lf2 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf02.yml
#gnmic -a clab-zur1-pods-pod1-lf3 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf03.yml
#gnmic -a clab-zur1-pods-pod1-lf4 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf04.yml
#gnmic -a clab-zur1-pods-pod1-lf5 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf05.yml
#gnmic -a clab-zur1-pods-pod1-lf6 --timeout 30s -u admin -p NokiaSrl1! -e json_ietf --skip-verify set --update-path / --update-file configs/pod1-lf06.yml
