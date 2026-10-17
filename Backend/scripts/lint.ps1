# Run ruff and mypy
$env:PYTHONPATH = "."
Write-Host "Running Ruff Check..."
ruff check .
Write-Host "Running Ruff Format Check..."
ruff format --check .
Write-Host "Running Mypy..."
mypy app
