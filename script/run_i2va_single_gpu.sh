#!/usr/bin/bash

set -euo pipefail

MODEL_ROOT="${1:-}"
SAVE_ROOT="${2:-visualization_i2av}"
CONFIG_NAME="${CONFIG_NAME:-robotwin_i2av}"
PYTHON_BIN="${PYTHON_BIN:-python}"
EXTRA_ARGS=("${@:3}")

if [ -z "${MODEL_ROOT}" ]; then
  echo "Usage: $0 /path/to/pretrained/model [save_root]" 1>&2
  echo "  CONFIG_NAME defaults to 'robotwin_i2av' (override via env)." 1>&2
  exit 2
fi

export TOKENIZERS_PARALLELISM=false

mkdir -p "${SAVE_ROOT}"

${PYTHON_BIN} -m wan_va.wan_va_server \
  --config-name "${CONFIG_NAME}" \
  --model_root "${MODEL_ROOT}" \
  --save_root "${SAVE_ROOT}" \
  "${EXTRA_ARGS[@]}"

echo "Saved: ${SAVE_ROOT}/demo.mp4"
