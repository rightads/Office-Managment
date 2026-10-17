from __future__ import annotations

import datetime
import json
import logging
import sys
from typing import Any


class JSONFormatter(logging.Formatter):
    """Formats log records as single-line JSON objects."""

    def format(self, record: logging.LogRecord) -> str:
        log_entry: dict[str, Any] = {
            "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat(),
            "level": record.levelname,
            "logger": record.name,
            "message": record.getMessage(),
        }

        if record.exc_info:
            log_entry["exception"] = self.formatException(record.exc_info)

        # Include custom extra fields if attached to record
        standard_attrs = {
            "name",
            "msg",
            "args",
            "levelname",
            "levelno",
            "pathname",
            "filename",
            "module",
            "exc_info",
            "exc_text",
            "stack_info",
            "lineno",
            "funcName",
            "created",
            "msecs",
            "relativeCreated",
            "thread",
            "threadName",
            "processName",
            "process",
            "message",
        }
        extras = {
            k: v
            for k, v in record.__dict__.items()
            if k not in standard_attrs and not k.startswith("_")
        }
        if extras:
            log_entry["extra"] = extras

        return json.dumps(log_entry, default=str)


def setup_logging(debug: bool = False) -> None:
    """Configures structured JSON logging across standard and third-party loggers."""
    log_level = logging.DEBUG if debug else logging.INFO
    root_logger = logging.getLogger()
    root_logger.setLevel(log_level)

    # Clear existing handlers to prevent duplicate lines
    root_logger.handlers.clear()

    handler = logging.StreamHandler(sys.stdout)
    handler.setLevel(log_level)
    handler.setFormatter(JSONFormatter())
    root_logger.addHandler(handler)

    # Align uvicorn loggers to use standard handler
    for uvicorn_logger_name in ("uvicorn", "uvicorn.error", "uvicorn.access"):
        u_logger = logging.getLogger(uvicorn_logger_name)
        u_logger.handlers.clear()
        u_logger.addHandler(handler)
        u_logger.propagate = False
