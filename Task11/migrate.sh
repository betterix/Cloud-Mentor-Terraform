#!/bin/sh

terraform init \
    -migrate-state \
    -backend-config='bucket=cmtr-ook9q7ho-backend-new-bucket-1786016055' \
    -backend-config='key=tf_code.tfstate' \
    -backend-config='region=eu-west-1'