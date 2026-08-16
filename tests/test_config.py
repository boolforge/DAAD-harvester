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
