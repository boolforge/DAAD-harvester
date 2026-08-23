"""Configuration settings for DAAD Harvester using pydantic-settings."""

import sys
import logging
from pathlib import Path
from typing import List, Optional, Union
from pydantic import Field
from pydantic_settings import BaseSettings, SettingsConfigDict
import structlog

from daad_harvester.logging import setup_logger


DEFAULT_USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:123.0) Gecko/20100101 Firefox/123.0",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
]


class Settings(BaseSettings):
    """Global configuration settings for DAAD Harvester pipeline."""

    model_config = SettingsConfigDict(
        env_prefix="DAAD_",
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    output_dir: Path = Field(default=Path("./output"), description="Main output directory")
    db_path: Path = Field(default=Path("./output/state.db"), description="SQLite database path")
    logs_dir: Path = Field(default=Path("./output/logs"), description="Log directory")

    proxy_list_file: Optional[Path] = Field(default=None, description="Optional path to proxy list file")
    proxy_list: List[str] = Field(default_factory=list, description="Loaded HTTP/HTTPS proxies")
    user_agents: List[str] = Field(default_factory=lambda: DEFAULT_USER_AGENTS, description="User-Agent headers for rotation")

    rate_limit_per_domain: float = Field(default=1.0, description="Rate limit delay per domain in seconds")
    request_timeout: float = Field(default=30.0, description="HTTP timeout in seconds")
    max_retries: int = Field(default=3, description="Maximum HTTP fetch retry attempts")
    backoff_base: float = Field(default=1.0, description="Base backoff multiplier in seconds")
    backoff_max: float = Field(default=60.0, description="Maximum backoff delay in seconds")

    max_unpack_depth: int = Field(default=5, description="Maximum recursion depth for unpacking nested archives")
    zip_bomb_max_ratio: float = Field(default=100.0, description="Maximum decompression ratio limit")

    parallel_workers: int = Field(default=8, description="Number of parallel execution workers")
    log_file: Path = Field(default=Path("./output/logs/daad_harvester.json"), description="Main JSON log file path")
    log_level: str = Field(default="INFO", description="Logging level threshold")

    def load_proxies(self) -> None:
        """Loads proxies from proxy_list_file if provided."""
        if self.proxy_list_file and self.proxy_list_file.exists():
            lines = self.proxy_list_file.read_text(encoding="utf-8").splitlines()
            self.proxy_list = [line.strip() for line in lines if line.strip() and not line.startswith("#")]


settings = Settings()


def setup_logging(log_file: Optional[Union[str, Path]] = None, log_level: str = "INFO", rotate_old: bool = True) -> None:
    """Configures logging to file and console supporting Loguru and structlog."""
    level = getattr(logging, log_level.upper(), logging.INFO)
    handlers: List[logging.Handler] = [logging.StreamHandler(sys.stdout)]

    if log_file:
        log_file_path = Path(log_file)
        log_file_path.parent.mkdir(parents=True, exist_ok=True)
        file_handler = logging.FileHandler(log_file_path, encoding="utf-8")
        handlers.append(file_handler)

    logging.basicConfig(
        format="%(message)s",
        level=level,
        handlers=handlers,
        force=True,
    )

    structlog.configure(
        processors=[
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.stdlib.PositionalArgumentsFormatter(),
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.StackInfoRenderer(),
            structlog.processors.format_exc_info,
            structlog.processors.KeyValueRenderer(),
        ],
        context_class=dict,
        logger_factory=structlog.stdlib.LoggerFactory(),
        wrapper_class=structlog.stdlib.BoundLogger,
        cache_logger_on_first_use=True,
    )

    setup_logger(log_file=log_file, log_level=log_level)
