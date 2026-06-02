#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# XENO.tape — architecture-current (editable per v1.2)
# Event history → XENO.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §0 Identity ──────────────────────────────────────────────────────

@I id001 := "xeno" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · exotic compute substrate domain — neuromorphic + quantum + organoid + QRNG"
  brief = "Exotic compute substrate — neuromorphic (Loihi/Akida/TrueNorth) · quantum hardware (IonQ trapped-ion / superconducting) · organoid intelligence · QRNG · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "XENO.log.tape"
  scope = "in-silico exotic-compute-substrate knowledge SSOT · NOT hardware-procurement advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see XENO.log.tape audit"
  compute-portfolio-ref = "AGENTS.tape @X x_compute_portfolio describes the xeno sister-repo routes: xeno→AKIDA · xeno→Loihi3 · xeno→IonQ · xeno→organoid · QRNG · classical-CPU fallback. This tape is the knowledge SSOT for those substrate families."
  sister-repo-note = "The xeno sister repo (dancinlab/xeno) manages runtime routing. This tape does NOT shadow that logic (hexa-bio AGENTS.tape f3 + g5_sister_repo_cli) — it records the scientific grounding of each substrate class."

@N scope_disclaimer := "exotic-compute-scope honesty" :: note [required]
  text = "This tape is an evidence-summary SSOT for exotic compute substrates relevant to hexa-bio workloads. Substrate capabilities and parameters paraphrased from the cited primary/review literature are for modeling-context orientation only — NOT hardware-procurement specs, NOT SLA guarantees, NOT clinical device guidance. Neuromorphic and quantum hardware specifications change rapidly; treat published figures as illustrative of research-era magnitude, not as current datasheets. Organoid intelligence is early-stage research with unresolved ethical questions (sentience uncertainty, animal/human tissue welfare) — the field explicitly notes these concerns in its founding document ([@x_smirnova_2023]). The in-silico↔physical-hardware boundary for all xeno substrates is epistemic: hexa-bio gates (PASS/SKIP/FAIL) reflect sister-repo CLI health, never physical-chip benchmarks."

# ─── §1 Neuromorphic computing foundations ────────────────────────────

@D neuro_concept := "neuromorphic computing — founding concept" :: domain [ok]
  origin = "The term 'neuromorphic' was coined by Carver Mead (1990, Proc. IEEE) to describe analog VLSI circuits that mimic the physics of neural membranes and synaptic connections — resistor/capacitor networks that are governed by the same equations as biological neurons, not digital logic pretending to simulate them."
  rationale = "Biological neural tissue performs perception/recognition tasks at extremely low power (~20 W for the whole human brain); Mead argued that analog physics-mirroring circuits could achieve comparable energy efficiency for specific pattern-recognition tasks."
  evolution = "From Mead's analog circuits (late 1980s–1990s), the field evolved into mixed-signal and then digital spiking architectures: SpiNNaker (Manchester), IBM TrueNorth, Intel Loihi/Loihi2, BrainChip Akida, and Samsung/IMEC research lines."
  honesty = "Chip-architecture parameters (neuron count, synapse count, power budget) are engineering choices and fabrication-technology constraints — not derivable from any n=6 lattice invariant. See [@f_lattice_fit] + [@n6_honest_stance]."
  |> "[@x_mead_1990]"

@D neuro_spinnaker := "SpiNNaker — massively parallel spiking neural network machine" :: domain [ok]
  architecture = "SpiNNaker (Spiking Neural Network Architecture) uses arrays of small ARM processor cores on custom ICs connected by an asynchronous packet-switched network; neurons are simulated in software on cores, synaptic packets routed between them. Designed to run large-scale neural-network simulations in real time."
  scale = "The SpiNNaker-1 system (University of Manchester, EPSRC-funded) was progressively scaled to a million-ARM-core machine (~1M cores, ~1 billion synapses per second capacity) by around 2018. Exact numbers from the cited Furber et al. 2014 paper and project documentation; treated here as cited illustrative figures."
  applications = "Models of cortical circuits, basal ganglia models, robotic motor control via neuromorphic interface."
  honesty = "Core counts and simulation capacity are engineering-scale figures from the cited paper; not re-derived. SpiNNaker's design choices — number of cores per chip, packet routing width — are embedded-systems architecture, not lattice values."
  |> "[@x_furber_2014]"

@D neuro_truenorth := "IBM TrueNorth — spike-based neurosynaptic chip" :: domain [ok]
  architecture = "TrueNorth (Merolla et al., Science 2014) is a 4096-core chip; each core implements 256 programmable spiking neurons with 256×256 synaptic connections. Spike events are binary and timed; computation is event-driven (near-zero idle power)."
  power = "Merolla et al. report ~70 mW at real-time performance levels for the full chip (~400 mW/cm² class), a drastic reduction from conventional GPU-based approaches for inference tasks. Exact figures from the cited Science paper; treated as cited illustrative magnitudes."
  applications = "Pattern recognition, multi-sensory fusion, inference at the edge; used in DARPA neuromorphic research programs."
  honesty = "The '4096 cores' is a fabrication and architecture choice (IBM 28 nm CMOS), not a lattice value. The '256 neurons per core' is likewise a design parameter chosen for die-area efficiency — not derivable from n=6."
  |> "[@x_merolla_2014]"

