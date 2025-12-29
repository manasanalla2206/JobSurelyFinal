#!/usr/bin/env bash
set -euo pipefail

APP_NAME="jobsurely"
DEPLOY_ROOT="/var/www/${APP_NAME}"
WEB_ROOT="/usr/share/nginx/html"

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo is required to run this script." >&2
  exit 1
fi

sudo yum update -y

if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
  sudo yum install -y nodejs
fi

sudo yum install -y nginx rsync

sudo mkdir -p "${DEPLOY_ROOT}"
sudo rsync -a --delete ./ "${DEPLOY_ROOT}/"

pushd "${DEPLOY_ROOT}" >/dev/null
npm install
npm run build
popd >/dev/null

sudo rm -rf "${WEB_ROOT}"/*
sudo cp -r "${DEPLOY_ROOT}/dist"/* "${WEB_ROOT}/"

sudo cp "${DEPLOY_ROOT}/deploy/nginx-jobsurely.conf" /etc/nginx/conf.d/jobsurely.conf
sudo rm -f /etc/nginx/conf.d/default.conf

sudo systemctl enable --now nginx
sudo nginx -t
sudo systemctl reload nginx

echo "Deployment complete."
