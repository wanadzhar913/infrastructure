#!/usr/bin/env bash
set -euo pipefail

LLMCOMPRESSOR_REPO="${LLMCOMPRESSOR_REPO:-https://github.com/wanadzhar913/llm-compressor}"
LLMCOMPRESSOR_BRANCH="${LLMCOMPRESSOR_BRANCH:-feature/add_step3p5_mappings_awq_v2}"
LLMCOMPRESSOR_DIR="${LLMCOMPRESSOR_DIR:-llm-compressor}"
VENV_DIR="${VENV_DIR:-.venv}"

echo ">>> Installing system dependencies..."
apt-get update

echo ">>> Cloning LLMCompressor repo and checking out branch: ${LLMCOMPRESSOR_BRANCH}"
git clone "${LLMCOMPRESSOR_REPO}" "${LLMCOMPRESSOR_DIR}"
git -C "${LLMCOMPRESSOR_DIR}" fetch origin "${LLMCOMPRESSOR_BRANCH}"
git -C "${LLMCOMPRESSOR_DIR}" checkout "${LLMCOMPRESSOR_BRANCH}"

echo ">>> Setting up Python environment in ${LLMCOMPRESSOR_DIR}/"
cd "${LLMCOMPRESSOR_DIR}"

pip install uv
uv venv "${VENV_DIR}"
# shellcheck source=/dev/null
source "${VENV_DIR}/bin/activate"

echo ">>> Installing LLMCompressor requirements..."
uv pip install -e .
uv pip install "compressed-tensors @ git+https://github.com/vllm-project/compressed-tensors.git@063d8df"
uv pip install hf_transfer

echo ">>> Done. Activate the venv with: cd ${LLMCOMPRESSOR_DIR} && source ${VENV_DIR}/bin/activate"


echo ">>> Testing LLMCompressor..."
cd ..
python3 awq_template.py --model-id "stepfun-ai/Step-3.5-Flash"