@D neuro_loihi := "Intel Loihi / Loihi2 — on-chip learning neuromorphic" :: domain [ok]
  loihi1 = "Intel Loihi (Davies et al., IEEE Micro 2018): 128 neuromorphic cores per chip, each with 1024 primitive spiking neural units; programmable on-chip plasticity (STDP-style learning rules configurable in microcode). Fabricated in Intel 14 nm process."
  loihi2 = "Loihi2 (announced ~2021): expanded core count, improved on-chip learning, lower per-spike energy, Intel 4 nm class process. Deployed through Intel Neuromorphic Research Community (INRC) — access is research-partnership-gated, not commodity."
  event-driven = "Loihi's core advantage is event-driven sparsity: a core draws significant power only when a spike arrives; idle cores consume near-zero. For workloads with naturally sparse activation (e.g. biosignal processing, tactile sensing), this can yield order-of-magnitude energy savings over dense matrix operations."
  honesty = "Core and neuron counts are engineering-architecture parameters from the cited Davies et al. paper; not lattice-derived. The sparsity advantage is a consequence of the spiking-neural-network computation model, documented in the cited primary source."
  |> "[@x_davies_2018]"

@D neuro_akida := "BrainChip Akida — edge neuromorphic inference (industry-era)" :: domain [ok]
  product = "BrainChip Akida (AKD1000 series) is a commercial neuromorphic inference chip targeting ultra-low-power edge deployment (~1 W class). Uses a spiking neural network execution model; supports conversion of trained ANNs to SNN equivalents via the MetaTF toolchain."
  niche = "Designed for sub-watt continuous-on-device inference for biosignal (ECG/EEG), wake-word detection, and computer-vision applications — power class directly relevant to implantable-adjacent and wearable medical devices."
  hexa-bio-relevance = "CRISPR-Cas13 lateral-flow signal classification, nanobot actuator control, and biosignal arrhythmia detection are potential hexa-bio workloads that map to Akida's designed niche (per AGENTS.tape COMPUTE_PORTFOLIO x_compute_portfolio)."
  honesty = "Exact performance figures are from BrainChip marketing/datasheet materials (industry-era, not peer-reviewed benchmarks). Treated here as author/era — directional magnitude (sub-1W, edge inference) rather than precisely asserted specs. Chip-architecture parameters are engineering choices, not lattice-derived."

@D neuro_energy_efficiency := "event-driven energy efficiency — why sparsity matters" :: mechanism [ok]
  principle = "Conventional CMOS logic dissipates energy on every clock cycle whether data changes or not. Spiking neuromorphic chips dissipate energy only when a spike event propagates — a computation model aligned with neural biology's principle that sparse firing is metabolically cheap."
  tradeoff = "Event-driven efficiency advantage materialises only for workloads with naturally sparse activation. Dense matrix workloads (e.g. large-model transformer inference) do NOT benefit from neuromorphic substrate — the advantage is niche-specific."
  tooling-maturity = "A key practical limit: programming spiking hardware requires either SNN-native training (limited toolchain maturity) or ANN-to-SNN conversion (accuracy loss possible). See [@lim_neuro_tooling]."
  honesty = "Energy figures from the cited Merolla 2014 and Davies 2018 primary literature; directionality (neuromorphic is more efficient for sparse workloads) is established, exact crossover thresholds are workload-dependent."
  |> "[@x_merolla_2014] · [@x_davies_2018]"

# ─── §2 Quantum hardware ──────────────────────────────────────────────

@D quant_paradigm := "quantum computing paradigm — gates, qubits, decoherence" :: domain [ok]
  principle = "Quantum computers exploit superposition and entanglement of two-level quantum systems (qubits) to run algorithms whose complexity scales better than best-known classical algorithms for specific problem classes (e.g. Shor factoring, Grover search, quantum simulation)."
  nisq-era = "Preskill (2018, Quantum) coined 'NISQ' (Noisy Intermediate-Scale Quantum) to describe the current era: devices of 50–hundreds of qubits with gate error rates too high for fault-tolerant operation. Useful quantum advantage for practically relevant problems in the NISQ era is not yet established with certainty."
  decoherence = "The fundamental limit is decoherence: quantum states are fragile — environmental interactions collapse superpositions on timescales (T1/T2 coherence times) that constrain the circuit depth feasible before errors accumulate. See [@lim_decoherence]."
  honesty = "Gate error rates, qubit counts, and coherence times are engineering figures from the cited primary literature and contemporary device reports. These change rapidly; the NISQ framing (Preskill 2018) is the honest characterisation of the field's current ceiling."
  |> "[@x_preskill_2018]"

