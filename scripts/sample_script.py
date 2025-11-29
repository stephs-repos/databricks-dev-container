from pyspark.sql import SparkSession


def main() -> None:
    # Get an existing SparkSession (Databricks creates it for you)
    spark = SparkSession.builder.getOrCreate()

    # Create a simple DataFrame with values 0–9
    df = spark.range(10)

    # Show the DataFrame in the job output
    print("=== Demo: spark.range(10) ===")
    df.show()

    print("Demo script completed successfully.")


if __name__ == "__main__":
    main()
