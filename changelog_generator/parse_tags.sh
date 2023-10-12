#!/usr/bin/env bash

source config

counter=0
while true; do
  previous=$counter
  ((counter++))
  bash tag_parser.sh $ENVIRONMENT $COMMIT_TAG $CHANGELOG_PATH $previous "$counter"
  if [ $? -eq 1 ]; then
        break
  fi
done
