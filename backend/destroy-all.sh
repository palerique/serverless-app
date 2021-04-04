#!/usr/bin/env bash

pushd terraform || exit
terraform destroy -auto-approve -var-file ./config/terraform.tfvars
popd || exit
