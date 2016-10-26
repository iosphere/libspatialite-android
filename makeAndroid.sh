#!/bin/bash

set -e
BASE=$(cd "$(dirname "$0")" && pwd)
source "${BASE}/pathSetup.sh"

cp -a "${CONFIGSDIR}/"* "${JNIDIR}"
pushd "${JNIDIR}"
ndk-build
popd

# cleanup config files
pushd "${BASE}"
find ./generated_configs -type f | sed -e 's#generated_configs#jni#' | xargs rm
popd

