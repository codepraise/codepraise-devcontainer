#!/bin/bash
# Start the devcontainer

docker-compose exec host /bin/zsh -l -c "cd codepraise-api; rake run:development"