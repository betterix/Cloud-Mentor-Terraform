#!/bin/sh

terraform init -backend-config='bucket=cmtr-ook9q7ho-backend-bucket-1786017126' -backend-config='key=tf_code.tfstate' -backend-config='region=eu-west-1'

ARN=$(aws iam list-policies --query "Policies[?PolicyName=='cmtr-ook9q7ho-iam-policy'].Arn" --output text)

terraform import aws_iam_policy.custom_policy "$ARN"