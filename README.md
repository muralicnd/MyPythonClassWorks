# my_project

A minimal Python project scaffold created for you.

Quick start (PowerShell):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python -m my_project
python -m pytest -q
```

Quick start (bash):

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python -m my_project
python -m pytest -q
```

Project layout:

- `src/my_project/` - package source
- `tests/` - pytest tests
- `pyproject.toml` - project metadata
- `requirements.txt` - runtime and test deps

Development notes:

- Install editable (developer) mode and dev dependencies:

```powershell
Push-Location .\my_project
python -m pip install -e .
pip install -r dev-requirements.txt
Pop-Location
```

- Run tests with `pytest`:

```powershell
python -m pytest -q
```

**Continuous Integration**

- This repository includes a GitHub Actions workflow that runs tests on pushes and pull requests. The workflow file is at `.github/workflows/ci.yml` and runs `pytest` on supported Python versions.

**Default branch**

- The repository now uses `main` as the primary branch. Pushes and PRs against `main` will trigger the CI workflow.

To change the project name, rename the `my_project` package and update `pyproject.toml`.