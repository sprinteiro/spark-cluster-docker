#!/bin/bash

ERROR_SPARK_STARTUP=1

echo "Starting Apache Spark two node cluster (Master & Slave)..."
echo "  Starting master..."
/opt/spark/sbin/start-master.sh 

if [ $? -eq 0 ]; then
    echo "  Starting slave..."
    /opt/spark/sbin/start-slave.sh spark://scale1.docker:7077

    if [ $? -eq 0 ]; then
        echo "  Cluster up and running." 
        echo "  Tailing master's logs"
        tail -f /opt/spark/logs/spark--org.apache.spark.deploy.master*
    else 
        echo "Stopping master... as slave start up failed"
        /opt/spark/sbin/stop-master.sh
        exit ${ERROR_SPARK_STARTUP}
    fi
fi

echo "Shutting down the cluster"
exit $?
