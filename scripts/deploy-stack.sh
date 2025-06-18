#!/bin/bash
set -euo pipefail

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--stack) STACK_NAME="$2"; shift ;;
        -t|--template) TEMPLATE="$2"; shift ;;
        -p|--params) PARAMS="$2"; shift ;;
        -r|--region) REGION="$2"; shift ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

# Check if stack exists
if aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --region $REGION >/dev/null 2>&1; then
    echo "Updating existing stack..."
    aws cloudformation update-stack \
      --stack-name $STACK_NAME \
      --template-body file://$TEMPLATE \
      --parameters file://$PARAMS \
      --capabilities CAPABILITY_IAM \
      --region $REGION
else
    echo "Creating new stack..."
    aws cloudformation create-stack \
      --stack-name $STACK_NAME \
      --template-body file://$TEMPLATE \
      --parameters file://$PARAMS \
      --capabilities CAPABILITY_IAM \
      --region $REGION
fi