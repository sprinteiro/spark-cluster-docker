package org.sprinteiro.spark.examples

import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.Row


object WordCount {
	/*
	 * IMPORTANT - ARGUMENTS
	 * 
	 * arg(1) fromFile(file with words to count). Optional.
	 * arg(2) toFile or stdout (target, words and count). Optional.
	 * 
	 */    

	def main(args: Array[String]) {

		val spark = SparkSession
				.builder
				.appName("Spark WordCount")
				.getOrCreate() 

		import spark.implicits._
		val words = args.length match {
			case x: Int if x > 0 => {
				spark.read.text(args(0)).rdd.flatMap {
				case Row(text: String) =>
				  text.split("\\s+")
				}
			}
			case _ => {
				spark.sparkContext.parallelize(List("pandas", "i like pandas")).flatMap(x => x.split("\\s+"))
			}
    }

		val counts = words.map(word => (word, 1)).reduceByKey{case (x,y) => x + y}
		args.length match {
  		case x: Int if x > 1 => {
  			counts.saveAsTextFile(args(1))
  		}
  		case _ => {
  		    counts.collect.foreach(println)
  		}
		}
	}
}