.PHONY: help install run migrate test lint format clean docker-up docker-down

help:
	@echo "Available commands:"
	@echo "  make install      Install production and development dependencies"
	@echo "  make run          Run the FastAPI development server"
	@echo "  make migrate      Run Alembic migrations to head"
	@echo "  make test         Execute test suite with pytest"
	@echo "  make lint         Run Ruff and Mypy checks"
	@echo "  make format       Format code with Ruff"
	@echo "  make docker-up    Start Docker Compose services (API, DB, Redis)"
	@echo "  make docker-down  Stop Docker Compose services"

install:
	pip install --upgrade pip
	pip install -r requirements-dev.txt

run:
	uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

migrate:
	alembic upgrade head

test:
	pytest -v tests/

lint:
	ruff check .
	mypy app

format:
	ruff format .
	ruff check --fix .

clean:
	rm -rf __pycache__ .pytest_cache .mypy_cache .ruff_cache htmlcov .coverage

docker-up:
	docker compose up --build -d

docker-down:
	docker compose down
