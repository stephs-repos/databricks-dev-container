# src/sample_package/jobs/sample_job.py

from sample_package import add_numbers


def main() -> None:
    """Example Databricks job entry point."""
    result = add_numbers(2, 3)
    print(f"Job ran successfully, 2 + 3 = {result}")


if __name__ == "__main__":
    main()
