#!/bin/bash

if hash buildkite-agent 2>/dev/null; then
  xyz_api_url=$(buildkite-agent meta-data get "xyz_api_url") java -jar ./karate-1.4.0.jar --env=buildkite ./message.feature
else
  echo "Running outside of buildkite"
  java -jar ./karate-1.4.0.jar ./message.feature
fi

