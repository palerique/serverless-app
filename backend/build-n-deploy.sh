#!/usr/bin/env bash
set -x

#find . -name "node_modules" -type d -exec rm -r "{}" \;
#find . -name "dist" -type d -exec rm -r "{}" \;
#find . -name "packaged-dist" -type d -exec rm -r "{}" \;

#find . -name "package-lock.json" -type f -delete &&
#  find . -name "yarn.lock" -type f -delete &&
#  find . -name "tsconfig.build.tsbuildinfo" -type f -delete &&
#  find . -name "tsconfig.tsbuildinfo" -type f -delete &&
  yarn install &&
#  tsc --build --verbose layer/genericStuff/tsconfig.build.json &&
  yarn script:build-dependency-layer &&
  yarn build

#pushd terraform || exit
#terraform apply -auto-approve
#popd || exit
