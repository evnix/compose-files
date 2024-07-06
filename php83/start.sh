#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

# Exit if any command in a pipeline fails.
set -o pipefail 2>/dev/null || true

# Treat unset variables as an error when substituting.
set -u

# Enable ERR trap for error handling in functions and subshells.
trap 'echo "Error on line $LINENO"' ERR


php-fpm -D

nginx -g "daemon off;"