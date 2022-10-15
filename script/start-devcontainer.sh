#!/bin/bash
# Start the devcontainer

project_root=$(dirname "${BASH_SOURCE[0]}")/..
if [ -e "${project_root}"/.env ]; then
  source "${project_root}"/.env
else
  echo "ERROR: ${project_root}/.env not found or not readable"
  exit 1
fi

docker-compose up -d --build 1> /dev/null && docker-compose exec host /bin/bash -l