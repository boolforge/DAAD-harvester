"""Fast, in-process CLI integration tests using typer.testing.CliRunner.

These exist specifically because the original PR #14 shipped with `daad-harvester
--phase unpack` (and therefore also the default `--phase all`) raising AttributeError
on every single invocation, and the existing test suite -- which imports submodules
directly rather than ever invoking daad_harvester.cli.main() end to end -- had no way
to notice. Every phase that does not require real network access is exercised here
against an empty, freshly-initialized state, matching what a first-time user's very
first run looks like.

daad_harvester.cli.main() mutates the module-level `settings` singleton on every
invocation (output_dir, db_path, log_file, ...). Every test below passes an isolated
--output-dir under tmp_path specifically to avoid one test's settings bleeding into
another's, or into the real repository's output/ directory.
"""
import pytest
from typer.testing import CliRunner

from daad_harvester.cli import app

runner = CliRunner()

NETWORK_FREE_PHASES = ["catalog", "unpack", "fingerprint", "synthesize", "organize", "report"]


def test_version():
    result = runner.invoke(app, ["--version"])
    assert result.exit_code == 0
    assert "daad-harvester" in result.stdout


def test_help():
    result = runner.invoke(app, ["--help"])
    assert result.exit_code == 0
    assert "--phase" in result.stdout


@pytest.mark.parametrize("phase", NETWORK_FREE_PHASES)
def test_phase_runs_cleanly_against_empty_state(tmp_path, phase):
    result = runner.invoke(app, ["--phase", phase, "--output-dir", str(tmp_path / phase)])
    assert result.exit_code == 0, result.output
    assert result.exception is None


def test_full_pipeline_minus_network_phases_runs_in_sequence_against_shared_state(tmp_path):
    """Mirrors a real invocation more closely than the parametrized test above: the
    same state.db is reused across phases in pipeline order, rather than each phase
    getting a pristine directory to itself."""
    output_dir = tmp_path / "shared"
    for phase in NETWORK_FREE_PHASES:
        result = runner.invoke(app, ["--phase", phase, "--output-dir", str(output_dir)])
        assert result.exit_code == 0, f"phase={phase!r} failed:\n{result.output}"
        assert result.exception is None, f"phase={phase!r} raised: {result.exception}"
