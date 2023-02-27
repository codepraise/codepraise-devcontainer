#!/bin/bash
# Start the devcontainer

docker-compose exec host /bin/zsh -l -c "cd codepraise-data-collector; rake run:dev"