# Docker standalone Spark Cluster
---

This image starts automatically two-node cluster in Apache Spark standalone cluster mode in a Docker container.

* Base image: Linux Alpine 3.6 .
* Java version: OpenJDK 8 .
* Apache Spark version: 2.1.1 .


## Pull the Docker image from Docker Hub.
---

```shell
$ docker pull sprinteiro/spark-cluster-docker
```

You can check the Docker image has been built by issuing the following Docker command.

```shell
$ docker images | grep sprinteiro/spark-cluster-docker


sprinteiro/spark-cluster-docker           latest              beb19dfb7d43        21 minutes ago      336 MB

```


## Build the Docker image.
---

1. Create a directory, change to the new directory, and clone the project from Git.

```shell
$ mkdir spark-cluster-docker
$ cd spark-cluster-docker
$ git clone TBC
```

2. Build the Docker image.

```
$ docker image build -t 'sprinteiro/spark-cluster-alpine:3.6' .
```
You can check the Docker image has been built by issuing the following Docker command.

```shell
$ docker images | grep spark-cluster-alpine

$ docker images | grep spark-cluster-alpine
sprinteiro/spark-cluster-alpine           3.6                 ced12c3bab84        11 seconds ago      336 MB

```


## Run a Docker container.
---
Run a Docker container by issuing the following command in __A__ or __B__, either you pulled or built the Docker image respectively. Once the cluster has started, you should be able to see logs from the master node as below.

__A. Run Docker container from previously pulled image (last version), tag as sprinteiro/spark-cluster-docker.__

```shell
$ docker run -h scale1.docker -p7077:7077 -p8080:8080 -i -t sprinteiro/spark-cluster-docker
```

 __B. Run Docker container from previously built image, tagged as sprinteiro/spark-cluster-alpine:3.6__

```
$ docker run -h scale1.docker -p7077:7077 -p8080:8080 -i -t sprinteiro/spark-cluster-alpine:3.6
```
__Note:__ Ports mapping would need to be changed if the are already taken.

Now, you should be able to see Spark web console on your browser on [http://172.17.0.2:8080](http://172.17.0.2:8080)

```shell

spark-cluster-docker$ docker run -h scale1.docker -p7077:7077 -p8080:8080 -i -t sprinteiro/spark-cluster-alpine:3.6
Starting Apache Spark two node cluster (Master & Slave)...
  Starting master...
starting org.apache.spark.deploy.master.Master, logging to /opt/spark/logs/spark--org.apache.spark.deploy.master.Master-1-scale1.docker.out
  Starting slave...
starting org.apache.spark.deploy.worker.Worker, logging to /opt/spark/logs/spark--org.apache.spark.deploy.worker.Worker-1-scale1.docker.out
  Cluster up and running.
  Tailing master's logs
Spark Command: /usr/lib/jvm/java-1.8-openjdk/jre/bin/java -cp /opt/spark/conf/:/opt/spark/jars/* -Xmx1g org.apache.spark.deploy.master.Master --host scale1.docker --port 7077 --webui-port 8080
========================================
Using Spark's default log4j profile: org/apache/spark/log4j-defaults.properties
17/07/01 21:58:52 INFO Master: Started daemon with process name: 18@scale1.docker
17/07/01 21:58:52 INFO SignalUtils: Registered signal handler for TERM
17/07/01 21:58:52 INFO SignalUtils: Registered signal handler for HUP
17/07/01 21:58:52 INFO SignalUtils: Registered signal handler for INT
17/07/01 21:58:55 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
17/07/01 21:58:55 INFO SecurityManager: Changing view acls to: root
17/07/01 21:58:55 INFO SecurityManager: Changing modify acls to: root
17/07/01 21:58:55 INFO SecurityManager: Changing view acls groups to: 
17/07/01 21:58:55 INFO SecurityManager: Changing modify acls groups to: 
17/07/01 21:58:55 INFO SecurityManager: SecurityManager: authentication disabled; ui acls disabled; users  with view permissions: Set(root); groups with view permissions: Set(); users  with modify permissions: Set(root); groups with modify permissions: Set()
17/07/01 21:58:56 INFO Utils: Successfully started service 'sparkMaster' on port 7077.
17/07/01 21:58:57 INFO Master: Starting Spark master at spark://scale1.docker:7077
17/07/01 21:58:57 INFO Master: Running Spark version 2.1.0
17/07/01 21:58:58 INFO Utils: Successfully started service 'MasterUI' on port 8080.
17/07/01 21:58:58 INFO MasterWebUI: Bound MasterWebUI to 0.0.0.0, and started at http://172.17.0.2:8080
17/07/01 21:58:58 INFO Utils: Successfully started service on port 6066.
17/07/01 21:58:58 INFO StandaloneRestServer: Started REST server for submitting applications on port 6066
17/07/01 21:58:58 INFO Master: I have been elected leader! New state: ALIVE
17/07/01 21:58:59 INFO Master: Registering worker 172.17.0.2:44371 with 4 cores, 2.0 GB RAM

```
