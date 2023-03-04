#!/bin/bash

set -xe

# Move to RedisInsight folder
cd "$(dirname "$0")/../../RedisInsight"

latest_tag=`git tag | grep -P '^\d+\.\d+\.\d+$' | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n1`

git checkout $latest_tag

echo "$latest_tag,latest" > .tags
echo "$latest_tag" > ../.helm_app_version