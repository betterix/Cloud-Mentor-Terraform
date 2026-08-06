#!/bin/sh

cd tf_code_1
terraform state pull > tf_code_1.tfstate

cd ../tf_code_2
terraform state pull > tf_code_2.tfstate

terraform state mv -state=../tf_code_1/tf_code_1.tfstate -state-out=tf_code_2.tfstate aws_iam_policy.custom_policy aws_iam_policy.custom_policy

terraform state push -force tf_code_2.tfstate

cd ../tf_code_1
terraform state push -force tf_code_1.tfstate
