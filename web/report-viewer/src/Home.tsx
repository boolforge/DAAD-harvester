/**
 * Phosphor Archive design: asymmetric evidence rail, graphite field, Archive
 * Phosphor verification color, and compact archival typography. Every figure
 * is derived from /report_data.json; unknown values remain visually explicit.
 */
import { useEffect, useMemo, useState } from "react";
import {
  Archive, Binary, BookOpen, Boxes, ChevronRight, CircleAlert, Copy, Database,
  Download, ExternalLink, FileCode2, FileText, LibraryBig, Loader2, RadioTower,
  Search, ShieldCheck, Terminal, X,
} from "lucide-react";

const BASE_URL = import.meta.env.BASE_URL;
const ASSETS = {
  hero: `${BASE_URL}media/daad-archive-hero.png`,
  tape: `${BASE_URL}media/daad-spectrum-tape-specimen.png`,
  disk: `${BASE_URL}media/daad-disk-specimen.png`,
  forensic: `${BASE_URL}media/daad-binary-forensics.png`,
  mark: `${BASE_URL}media/daad-harvester-signal-mark.png`,
};

type Artifact = {
  id: number;
  source_id: number;
  original_filename: string;
  sha256: string;
  file_size: number;
  is_daad_payload: boolean;
  measured_platform?: string | null;
  legacy_platform_hint?: string | null;
  ddb_format?: string | null;
  interpreter_identity?: string | null;
  fingerprint_confidence?: string | null;
  version_evidence?: Array<{ kind: string; value: string; confidence: string }>;
};

type Source = {
  id: number;
  title?: string | null;
  url: string;
  platform?: string | null;
  status: string;
  source_role?: string | null;
  priority: number;
};

type ReportData = {
  generated_at: string;
  summary: Record<string, number | Record<string, number>>;
  policy: Record<string, string>;
  catalog: { sources: Source[]; artifacts: Artifact[]; games: Array<{ game_id: string; title: string; platform_evidence: string[] }> };
  detections: { available: boolean; download_path: string | null; entry_count: number; preview: string };
  library: { summary: Record<string, number>; artifacts: Array<{ title: string; platform: string; classification: string; ready_to_use: boolean; library_path: string; original_filename: string; binary_verified_daad: boolean }> };
  logs: Record<string, string[]>;
};

type View = "overview" | "ledger" | "detections" | "library" | "logs";

