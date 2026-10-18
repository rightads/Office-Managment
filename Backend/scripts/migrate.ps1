# Run database migrations
$env:PYTHONPATH = "."
alembic upgrade head
