#!/bin/bash

set -eo pipefail

# shellcheck disable=SC1090
source "${HOST_WORK_DIR}/scripts/lib/gaction.sh"

SKIP_TARGET=1
if [ "x${GITHUB_EVENT_NAME}" = "xrepository_dispatch" ]; then
  echo "Repo dispatch triggered time: ${RD_TASK} target: ${RD_TARGET}"
  if [ "${RD_TARGET}" == "all" ] || [ "${RD_TARGET}" == "${BUILD_TARGET}" ]; then
    SKIP_TARGET=0
  fi
else
  echo "::warning::Unknown default target for triggering event: ${GITHUB_EVENT_NAME}" >&2
  SKIP_TARGET=0
fi

if [ "x${SKIP_TARGET}" = "x1" ]; then
  echo "Skipping current job"
else
  echo "Not skipping current job"
fi
_set_env SKIP_TARGET
