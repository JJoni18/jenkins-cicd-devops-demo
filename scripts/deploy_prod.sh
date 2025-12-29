#!/usr/bin/env bash
set -euxo pipefail

PROD_HOST="${PROD_HOST:-prod.example.local}"
PROD_USER="${PROD_USER:-ubuntu}"
APP_VERSION="${APP_VERSION:-latest}"

ssh -o StrictHostKeyChecking=no "${PROD_USER}@${PROD_HOST}" "
  export APP_VERSION=${APP_VERSION}
  cd /opt/jenkins-cicd-demo || mkdir -p /opt/jenkins-cicd-demo && cd /opt/jenkins-cicd-demo
  # Assuming docker-compose.prod.yml is already on server OR pulled from repo
  docker compose -f docker-compose.prod.yml pull
  docker compose -f docker-compose.prod.yml up -d
"

