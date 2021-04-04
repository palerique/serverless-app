#!/usr/bin/env bash

pushd terraform || exit
terraform destroy -auto-approve
popd || exit
