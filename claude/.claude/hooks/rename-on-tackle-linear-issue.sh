#!/usr/bin/env bash
# UserPromptSubmit hook: when the user invokes /tackle-linear-issue with a
# PIT-XXX argument, set the session title to "PIT-XXX: <Linear issue title>"
# (or just "PIT-XXX" if the Linear API is unreachable or the key isn't set).
#
# Silent no-op for any prompt that doesn't match the pattern.
#
# Linear API key resolution order:
#   1. $LINEAR_API_KEY env var
#   2. ~/.config/linear/api_key file (chmod 600)
# Generate a personal key at https://linear.app/settings/account/security.

set -uo pipefail

input=$(cat)
prompt=$(jq -r '.prompt // ""' <<< "$input")

if [[ ! "$prompt" =~ ^[[:space:]]*/tackle-linear-issue[[:space:]]+([Pp][Ii][Tt]-[0-9]+) ]]; then
  exit 0
fi

issue_id=$(tr '[:lower:]' '[:upper:]' <<< "${BASH_REMATCH[1]}")
title="$issue_id"

api_key="${LINEAR_API_KEY:-}"
if [ -z "$api_key" ] && [ -r "$HOME/.config/linear/api_key" ]; then
  api_key=$(tr -d '[:space:]' < "$HOME/.config/linear/api_key")
fi

if [ -n "$api_key" ]; then
  query=$(jq -nc --arg id "$issue_id" '{
    query: "query($id: String!) { issue(id: $id) { title } }",
    variables: { id: $id }
  }')
  response=$(curl -fsS --max-time 5 \
    -H "Authorization: $api_key" \
    -H "Content-Type: application/json" \
    -d "$query" \
    https://api.linear.app/graphql 2>/dev/null || true)
  linear_title=$(jq -r '.data.issue.title // empty' <<< "$response" 2>/dev/null || true)
  if [ -n "$linear_title" ]; then
    title="$issue_id: $linear_title"
  fi
fi

jq -nc --arg t "$title" '{
  hookSpecificOutput: {
    hookEventName: "UserPromptSubmit",
    sessionTitle: $t
  }
}'
