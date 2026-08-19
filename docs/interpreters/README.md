# Interpreters Index

**Question:** How does a preservation workflow identify a runtime without turning a filename into an engine-version claim?

| Module | Single responsibility | Status |
| --- | --- | --- |
| [Identity protocol](IDENTITY_PROTOCOL.md) | Define exact-hash, neighboring-bundle, and non-identity evidence. | Implementation contract |
| [Official profile ledger](OFFICIAL_PROFILE_LEDGER.md) | Describe profile provenance and hash reproducibility. | Measured |
| [Public implementation boundaries](PUBLIC_IMPLEMENTATIONS.md) | Separate open derivative implementations from original proprietary interpreter binaries. | Source-backed |

Platform loader context belongs in `../platforms/`; data format generation belongs in `../versions/`.
