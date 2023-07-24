#!/bin/bash

COMMAND_ID=$1

while :
do
  STATUS=$(aws ssm list-command-invocations --command-id $COMMAND_ID --details --query 'CommandInvocations[0].Status' --output text)
  if [ "$STATUS" == "Success" ]; then
    echo "Command finished successfully"
    break
  elif [ "$STATUS" == "Failed" ]; then
    echo "Command failed"
    exit 1
  else
    echo "Command is still in progress"
    sleep 15
  fi
done
