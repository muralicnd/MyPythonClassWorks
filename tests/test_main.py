from my_project.main import greet


def test_greet_basic():
    assert greet("Alice") == "Hello, Alice!"


def test_greet_empty_name():
    assert greet("") == "Hello, !"
