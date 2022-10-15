#!/bin/bash
# Initialize the project in DevContainer

echo "*** project initialized from ${BASH_SOURCE[0]} via ${BASH_SOURCE[1]} ***"

# Get project github urls from config.yml
config_file="${HOME}/workspace/.devcontainer/config.yml"
IFS=' ' readarray -t project_github_urls <<< $(yq '.project_github_urls.[]' ${config_file})

project_root=$(dirname "${BASH_SOURCE[0]}")/..
for url in "${project_github_urls[@]}"; do
    repo_name=$(echo "${url}" | sed -E 's/.*\/(.*)/\1/')

    # Clone the project repo
    if [ ! -e "${project_root}/projects/${repo_name}" ]; then
        echo -n "Cloning into '${repo_name}'... " \
        && git clone "${url}" "${project_root}/projects/${repo_name}" &> /dev/null \
        && echo "done."
    fi

    # Bundle install
    echo -n "Bundle installing for '${repo_name}'... " \
    && cd "${project_root}/projects/${repo_name}" \
    && bundle install &> /dev/null \
    && cd - &> /dev/null \
    && echo "done."
done