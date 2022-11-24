#!/bin/bash

# Exit on error (e), error on undefined variable (u), show command to debug (x)
set -eux

# Go to directory of this script
cd "$(dirname $0)"

# Build debug image, with host's UID and GID to run rails under
docker-compose build --pull \
  --build-arg "APP_UID=$(id --user)" \
  --build-arg "APP_GID=$(id --group)" \
  rails_7_debug

# So app can read files mounted from host
# Used to dynamically change the "rails" application user uid and gid to match host's

# Start debug app
docker-compose up rails_7_debug