@D quant_superconducting := "superconducting qubits (IBM, Google)" :: domain [ok]
  architecture = "Superconducting qubits use Josephson junctions to create non-linear quantum oscillators operated at millikelvin temperatures in dilution refrigerators. Gate operations are microwave pulses; two-qubit gates (CNOT/CZ) are the standard entangling primitive."
  google_supremacy = "Arute et al. (Google, Nature 2019) reported a 53-qubit Sycamore processor completing a specific random-circuit sampling task in ~200 seconds, estimated to take ~10,000 years on a classical supercomputer of that era — branded 'quantum supremacy'. This claim is contested: subsequent improved classical simulation algorithms (Pednault et al., Pan & Zhang et al.) significantly reduced the estimated classical runtime, though the exact crossover remains debated. The claim is flagged here as contested — both the original result and the subsequent classical improvements are cited; neither side's resolution is final."
  ibm-progress = "IBM Quantum has progressively scaled superconducting devices (Eagle 127q, Osprey 433q, Condor 1000+q series) and published error-correction demonstrations; utility-scale demonstrations remain active research."
  honesty = "Qubit counts and gate fidelities from the cited Arute et al. 2019 paper and contemporaneous IBM public releases. The contested-supremacy flag is factual and per honesty obligation ([@x_arute_2019] cites the Google result; classical-challenge work cited separately with author/era)."
  |> "[@x_arute_2019]"

@D quant_ionq := "IonQ trapped-ion quantum computer (industry-era)" :: domain [ok]
  architecture = "IonQ uses individual ytterbium (Yb+) ions confined in electromagnetic traps as qubits. Laser pulses implement single-qubit rotations; two-qubit gates (e.g. Mølmer-Sørensen gates) exploit motional modes of the ion chain. Trapped-ion qubits have long coherence times (seconds-class T2 vs microseconds for superconducting) but slower gate rates and limited chain length."
  advantage = "Higher per-gate fidelity than NISQ superconducting devices in typical benchmarks; all-to-all connectivity within the ion chain (vs limited nearest-neighbor connectivity of grid-based superconducting devices)."
  limit = "Gate speed is ~milliseconds per two-qubit gate (laser-pulse-limited); scaling the ion chain beyond ~30–50 ions while maintaining high fidelity is an active engineering problem."
  hexa-bio-link = "AGENTS.tape COMPUTE_PORTFOLIO references xeno→IonQ as a route for quantum-gate workloads; hexa-bio shells out to the xeno sister repo for IonQ access — does NOT reimplement trapped-ion gate simulation here (f3)."
  honesty = "IonQ architecture parameters are from public company documentation and academic papers (author/era; precise current qubit-count claims are marketing-era and change rapidly)."

@D quant_crossover := "quantum vs classical compute crossover — honest state of knowledge" :: domain [ok]
  nisq-caution = "For the workloads hexa-bio targets (ribozyme quantum chemistry, VQE small-molecule active space), NISQ devices can run small active-space VQE circuits (as in hexa-bio's qmirror integration), but larger systems still require classical simulation or error-correction-capable hardware not yet available."
  vqe-context = "Variational Quantum Eigensolver (VQE) and related hybrid quantum-classical algorithms are the target application family for hexa-bio's quantum axis; hexa-bio shells out to qmirror for this (AGENTS.tape g5 + f3). The XENO tape records the hardware-substrate knowledge; qmirror records the algorithm."
  honesty = "Whether quantum computers will achieve practically meaningful advantage over classical computers for molecular simulation on the timescale of hexa-bio's roadmap is genuinely uncertain. NISQ-era noise is a real engineering constraint, not a latice value."
  |> "[@x_preskill_2018]"

# ─── §3 Quantum random number generators (QRNG) ───────────────────────

@D qrng_concept := "quantum random number generators — physics of certified randomness" :: domain [ok]
  principle = "A QRNG generates random bits from genuinely quantum-mechanical processes (typically photon detection or vacuum-state quadrature measurement) where quantum indeterminacy — not algorithmic pseudo-randomness — is the source of entropy. The resulting bits are certifiably unpredictable under quantum mechanics, unlike PRNG or hardware-entropy-based RNG which are computationally unpredictable but in principle deterministic."
  photon-based = "Common architectures: single-photon detection (arrival time randomness); beam-splitter 50/50 path randomness (photon takes one of two paths at random); vacuum-state homodyne quadrature measurement. Speeds range from tens of Mbps to Gbps in commercial units."
  device-independent = "Bierhorst et al. (Nature 2018) demonstrated device-independent certified randomness: randomness certified by Bell-inequality violation, guaranteeing that the output is random even if the device is untrusted or partially adversarial. This is a stronger guarantee than standard QRNG and is currently research-grade."
  hexa-bio-link = "AGENTS.tape COMPUTE_PORTFOLIO references QRNG as a route in xeno; hexa-bio may use QRNG-seeded randomness for stochastic simulation or cryptographic keys. No reimplementation here (f3)."
  honesty = "Generation rates and certification levels from the cited primary literature ([@x_bierhorst_2018]). Commercial QRNG specs are vendor-era; directionality (photon-based QRNG is genuinely quantum) is physics, not a lattice property."
  |> "[@x_bierhorst_2018]"

# ─── §4 Organoid intelligence ─────────────────────────────────────────

