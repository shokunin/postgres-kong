#!/bin/bash

curl -i -X POST \
 --url http://localhost:8001/apis/ \
 --data 'name=example-api' \
 --data 'hosts=example.com' \
 --data 'upstream_url=http://httpbin.org'

curl -X POST http://localhost:8001/apis/example-api/plugins \
   --data "name=key-auth" \
   --data "config.hide_credentials=false"

curl -X POST http://localhost:8001/consumers/ \
   --data "username=customera" \
   --data "custom_id=customer1"

curl -s -X POST http://localhost:8001/consumers/customera/key-auth -d '' |jq .key |sed -e s/\"//g > /tmp/key

curl -X POST http://localhost:8001/apis/example-api/plugins \
    --data "name=rate-limiting" \
    --data "config.second=1" \
    --data "config.minute=10" \
    --data "config.limit_by=consumer" \
    --data "config.policy=redis" \
    --data "config.redis_host=redis" \
    --data "config.redis_port=6380" 

echo "########################################################################################"
echo "# Example request"
echo "########################################################################################"

curl -s -o /dev/null -v -H "apikey: `cat /tmp/key`" -H "Host: example.com" localhost:8000


