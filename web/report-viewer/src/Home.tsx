/*
 * Phosphor Archive design: evidence-first field notebook with stable static
 * routes. Every entity comes from report_data.json; route state never infers
 * a port, exposes local paths, or mutates preservation evidence.
 */
import { useEffect, useMemo, useState } from "react";
import type { ReactElement } from "react";
import {
  Archive, Binary, BookOpen, Boxes, ChevronLeft, ChevronRight, CircleAlert, Copy,
  Database, Download, ExternalLink, FileCode2, FolderArchive, LibraryBig, Link2,
  Loader2, RadioTower, Search, ShieldCheck, Terminal,
} from "lucide-react";

const BASE_URL = import.meta.env.BASE_URL;
const ASSETS = {
  hero: `${BASE_URL}media/daad-archive-hero.png`,
  tape: `${BASE_URL}media/daad-spectrum-tape-specimen.png`,
  disk: `${BASE_URL}media/daad-disk-specimen.png`,
  forensic: `${BASE_URL}media/daad-binary-forensics.png`,
  mark: `${BASE_URL}media/daad-harvester-signal-mark.png`,
};

const CHECKSUM_LABELS: Record<string, string> = {
  md5_full: "MD5 (full)", md5_5000: "MD5 (head 5 KB)", md5_tail5000: "MD5 (tail 5 KB)",
  sha1: "SHA-1", sha224: "SHA-224", sha256: "SHA-256", sha384: "SHA-384", sha512: "SHA-512",
  sha3_256: "SHA3-256", sha3_512: "SHA3-512", blake2b: "BLAKE2b", blake2s: "BLAKE2s",
  crc32: "CRC-32", adler32: "Adler-32", xxh32: "XXH32", xxh64: "XXH64", xxh128: "XXH128",
};

type Checksums = Record<string, string | null | undefined>;
type Artifact = {
  id: number; source_id: number; original_filename: string; sha256: string; file_size: number;
  is_daad_payload: boolean; measured_platform?: string | null; legacy_platform_hint?: string | null;
  archive_depth?: number; container_format?: string | null; container_member?: string | null;
  media_parser?: string | null; media_status?: string | null; media_validation?: string | null;
  ddb_format?: string | null; interpreter_identity?: string | null; fingerprint_confidence?: string | null;
  sha1?: string | null; md5_full?: string | null; md5_5000?: string | null; md5_tail5000?: string | null;
  sha224?: string | null; sha384?: string | null; sha512?: string | null; sha3_256?: string | null;
  sha3_512?: string | null; blake2b?: string | null; blake2s?: string | null; crc32?: string | null;
  adler32?: string | null; xxh32?: string | null; xxh64?: string | null; xxh128?: string | null;
  version_evidence?: Array<{ kind: string; value: string; confidence: string }>;
};
type Source = {
  id: number; title?: string | null; url: string; platform?: string | null; status: string;
  source_role?: string | null; priority: number; known_game_id?: string | null;
};
type MatrixArtifact = {
  artifact_id: number; source_id: number; original_filename: string; sha256: string; checksums: Checksums;
  file_size: number; source_platform?: string | null; archive_depth: number;
  artifact_platform_hint?: string | null; measured_platform?: string | null;
  container_format?: string | null; container_member?: string | null;
  media_parser?: string | null; media_status?: string | null; media_validation?: string | null;
  lineage_role: "source_container" | "extracted_medium" | "extracted_member" | "derived_recovery" | "retained_byte";
  is_daad_payload: boolean; ddb_format?: string | null; interpreter_identity?: string | null;
  evidence_state: "verified_ddb" | "retained_artifact";
};
type GamePortMatrix = {
  game_id: string; title: string; catalog_platforms: string[]; source_platforms: string[];
  measured_artifact_platforms: string[]; source_count: number; artifacts: MatrixArtifact[]; boundary: string;
};
type LibraryItem = {
  title: string; platform: string; classification: string; ready_to_use: boolean;
  library_path: string; original_filename: string; binary_verified_daad: boolean;
};
type GeneratorEvidence = {
  generator_id: string; technical_medium: string; status: string;
  inputs: Record<string, string>; output: { byte_length: number; sha256: string; md5_full: string; checksums: Checksums };
  native_validation: { parser: string; status: string; validation: string; evidence: Record<string, unknown> };
  comparison_boundary: Record<string, string>;
};
type ReportData = {
  generated_at: string; summary: Record<string, number | Record<string, number>>; policy: Record<string, string>;
  catalog: { sources: Source[]; artifacts: Artifact[]; games: Array<{ game_id: string; title: string; platform_evidence: string[] }> };
  game_port_matrix: GamePortMatrix[];
  generator_evidence: { available: boolean; generators: GeneratorEvidence[]; boundary: string };
  detections: { available: boolean; download_path: string | null; entry_count: number; preview: string; sha256?: string | null; generator?: string; input_catalog?: string; boundary?: string };
  library: { summary: Record<string, number>; artifacts: LibraryItem[] };
  logs: Record<string, string[]>;
};
type PublicArtifact = { artifact_id: number; public_path: string; checksums: Checksums; file_size: number };
type PublicArtifactManifest = { artifact_count: number; artifacts: PublicArtifact[] };
type LineageRole = "source_container" | "extracted_medium" | "extracted_member" | "derived_recovery" | "retained_byte";

type Section = "overview" | "ledger" | "games" | "sources" | "generators" | "detections" | "library" | "logs";
type EntityKind = "game" | "artifact" | "source" | "library";
type Route = { section: Section; entity?: EntityKind; id?: string; checksum?: string };

