# Interpreters Index

**Question:** How does a preservation workflow identify a runtime without turning a filename into an engine-version claim?

| Module | Single responsibility | Status |
| --- | --- | --- |
| [Identity protocol](IDENTITY_PROTOCOL.md) | Define exact-hash, neighboring-bundle, and non-identity evidence. | Planned |
| [Official profile ledger](OFFICIAL_PROFILE_LEDGER.md) | Describe profile provenance and hash reproducibility. | Planned |
| [Public implementation boundaries](PUBLIC_IMPLEMENTATIONS.md) | Separate open derivative implementations from original proprietary interpreter binaries. | Planned |

Platform loader context belongs in `../platforms/`; data format generation belongs in `../versions/`.
