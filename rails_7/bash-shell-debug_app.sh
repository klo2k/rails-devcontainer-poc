#!/bin/bash

set -eu

# Check if container is running - exit with error message if not
docker ps --filter name=rails_7_debug --format '{{.Names}}'|grep rails_7_debug > /dev/null|| \
  (echo "ERROR: rails_7_debug container must be running - start with 'start-debug-app.sh'" && exit 1)

# Get an interactive bash shell into the "rails_7_debug" container (must be running)
docker exec --user=rails -it rails_7_debug bash
