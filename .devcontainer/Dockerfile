# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/python:1-3.11-bookworm

RUN set -eux; \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
        curl \
        jq \
        git \
        ca-certificates \
        openjdk-17-jdk-headless && \
    rm -rf /var/lib/apt/lists/* \
    # Install Databricks CLI
    && curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh

    
# Bake uv into the image (fast, reproducible)
RUN python -m pip install --no-cache-dir --upgrade pip && \
    python -m pip install --no-cache-dir uv


