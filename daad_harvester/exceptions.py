"""Custom exception hierarchy for DAAD Harvester."""

class DAADHarvesterError(Exception):
    """Base exception for all DAAD Harvester errors."""
    pass


class DiscoveryError(DAADHarvesterError):
    """Raised when source discovery or URL crawling fails."""
    pass


class FetchError(DAADHarvesterError):
    """Raised when artifact downloading fails."""
    pass


class UnpackError(DAADHarvesterError):
    """Raised when extracting or unpacking container formats fails."""
    pass


class FingerprintError(DAADHarvesterError):
    """Raised during DAAD byte payload identification or analysis."""
    pass


class SynthesizeError(DAADHarvesterError):
    """Raised during C++ detection table or JSON catalog generation."""
    pass
