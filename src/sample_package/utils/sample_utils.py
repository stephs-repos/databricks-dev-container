# src/sample_package/utils/sample_utils.py

from typing import Iterable


def add_numbers(a: float, b: float) -> float:
    """Return the sum of two numbers."""
    return a + b


def mean(values: Iterable[float]) -> float:
    """Compute the arithmetic mean of an iterable of numbers.

    Raises:
        ValueError: if values is empty.
    """
    vals = list(values)
    if not vals:
        raise ValueError("mean() requires at least one value")
    return sum(vals) / len(vals)
