# Docker standalone Apache Spark Cluster
---

This image starts automatically two-node cluster in Apache Spark standalone cluster mode in a Docker container.

* Base image: Linux Alpine 3.6 .
* Java version: OpenJDK 8 .
* Apache Spark version: 2.1.1 .

Also, it contains a fat JAR with Apache Spark example jobs in Scala programming language from [Databricks](https://github.com/databricks/learning-spark). The JAR is only compatible with Apache Spark API version to 2.x as it has been upgraded from Apache Spark 1.6.
* JAR: spark-jobs-poc (WordCount.scala, SparkPI.scala), Apache Spark 2.x compatible


## Pull the Docker image from Docker Hub.
---

```shell
$ docker pull sprinteiro/spark-cluster-docker
```

You can check that the Docker image has been built by issuing the following Docker command.

```shell
$ docker images | grep sprinteiro/spark-cluster-docker


sprinteiro/spark-cluster-docker           latest              beb19dfb7d43        21 minutes ago      336 MB

```


## Build the Docker image.
---

1.Create a directory, change to the new directory, and clone the project from Git.

```shell
$ mkdir spark-cluster-docker
$ cd spark-cluster-docker
$ git clone https://github.com/sprinteiro/spark-cluster-docker.git
```

2.Build the Docker image.

```
$ docker image build -t 'sprinteiro/spark-cluster-alpine:3.6' .
```
You can check whether the Docker image has been built by issuing the following Docker command.

```shell
$ docker images | grep spark-cluster-alpine

$ docker images | grep spark-cluster-alpine
sprinteiro/spark-cluster-alpine           3.6                 ced12c3bab84        11 seconds ago      336 MB

```


## Run a Docker container.
---
Run a Docker container from the image previously pulled or built, by issuing the following command in __A__ or __B__. Once the cluster has started, you should be able to see logs from the master node as below.

__A. Run Docker container from the previously pulled image (lastest version), and tagged as sprinteiro/spark-cluster-docker.__

```shell
$ docker run --rm --name spark-cluster -h scale1.docker -p7077:7077 -p8080:8080 -i -t sprinteiro/spark-cluster-docker

```

 __B. Run Docker container from previously built image, and tagged as sprinteiro/spark-cluster-alpine:3.6__

```
$ docker run --rm --name spark-cluster -h scale1.docker -p7077:7077 -p8080:8080 -i -t sprinteiro/spark-cluster-alpine:3.6
```
__Note:__ Ports mapping would need to be changed if the are already taken.

Now, you should be able to see Spark UI/web console on your browser on [http://172.17.0.2:8080](http://172.17.0.2:8080) .


Docker container start-up example from sprinteiro/spark-cluster-docker Docker Hub pulled image.

```shell
jj@pluto2:~/workspaceSprintdaters/spark-cluster-docker$ docker run --rm --name spark-cluster -h scale1.docker -p7077:7077 -p8080:8080 -i -t sprinteiro/spark-cluster-docker
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
17/07/05 21:15:57 INFO Master: Started daemon with process name: 18@scale1.docker
17/07/05 21:15:57 INFO SignalUtils: Registered signal handler for TERM
17/07/05 21:15:57 INFO SignalUtils: Registered signal handler for HUP
17/07/05 21:15:57 INFO SignalUtils: Registered signal handler for INT
17/07/05 21:15:59 WARN NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
17/07/05 21:16:00 INFO SecurityManager: Changing view acls to: root
17/07/05 21:16:00 INFO SecurityManager: Changing modify acls to: root
17/07/05 21:16:00 INFO SecurityManager: Changing view acls groups to: 
17/07/05 21:16:00 INFO SecurityManager: Changing modify acls groups to: 
17/07/05 21:16:00 INFO SecurityManager: SecurityManager: authentication disabled; ui acls disabled; users  with view permissions: Set(root); groups with view permissions: Set(); users  with modify permissions: Set(root); groups with modify permissions: Set()
17/07/05 21:16:01 INFO Utils: Successfully started service 'sparkMaster' on port 7077.
17/07/05 21:16:01 INFO Master: Starting Spark master at spark://scale1.docker:7077
17/07/05 21:16:01 INFO Master: Running Spark version 2.1.1
17/07/05 21:16:03 INFO Utils: Successfully started service 'MasterUI' on port 8080.
17/07/05 21:16:03 INFO MasterWebUI: Bound MasterWebUI to 0.0.0.0, and started at http://172.17.0.2:8080
17/07/05 21:16:03 INFO Utils: Successfully started service on port 6066.
17/07/05 21:16:03 INFO StandaloneRestServer: Started REST server for submitting applications on port 6066
17/07/05 21:16:03 INFO Master: I have been elected leader! New state: ALIVE
17/07/05 21:16:03 INFO Master: Registering worker 172.17.0.2:41515 with 4 cores, 2.0 GB RAM
```


## Submit a job to Apache Spark cluster.
---

#### Access Apache Spark Cluster container's command line (master's node). 

Make sure that the Docker container's name is spark-cluster, and run /bin/bash to access the command line.

__A. Check container's name (it should be spark-cluster). __

```
$ docker ps

CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS              PORTS                                            NAMES
02f3533fa367        sprinteiro/spark-cluster-docker   "/opt/startTwoNode..."   11 minutes ago      Up 11 minutes       0.0.0.0:7077->7077/tcp, 0.0.0.0:8080->8080/tcp   spark-cluster
```


__B. Execute a shell/command line by running /bin/bash. __

```shell
$ docker exec -ti spark-cluster /bin/bash
```

#### Submit the fat JAR to the master and execute a job in Spark cluster

From the Apache Spark Cluster container's command line:

   - __Execute WordCount job__
   
```shell
bash-4.3# /opt/spark/bin/spark-submit --class org.sprinteiro.spark.examples.WordCount --master spark://scale1.docker:7077 /spark-jobs/spark-jobs-poc-1.0.jar /spark-jobs/words-example.txt
```
It has been passed in words-example.txt file as a parameter which contains words to be count by the cluster, and the calculation/result is shown up on the console.

   - __Execute SparkPi job__

```shell
bash-4.3# /opt/spark/bin/spark-submit --class org.sprinteiro.spark.examples.SparkPi --master spark://scale1.docker:7077 /spark-jobs/spark-jobs-poc-1.0.jar 15000
```
It has been passed in 15000 value as a parameter, and the PI calculation/result is shown up in the console.
