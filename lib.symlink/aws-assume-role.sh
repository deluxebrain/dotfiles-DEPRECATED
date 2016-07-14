#!/usr/bin/env bash

[ -z "${__AWS_ASSUME_ROLE+.}" ] && readonly __AWS_ASSUME_ROLE= || return 0

function set_xaccount_creds()
{
  local role_arn="$1"
  local session_name="$2"
  local creds
  
  if [ -z "$1" ]; then
    echo "Please provide the role to assume" >&2
    return 1
  fi

  if [ -z "$2" ]; then
    echo "Please provide the session name" >&2
    return 1
  fi

  IFS=$'\n'
  
  creds=($( \
    jq -r '.Credentials | .AccessKeyId, .SecretAccessKey, .SessionToken' \
      <(aws sts assume-role \
        --role-arn "$role_arn" \
        --role-session-name "$session_name") \
      ))

  unset IFS

  export AWS_ACCESS_KEY_ID="${creds[0]}"
  export AWS_SECRET_ACCESS_KEY="${creds[1]}"
  export AWS_SESSION_TOKEN="${creds[2]}"
}






