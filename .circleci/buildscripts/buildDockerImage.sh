#!/bin/bash

set -xe

# Move to RedisInsight folder
cd "$(dirname "$0")/../../RedisInsight"

DOCKER_TAGS_ARG=""
tags=""

parse_tags_to_docker_arg() {
  # Set comma as the new delimiter for the scope of this function.
  local IFS=","

  # Split tags into an array based on IFS delimiter.
  read -ra tags <<< `cat .tags`

  local docker_arg

  for tag in "${tags[@]}"; do
    if [ -z "$docker_arg" ]; then
      docker_arg="--tag=\"$DOCKER_IMAGE_NAME:$tag\""
    else
      docker_arg="$docker_arg --tag=\"$DOCKER_IMAGE_NAME:$tag\""
    fi
  done

  # Set IFS to null to stop "," from breaking bash substitution
  local IFS=
  DOCKER_TAGS_ARG="$(eval echo $docker_arg)"
}

if parse_tags_to_docker_arg ; then
    build_args=(
    "$DOCKER_TAGS_ARG"
    "--progress=plain"
    )
    docker build ${build_args[*]} .

    for tag in "${tags[@]}"; do
        docker push "$DOCKER_IMAGE_NAME:$tag"
    done
fi
