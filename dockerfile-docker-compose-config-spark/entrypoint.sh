#!/bin/bash

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

if [ "$SPARK_WORKLOAD" == "master" ];
then
  # Start Spark Master
  start-master.sh -p 7077 &

  # # Start Jupyter Lab explicitly
  # import pyspark command in python is required and spark session needs to be created from the jupyter notebook. 
  jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root > /usr/hive-metastore/logs/jupyter.log 2>&1 

elif [ "$SPARK_WORKLOAD" == "worker" ];
then
  start-worker.sh spark://spark-master:7077
elif [ "$SPARK_WORKLOAD" == "history" ]
then
  start-history-server.sh
fi