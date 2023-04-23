#!/bin/bash
set -e

# rm -f /app/tmp/pids/server.pid
rm -f /html-css-try/tmp/pids/server.pid
exec "$@"