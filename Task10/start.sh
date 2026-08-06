#!/bin/sh

cd tf_code_1

terraform init -backend-config='bucket=cmtr-ook9q7ho-backend-bucket-1786010749' -backend-config='key=tf_code_1.tfstate' -backend-config='region=eu-west-1'

terraform import aws_iam_policy.custom_policy arn:aws:iam::418295704082:policy/resource-move-demo-policy

terraform state pull > tf_code_1.tfstate


cd ../tf_code_2

terraform init -backend-config='bucket=cmtr-ook9q7ho-backend-bucket-1786010749' -backend-config='key=tf_code_2.tfstate' -backend-config='region=eu-west-1'

terraform state pull > tf_code_2.tfstate

terraform state mv -state=../tf_code_1/tf_code_1.tfstate -state-out=tf_code_2.tfstate aws_iam_policy.custom_policy aws_iam_policy.custom_policy

terraform state push -force tf_code_2.tfstate

cd ../tf_code_1
terraform state push -force tf_code_1.tfstate