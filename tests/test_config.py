import pytest
from pathlib import Path
from daad_harvester.config import Settings

def test_settings_default_values():
    s = Settings()
    assert s.rate_limit_per_domain == 1.0
    assert s.request_timeout == 30.0
    assert s.max_retries == 3
    assert s.parallel_workers == 8
    assert len(s.user_agents) > 0

def test_load_proxies(tmp_path):
    proxy_file = tmp_path / "proxies.txt"
    proxy_file.write_text("http://1.2.3.4:8080\n# comment\nhttp://5.6.7.8:8080\n", encoding="utf-8")

    s = Settings(proxy_list_file=proxy_file)
    s.load_proxies()
    assert len(s.proxy_list) == 2
    assert "http://1.2.3.4:8080" in s.proxy_list
    assert "http://5.6.7.8:8080" in s.proxy_list

def test_setup_logging_file_creation(tmp_path):
    import structlog
    from daad_harvester.config import setup_logging

    log_file = tmp_path / "test-harvester.log"
    setup_logging(log_file=log_file, log_level="INFO")

    logger = structlog.get_logger("test")
    logger.info("unit_test_log_message", key="value")

    assert log_file.exists()
    content = log_file.read_text(encoding="utf-8")
    assert "unit_test_log_message" in content
    assert "value" in content
