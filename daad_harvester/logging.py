"""Asynchronous structured logging and telemetry for DAAD Harvester using Loguru."""

import sys
import json
from pathlib import Path
from typing import Optional, Union, Dict, Any
from loguru import logger


def setup_logger(
    log_file: Optional[Union[str, Path]] = None,
    log_level: str = "INFO",
    json_output: bool = True,
    rotation: str = "10 MB",
    retention: str = "1 week",
) -> None:
    """Configures Loguru logger with console and structured JSON file sinks.

    Args:
        log_file: Optional filepath to output structured logs.
        log_level: Severity threshold (DEBUG, INFO, WARNING, ERROR).
        json_output: Whether file logs should be serialized as structured JSON.
        rotation: Log rotation specification (e.g. '10 MB', '1 day').
        retention: Log retention rule (e.g. '1 week').
    """
    logger.remove()

    # Console sink
    logger.add(
        sys.stderr,
        level=log_level,
        format="<green>{time:YYYY-MM-DD HH:mm:ss.SSS}</green> | <level>{level:10}</level> | <cyan>{name}</cyan>:<cyan>{function}</cyan>:<cyan>{line}</cyan> - <level>{message}</level>",
        colorize=True,
    )

    # File sink (structured JSON)
    if log_file:
        file_path = Path(log_file)
        file_path.parent.mkdir(parents=True, exist_ok=True)

        logger.add(
            str(file_path),
            level=log_level,
            serialize=json_output,
            rotation=rotation,
            retention=retention,
            encoding="utf-8",
            enqueue=True,  # Asynchronous thread-safe logging
        )


def log_event(event_type: str, details: Dict[str, Any], level: str = "INFO") -> None:
    """Logs a structured domain event with context parameters.

    Args:
        event_type: Category identifier of the event.
        details: Payload details map.
        level: Severity level string.
    """
    log_func = getattr(logger, level.lower(), logger.info)
    log_func("{type}: {details}", type=event_type, details=json.dumps(details, default=str))