@D oi_concept := "organoid intelligence — concept and founding framework" :: domain [ok]
  definition = "Smirnova et al. (2023, Frontiers in Science) coined 'Organoid Intelligence (OI)' as an emerging field combining 3-D brain organoid tissue with machine-learning and electrophysiology to create 'biocomputers' that may, in principle, learn and compute with greater energy efficiency than silicon. The paper is the field's founding position statement."
  dishbrain = "Kagan et al. (2022, Neuron) reported 'DishBrain': dissociated rat and human cortical neurons cultured on multi-electrode arrays, trained via closed-loop real-time electrophysiological feedback (operant-style stimulus-response) to play the video game Pong at above-chance performance. This is the primary empirical demonstration that in vitro neural tissue can exhibit goal-directed adaptation."
  significance = "DishBrain is a proof-of-concept that cultured neurons are not merely passive — they adapt their activity patterns when consequences (sensory feedback) are shaped by their output. The paper explicitly frames this as a minimal in-vitro learning system, not evidence of consciousness or sentience."
  honesty = "Both papers are early-stage results in a nascent field. The OI Smirnova 2023 paper explicitly identifies major open questions: learning speed, scaling, reproducibility, training protocols, and — critically — ethics."
  |> "[@x_smirnova_2023] · [@x_kagan_2022]"

@D oi_ethics := "organoid intelligence — ethical hard walls" :: domain [ok required]
  sentience-uncertainty = "Brain organoids derived from human iPSCs contain functional neurons, form synapses, and exhibit spontaneous electrical activity. Whether they have or could develop morally-relevant experience (sentience, capacity for suffering) is an open philosophical and empirical question with no current consensus answer."
  explicit-concern = "Smirnova et al. 2023 devote a substantial section to ethical considerations, calling for embedded ethics frameworks to accompany OI research from the outset — a first-of-field acknowledgment that the technology's ethical envelope is not resolved."
  regulatory-gap = "There is no regulatory framework specifically governing computation on human-organoid-derived tissue at the time of writing (knowledge cutoff). This is an active area of bioethics research and institutional debate."
  hexa-bio-scope = "Hexa-bio's xeno axis references organoid as a compute-substrate route (via xeno sister repo). This tape records the honest scientific and ethical framing; actual organoid laboratory experiments are out-of-repo scope (AGENTS.tape g8_in_silico_only)."
  honesty = "The ethical uncertainties are stated as currently unresolved because they ARE currently unresolved. This is not a caution inserted for form; the founding paper of the field itself raises them."
  |> "[@x_smirnova_2023]"

@D oi_finalspark := "FinalSpark Neuroplatform — biological compute as a service (industry-era)" :: domain [ok]
  platform = "FinalSpark is a company offering remote-access computing on human brain organoids ('Neuroplatform') — a cloud-accessed biological compute interface. This is an industry offering, not a peer-reviewed benchmark."
  status = "Early-commercial, research-partnership stage as of knowledge cutoff. Throughput, reliability, and reproducibility figures are from company communications (industry-era; not independently peer-reviewed at the level of the Kagan 2022 / Smirnova 2023 academic benchmarks)."
  hexa-bio-link = "AGENTS.tape COMPUTE_PORTFOLIO lists FinalSpark as a xeno organoid route; hexa-bio gates (PASS/SKIP/FAIL) on xeno CLI health, never on FinalSpark's internal substrate fidelity (AGENTS.tape g6_gates_not_reverifications)."
  honesty = "FinalSpark is cited at the level of 'industry-era' — directional characterisation only, no precise specs asserted."

# ─── §5 Substrate trade-off matrix ────────────────────────────────────

@D tradeoff_matrix := "exotic-substrate trade-off dimensions" :: domain [ok]
  dimensions = "Each exotic substrate is characterised along five qualitative dimensions: (1) energy per operation class; (2) gate/operation precision; (3) scale (qubit/neuron count); (4) programmability/toolchain maturity; (5) access model (commodity / research-partnership / cloud-only)."
  neuromorphic = "ENERGY: excellent for sparse spiking workloads (sub-mW to low-W class). PRECISION: analog approximation for Loihi/Akida; digital-spike but noisy. SCALE: millions of neurons for SpiNNaker; thousands for Loihi/Akida. TOOLCHAIN: immature — NxSDK (Intel), MetaTF (BrainChip) are specialised, limited framework support. ACCESS: Intel INRC (research), BrainChip Akida cloud, SpiNNaker open-science."
  quantum = "ENERGY: cryogenic overhead is enormous (~10 kW per dilution refrigerator), power advantage only materialises for exponential quantum speedup tasks that currently do NOT include most near-term ML. PRECISION: NISQ era gate errors ~0.1–1% per two-qubit gate. SCALE: 50–1000 qubits as of 2023 era, circuit depth limited by decoherence. TOOLCHAIN: Qiskit (IBM), Cirq (Google), pyQuil (Rigetti), IonQ APIs — maturing. ACCESS: cloud APIs for research."
  organoid = "ENERGY: speculative ultra-low (biological neurons operate at ~10 fJ per spike theoretical); total platform overhead currently dominates. PRECISION: stochastic, poorly characterised for computation. SCALE: early-stage proof-of-concept. TOOLCHAIN: electrophysiology arrays (MEA) + bespoke feedback systems; no general SDK. ACCESS: FinalSpark cloud (industry-era), academic labs only."
  qrng = "Not a general-purpose compute substrate but an entropy source; speed/quality are the relevant dimensions (Gbps+ for photon-based; certifiability for device-independent)."
  honesty = "These characterisations are qualitative summaries of the cited primary literature and publicly documented state as of knowledge cutoff — not vendor benchmarks, not a lattice-derived ordering. The ordering changes as hardware advances."
  |> "[@x_mead_1990] · [@x_merolla_2014] · [@x_davies_2018] · [@x_preskill_2018] · [@x_smirnova_2023]"

