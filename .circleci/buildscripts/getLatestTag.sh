#!/bin/bash

set -xe

# MOve to working dir
cd "$(dirname "$0")/../.."
git submodule init
git submodule update --recursive

# Move to RedisInsight folder
cd "RedisInsight"

# Get latest tag
latest_tag=`git tag | grep -P '^\d+\.\d+\.\d+$' | sort -t "." -k1,1n -k2,2n -k3,3n | tail -n1`

# Check out latest tag for build
git checkout $latest_tag

# Let other step know the tag
echo "$latest_tag,latest" > .tags
echo "$latest_tag" > ../.helm_app_version