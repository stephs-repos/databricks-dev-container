# tests/unit/test_math_utils.py

import pytest

from sample_package import add_numbers
from sample_package.utils.sample_utils import mean


def test_add_numbers():
    assert add_numbers(2, 3) == 5
    assert add_numbers(-1, 1.5) == 0.5


def test_mean_basic():
    assert mean([1, 2, 3, 4]) == 2.5


def test_mean_raises_on_empty():
    with pytest.raises(ValueError):
        mean([])
