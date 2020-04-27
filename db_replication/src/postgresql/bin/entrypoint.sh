#!/bin/bash
DATA_DIRECTORY="/home/postgres/data/postgres"
LOGS_DIRECTORY="/home/postgres/data/logs"

echo ">>> TEST IF DATA DIRECTORY IS EMPTY"
if [ -z "$(ls -A $DATA_DIRECTORY)" ]; then
    # If data directory is empty we assume we are at the first startup and
    # the master node is MASTER_NAME. This assumption make sense because if for example
    # we are recovery the nodeX that is a slave and master is, for example, node2
    # we need first to attach nodeX to node2 with pg_basebackup and then
    # start it.
    echo ">>> PREPARE NODE $NODE_NAME FOR FIRST STARTUP"
    if [ "$NODE_NAME" = "$MASTER_NAME" ]
    then
        echo ">>> CREATE DATA DIRECTORY ON THE MASTER NODE"
        /usr/lib/postgresql/9.5/bin/initdb -D $DATA_DIRECTORY
        echo ">>> COPY CONFIGURATION FILES"
        cp /usr/local/bin/cluster/postgresql/config/postgresql.conf $DATA_DIRECTORY
        cp /usr/local/bin/cluster/postgresql/config/pg_hba.conf $DATA_DIRECTORY
    else
        echo ">>> $NODE_NAME IS WAITING MASTER IS UP AND RUNNING"
        while ! nc -z $MASTER_NAME 5432; do sleep 1; done;
        sleep 10
        echo ">>> REPLICATE DATA DIRECTORY ON THE SLAVE $NODE_NAME"
        /usr/lib/postgresql/9.5/bin/pg_basebackup -h 10.0.2.31 -p 5432 -U postgres -D $DATA_DIRECTORY -X stream -P
        echo ">>> COPY recovery.conf ON SLAVE $NODE_NAME"
        cp /usr/local/bin/cluster/postgresql/config/recovery.conf $DATA_DIRECTORY
        sed -i "s/NODE_NAME/$NODE_NAME/g" $DATA_DIRECTORY/recovery.conf
        sed -i "s/MASTER_NAME/$MASTER_NAME/g" $DATA_DIRECTORY/recovery.conf
    fi
fi
echo ">>> START POSTGRESQL ON NODE $NODE_NAME"
/usr/lib/postgresql/9.5/bin/postgres -D $DATA_DIRECTORY > $LOGS_DIRECTORY/postgres.log 2>&1