# ─── §6 Hexa-bio cross-link (compute-portfolio · not shadow) ──────────

@D hexa_bio_integration := "hexa-bio xeno integration model" :: domain [ok]
  model = "hexa-bio defines WHICH biology problem needs exotic compute (e.g. ribozyme off-target Hamming matching on neuromorphic, or quantum chemistry VQE via qmirror→IonQ). The xeno sister repo (dancinlab/xeno) manages substrate routing, session access, and substrate-level health checks. hexa-bio emits a gate (PASS/SKIP/FAIL) against xeno CLI exit code, never re-verifying substrate internals."
  gates = "PASS: `xeno status` exit 0 (xeno reachable + bridges healthy). SKIP: exit 91 (honest C3 sub-bridge failure, not a hexa-bio regression) or timeout or binary missing. FAIL: xeno reachable, `status` non-zero."
  no-shadow = "This tape does NOT reimplement: BrainChip Akida driver logic, Intel NxSDK, IonQ gate compilation, FinalSpark organoid access, or QRNG entropy buffering. These live in xeno; hexa-bio references via CLI (AGENTS.tape f3 + g5_sister_repo_cli)."
  axes-map = "CRISPR-Cas13 lateral-flow signal classification → Akida edge inference. Nanobot actuator control → Akida sub-mW real-time. Ribozyme off-target Hamming search → neuromorphic spiking pattern-match. Quantum chemistry VQE → qmirror (primary, xeno→IonQ as escalation). Virocapsid cryo-EM T-number classification → borderline neuromorphic. Formal proofs → hexa-meta (not xeno)."
  |> "[@x_hexa_bio_agents]"

# ─── §7 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ───

@D lim_decoherence := "quantum decoherence + NISQ error rates" :: real-limit [ok required]
  wall = "HARD WALL (physics, current engineering era)"
  statement = "Quantum bits lose superposition through interaction with the environment (T1 energy relaxation, T2 dephasing). In superconducting qubits T1/T2 are microseconds-class; in trapped-ion qubits seconds-class but gate speeds are slower. NISQ-era two-qubit gate error rates are typically ~0.1–1%, bounding the circuit depth that can be reliably executed before errors accumulate beyond correction. Preskill (2018) defines this as the defining constraint of the current era."
  consequence = "Exponential quantum speedups require fault-tolerant error correction (thousands of physical qubits per logical qubit), which does not yet exist at practical scale. For hexa-bio's VQE workloads, active-space size and circuit depth are bounded by this wall — larger molecular systems remain classically simulated."
  honesty = "Decoherence timescales and gate error rates are from the cited Preskill 2018 review and contemporaneous device characterisation papers. These numbers improve with each hardware generation; the wall is a current-era soft wall, not a fundamental physics floor."
  |> "[@x_preskill_2018]"

@D lim_neuro_tooling := "neuromorphic toolchain immaturity" :: real-limit [ok required]
  wall = "SOFT WALL (engineering + ecosystem maturity)"
  statement = "Programming spiking neuromorphic hardware requires either (a) native SNN training (tools: Norse, BindsNET, Intel NxSDK, BrainChip MetaTF — each chip-specific, limited interoperability), or (b) ANN-to-SNN conversion with accuracy degradation risk. There is no unified neuromorphic ML framework comparable to PyTorch/TensorFlow. This limits which workloads can be practically offloaded to neuromorphic substrates today."
  consequence = "Hexa-bio workloads mapped to neuromorphic (Akida edge inference for CRISPR lateral-flow classification, nanobot actuator control) require SNN-specific toolchain work or trained-ANN conversion; this is a real engineering cost, not a lattice constraint."
  honesty = "Toolchain maturity assessment is a qualitative read of the field as of knowledge cutoff; no quantitative benchmark cited. Noted as rapidly evolving."

@D lim_organoid_ethics := "organoid intelligence — ethics + sentience as hard wall" :: real-limit [ok required]
  wall = "HARD WALL (bioethics / epistemic)"
  statement = "Computation using human-iPSC-derived brain organoids encounters an ethical ceiling set by genuine uncertainty about organoid sentience and suffering capacity. Smirnova et al. (2023) name this explicitly: until the field develops validated sentience/pain markers for organoid tissue, scaling to human-level-complexity biocompute systems faces an ethical moratorium risk that cannot be resolved by engineering. This is not a hypothetical future concern — it is a present ethical constraint."
  consequence = "Hexa-bio's organoid route (via xeno→FinalSpark) is feasible for small-scale proof-of-concept workloads, but scaling and clinical integration require resolved ethics frameworks not currently available. AGENTS.tape g8_in_silico_only + g9_external_contact_defer apply."
  honesty = "The sentience uncertainty is reported as unresolved because it is — this is not inserted caution but the accurate description of the field per the founding paper of organoid intelligence."
  |> "[@x_smirnova_2023]"

