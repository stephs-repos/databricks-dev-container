#!/usr/bin/env bash
set -euo pipefail

# --- config ---
PY="python3"
DEFAULT_DEPS=("databricks-connect>=15.0")  # add first-run deps here
# Dev-only deps for [dependency-groups].dev
DEV_DEPS=("pytest" "ipykernel" "pytest-cov" "black" "isort" "flake8" "pyyaml")

# --- detect container python (major.minor) ---
img_py_ver="$($PY -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')"

# --- 1) Create pyproject.toml ONCE (if missing); otherwise leave it alone ---
if [ ! -f pyproject.toml ]; then
  echo "Creating pyproject.toml"
  cat > pyproject.toml <<EOF
[project]
name = "sample_package"
version = "0.1.0"
description = "databricks package development template"
requires-python = ">=${img_py_ver}"
dependencies = [
  $(printf '"%s",\n' "${DEFAULT_DEPS[@]}" | sed '$s/,$//')
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.hatch.build.targets.wheel]
packages = ["src/sample_package"]

[dependency-groups]
dev = [
  $(printf '"%s",\n' "${DEV_DEPS[@]}" | sed '$s/,$//')
]

[project.scripts]
main = "sample_package.jobs.sample_job:main"
EOF
fi

# --- 2) Ensure there's a lock (first time only) ---
if [ ! -f uv.lock ]; then
  echo "No uv.lock found; resolving and creating one"
  uv lock
fi

# --- 3) Create or reuse .venv based on Python version ---
venv_ok=false
if [ -x .venv/bin/python ]; then
  venv_py_ver="$(./.venv/bin/python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))' || true)"
  if [ "$venv_py_ver" = "$img_py_ver" ]; then
    venv_ok=true
  fi
fi

if [ "$venv_ok" = false ]; then
  echo "Creating fresh .venv for Python $img_py_ver (old: ${venv_py_ver:-none})"
  rm -rf .venv
  uv venv --seed
fi

# --- 4) Install EXACTLY from the lock (idempotent) ---
echo "Syncing environment from uv.lock"
uv sync --frozen

echo "Done. Using: $(.venv/bin/python -V)"
