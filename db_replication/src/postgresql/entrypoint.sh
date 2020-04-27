#!/bin/bash
set -e
echo '>>> BEGIN STARTING POSTGRESQL ...'
/usr/local/bin/cluster/postgresql/bin/entrypoint.sh & wait ${!}

EXIT_CODE=$?

while [ -f /var/run/recovery.lock ]; do
    sleep 1;
done;
echo ">>> POSTGRESQL TERMINATED WITH EXIT CODE: $EXIT_CODE"

exit $EXIT_CODE
