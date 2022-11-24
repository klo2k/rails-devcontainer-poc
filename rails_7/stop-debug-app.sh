#!/bin/bash

# Exit on error (e), error on undefined variable (u), show command to debug (x)
set -eux

# Go to directory of this script
cd "$(dirname $0)"

# Stop debug app
docker-compose stop rails_7_debug
