#!/usr/bin/env bash
# import saved searches and dashboards (overwrites existing objects with the same name)
nc -zv localhost 5601 > /dev/null 2>&1
if [ $? == 0  ]; then
	curl -s -X POST 'http://100.101.0.200:5601/api/saved_objects/_import?overwrite=true' -H "kbn-xsrf: true" --form file=@elk/kibana/saved-objects.ndjson | jq
else 
	echo "Please wait a minute kibana isn't available yet (or maybe not started)."
fi