@D lim_supply_access := "exotic hardware access + supply constraints" :: real-limit [ok required]
  wall = "SOFT WALL (access / supply-chain)"
  statement = "Neuromorphic research hardware (Intel Loihi via INRC, SpiNNaker via Manchester) is access-controlled through research partnerships, not commodity purchase. Quantum hardware (IBM Quantum, IonQ, Quantinuum) is accessible via cloud API with queue times and shot/time limits. Organoid compute (FinalSpark) is early-commercial and not generally available. For hexa-bio, this means the xeno sister repo may return SKIP (binary missing / bridge unreachable) on hosts without approved access — SKIP is honest (AGENTS.tape g7_skip_is_honest)."
  consequence = "In-silico gate testing (PASS/SKIP/FAIL) is bounded by access, not capability. A SKIP does not mean the substrate is non-existent or non-functional — it means the sister-repo bridge is not available on this host."
  honesty = "Access constraints described from public program documentation (INRC, IBM Quantum open access). Not lattice-derived; real supply-chain and program-policy constraints."

@D lim_in_silico_boundary := "in-silico → physical hardware gap" :: real-limit [ok required]
  wall = "HARD WALL (epistemic — out of repo scope)"
  statement = "Hexa-bio XENO axis gates on xeno CLI health and emits witness rows. Whether a given hexa-bio workload actually RUNS at production scale on AKIDA silicon / Intel Loihi / IonQ trapped-ion / FinalSpark organoid — and whether results are numerically correct and reproducible — is empirically unverified by this repo. The sister repo (xeno) is responsible for substrate-level verification (hexa-bio AGENTS.tape g6_gates_not_reverifications)."
  consequence = "No C2/C3 PASS in the XENO gate is a claim about physical-chip performance. It is a claim about xeno CLI health. This is the honest epistemic boundary."
  honesty = "Explicitly the same pattern as HEXA-NANOBOT's lim_in_silico_boundary — the in-silico-scope claim is the honest ceiling for all hexa-bio axes."

# ─── §8 n=6 lattice stance (HONEST — observation, not derivation) ─────

@F f_lattice_fit := "lattice-fit-on-exotic-compute" :: governance [required deny:write]
  pattern = "Deriving neuromorphic core counts, qubit counts, neuron counts, gate error rates, energy-per-spike figures, QRNG bit rates, organoid-neuron numbers, or substrate-access tiers FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. 'Loihi has 128 cores because σ·(τ+τ+…)' or 'IonQ uses 6 ion-trap zones because n=6'."
  why = "Exotic compute-substrate architecture parameters are engineering choices and fabrication-technology outcomes — set by VLSI design rules, cryogenic engineering, trapped-ion chain physics, and organoid biology, as documented in the cited primary literature (Mead 1990; Merolla/Science 2014; Davies/IEEE Micro 2018; Preskill/Quantum 2018; Smirnova/Front.Sci. 2023; Kagan/Neuron 2022). Zero of these are derivable from a lattice invariant."
  remedy = "Cite the real exotic-compute-substrate sources (this tape's @X entries). Numerical coincidences (e.g. if a chip happens to have 6 cores) are OBSERVATION ONLY — never a derivation. Per hexa-bio AGENTS.tape f1 + g1 (real-limits-first)."

@N n6_honest_stance := "exotic compute substrate has no derivational n=6 invariant" :: note [required]
  text = "Stated plainly: exotic compute substrates (neuromorphic, quantum, organoid, QRNG) expose NO natural n=6 invariant. Intel Loihi has 128 cores per chip because of 14 nm die-area constraints and architecture choices documented in Davies et al. 2018 — not because 128 = anything derived from n=6. IBM TrueNorth has 4096 cores (64×64 array) because of CMOS tile replication in 28 nm — not from the lattice. IonQ's trapped-ion chain length is a physics constraint (motional-mode coupling in the ion chain) — not lattice-derived. DishBrain's in-vitro neurons number ~800,000 per experiment (Kagan 2022) — that is a tissue-culture-well area and plating-density result, not a lattice count. QRNG photon detection is a quantum-mechanical process; its randomness is certified by quantum indeterminacy, not by any lattice invariant. Per hexa-bio AGENTS.tape g1 (real-limits-first) / g2 (lattice-is-tool): in this tape the lattice is explicitly DECLINED as a derivation tool for any count, rate, power, or access tier. This honesty corrects the audited lattice-tautology stub this tape replaced."

# ─── §9 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 NISQ-era VQE molecule-size ceiling" :: prediction [ok]
  claim = "Fault-tolerant quantum advantage for molecular simulation of systems larger than ~100 atoms will NOT be demonstrated on NISQ-era (uncorrected, <1000 physical qubit) hardware within the hexa-bio roadmap horizon, because decoherence bounds circuit depth below what is needed for exact-ground-state calculation of such systems."
  falsifier = "A peer-reviewed demonstration of exact (chemical-accuracy) ground-state energy calculation for a >100-atom molecular system on NISQ hardware without error correction falsifies [@lim_decoherence] and the NISQ ceiling."
  source = "[@x_preskill_2018]"

