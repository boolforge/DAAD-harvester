"""Configuration management for DAAD Harvester using pydantic-settings."""

import sys
import logging
from pathlib import Path
from typing import List, Optional
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import Field
import structlog

from daad_harvester.logging import setup_logger


DEFAULT_USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:123.0) Gecko/20100101 Firefox/123.0",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
    "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:123.0) Gecko/20100101 Firefox/123.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Edge/122.0.2365.92",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3.1 Safari/605.1.15"
]


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_prefix="DAAD_",
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore"
    )

    output_dir: Path = Field(default=Path("./output"))
    db_path: Path = Field(default=Path("./output/state.db"))
    logs_dir: Path = Field(default=Path("./output/logs"))
    proxy_list_file: Optional[Path] = Field(default=None)
    proxy_list: List[str] = Field(default_factory=list)
    user_agents: List[str] = Field(default_factory=lambda: DEFAULT_USER_AGENTS)

    rate_limit_per_domain: float = Field(default=1.0, description="Requests per second per domain")
    request_timeout: float = Field(default=30.0, description="HTTP request timeout in seconds")
    max_retries: int = Field(default=3, description="Max retry attempts for fetching")
    backoff_base: float = Field(default=1.0, description="Base exponential backoff delay in seconds")
    backoff_max: float = Field(default=60.0, description="Max backoff delay in seconds")

    max_unpack_depth: int = Field(default=5, description="Max recursion depth for nested unpacking")
    # Retro disk/tape images (.dsk, .tap, .d64...) are mostly zero-padding and
    # routinely compress 20-50x+ with plain DEFLATE, so the previous 10x
    # default was rejecting legitimate DAAD game disk images as "zip bombs" --
    # actively working against this tool's own purpose. 100x still catches
    # genuine bombs (typically >1000x) while giving real retro archives
    # headroom; combined with max_unpack_depth above, worst-case expansion
    # stays bounded regardless, since DAAD-era games are inherently tiny.
    zip_bomb_max_ratio: float = Field(default=100.0, description="Max extracted/compressed file ratio limit")

    parallel_workers: int = Field(default=8, description="Number of parallel execution workers")
    log_file: Path = Field(default=Path("./output/logs/daad_harvester.json"), description="Path to main structured JSON log file")
    log_level: str = Field(default="INFO", description="Logging level")

    def load_proxies(self) -> None:
        """Loads proxy list from file if specified."""
        if self.proxy_list_file and self.proxy_list_file.exists():
            lines = self.proxy_list_file.read_text(encoding="utf-8").splitlines()
            self.proxy_list = [line.strip() for line in lines if line.strip() and not line.startswith("#")]


settings = Settings()


def setup_logging(log_file: Optional[Path] = None, log_level: str = "INFO", rotate_old: bool = True) -> None:
    """Configures logging to both stdout and a file using structlog, rotating old log
    files if present, and also configures the Loguru sinks used by newer ETL-layer
    modules. This is the single entry point cli.py calls so that both the legacy
    structlog-based modules (Discoverer, Fetcher, Fingerprinter, ...) and the newer
    Loguru-based modules end up correctly configured from one call."""
    level = getattr(logging, log_level.upper(), logging.INFO)
    handlers: List[logging.Handler] = [logging.StreamHandler(sys.stdout)]

    if log_file:
        log_file = Path(log_file)
        log_file.parent.mkdir(parents=True, exist_ok=True)

        if rotate_old and log_file.exists() and log_file.stat().st_size > 0:
            from daad_harvester.daad_logger import rotate_log_file
            rotate_log_file(log_file)

        file_handler = logging.FileHandler(log_file, encoding="utf-8")
        handlers.append(file_handler)

    logging.basicConfig(
        format="%(message)s",
        level=level,
        handlers=handlers,
        force=True
    )

    structlog.configure(
        processors=[
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.stdlib.PositionalArgumentsFormatter(),
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.StackInfoRenderer(),
            structlog.processors.format_exc_info,
            structlog.processors.KeyValueRenderer()
        ],
        context_class=dict,
        logger_factory=structlog.stdlib.LoggerFactory(),
        wrapper_class=structlog.stdlib.BoundLogger,
        cache_logger_on_first_use=True,
    )

    setup_logger(log_file=log_file, log_level=log_level)
