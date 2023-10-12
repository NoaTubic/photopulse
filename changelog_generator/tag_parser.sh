#!/usr/bin/env bash

ENVIRONMENT_TAG="$1"
COMMIT_TAG="$2"
CHANGELOG_PATH="$3"
NEWEST_INDEX="$4"
SECOND_NEWEST_INDEX="$5"

if [ "$NEWEST_INDEX" -eq 0 ]; then
  newest_tag=$(git rev-parse HEAD)
  build_number="Latest tag"
else
  newest_tag=$(git tag -l | sort -V | grep $ENVIRONMENT_TAG | tail -n "$NEWEST_INDEX" | head -n 1)
  build_number="$newest_tag"
fi
if [ -z "$newest_tag" ]; then
  echo "No $ENVIRONMENT_TAG tag found."
  exit 1
fi

tag_count=$(git tag | grep -c $ENVIRONMENT_TAG)
if [ "$NEWEST_INDEX" -gt "$tag_count" ]; then
  exit 1
fi

second_newest_tag=$(git tag -l | sort -V | grep $ENVIRONMENT_TAG | tail -n "$SECOND_NEWEST_INDEX" | head -n 1)

if [ "$tag_count" -eq "0" ]; then
  changelog=$(git log --pretty=format:%s | grep "$COMMIT_TAG")
elif [ "$newest_tag" == "$second_newest_tag" ]; then
  changelog=$(git log --pretty=format:%s "$newest_tag" | grep "$COMMIT_TAG")
else
  changelog=$(git log --pretty=format:%s "$newest_tag"..."$second_newest_tag" | grep "$COMMIT_TAG")
fi

date=$(git log -1 --format=%ai "$newest_tag" | cut -d ' ' -f 1)
printf "%s\n%s\n%s\n################################\n" "$build_number" "$date" "$changelog" >> "$CHANGELOG_PATH"