const SECTIONS: Array<{ id: Section; label: string; icon: typeof Archive }> = [
  { id: "overview", label: "Preservation brief", icon: Archive },
  { id: "ledger", label: "Evidence ledger", icon: Database },
  { id: "games", label: "Games & ports", icon: Boxes },
  { id: "sources", label: "Source evidence", icon: RadioTower },
  { id: "generators", label: "Native generators", icon: Binary },
  { id: "detections", label: "Detection tables", icon: FileCode2 },
  { id: "library", label: "Classified library", icon: LibraryBig },
  { id: "logs", label: "Run log", icon: Terminal },
];

function count(summary: ReportData["summary"], key: string) {
  const value = summary[key];
  return typeof value === "number" ? value : 0;
}
function bytes(value: number) {
  if (!value) return "—";
  if (value < 1024) return `${value} B`;
  return `${(value / 1024).toFixed(1)} KB`;
}
function platformOf(artifact: Artifact) {
  return (artifact.measured_platform || artifact.legacy_platform_hint || "unknown").toUpperCase();
}
const MEDIUM_LABELS: Record<string, string> = {
  "c64-d64": "C64 D64 disk image", "cpc-dsk": "CPC DSK disk image", "cbm-tap": "Commodore TAP pulse tape",
  "zx-tap": "ZX TAP tape image", tzx: "TZX/CDT tape image", zip: "ZIP archive", "vice-runtime-ram": "Derived runtime RAM recovery",
};
const ROLE_LABELS: Record<LineageRole, string> = {
  source_container: "Source container", extracted_medium: "Extracted technical medium", extracted_member: "Extracted member",
  derived_recovery: "Derived recovery", retained_byte: "Retained byte",
};
function inferLineageRole(artifact: Pick<Artifact, "archive_depth" | "container_format" | "container_member" | "media_status">): LineageRole {
  if (artifact.media_status === "runtime_recovered") return "derived_recovery";
  if ((artifact.archive_depth || 0) === 0 && artifact.container_format) return "source_container";
  if (artifact.container_format) return "extracted_medium";
  if (artifact.container_member) return "extracted_member";
  return "retained_byte";
}
function mediumLabel(artifact: Pick<MatrixArtifact, "container_format" | "container_member" | "lineage_role">) {
  if (artifact.container_format) return MEDIUM_LABELS[artifact.container_format] || artifact.container_format.replaceAll("-", " ");
  if (artifact.container_member) return "Opaque extracted member";
  return artifact.lineage_role === "retained_byte" ? "Retained byte" : "No outer medium recorded";
}
function evidencePlatformLabel(artifact: Pick<MatrixArtifact, "source_platform" | "artifact_platform_hint" | "measured_platform">) {
  if (artifact.measured_platform) return `Measured DDB target: ${artifact.measured_platform.toUpperCase()}`;
  if (artifact.artifact_platform_hint) return `Artifact platform evidence: ${artifact.artifact_platform_hint.toUpperCase()}`;
  if (artifact.source_platform) return `Source platform claim: ${artifact.source_platform.toUpperCase()}`;
  return "No platform evidence recorded for this artifact";
}
function interpreterLabel(identity?: string | null) {
  return identity ? `Interpreter profile: ${identity}` : "No exact interpreter-profile match for this byte";
}
function checksumMap(artifact: Artifact): Checksums {
  return Object.fromEntries(Object.keys(CHECKSUM_LABELS).map((field) => [field, artifact[field as keyof Artifact] as string | null | undefined]));
}
function parseRoute(): Route {
  const parts = window.location.hash.replace(/^#\/?/, "").split("/").filter(Boolean);
  const requested = parts[0] as Section;
  const section = SECTIONS.some((item) => item.id === requested) ? requested : "overview";
  const candidate = parts[1] as EntityKind;
  const entity = ["game", "artifact", "source", "library"].includes(candidate) ? candidate : undefined;
  const id = entity && parts[2] ? decodeURIComponent(parts[2]) : undefined;
  const checksum = entity === "artifact" && parts[3] === "checksum" && parts[4] ? decodeURIComponent(parts[4]) : undefined;
  return { section, entity, id, checksum };
}
function routeHash(route: Route) {
  const parts: string[] = [route.section];
  if (route.entity && route.id) parts.push(route.entity, encodeURIComponent(route.id));
  if (route.entity === "artifact" && route.checksum) parts.push("checksum", encodeURIComponent(route.checksum));
  return `#${parts.join("/")}`;
}
function Status({ verified }: { verified: boolean }) {
  return <span className={verified ? "stamp stamp-verified" : "stamp"}>{verified ? "Measured DDB" : "Retained evidence"}</span>;
}

export default function Home() {
  const [data, setData] = useState<ReportData | null>(null);
  const [publicManifest, setPublicManifest] = useState<PublicArtifactManifest | null>(null);
  const [error, setError] = useState("");
  const [route, setRoute] = useState<Route>(() => parseRoute());
  const initialQuery = new URLSearchParams(window.location.search);
  const [query, setQuery] = useState(() => initialQuery.get("q") || "");
  const [platform, setPlatform] = useState(() => initialQuery.get("platform") || "ALL");
  const [copiedValue, setCopiedValue] = useState<string | null>(null);

  useEffect(() => {
    Promise.all([
      fetch(`${BASE_URL}report_data.json`, { cache: "no-store" })
        .then((response) => { if (!response.ok) throw new Error(`Report data returned ${response.status}`); return response.json() as Promise<ReportData>; }),
      fetch(`${BASE_URL}public_artifacts_manifest.json`, { cache: "no-store" })
        .then((response) => { if (!response.ok) throw new Error(`Public artifact manifest returned ${response.status}`); return response.json() as Promise<PublicArtifactManifest>; }),
    ])
      .then(([report, manifest]) => { setData(report); setPublicManifest(manifest); })
      .catch((fetchError: unknown) => setError(fetchError instanceof Error ? fetchError.message : "Report data could not be loaded."));
  }, []);
  useEffect(() => {
    const update = () => setRoute(parseRoute());
    window.addEventListener("hashchange", update);
    window.addEventListener("popstate", update);
    return () => { window.removeEventListener("hashchange", update); window.removeEventListener("popstate", update); };
  }, []);
  useEffect(() => {
    const params = new URLSearchParams();
    if (query) params.set("q", query);
    if (platform !== "ALL") params.set("platform", platform);
    const search = params.toString();
    window.history.replaceState(null, "", `${window.location.pathname}${search ? `?${search}` : ""}${routeHash(route)}`);
  }, [query, platform, route]);

  const go = (next: Route) => { window.location.hash = routeHash(next); };
  const copy = async (value: string) => {
    try { await navigator.clipboard?.writeText(value); } catch { /* keyboard text selection remains available */ }
    setCopiedValue(value); window.setTimeout(() => setCopiedValue((current) => current === value ? null : current), 1400);
  };
  const copyLink = () => copy(window.location.href);
  const platforms = useMemo(() => {
    if (!data) return ["ALL"];
    const matrixPlatforms = data.game_port_matrix.flatMap((game) => [...game.catalog_platforms, ...game.source_platforms, ...game.measured_artifact_platforms]).map((item) => item.toUpperCase());
    return ["ALL", ...Array.from(new Set([...data.catalog.artifacts.map(platformOf), ...matrixPlatforms])).sort()];
  }, [data]);
  const filteredArtifacts = useMemo(() => {
    if (!data) return [];
    const needle = query.trim().toLowerCase();
    return data.catalog.artifacts.filter((artifact) => {
      const hashes = Object.values(checksumMap(artifact)).join(" ");
      const haystack = `${artifact.original_filename} ${hashes} ${artifact.ddb_format || ""} ${artifact.interpreter_identity || ""}`.toLowerCase();
      return (platform === "ALL" || platformOf(artifact) === platform) && (!needle || haystack.includes(needle));
    });
  }, [data, platform, query]);
  const filteredGames = useMemo(() => {
    if (!data) return [];
    const needle = query.trim().toLowerCase();
    return data.game_port_matrix.filter((game) => {
      const allPlatforms = [...game.catalog_platforms, ...game.source_platforms, ...game.measured_artifact_platforms].map((item) => item.toUpperCase());
      const haystack = `${game.title} ${game.game_id} ${allPlatforms.join(" ")} ${game.artifacts.map((artifact) => `${artifact.original_filename} ${Object.values(artifact.checksums).join(" ")} ${artifact.interpreter_identity || ""} ${artifact.ddb_format || ""}`).join(" ")}`.toLowerCase();
      return (platform === "ALL" || allPlatforms.includes(platform)) && (!needle || haystack.includes(needle));
    });
  }, [data, platform, query]);
  const publicArtifactById = useMemo(
    () => new Map((publicManifest?.artifacts || []).map((artifact) => [artifact.artifact_id, artifact])),
    [publicManifest],
  );

  if (error) return <main className="empty-state"><CircleAlert size={28} /><h1>Report data is unavailable</h1><p>{error}</p><code>Run: daad-harvester --phase report --resume --output-dir &lt;output&gt;</code></main>;
  if (!data || !publicManifest) return <main className="loading-state"><Loader2 className="spin" size={28} /><span>Reading preservation ledger…</span></main>;

  const verified = count(data.summary, "verified_daad_artifacts");
  const measured = count(data.summary, "measured_artifacts");
  const sources = count(data.summary, "all_sources");
  const nativeGenerators = data.generator_evidence.generators;
  const generated = new Date(data.generated_at).toLocaleString("en-US", { dateStyle: "medium", timeStyle: "short" });
  const selectedGame = route.entity === "game" ? data.game_port_matrix.find((game) => game.game_id === route.id) : undefined;
  const selectedArtifact = route.entity === "artifact" ? data.catalog.artifacts.find((artifact) => String(artifact.id) === route.id) : undefined;
  const selectedSource = route.entity === "source" ? data.catalog.sources.find((source) => String(source.id) === route.id) : undefined;
  const selectedLibrary = route.entity === "library" ? data.library.artifacts.find((item) => item.library_path === route.id) : undefined;
  const filterControls = <div className="filters"><label className="searchbox"><Search size={15} /><span className="sr-only">Search evidence</span><input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Title, filename, hash, runtime…" /></label><label className="sr-only" htmlFor="platform-filter">Filter platform</label><select id="platform-filter" value={platform} onChange={(event) => setPlatform(event.target.value)}>{platforms.map((item) => <option key={item}>{item}</option>)}</select></div>;
  const DetailHeader = ({ eyebrow, title, parent }: { eyebrow: string; title: string; parent: Section }) => <header className="detail-heading"><div><a className="back-link" href={routeHash({ section: parent })}><ChevronLeft size={15} /> Back to {parent}</a><p className="eyebrow">{eyebrow}</p><h1>{title}</h1></div><button className="share-link" onClick={copyLink}><Link2 size={15} /> {copiedValue === window.location.href ? "Link copied" : "Copy share link"}</button></header>;
  const ChecksumRows = ({ checksums, artifactId, section }: { checksums: Checksums; artifactId: number; section: Section }) => <div className="checksum-list">{Object.entries(CHECKSUM_LABELS).map(([field, label]) => {
    const value = checksums[field]; const active = route.checksum === field;
    return <div className={active ? "checksum-row active" : "checksum-row"} id={`checksum-${artifactId}-${field}`} key={field}><span>{label}</span><code>{value || "not recorded"}</code>{value ? <><a href={routeHash({ section, entity: "artifact", id: String(artifactId), checksum: field })}>Link</a><button onClick={() => copy(value)} aria-label={`Copy ${label}`}>{copiedValue === value ? "Copied" : "Copy"}</button></> : <em>Integrity record absent</em>}</div>;
  })}</div>;
  const ArtifactEvidenceFields = ({ artifact, source }: { artifact: Artifact; source?: Source }) => {
    const lineageRole = inferLineageRole(artifact);
    const platformEvidence = evidencePlatformLabel({
      source_platform: source?.platform,
      artifact_platform_hint: artifact.legacy_platform_hint,
      measured_platform: artifact.measured_platform,
    });
    return <dl className="artifact-evidence-fields">
      <div><dt>Artifact ID</dt><dd>{artifact.id}</dd></div>
      <div><dt>Lineage role</dt><dd>{ROLE_LABELS[lineageRole]}</dd></div>
      <div><dt>Source platform claim</dt><dd>{source?.platform?.toUpperCase() || "Not recorded"}</dd></div>
      <div><dt>Artifact platform evidence</dt><dd>{platformEvidence}</dd></div>
      <div><dt>Technical medium</dt><dd>{mediumLabel({ container_format: artifact.container_format, container_member: artifact.container_member, lineage_role: lineageRole })}</dd></div>
      <div><dt>Parent member</dt><dd>{artifact.container_member || "Not a child member"}</dd></div>
      <div><dt>Parser result</dt><dd>{artifact.media_parser ? `${artifact.media_parser} · ${artifact.media_status || "recorded"} · ${artifact.media_validation || "no validation text"}` : "No native structural signature was recognized for this byte"}</dd></div>
      <div><dt>DDB measurement</dt><dd>{artifact.ddb_format || "No DDB structure measured"}</dd></div>
      <div><dt>Interpreter boundary</dt><dd>{interpreterLabel(artifact.interpreter_identity)}</dd></div>
      <div><dt>File size</dt><dd>{bytes(artifact.file_size)}</dd></div>
    </dl>;
  };
  const ArtifactDetail = ({ artifact, parent }: { artifact: Artifact; parent: Section }) => {
    const source = data.catalog.sources.find((item) => item.id === artifact.source_id);
    const publicArtifact = publicArtifactById.get(artifact.id);
    return <section className="entity-detail"><DetailHeader eyebrow="RETAINED ARTIFACT / FULL INTEGRITY RECORD" title={artifact.original_filename} parent={parent} /><div className="detail-grid"><article className="detail-card"><Status verified={artifact.is_daad_payload} /><ArtifactEvidenceFields artifact={artifact} source={source} />{publicArtifact ? <a className="download-button artifact-download" href={`${BASE_URL}${publicArtifact.public_path}`} download><Download size={16} /> Download retained byte</a> : <p className="download-boundary">This export has no manifest-approved public path for the selected artifact.</p>}{source && <a className="related-link" href={routeHash({ section: "sources", entity: "source", id: String(source.id) })}><RadioTower size={14} /> Open source evidence <ChevronRight size={14} /></a>}</article><article className="detail-card checksum-card"><h2>All recorded checksums</h2><p>Every digest identifies this exact retained byte sequence. The downloadable byte is staged from the checked manifest; its declared SHA-256 is <code>{publicArtifact?.checksums.sha256 || artifact.sha256}</code>.</p><ChecksumRows checksums={checksumMap(artifact)} artifactId={artifact.id} section={parent} /></article></div></section>;
  };
  const FormatLegend = () => <section className="format-legend" aria-labelledby="format-legend-title"><div><p className="eyebrow">FORMAT AND LINEAGE LEGEND</p><h3 id="format-legend-title">Read every retained byte in context.</h3><p>Containers hold recorded media; extracted members come from them; derived recoveries are separately retained validation outputs. A source platform is provenance, while a measured DDB target comes only from structural analysis.</p></div><dl><div><dt>D64 / DSK</dt><dd>Disk-image containers; directory members remain separate bytes.</dd></div><div><dt>TAP / TZX / CDT</dt><dd>Tape-image containers; blocks or packet recoveries are child evidence.</dd></div><div><dt>ZIP</dt><dd>Archive container; it is not a platform measurement.</dd></div><div><dt>PIC / other member</dt><dd>Filename alone does not establish content semantics; the parser result states the available evidence.</dd></div><div><dt>DDB</dt><dd>Only a structurally validated game database has a measured DDB target.</dd></div></dl></section>;
  const GameArtifactList = ({ artifacts, section }: { artifacts: MatrixArtifact[]; section: Section }) => <div className="game-artifacts complete-artifact-list" aria-label="Complete source-associated retained artifact list">{artifacts.map((artifact) => <article className="game-artifact" key={artifact.artifact_id}><div><a href={routeHash({ section, entity: "artifact", id: String(artifact.artifact_id) })}><strong>{artifact.original_filename}</strong><span>{ROLE_LABELS[artifact.lineage_role]} · {mediumLabel(artifact)} · {bytes(artifact.file_size)}</span></a><small className="artifact-evidence-summary">{evidencePlatformLabel(artifact)} · {artifact.media_parser ? `${artifact.media_parser}: ${artifact.media_status || "recorded"}` : "No native structural signature recognized"} · {interpreterLabel(artifact.interpreter_identity)}</small></div><div className="hash-control"><code title={artifact.sha256}>{artifact.sha256}</code><a href={routeHash({ section, entity: "artifact", id: String(artifact.artifact_id), checksum: "sha256" })}>All checksums</a></div></article>)}</div>;
  const GameDetail = ({ game }: { game: GamePortMatrix }) => {
    const gameSources = data.catalog.sources.filter((source) => source.known_game_id === game.game_id);
    return <section className="entity-detail"><DetailHeader eyebrow="GAME / PLATFORM EVIDENCE" title={game.title} parent="games" /><p className="detail-boundary">{game.boundary}</p><div className="evidence-layers detail-layers"><div><span>Catalog platforms</span><p>{game.catalog_platforms.length ? game.catalog_platforms.map((item) => <i className="platform-tag" key={item}>{item.toUpperCase()}</i>) : <em>Not recorded</em>}</p></div><div><span>Source platforms</span><p>{game.source_platforms.length ? game.source_platforms.map((item) => <i className="platform-tag" key={item}>{item.toUpperCase()}</i>) : <em>No matched source</em>}</p></div><div><span>Measured DDB targets</span><p>{game.measured_artifact_platforms.length ? game.measured_artifact_platforms.map((item) => <i className="platform-tag measured-platform" key={item}>{item.toUpperCase()}</i>) : <em>No measured DDB target</em>}</p></div></div><FormatLegend /><div className="detail-grid"><article className="detail-card"><h2>Recorded sources</h2>{gameSources.length ? <ul className="entity-list">{gameSources.map((source) => <li key={source.id}><a href={routeHash({ section: "sources", entity: "source", id: String(source.id) })}><strong>{source.title || `Source ${source.id}`}</strong><span>{source.platform?.toUpperCase() || "UNKNOWN"} · {source.status}</span></a></li>)}</ul> : <p>No source record was exported for this title.</p>}</article><article className="detail-card complete-artifact-card"><h2>Complete source-associated retained artifacts</h2><p>All {game.artifacts.length} records are shown in deterministic source and lineage order. Open any record for its complete provenance, parser boundary, download, and 17 checksums.</p>{game.artifacts.length ? <GameArtifactList artifacts={game.artifacts} section="games" /> : <p>No source-associated retained artifact is present in this report export.</p>}</article></div></section>;
  };
  const SourceDetail = ({ source }: { source: Source }) => {
    const linked = data.catalog.artifacts.filter((artifact) => artifact.source_id === source.id);
    return <section className="entity-detail"><DetailHeader eyebrow="SOURCE / PORT EVIDENCE" title={source.title || `Source ${source.id}`} parent="sources" /><div className="detail-grid"><article className="detail-card"><dl><div><dt>Source ID</dt><dd>{source.id}</dd></div><div><dt>Platform claim</dt><dd>{source.platform?.toUpperCase() || "Not recorded"}</dd></div><div><dt>Status</dt><dd>{source.status}</dd></div><div><dt>Role</dt><dd>{source.source_role || "Not recorded"}</dd></div><div><dt>Priority</dt><dd>{source.priority}</dd></div></dl><a className="related-link" href={source.url} target="_blank" rel="noreferrer"><ExternalLink size={14} /> Recorded public source <ChevronRight size={14} /></a></article><article className="detail-card"><h2>Retained artifacts from this source</h2>{linked.length ? <ul className="entity-list">{linked.map((artifact) => <li key={artifact.id}><a href={routeHash({ section: "sources", entity: "artifact", id: String(artifact.id) })}><strong>{artifact.original_filename}</strong><span>{platformOf(artifact)} · SHA-256 {artifact.sha256.slice(0, 16)}…</span></a></li>)}</ul> : <p>No retained artifact is associated with this source.</p>}</article></div></section>;
  };
  const LibraryDetail = ({ item }: { item: LibraryItem }) => <section className="entity-detail"><DetailHeader eyebrow="CLASSIFIED LIBRARY RECORD" title={item.title} parent="library" /><div className="detail-grid"><article className="detail-card"><dl><div><dt>Platform</dt><dd>{item.platform.toUpperCase()}</dd></div><div><dt>Classification</dt><dd>{item.classification.replaceAll("_", " ")}</dd></div><div><dt>Original filename</dt><dd>{item.original_filename}</dd></div><div><dt>Binary verification</dt><dd>{item.binary_verified_daad ? "Measured DDB" : "Retained evidence"}</dd></div></dl></article><article className="detail-card"><h2>Evidence navigation</h2><p>The public report publishes classification metadata, not retained binary payloads. Use the game explorer to inspect linked catalog and artifact evidence.</p><button className="drawer-link" onClick={() => { setQuery(item.title); setPlatform("ALL"); go({ section: "games" }); }}>Search game evidence <ChevronRight size={15} /></button></article></div></section>;

  let content: ReactElement;
  if (selectedGame) content = <GameDetail game={selectedGame} />;
  else if (selectedArtifact) content = <ArtifactDetail artifact={selectedArtifact} parent={route.section} />;
  else if (selectedSource) content = <SourceDetail source={selectedSource} />;
  else if (selectedLibrary) content = <LibraryDetail item={selectedLibrary} />;
  else if (route.entity) content = <section className="empty-entity"><CircleAlert size={24} /><h1>Evidence record not present in this export</h1><p>The shared link is valid in shape but its entity ID is not in the currently loaded report. It may refer to another measured report revision.</p><a href={routeHash({ section: route.section })}>Return to {route.section}</a></section>;
  else if (route.section === "overview") content = <><section className="hero-panel" style={{ backgroundImage: `linear-gradient(90deg, rgba(8,12,11,.98) 0%, rgba(8,12,11,.76) 54%, rgba(8,12,11,.3) 100%), url(${ASSETS.hero})` }}><div className="timeline-instrument"><div className="timeline-head"><span className="eyebrow">HORIZONTAL PRESERVATION TIMELINE</span><span>EXPORT / {generated}</span></div><div className="timeline-stages"><div><i /><span>SOURCE CLAIM</span><b>{sources} ledger records</b></div><div><i /><span>MEASURED ARTIFACT</span><b>{measured} retained binaries</b></div><div className="verified-stage"><i /><span>VERIFIED RUNTIME</span><b>{verified} evidenced payloads</b></div></div></div><div className="hero-copy"><p className="eyebrow">DAAD PRESERVATION REPORT</p><h1>Trace the database,<br /><em>not the rumor.</em></h1><p>DAAD Harvester preserves the evidence chain across ZX Spectrum, Amstrad CPC, Commodore 64, Plus/4, MSX, PCW, Atari ST, Amiga, and IBM PC/DOS. It separates catalog claims, retained media, measured DDB structure, and interpreter identity without manufacturing certainty.</p><div className="hero-actions"><a href={routeHash({ section: "games" })}>Explore games and ports <ChevronRight size={16} /></a><a className="quiet" href={routeHash({ section: "ledger" })}>Inspect recorded artifacts</a></div></div><div className="hero-trace"><span>STATUS</span><b>{verified ? "VERIFIED" : "NO CLAIM"}</b><i /></div></section><section className="metrics-strip" aria-label="Recorded preservation metrics"><article><span>KNOWN TITLES</span><strong>{count(data.summary, "known_games")}</strong><small>Catalog evidence rows</small></article><article><span>MEASURED ARTIFACTS</span><strong>{measured}</strong><small>{verified} structurally verified DDBs</small></article><article><span>SOURCE LEDGER</span><strong>{sources}</strong><small>{count(data.summary, "queued_known_sources")} evidence-led candidates</small></article><article><span>DETECTION ENTRIES</span><strong>{data.detections.entry_count}</strong><small>{data.detections.available ? "Header available" : "No measured entries yet"}</small></article></section><section className="split-section trace-section"><div className="section-intro"><p className="eyebrow">CONTRACT</p><h2>Every number has a boundary.</h2><p>{data.policy.unknowns}</p><a className="inline-action" href={routeHash({ section: "ledger" })}>Open evidence ledger <ChevronRight size={16} /></a></div><div className="policy-list">{Object.entries(data.policy).map(([key, value]) => <div key={key}><span>{key.replaceAll("_", " ")}</span><p>{value}</p></div>)}</div></section><section className="specimen-row trace-section"><article className="specimen-card" style={{ backgroundImage: `linear-gradient(0deg, rgba(8,12,11,.8), transparent), url(${ASSETS.tape})` }}><span>SPECTRUM / CPC</span><strong>Tape blocks retain their control evidence.</strong><i>SOURCE CLAIM</i></article><article className="specimen-card" style={{ backgroundImage: `linear-gradient(0deg, rgba(8,12,11,.8), transparent), url(${ASSETS.disk})` }}><span>DISK MEDIA</span><strong>Geometry precedes extraction.</strong><i>MEASURED ARTIFACT</i></article><article className="specimen-card" style={{ backgroundImage: `linear-gradient(0deg, rgba(8,12,11,.8), transparent), url(${ASSETS.forensic})` }}><span>BINARY FORENSICS</span><strong>Hash identity is never a filename guess.</strong><i>VERIFIED RUNTIME</i></article></section></>;
  else if (route.section === "ledger") content = <section className="ledger-view"><div className="view-heading"><div><p className="eyebrow">SOURCE → ARTIFACT → MEASUREMENT</p><h2>Evidence ledger</h2><p>{filteredArtifacts.length} retained records match the URL-persisted filter.</p></div>{filterControls}</div><div className="ledger-table-wrap"><table><thead><tr><th>Artifact</th><th>Platform</th><th>Measurement</th><th>Runtime evidence</th><th>Size</th><th>Detail</th></tr></thead><tbody>{filteredArtifacts.slice(0, 80).map((artifact) => <tr key={artifact.id}><td><a className="entity-link" href={routeHash({ section: "ledger", entity: "artifact", id: String(artifact.id) })}><strong>{artifact.original_filename}</strong><span>{artifact.sha256.slice(0, 20)}…</span></a></td><td><span className="platform-tag">{platformOf(artifact)}</span></td><td><Status verified={artifact.is_daad_payload} /><span>{artifact.ddb_format || "No DDB claim"}</span></td><td>{artifact.interpreter_identity || "Not correlated"}</td><td>{bytes(artifact.file_size)}</td><td><a className="inspect" href={routeHash({ section: "ledger", entity: "artifact", id: String(artifact.id) })}>Open record</a></td></tr>)}</tbody></table>{filteredArtifacts.length > 80 && <p className="table-note">Showing first 80 matching records. Narrow the instrument filter to continue.</p>}</div></section>;
  else if (route.section === "games") content = <section className="games-view"><div className="view-heading"><div><p className="eyebrow">TITLE → SOURCE → RETAINED ARTIFACT</p><h2>Game and platform evidence</h2><p>Every matching game card shows its complete retained-artifact lineage by default. Catalog, source, and measured DDB-target layers remain distinct.</p></div>{filterControls}</div><div className="explorer-boundary"><ShieldCheck size={17} /><span>{filteredGames[0]?.boundary || "No game/port evidence matrix was exported for this report state."}</span></div><FormatLegend /><div className="game-grid">{filteredGames.slice(0, 40).map((game) => <article className="game-card" key={game.game_id}><header><div><span className="eyebrow">{game.game_id}</span><h3><a href={routeHash({ section: "games", entity: "game", id: game.game_id })}>{game.title}</a></h3></div><span className="source-count">{game.source_count} sources · {game.artifacts.length} complete records</span></header><div className="evidence-layers"><div><span>Catalog platforms</span><p>{game.catalog_platforms.length ? game.catalog_platforms.map((item) => <i className="platform-tag" key={item}>{item.toUpperCase()}</i>) : <em>Not recorded</em>}</p></div><div><span>Source platforms</span><p>{game.source_platforms.length ? game.source_platforms.map((item) => <i className="platform-tag" key={item}>{item.toUpperCase()}</i>) : <em>No matched source</em>}</p></div><div><span>Measured DDB targets</span><p>{game.measured_artifact_platforms.length ? game.measured_artifact_platforms.map((item) => <i className="platform-tag measured-platform" key={item}>{item.toUpperCase()}</i>) : <em>No measured DDB target</em>}</p></div></div><a className="open-entity" href={routeHash({ section: "games", entity: "game", id: game.game_id })}>Open game, ports & evidence <ChevronRight size={15} /></a>{game.artifacts.length ? <GameArtifactList artifacts={game.artifacts} section="games" /> : <div className="empty-evidence">No source-associated retained artifact is present in this report export.</div>}</article>)}</div>{filteredGames.length > 40 && <p className="table-note">Showing the first 40 matching titles. Narrow the explorer filter to inspect more.</p>}</section>;
  else if (route.section === "sources") content = <section className="ledger-view"><div className="view-heading"><div><p className="eyebrow">PROVENANCE → RETAINED EVIDENCE</p><h2>Source evidence</h2><p>Open a source to view its platform claim and associated retained artifacts without treating the source page as a binary.</p></div>{filterControls}</div><div className="source-grid">{data.catalog.sources.filter((source) => { const needle = query.toLowerCase(); return !needle || `${source.title || ""} ${source.url} ${source.platform || ""}`.toLowerCase().includes(needle); }).slice(0, 80).map((source) => <article key={source.id}><span className="platform-tag">{source.platform?.toUpperCase() || "UNKNOWN"}</span><h3><a href={routeHash({ section: "sources", entity: "source", id: String(source.id) })}>{source.title || `Source ${source.id}`}</a></h3><p>{source.status} · {source.source_role || "recorded source"}</p><a className="open-entity" href={routeHash({ section: "sources", entity: "source", id: String(source.id) })}>Open provenance <ChevronRight size={15} /></a></article>)}</div></section>;
  else if (route.section === "generators") content = <section className="generator-view"><div className="view-heading"><div><p className="eyebrow">REPOSITORY-NATIVE FORMAT GENERATION</p><h2>Generator evidence</h2><p>These are generated technical-media fixtures that the primary workflow rebuilds and validates without a network or external GUI tool. A structurally valid container is not automatically a populated filesystem, authentic historical release, or executable target image.</p></div><span className="generator-count">{nativeGenerators.length} CI-gated {nativeGenerators.length === 1 ? "generator" : "generators"}</span></div><p className="detection-boundary">{data.generator_evidence.boundary}</p>{nativeGenerators.length ? <div className="generator-grid">{nativeGenerators.map((generator) => <article className="generator-card" key={generator.generator_id}><header><div><p className="eyebrow">{generator.technical_medium.replaceAll("_", " ")}</p><h3>{generator.generator_id}</h3></div><span className="stamp stamp-verified">{generator.status.replaceAll("_", " ")}</span></header><dl className="generator-facts"><div><dt>Declared input profile</dt><dd>{generator.inputs.profile || "Not recorded"}</dd></div><div><dt>Filesystem claim</dt><dd>{generator.inputs.filesystem_claim || "Not recorded"}</dd></div><div><dt>Native validation</dt><dd>{generator.native_validation.validation}</dd></div><div><dt>Inspector</dt><dd>{generator.native_validation.parser} · {generator.native_validation.status}</dd></div><div><dt>Output size</dt><dd>{bytes(generator.output.byte_length)}</dd></div></dl><section className="generator-checksums" aria-label={`Generated output checksums for ${generator.generator_id}`}><h4>All generated-output checksums</h4>{Object.entries(CHECKSUM_LABELS).map(([field, label]) => { const value = generator.output.checksums[field]; return <div key={field}><span>{label}</span><code>{value || "not recorded"}</code>{value && <button onClick={() => copy(value)}><Copy size={13} /> {copiedValue === value ? "Copied" : "Copy"}</button>}</div>; })}</section><section className="generator-evidence"><h4>Measured container evidence</h4><dl>{Object.entries(generator.native_validation.evidence).map(([key, value]) => <div key={key}><dt>{key.replaceAll("_", " ")}</dt><dd>{Array.isArray(value) ? value.join("; ") : value !== null && typeof value === "object" ? JSON.stringify(value) : String(value)}</dd></div>)}</dl></section><section className="generator-boundaries"><h4>Comparison boundary</h4><dl>{Object.entries(generator.comparison_boundary).map(([key, value]) => <div key={key}><dt>{key.replaceAll("_", " ")}</dt><dd>{value.replaceAll("_", " ")}</dd></div>)}</dl></section></article>)}</div> : <section className="empty-evidence">No native generator evidence was exported for this report revision.</section>}</section>;
  else if (route.section === "detections") content = <section className="code-view"><div className="view-heading"><div><p className="eyebrow">SCUMMVM HANDOFF</p><h2>Detection tables</h2><p>Generated only from deterministic catalog state. This export contains {data.detections.entry_count} entries; it is detection metadata, not a universal engine or playability claim.</p></div>{data.detections.available && data.detections.download_path ? <a className="download-button" href={`${BASE_URL}${data.detections.download_path}`} download><Download size={16} /> Download .h</a> : <span className="disabled-download">No header generated</span>}</div><div className="detection-provenance"><div><span>Generator</span><code>{data.detections.generator || "Not recorded"}</code></div><div><span>Input catalog</span><code>{data.detections.input_catalog || "Not recorded"}</code></div><div className="detection-hash"><span>Header SHA-256</span><code>{data.detections.sha256 || "Unavailable"}</code>{data.detections.sha256 && <button onClick={() => copy(data.detections.sha256!)}><Copy size={13} /> {copiedValue === data.detections.sha256 ? "Copied" : "Copy"}</button>}</div></div><p className="detection-boundary">{data.detections.boundary || "Generated detection metadata has no additional engine or runtime claim."}</p><pre>{data.detections.preview || "// No detection table has been generated for this report state.\n// Retained artifacts remain accessible through the evidence ledger."}</pre></section>;
  else if (route.section === "library") content = <section className="library-view"><div className="view-heading"><div><p className="eyebrow">MATERIALIZED OUTPUT</p><h2>Classified library</h2><p>Every card opens its classification detail and a contextual route to measured game evidence. Public Pages publishes metadata, not the retained binary tree.</p></div><div className="library-counts">{Object.entries(data.library.summary).map(([label, value]) => <span key={label}>{value} {label.replaceAll("_", " ")}</span>)}</div></div><div className="library-grid">{data.library.artifacts.slice(0, 60).map((item, index) => <article key={`${item.library_path}-${index}`}><div><span className="platform-tag">{item.platform.toUpperCase()}</span><Status verified={item.binary_verified_daad} /></div><h3><a href={routeHash({ section: "library", entity: "library", id: item.library_path })}>{item.title}</a></h3><p>{item.original_filename}</p><footer><span>{item.classification.replaceAll("_", " ")}</span><a href={routeHash({ section: "library", entity: "library", id: item.library_path })}>Open record <ChevronRight size={14} /></a></footer></article>)}</div></section>;
  else content = <section className="log-view"><div className="view-heading"><div><p className="eyebrow">OPERATIONAL RECORD</p><h2>Pipeline log tail</h2><p>Latest retained lines from the export directory. This view does not synthesize run events.</p></div></div>{Object.entries(data.logs).map(([name, lines]) => <article key={name}><h3><Terminal size={15} /> {name}.log</h3><pre>{lines.length ? lines.join("\n") : "No retained lines were supplied by this report export."}</pre></article>)}</section>;

  return <div className="archive-shell"><aside className="evidence-rail"><div className="brand-lockup"><img src={ASSETS.mark} alt="DAAD Harvester signal mark" /><div><span>DAAD</span><strong>Harvester</strong></div></div><div className="rail-label">Evidence navigation</div><nav>{SECTIONS.map(({ id, label, icon: Icon }) => <a key={id} className={route.section === id && !route.entity ? "rail-nav active" : "rail-nav"} href={routeHash({ section: id })}><Icon size={16} /><span>{label}</span><ChevronRight size={14} /></a>)}<a className="rail-nav documentation-link" href={`${BASE_URL}documentation/index.html`}><BookOpen size={16} /><span>Project documentation</span><ExternalLink size={14} /></a></nav><div className="rail-foot"><RadioTower size={14} /><span>Static report<br />schema v1</span></div></aside><main className="report-canvas"><header className="topline"><span><span className="pulse-dot" /> PRESERVATION EVIDENCE / LIVE EXPORT</span><span>Generated {generated}</span></header>{content}{route.section === "overview" && !route.entity && <section className="orientation-panel"><div><p className="eyebrow">HOW TO READ THIS EXPORT</p><h2>One archive, four distinct kinds of evidence.</h2><p>DAAD Harvester is a digital-preservation pipeline for public, authorized DAAD game evidence across ZX Spectrum, Amstrad CPC, Commodore 64, Plus/4, MSX, Amstrad PCW, Atari ST, Amiga, and IBM PC/DOS. It records source claims, retained technical media such as tapes, disk images, archive members and executables, structural measurements, and interpreter correlations as separate layers.</p><p>This portal does not convert a filename into a platform claim, a source page into a byte identity, or a measured structure into a playability assertion.</p></div><div className="orientation-paths"><article><span>READER</span><h3>Trace a title across ports.</h3><p>Start with the game-and-port matrix, then follow source and artifact links only where the report has recorded them.</p><a href={routeHash({ section: "games" })}>Explore games and ports <ChevronRight size={15} /></a></article><article><span>PRESERVER</span><h3>Verify the retained byte.</h3><p>Open an artifact record to download its manifest-staged byte, inspect all 17 digests, and share a checksum-specific URL.</p><a href={routeHash({ section: "ledger" })}>Inspect artifact evidence <ChevronRight size={15} /></a></article><article><span>IMPLEMENTER</span><h3>Review measured handoff data.</h3><p>Read the generated detection table with its provenance and use the linked documentation to reproduce the deterministic evidence workflow.</p><a href={routeHash({ section: "detections" })}>Open detection tables <ChevronRight size={15} /></a></article></div></section>}</main></div>;
}