const NAV: Array<{ id: View; label: string; icon: typeof Archive }> = [
  { id: "overview", label: "Preservation brief", icon: Archive },
  { id: "ledger", label: "Evidence ledger", icon: Database },
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

function Status({ verified }: { verified: boolean }) {
  return <span className={verified ? "stamp stamp-verified" : "stamp"}>{verified ? "Measured DDB" : "Retained evidence"}</span>;
}

export default function Home() {
  const [data, setData] = useState<ReportData | null>(null);
  const [error, setError] = useState("");
  const [view, setView] = useState<View>("overview");
  const [query, setQuery] = useState("");
  const [platform, setPlatform] = useState("ALL");
  const [selected, setSelected] = useState<Artifact | null>(null);
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    fetch(`${BASE_URL}report_data.json`, { cache: "no-store" })
      .then((response) => {
        if (!response.ok) throw new Error(`Report data returned ${response.status}`);
        return response.json() as Promise<ReportData>;
      })
      .then(setData)
      .catch((fetchError: unknown) => setError(fetchError instanceof Error ? fetchError.message : "Report data could not be loaded."));
  }, []);

  const platforms = useMemo(() => {
    if (!data) return ["ALL"];
    return ["ALL", ...Array.from(new Set(data.catalog.artifacts.map(platformOf))).sort()];
  }, [data]);

  const filteredArtifacts = useMemo(() => {
    if (!data) return [];
    const needle = query.trim().toLowerCase();
    return data.catalog.artifacts.filter((artifact) => {
      const matchesPlatform = platform === "ALL" || platformOf(artifact) === platform;
      const haystack = `${artifact.original_filename} ${artifact.sha256} ${artifact.ddb_format || ""} ${artifact.interpreter_identity || ""}`.toLowerCase();
      return matchesPlatform && (!needle || haystack.includes(needle));
    });
  }, [data, platform, query]);

  const copyHash = async (hash: string) => {
    await navigator.clipboard?.writeText(hash);
    setCopied(true);
    window.setTimeout(() => setCopied(false), 1400);
  };

  if (error) {
    return <main className="empty-state"><CircleAlert size={28} /><h1>Report data is unavailable</h1><p>{error}</p><code>Run: daad-harvester --phase report --resume --output-dir &lt;output&gt;</code></main>;
  }
  if (!data) {
    return <main className="loading-state"><Loader2 className="spin" size={28} /><span>Reading preservation ledger…</span></main>;
  }

  const verified = count(data.summary, "verified_daad_artifacts");
  const measured = count(data.summary, "measured_artifacts");
  const sources = count(data.summary, "all_sources");
  const generated = new Date(data.generated_at).toLocaleString("en-US", { dateStyle: "medium", timeStyle: "short" });

  return (
    <div className="archive-shell">
      <aside className="evidence-rail">
        <div className="brand-lockup"><img src={ASSETS.mark} alt="DAAD Harvester signal mark" /><div><span>DAAD</span><strong>Harvester</strong></div></div>
        <div className="rail-label">Evidence navigation</div>
        <nav>{NAV.map(({ id, label, icon: Icon }) => <button key={id} className={view === id ? "rail-nav active" : "rail-nav"} onClick={() => setView(id)}><Icon size={16} /><span>{label}</span><ChevronRight size={14} /></button>)}</nav>
        <div className="rail-foot"><RadioTower size={14} /><span>Static report<br />schema v1</span></div>
      </aside>

      <main className="report-canvas">
        <header className="topline"><span><span className="pulse-dot" /> PRESERVATION EVIDENCE / LIVE EXPORT</span><span>Generated {generated}</span></header>

        {view === "overview" && <>
          <section className="hero-panel" style={{ backgroundImage: `linear-gradient(90deg, rgba(8,12,11,.98) 0%, rgba(8,12,11,.76) 54%, rgba(8,12,11,.3) 100%), url(${ASSETS.hero})` }}>
            <div className="timeline-instrument"><div className="timeline-head"><span className="eyebrow">HORIZONTAL PRESERVATION TIMELINE</span><span>EXPORT / {generated}</span></div><div className="timeline-stages"><div><i /><span>SOURCE CLAIM</span><b>{sources} ledger records</b></div><div><i /><span>MEASURED ARTIFACT</span><b>{measured} retained binaries</b></div><div className="verified-stage"><i /><span>VERIFIED RUNTIME</span><b>{verified} evidenced payloads</b></div></div></div>
            <div className="hero-copy"><p className="eyebrow">DAAD PRESERVATION REPORT</p><h1>Trace the database,<br /><em>not the rumor.</em></h1><p>One static ledger separates source claims, retained media, measured DDB structure, and interpreter identity without manufacturing certainty.</p><div className="hero-actions"><button onClick={() => setView("ledger")}>Inspect recorded artifacts <ChevronRight size={16} /></button><button className="quiet" onClick={() => setView("library")}>Browse retained library</button></div></div>
            <div className="hero-trace"><span>STATUS</span><b>{verified ? "VERIFIED" : "NO CLAIM"}</b><i /></div>
          </section>

          <section className="metrics-strip" aria-label="Recorded preservation metrics">
            <article><span>KNOWN TITLES</span><strong>{count(data.summary, "known_games")}</strong><small>Catalog evidence rows</small></article>
            <article><span>MEASURED ARTIFACTS</span><strong>{measured}</strong><small>{verified} structurally verified DDBs</small></article>
            <article><span>SOURCE LEDGER</span><strong>{sources}</strong><small>{count(data.summary, "queued_known_sources")} evidence-led candidates</small></article>
            <article><span>DETECTION ENTRIES</span><strong>{data.detections.entry_count}</strong><small>{data.detections.available ? "Header available" : "No measured entries yet"}</small></article>
          </section>

          <section className="split-section trace-section"><div className="section-intro"><p className="eyebrow">CONTRACT</p><h2>Every number has a boundary.</h2><p>{data.policy.unknowns}</p><button onClick={() => setView("ledger")}>Open evidence ledger <ChevronRight size={16} /></button></div><div className="policy-list">{Object.entries(data.policy).map(([key, value]) => <div key={key}><span>{key.replaceAll("_", " ")}</span><p>{value}</p></div>)}</div></section>

          <section className="specimen-row trace-section"><article className="specimen-card" style={{ backgroundImage: `linear-gradient(0deg, rgba(8,12,11,.8), transparent), url(${ASSETS.tape})` }}><span>SPECTRUM / CPC</span><strong>Tape blocks retain their control evidence.</strong><i>SOURCE CLAIM</i></article><article className="specimen-card" style={{ backgroundImage: `linear-gradient(0deg, rgba(8,12,11,.8), transparent), url(${ASSETS.disk})` }}><span>DISK MEDIA</span><strong>Geometry precedes extraction.</strong><i>MEASURED ARTIFACT</i></article><article className="specimen-card" style={{ backgroundImage: `linear-gradient(0deg, rgba(8,12,11,.8), transparent), url(${ASSETS.forensic})` }}><span>BINARY FORENSICS</span><strong>Hash identity is never a filename guess.</strong><i>VERIFIED RUNTIME</i></article></section>
        </>}

        {view === "ledger" && <section className="ledger-view"><div className="view-heading"><div><p className="eyebrow">SOURCE → ARTIFACT → MEASUREMENT</p><h2>Evidence ledger</h2><p>{filteredArtifacts.length} retained records match the active instrument filter.</p></div><div className="filters"><div className="searchbox"><Search size={15} /><input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Filename, hash, runtime…" /></div><select value={platform} onChange={(event) => setPlatform(event.target.value)}>{platforms.map((item) => <option key={item}>{item}</option>)}</select></div></div><div className="ledger-table-wrap"><table><thead><tr><th>Artifact</th><th>Platform</th><th>Measurement</th><th>Runtime evidence</th><th>Size</th><th /></tr></thead><tbody>{filteredArtifacts.slice(0, 80).map((artifact) => <tr key={artifact.id}><td><strong>{artifact.original_filename}</strong><span>{artifact.sha256.slice(0, 20)}…</span></td><td><span className="platform-tag">{platformOf(artifact)}</span></td><td><Status verified={artifact.is_daad_payload} /><span>{artifact.ddb_format || "No DDB claim"}</span></td><td>{artifact.interpreter_identity || "Not correlated"}</td><td>{bytes(artifact.file_size)}</td><td><button className="inspect" onClick={() => setSelected(artifact)}>Inspect</button></td></tr>)}</tbody></table>{filteredArtifacts.length > 80 && <p className="table-note">Showing first 80 matching records. Narrow the instrument filter to continue.</p>}</div></section>}

        {view === "detections" && <section className="code-view"><div className="view-heading"><div><p className="eyebrow">SCUMMVM HANDOFF</p><h2>Detection tables</h2><p>Generated only from structurally verified payloads. This export currently contains {data.detections.entry_count} entries.</p></div>{data.detections.available && data.detections.download_path ? <a className="download-button" href={`${BASE_URL}${data.detections.download_path}`} download><Download size={16} /> Download .h</a> : <span className="disabled-download">No header generated</span>}</div><pre>{data.detections.preview || "// No detection table has been generated for this report state.\n// Retained artifacts remain accessible through the evidence ledger."}</pre></section>}

        {view === "library" && <section className="library-view"><div className="view-heading"><div><p className="eyebrow">MATERIALIZED OUTPUT</p><h2>Classified library</h2><p>Links appear only for report exports whose deployment includes the retained library tree.</p></div><div className="library-counts">{Object.entries(data.library.summary).map(([label, value]) => <span key={label}>{value} {label.replaceAll("_", " ")}</span>)}</div></div><div className="library-grid">{data.library.artifacts.slice(0, 36).map((item, index) => <article key={`${item.library_path}-${index}`}><div><span className="platform-tag">{item.platform.toUpperCase()}</span><Status verified={item.binary_verified_daad} /></div><h3>{item.title}</h3><p>{item.original_filename}</p><footer><span>{item.classification.replaceAll("_", " ")}</span><a href={`${BASE_URL}${item.library_path}`}><ExternalLink size={14} /> Artifact</a></footer></article>)}</div></section>}

        {view === "logs" && <section className="log-view"><div className="view-heading"><div><p className="eyebrow">OPERATIONAL RECORD</p><h2>Pipeline log tail</h2><p>Latest retained lines from the export directory. This view does not synthesize run events.</p></div></div>{Object.entries(data.logs).map(([name, lines]) => <article key={name}><h3><Terminal size={15} /> {name}.log</h3><pre>{lines.length ? lines.join("\n") : "No retained lines were supplied by this report export."}</pre></article>)}</section>}
      </main>

      {selected && <aside className="inspect-drawer"><button className="close-drawer" onClick={() => setSelected(null)} aria-label="Close artifact inspector"><X size={18} /></button><div className="drawer-mark"><Binary size={19} /> Selected artifact</div><h2>{selected.original_filename}</h2><Status verified={selected.is_daad_payload} /><dl><div><dt>SHA-256</dt><dd><code>{selected.sha256}</code><button onClick={() => copyHash(selected.sha256)}><Copy size={13} /> {copied ? "Copied" : "Copy"}</button></dd></div><div><dt>Platform</dt><dd>{platformOf(selected)}</dd></div><div><dt>DDB format</dt><dd>{selected.ddb_format || "Not measured"}</dd></div><div><dt>Interpreter</dt><dd>{selected.interpreter_identity || "Not correlated"}</dd></div><div><dt>File size</dt><dd>{bytes(selected.file_size)}</dd></div></dl><div className="drawer-evidence"><span>Version evidence</span>{selected.version_evidence?.length ? selected.version_evidence.map((item) => <p key={`${item.kind}-${item.value}`}><b>{item.kind}</b> {item.value} <em>{item.confidence}</em></p>) : <p>No separate version-evidence record was exported.</p>}</div><button className="drawer-link" onClick={() => { setView("ledger"); setSelected(null); }}>Return to ledger <ChevronRight size={15} /></button></aside>}
    </div>
  );
}
