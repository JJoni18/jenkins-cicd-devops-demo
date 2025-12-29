#!/usr/bin/env bash
set -euxo pipefail

STAGING_HOST="${STAGING_HOST:-staging.example.local}"
STAGING_USER="${STAGING_USER:-ubuntu}"
APP_VERSION="${APP_VERSION:-staging}"

ssh -o StrictHostKeyChecking=no "${STAGING_USER}@${STAGING_HOST}" "
  export APP_VERSION=${APP_VERSION}
  cd /opt/jenkins-cicd-demo || mkdir -p /opt/jenkins-cicd-demo && cd /opt/jenkins-cicd-demo
  # Assuming docker-compose.staging.yml is already on server OR pulled from repo
  docker compose -f docker-compose.staging.yml pull
  docker compose -f docker-compose.staging.yml up -d
"

