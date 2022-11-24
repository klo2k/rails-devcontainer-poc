#!/bin/bash

# Exit on error (e), error on undefined variable (u), show command to debug (x)
set -eux

# Go to directory of this script
cd "$(dirname $0)"

# Stop the app stack
docker-compose stop
