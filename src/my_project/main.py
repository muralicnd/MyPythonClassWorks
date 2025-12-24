def greet(name: str) -> str:
    """Return a greeting for `name`."""
    return f"Hello, {name}!"


def main() -> None:
    name = input("Your name: ").strip() or "world"
    print(greet(name))


if __name__ == "__main__":
    main()
