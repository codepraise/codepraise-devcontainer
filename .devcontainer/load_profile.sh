#!/bin/bash
# Load profile.sh for new shells
# This script is intended to be copied into /etc/profile.d/ in the container

project_profile="${HOME}/workspace/.devcontainer/profile.sh"
project_initialization="${HOME}/workspace/.devcontainer/initialization.sh"

if [ -r "${project_profile}" ]; then
  source "${project_profile}"
else
  echo "WARNING: ${project_profile} not found or not readable"
fi

if [ -r "${project_initialization}" ]; then
  source "${project_initialization}"
else
  echo "WARNING: ${project_initialization} not found or not readable"
fi