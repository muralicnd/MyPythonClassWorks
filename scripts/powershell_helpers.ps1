function pj-venv {
    param(
        [string]$Path = '.venv'
    )
    python -m venv $Path
    Write-Output "Created virtual environment at '$Path'. Activate with:`n. $Path\Scripts\Activate.ps1"
}

function pj-install {
    . .\.venv\Scripts\Activate.ps1
    python -m pip install --upgrade pip
    python -m pip install -e .
    if (Test-Path dev-requirements.txt) { pip install -r dev-requirements.txt }
}

function pj-run {
    python -m my_project
}

function pj-test {
    param([string]$Args = '')
    if ($Args -ne '') { python -m pytest $Args }
    else { python -m pytest -q }
}

function pj-build {
    python -m pip install --upgrade build
    python -m build -o dist/
}

function pj-release {
    param(
        [string]$Tag = 'v0.1.0',
        [string]$Notes = 'Release'
    )
    git tag -a $Tag -m $Tag
    git push origin $Tag
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        gh release create $Tag --title $Tag --notes $Notes
    } else {
        Write-Output "gh CLI not found — pushed tag but did not create GitHub release."
    }
}

function pj-clean {
    Remove-Item -Recurse -Force build,dist,*.egg-info,.pytest_cache,__pycache__ -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force .venv -ErrorAction SilentlyContinue
}

Write-Output "pj-* helper functions loaded: pj-venv, pj-install, pj-run, pj-test, pj-build, pj-release, pj-clean"
