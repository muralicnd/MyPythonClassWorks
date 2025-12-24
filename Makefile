PY ?= python
PIP = $(PY) -m pip
VENV = .venv
TAG ?= v0.1.0
NOTES ?= Release $(TAG)

.PHONY: help venv install run test test-verbose build release clean

help:
	@echo "Available targets:"
	@echo "  make venv          # create and activate virtualenv (activation not sourced)"
	@echo "  make install       # install package editable + dev requirements"
	@echo "  make run           # run the application"
	@echo "  make test          # run pytest (quiet)"
	@echo "  make test-verbose  # run pytest (verbose)"
	@echo "  make build         # build distribution in ./dist"
	@echo "  make release TAG=v0.1.0  # create tag, push, and create GitHub release (requires gh)"
	@echo "  make clean         # remove build artifacts and caches"

venv:
	$(PY) -m venv $(VENV)

install: venv
	$(PIP) install --upgrade pip
	$(PIP) install -e .
	@if [ -f dev-requirements.txt ]; then $(PIP) install -r dev-requirements.txt; fi

run:
	$(PY) -m my_project

test:
	$(PY) -m pytest -q

test-verbose:
	$(PY) -m pytest -vv

build:
	$(PIP) install --upgrade build
	$(PY) -m build -o dist/

release:
	@git tag -a $(TAG) -m "$(TAG)" || echo "tag exists"
	@git push origin $(TAG)
	@if command -v gh >/dev/null 2>&1; then \
		gh release create $(TAG) --title "$(TAG)" --notes "$(NOTES)"; \
	else \
		echo "gh CLI not found — release tag pushed but GitHub release not created."; \
	fi

clean:
	@echo "Cleaning..."
	@rm -rf build/ dist/ *.egg-info .pytest_cache __pycache__ $(VENV)
