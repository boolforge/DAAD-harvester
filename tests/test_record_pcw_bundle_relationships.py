from __future__ import annotations

import json

from daad_harvester.db import Database
from scripts.record_pcw_bundle_relationships import (
    DEFAULT_DB,
    _database_is_current,
    build_output,
)


def test_torreoscura_pcw_relationship_output_reextracts_two_separate_disks() -> None:
    db = Database(DEFAULT_DB)
    output = build_output(db)

    assert output["relationship_count"] == 2
    relationships = output["relationships"]
    assert [relationship["disk"]["filename"] for relationship in relationships] == [
        "TO.DSK",
        "TO2.DSK",
    ]
    assert [relationship["ddb"]["filename"] for relationship in relationships] == [
        "PARTE001.DDB",
        "PARTE002.DDB",
    ]
    assert [
        [companion["filename"] for companion in relationship["companions"]]
        for relationship in relationships
    ] == [
        ["PARTE001.CHR", "PARTE001.DAT"],
        ["PARTE002.CHR", "PARTE002.DAT"],
    ]
    assert _database_is_current(db, output)


def test_torreoscura_relationship_evidence_does_not_claim_runtime_linkage() -> None:
    output = build_output(Database(DEFAULT_DB))
    serialized = json.dumps(output, sort_keys=True)

    assert "DDB-internal reference" in serialized
    assert "runtime load order" in serialized
    assert "semantic equivalence" in serialized