@D tp_2 := "TP-2 neuromorphic advantage is workload-gated" :: prediction [ok]
  claim = "For any hexa-bio workload that is fundamentally dense-activation (e.g. large-transformer-style inference, large-model protein structure prediction), neuromorphic substrate will NOT outperform a well-optimised GPU/TPU on energy-per-inference, because the spiking efficiency advantage only materialises for sparse, event-driven activation patterns."
  falsifier = "A peer-reviewed benchmark demonstrating that a spiking neuromorphic chip outperforms a comparable-generation GPU on energy-per-inference for a large dense-activation workload falsifies the claim in [@neuro_energy_efficiency] that the advantage is niche-specific."
  source = "[@x_merolla_2014] · [@x_davies_2018]"

@D tp_3 := "TP-3 organoid intelligence remains pre-clinical for at least 5 years" :: prediction [ok]
  claim = "As of knowledge cutoff (2026-05-16), no organoid-intelligence platform will achieve regulatory recognition as a general-purpose compute substrate for clinical-grade applications within five years, given the combination of unresolved sentience-ethics questions, reproducibility challenges, and absence of regulatory frameworks."
  falsifier = "A regulatory approval (FDA, EMA, or equivalent) or formal regulatory framework for clinical-grade biocompute on human brain organoids published before 2031 falsifies this prediction."
  source = "[@x_smirnova_2023] · [@x_kagan_2022]"

# ─── §10 Cross-links (sister repos / axes — reference, do NOT shadow · f3) ─

@X x_hexa_bio_agents := "hexa-bio AGENTS.tape" :: governance [active]
  scope = "g1 real-limits-first · g2 lattice-is-tool · g5 sister-repo-CLI-not-wrap · g6 gates-not-reverifications · g7 SKIP-is-honest · g8 in-silico-only · f1 lattice-fit-forbidden · f3 no-shadow-impl-of-sister-repo. This tape complies: xeno substrate routing, QRNG buffering, and Loihi/IonQ/Akida driver logic remain in xeno and are referenced via CLI gates, never reimplemented here."

@X x_compute_portfolio := "hexa-bio COMPUTE_PORTFOLIO.md" :: doc [active]
  scope = "Compute-substrate SSOT: qmirror state-vector, qmirror chemistry-VQE, xeno→AKIDA, xeno→Loihi3, xeno→IonQ, xeno→organoid, QRNG, classical-CPU fallback. XENO.tape is the scientific-knowledge companion; COMPUTE_PORTFOLIO.md is the operational route map."

@X x_qmirror_sibling := "qmirror (sister repo)" :: sister-repo [active]
  scope = "State-vector simulator + chemistry-VQE. Quantum chemistry (VQE for molecular active spaces) is routed via qmirror — hexa-bio shells out to qmirror via CLI per AGENTS.tape g5. Hexa-bio NEVER reimplements VQE or quantum circuit simulation here (f3). xeno→IonQ is an escalation route from qmirror's classical-quantum boundary."

@X x_xeno_sibling := "xeno sister repo (dancinlab/xeno)" :: sister-repo [active]
  scope = "Runtime exotic-substrate routing: AKIDA, Loihi3, IonQ, organoid (FinalSpark, Cortical Labs), QRNG. Hexa-bio shells out via `xeno status` and axis-specific CLI. XENO.tape records the science; xeno records the runtime. No reimplementation (f3)."
  local = "`~/core/xeno` · binary: `~/core/xeno/bin/xeno`"

@X x_hexa_nanobot_sibling := "HEXA-NANOBOT.tape" :: sibling-tape [active]
  scope = "NANOBOT axis. When nanobot actuator control is targeted to Akida neuromorphic (sub-mW in-vivo actuation), XENO.tape is the substrate-knowledge companion. The axes cross: nanobot defines the workload, xeno routes to hardware."

@X x_closure_backlog := "CLOSURE_RESIDUAL_BACKLOG.md" :: doc [active]
  scope = "§0 in-silico-only scope boundary. Physical-chip benchmarks, clinical-grade organoid compute, and hardware-access contracts for AKIDA/Loihi3/IonQ are out-of-repo and unverified."

# ─── §11 External citations (real, landmark literature) ──────────────

@X x_mead_1990 := "Mead C 1990" :: literature [active]
  ref = "Mead C. Neuromorphic electronic systems. Proc IEEE 1990;78(10):1629–1636. (coining of 'neuromorphic'; analog VLSI circuits mimicking neural membrane physics as the founding concept of the field.)"

@X x_furber_2014 := "Furber SB et al 2014" :: literature [active]
  ref = "Furber SB, Galluppi F, Temple S, Plana LA. The SpiNNaker project. Proc IEEE 2014;102(5):652–665. (SpiNNaker massively parallel ARM-core neuromorphic machine; architecture, scale, and applications; primary-authors/era — volume/issue cited from standard record.)"

