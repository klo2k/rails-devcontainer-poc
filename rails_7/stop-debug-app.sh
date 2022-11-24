#!/bin/bash

# Exit on error (e), error on undefined variable (u), show command to debug (x)
set -eux

# Go to directory of this script
cd "$(dirname $0)"

# Build debug image (based on run image above)
docker build \
    --tag "mq/rails:debug" \
    --file ./rails.debug.dockerfile \
    .

# Run database and app
# We seperate out the 2 so we can quickly restart app only

# Start network, database, redis
#docker-compose up --detach db redis

# So app can read files mounted from host
# Used to dynamically change the "rails" application user uid and gid to match host's
export RAILS_DEBUG_UID="$(id --user)"
export RAILS_DEBUG_GID="$(id --group)"
# Start debug app
docker-compose up rails_7_debug
