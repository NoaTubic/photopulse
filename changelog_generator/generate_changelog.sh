#!/bin/bash

source config

bash parse_tags.sh
python3 generate_destination_changelog.py "$CHANGELOG_PATH" "$COMMIT_TAG" "$ISSUE_BASE_URL" "$DESTINATION_TEMPLATE" "$DESTINATION_FILE_NAME"
if [ -f "$CHANGELOG_PATH" ]; then
  rm "$CHANGELOG_PATH"
fi
