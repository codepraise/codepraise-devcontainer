#!/bin/bash
# Start the devcontainer

function devcontainer_json() {
  echo "{" $'\n'\
         "  \"name\": \"${COMPOSE_PROJECT_NAME}\","$'\n'\
         "  \"dockerComposeFile\": \"docker-compose.yml\","$'\n'\
         "  \"service\": \"host\","$'\n'\
         "  \"workspaceFolder\": \"/home/"${USER}"/workspace/projects\","$'\n'\
         "  \"settings\": {"$'\n'\
         "    \"terminal.integrated.shell.linux\": \"${SHELL}\""$'\n'\
         "  }"$'\n'\
         "}"
}

project_root=$(dirname "${BASH_SOURCE[0]}")/..
if [ -e "${project_root}"/.env ]; then
  source "${project_root}"/.env
else
  echo "ERROR: ${project_root}/.env not found or not readable"
  exit 1
fi

if [ ! -e "${project_root}"/.devcontainer/devcontainer.json ]; then
  touch "${project_root}"/.devcontainer/devcontainer.json
  echo $(devcontainer_json) >> "${project_root}"/.devcontainer/devcontainer.json
fi

docker-compose up -d --build 1> /dev/null && docker-compose exec host /bin/zsh -l