@X x_merolla_2014 := "Merolla PA et al 2014" :: literature [active]
  ref = "Merolla PA, Arthur JV, Alvarez-Icaza R, Cassidy AS, Sawada J, Akopyan F, Jackson BL, Imam N, Guo C, Nakamura Y, Brezzo B, Vo I, Esser SK, Appuswamy R, Taba B, Amir A, Flickner MD, Risk WP, Manohar R, Modha DS. A million spiking-neuron integrated circuit with a scalable communication network and interface. Science 2014;345(6197):668–673. (IBM TrueNorth: 4096-core spike-based neurosynaptic chip; power and performance figures; landmark published paper.)"

@X x_davies_2018 := "Davies M et al 2018" :: literature [active]
  ref = "Davies M, Srinivasa N, Lin T-H, Chinya G, Cao Y, Choday SH, Dimou G, Joshi P, Imam N, Jain S, Liao Y, Lin C-K, Lines A, Liu R, Mathaikutty D, McCoy S, Paul A, Tse J, Venkataramanan G, Weng Y-H, Wild A, Yang Y, Wang H. Loihi: A neuromorphic manycore processor with on-chip learning. IEEE Micro 2018;38(1):82–99. (Intel Loihi; 128-core architecture; on-chip STDP learning; event-driven energy efficiency; primary-authors/era; volume/issue cited from standard record.)"

@X x_arute_2019 := "Arute F et al 2019 (Google Sycamore — contested quantum supremacy claim)" :: literature [active]
  ref = "Arute F, Arya K, Babbush R, et al (Google AI Quantum). Quantum supremacy using a programmable superconducting processor. Nature 2019;574(7779):505–510. (53-qubit Sycamore random-circuit sampling in ~200 s, estimated 10,000 classical-year equivalent of that era — the 'quantum supremacy' claim. CONTESTED: subsequent improved classical simulation algorithms by Pednault et al. (IBM, 2019) and Pan & Zhang et al. (2022) significantly reduced the estimated classical runtime; the supremacy margin is disputed. Both the original result and subsequent classical-improvement papers are real; no side has conclusively resolved the claim.)"

@X x_preskill_2018 := "Preskill J 2018" :: literature [active]
  ref = "Preskill J. Quantum computing in the NISQ era and beyond. Quantum 2018;2:79. (coined 'NISQ' — Noisy Intermediate-Scale Quantum; defines the current era, decoherence as the dominant constraint, honest framing of near-term quantum utility uncertainty; foundational reference for honest quantum-computing claims.)"

@X x_bierhorst_2018 := "Bierhorst P et al 2018" :: literature [active]
  ref = "Bierhorst P, Knill E, Glancy S, Zhang Y, Mink A, Jordan S, Rommal A, Liu Y-K, Christensen B, Nam SW, Stevens MJ, Shalm LK. Experimentally generated randomness certified by the impossibility of superluminal signals. Nature 2018;556(7700):223–226. (device-independent certified randomness via Bell-inequality violation; NIST experimental demonstration; landmark for strong QRNG certification.)"

@X x_smirnova_2023 := "Smirnova L et al 2023" :: literature [active]
  ref = "Smirnova L, Caffo BS, Gracias DH, Bhargava P, Bhattacharya R, Brain C, Butler N, Cantley C, Cheon K, Coady N, Cohen-Karni T, Cooksey J, Culurciello E, Feldman EL, Gao W, Hamad-Schifferli K, Hristov D, Huang J, Huckins J, Hue S, Huang MC, Hunt KD, Johnson EC, Kagan B, Kodandaramaiah S, Kording K, Kumar S, Kyng KS, Lee CW, Levy M, LiChia R, Liu Y, Ma J, Marblestone A, Martino D, Mastroianni M, McGuire M, Meade RD, Moore CI, Morse M, Nakada M, Nashed YSG, O'Brien J, Olesik M, Ortiz-Rios M, Paik SB, Papadopoulos CM, Parisots S, Park J, Perkins E, Petrini EM, Pham M, Posch S, Quinlan E, Rajangam S, Ramos-Murguialday A, Rao R, Raskar R, Richardson K, Roelfsema P, Ruber T, Schulkin J, Seremet T, Shaibani M, Shahbazi-Salam L, Sherr DH, Shi Y, Smirnova N, Soekadar SR, Stein J, Tanaka K, Taylor DM, Thomas C, Thompson J, Tiwari V, Tovar-Moll F, Trujillo CA, Ursu O, Vogt NM, Wachowiak M, Weinstein DE, Wolff SE, Young JD, Zador A, Bhattacharya S. Organoid intelligence (OI): the new frontier in biocomputing and intelligence-in-a-dish. Front Sci 2023;1:1017235. (founding concept paper for organoid intelligence; covers biocomputing potential, ethical frameworks, and open questions including sentience uncertainty — primary reference for OI scope and ethics.)"

@X x_kagan_2022 := "Kagan BJ et al 2022" :: literature [active]
  ref = "Kagan BJ, Kitchen AC, Tran NT, Habibollahi F, Khajehnejad M, Parker BJ, Bhat A, Rollo B, Razi A, Friston KJ. In vitro neurons learn and exhibit sentience when embodied in a simulated game-world. Neuron 2022;110(23):3952–3969. (DishBrain: rat and human cortical neurons on MEAs trained via closed-loop electrophysiological feedback to play Pong at above-chance performance; primary empirical demonstration of in vitro goal-directed neural adaptation — with sentience-question discussion in the paper itself.)"
