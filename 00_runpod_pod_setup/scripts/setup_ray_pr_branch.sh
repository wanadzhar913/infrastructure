#!/usr/bin/env bash
set -euo pipefail

RAY_REPO="${RAY_REPO:-https://github.com/wanadzhar913/ray}"
RAY_BRANCH="${RAY_BRANCH:-data/profile-vllmengine-in-datallmrelease-v2}"
RAY_WHEEL="${RAY_WHEEL:-https://s3-us-west-2.amazonaws.com/ray-wheels/latest/ray-3.0.0.dev0-cp312-cp312-manylinux2014_x86_64.whl}"
RAY_DIR="${RAY_DIR:-ray}"
VENV_DIR="${VENV_DIR:-.venv}"

echo ">>> Installing system dependencies..."
apt-get update
apt-get install -y build-essential clang curl pkg-config psmisc unzip

echo ">>> Cloning Ray repo and checking out branch: ${RAY_BRANCH}"
git clone "${RAY_REPO}" "${RAY_DIR}"
git -C "${RAY_DIR}" fetch origin "${RAY_BRANCH}"
git -C "${RAY_DIR}" checkout "${RAY_BRANCH}"

echo ">>> Installing Bazelisk..."
( cd "${RAY_DIR}" && ci/env/install-bazel.sh )

echo ">>> Installing Node 14 via nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# shellcheck source=/dev/null
source "${HOME}/.nvm/nvm.sh"
nvm install 14
nvm use 14

echo ">>> Setting up Python environment in ${RAY_DIR}/"
cd "${RAY_DIR}"

python -m venv "${VENV_DIR}"
# shellcheck source=/dev/null
source "${VENV_DIR}/bin/activate"
export PIP_NO_CACHE_DIR=1

echo ">>> Installing Ray wheel and running setup-dev.py..."
pip install -U "${RAY_WHEEL}"
python python/ray/setup-dev.py -y

echo ">>> Installing pre-commit hooks..."
pip install -c python/requirements_compiled.txt pre-commit
pre-commit install

echo ">>> Installing LLM requirements..."
pip install --no-cache-dir --no-build-isolation \
  -r python/requirements/llm/llm-requirements.txt \
  -r python/requirements/llm/llm-test-requirements.txt

echo ">>> Done. Activate the venv with: cd ${RAY_DIR} && source ${VENV_DIR}/bin/activate"
