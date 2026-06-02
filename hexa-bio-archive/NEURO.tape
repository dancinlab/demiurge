#!/usr/bin/env tape


# ══════════════════════════════════════════════════════════════
# NEURO.tape — architecture-current (editable per v1.2)
# Event history → NEURO.log.tape sibling
# ══════════════════════════════════════════════════════════════

@V := "tape" :: spec [active]
  version = "1.2"

@I id001 := "neuro" :: identity-claim [d=2026-05-16 active]
  kind = "HEXA-Bio family · brain-machine interface (BCI) / neurotechnology in-silico knowledge SSOT"
  brief = "Neural recording / decoding / stimulation landscape · evidence-based · real-limits anchored · n=6 NOT used as a derivation (honest)"
  parent = "dancinlab/hexa-bio"
  sibling-log = "NEURO.log.tape"
  scope = "in-silico knowledge SSOT · NOT clinical / surgical / device-regulatory advice"
  rewritten-from = "lattice-tautology stub (hexa-bio mass-split 153b5a2); full real-science rewrite 2026-05-16 — see NEURO.log.tape audit"

@N scope_disclaimer := "clinical-scope honesty" :: note [required]
  text = "This tape is an evidence-summary knowledge SSOT for an in-silico BCI / neurotechnology substrate. Channel counts, decoder accuracies, electrode-array longevity, surgical-risk figures and clinical-trial outcomes are paraphrased from published literature for modeling context only — they are NOT prescribing guidance, NOT a surgical protocol, NOT a regulatory submission. Implantable BCIs are high-risk neurosurgical devices; real use requires neurosurgical / neurology / device-engineering / IRB oversight. All claims here are in-silico simulator/metadata consistency only; the wet-lab → preclinical → first-in-human → regulatory → market boundary is explicitly out of scope (hexa-bio AGENTS.tape g8 / f2)."

# ── §1 What a brain-machine interface is ─────────────────────────────

@D dx_definition := "what a BCI is" :: domain [ok]
  disease = "Brain-machine interface (BCI) / brain-computer interface = a system that measures neural activity, decodes intent or state from it, and optionally delivers feedback (motor output to an effector, sensory restoration via stimulation, or cognitive/affective readout)."
  not-one-thing = "BCI is an UMBRELLA, not one device: invasive intracortical arrays (motor restoration, communication), ECoG / subdural grids (epilepsy mapping, speech), scalp EEG (consumer / clinical screening), endovascular stent-electrodes (Stentrode), peripheral-nerve interfaces, and vision/auditory neuroprostheses (retinal implants, cochlear implants) are mechanistically distinct."
  axis-recording-vs-stim = "Two orthogonal axes: READ (recording → decoding) and WRITE (stimulation → sensation/modulation). Closed-loop BCI couples them."
  honesty = "BCI is an active engineering field where landmark first-in-human demonstrations are recent, durability is short, and 'general consumer brain interface' is not established clinical reality."
  |> "[@x_lebedev_nicolelis_2006]"

@D mech_action_potential := "neural action potential (Hodgkin-Huxley)" :: mechanism [ok]
  what = "An action potential is a transient depolarization of a neuron's membrane voltage propagating along its axon — the canonical 'spike' that BCI electrodes detect when close enough to a firing cell."
  hh-model = "Hodgkin & Huxley (1952) modelled the squid-axon action potential as voltage-gated Na+ / K+ conductances with empirically fit gating variables; this remains the foundational quantitative model of excitable membranes (Nobel 1963)."
  signal-source = "Extracellular recording picks up spike waveforms within tens to ~150 µm of an electrode tip; field potentials integrate activity over wider radii; EEG/MEG integrate over centimetre-scale cortical patches."
  |> "[@x_hodgkin_huxley_1952]"

@D mech_neural_coding := "neural coding — rate vs temporal" :: mechanism [ok]
  rate-code = "Firing rate (spikes per second over a window) carries much of the decodable signal in motor cortex and many sensory areas; classic neuroprosthetic decoders treat rates as the regression input."
  temporal-code = "Precise spike timing, phase relative to local-field oscillations, and synchrony also carry information (e.g. hippocampal theta phase, cortical gamma). The rate-vs-temporal split is a working partition, not a closed dichotomy."
  population-code = "Information is distributed across many neurons; small ensembles already permit useful decoding (Wessberg 2000 demonstrated arm-trajectory decoding from a few dozen cortical units in primates)."
  |> "[@x_wessberg_2000]"

@D mech_population_vector := "motor cortex population coding (Georgopoulos)" :: mechanism [ok]
  m1 = "Primary motor cortex (M1) neurons exhibit cosine directional tuning during arm reaches; Georgopoulos and colleagues showed the vector sum of preferred directions weighted by firing rate predicts the upcoming reach direction."
  why-it-matters-for-bci = "This is the conceptual bridge from spikes to a cursor / robotic arm: a linear (or learned) map from population firing to intended kinematics is what intracortical motor BCIs decode."
  |> "[@x_georgopoulos_1986]"

@D mech_plasticity := "cortical plasticity & co-adaptation" :: mechanism [ok]
  what = "Cortex reorganizes in response to use and feedback; closed-loop BCI explicitly exploits this — the user learns to modulate neural activity that the decoder reads, while the decoder is recalibrated to the user's evolving signal (co-adaptation)."
  consequence = "Performance is a JOINT property of biology and decoder; reported accuracy depends on training paradigm, calibration cadence and feedback latency, not on intrinsic 'channel capacity' alone."

# ── §2 Recording modalities (trade-off landscape) ────────────────────

@D rec_eeg := "scalp EEG" :: modality [ok]
  what = "Non-invasive electrodes on the scalp; records summed cortical population activity (mainly synaptic currents) through skull and scalp."
  pros = "No surgery, low cost, decades of clinical and research deployment, established for epilepsy, sleep, anesthesia, and event-related potentials (P300, motor imagery rhythms)."
  cons = "Low spatial resolution (~cm), low SNR (skull attenuation and muscle/motion artefact), no single-unit access; communication-rate BCIs based on EEG are slow vs intracortical."
  use = "Consumer-grade and clinical screening; ALS communication via P300 spellers; sleep staging; non-invasive neurofeedback."

@D rec_ecog := "ECoG / subdural & stereo-EEG" :: modality [ok]
  what = "Electrodes placed on the cortical surface (subdural ECoG grids/strips) or penetrating depth electrodes (stereo-EEG) — intermediate between scalp EEG and intracortical."
  pros = "Higher SNR and broader bandwidth than scalp EEG; established in clinical epilepsy localization; opportunistic research access in pre-resection patients enabled key speech-decoding work."
  cons = "Requires craniotomy or burr-hole placement; clinical implant duration limited; surface coverage limits access to deep structures (mitigated by stereo-EEG)."
  bci-role = "Workhorse modality for cortical speech-decoding research (Chang lab, UCSF; Moses 2021 speech-decoding in a paralyzed individual; Willett 2023 brain-to-text via penetrating arrays in motor speech cortex)."
  |> "[@x_moses_2021]"

@D rec_intracortical_mea := "intracortical microelectrode arrays (Utah / BrainGate)" :: modality [ok]
  what = "Penetrating multi-electrode arrays implanted in cortex; the Utah array (Blackrock Microsystems lineage) is the canonical 96-channel research/clinical device used by BrainGate and many academic labs."
  pros = "Access to single-unit spiking and local-field potentials; highest information-per-channel for motor BCI; enabled landmark human demonstrations (BrainGate cursor control, robotic-arm reach-and-grasp, communication BCIs)."
  cons = "Invasive craniotomy; signal yield degrades over months-to-years as glial encapsulation and tip damage accumulate (chronic-recording limit; see [@lim_chronic_longevity]); per-session decoder recalibration typical due to non-stationarity ([@lim_nonstationarity])."
  |> "[@x_hochberg_2006] · [@x_hochberg_2012] · [@x_collinger_2013]"

@D rec_neuropixels := "high-density silicon probes (Neuropixels-class)" :: modality [ok]
  what = "CMOS-integrated silicon shanks with hundreds-to-thousands of recording sites on a single probe (Neuropixels 1.0 / 2.0 lineage); standard for systems-neuroscience rodent and primate work."
  pros = "Two orders of magnitude more simultaneously recordable sites per shank than conventional probes; enables circuit-scale population analysis."
  cons = "Primarily acute/short-term research instrument in animals; chronic human deployment is not the typical use case; spike-sorting and data-management overhead are non-trivial."
  |> "[@x_jun_neuropixels_2017]"

@D rec_endovascular := "endovascular stent-electrodes (Stentrode)" :: modality [ok]
  what = "Stent-mounted electrode array deployed via catheter into a cortical vein (e.g. superior sagittal sinus) — records cortical activity from inside the venous wall without craniotomy."
  pros = "Avoids open neurosurgery; uses established endovascular techniques; first-in-human implants demonstrated safety/feasibility and basic switch-control."
  cons = "Bandwidth and spatial resolution intermediate between ECoG and EEG; field is early; only short-list of implanted participants to date."
  |> "[@x_oxley_2021]"

@D rec_flexible := "flexible / high-channel-count emerging probes" :: modality [draft]
  what = "Polymer / mesh / micro-thread arrays designed to reduce mechanical mismatch with brain tissue and increase channel counts (e.g. Neuralink-class robotic-inserted threads; academic flexible-mesh approaches)."
  promise = "Plausible path to higher chronic channel counts and reduced foreign-body response; published peer-reviewed long-term human efficacy data is limited as of the knowledge cutoff."
  honesty = "Status here is 'emerging / partly preclinical'; do NOT treat company press releases as clinical evidence (see [@lim_evidence_grade])."

@D rec_neuroprosthetics_sensory := "sensory neuroprostheses (cochlear · retinal)" :: modality [ok]
  what = "Established sensory-restoration BCIs of a different lineage: cochlear implants electrically stimulate the auditory nerve in profound sensorineural hearing loss; retinal implants (e.g. Argus II, historical context) stimulated retina in late-stage retinitis pigmentosa."
  status = "Cochlear implants are the most widely deployed neuroprosthesis worldwide and the strongest historical proof that chronic electrical stimulation of a neural pathway can restore a useful percept. Argus II illustrates both the feasibility and the commercial/clinical limits of early retinal prostheses (program effectively discontinued by manufacturer); newer cortical and subretinal approaches are in trials."
  honesty = "These devices are NOT 'brain-reading' BCIs; they are stimulation prostheses on peripheral neural tissue. Bundled in §2 because they are the most clinically mature neural-interface technology and set realistic expectation for chronic implants."

# ── §3 Decoding (signal → intent) ────────────────────────────────────

@D dec_kalman_linear := "linear / Kalman decoders" :: therapy [ok recommended]
  moa = "Linear regression / linear discriminant / Kalman filter map binned firing rates (and/or LFP features) to continuous kinematics or discrete classes. The Kalman filter (Wu, Black and colleagues, BrainGate era) became the standard motor BCI baseline for cursor/arm decoding."
  why-it-works = "Cosine directional tuning ([@mech_population_vector]) makes a linear relationship between population firing and intended velocity a strong first approximation."
  limit = "Stationarity assumption breaks day-to-day; recalibration is routine. Performance is bounded by recorded unit yield and non-stationarity ([@lim_nonstationarity])."
  |> "[@x_wu_black_2006]"

@D dec_deep_rnn := "deep-learning / RNN decoders" :: therapy [ok recommended]
  moa = "Recurrent neural networks (and other deep models) replace linear decoders to capture nonlinear, temporally extended structure in population activity; have repeatedly raised state-of-the-art communication and movement-decoding performance in intracortical BCIs."
  evidence = "High-performance communication BCI (Pandarinath 2017, eLife) demonstrated rapid typing via intracortical motor-cortex recordings; Willett 2021 (Nature) demonstrated 'brain-to-text' via attempted handwriting decoded by a recurrent network in tetraplegic participants; Willett 2023 (Nature) decoded attempted speech to text at higher words-per-minute via intracortical arrays in speech motor cortex."
  limit = "Larger models need more data and stable signal; chronic decoder drift remains the real-world bottleneck ([@lim_nonstationarity])."
  |> "[@x_pandarinath_2017] · [@x_willett_2021] · [@x_willett_2023]"

@D dec_speech := "cortical speech decoding" :: therapy [ok recommended]
  what = "Two convergent landmark lines: (i) ECoG over speech motor / superior-temporal cortex decoded to text or audio (Chang lab; Moses 2021 NEJM, paralyzed individual with anarthria); (ii) intracortical arrays in motor-speech cortex decoded to text via RNN/transformer pipelines (Willett 2023)."
  state = "Tens to >60 words per minute on closed-vocabulary or open-vocabulary tasks have been reported in single-participant demonstrations — fast for the field, still well below natural speech, and not yet a routine clinical product."
  limit = "Per-participant calibration; restricted vocabularies in some studies; durability across months and across many patients is the next bar to clear."
  |> "[@x_moses_2021] · [@x_willett_2023]"

@D dec_calibration_nonstationarity := "session-to-session calibration" :: therapy [ok]
  problem = "Recorded units drift across days: small electrode micromotion, glial reaction, neural plasticity, and electronics changes shift the input distribution; a decoder trained yesterday under-performs today without recalibration."
  current-practice = "Routine short recalibration sessions; unsupervised / continual-learning approaches are an active research line."
  consequence = "Reported peak performance numbers usually reflect freshly calibrated decoders, not steady-state at-home performance — a meaningful caveat when comparing BCI accuracy to consumer-input benchmarks."

# ── §4 Stimulation, sensory feedback & closed-loop ───────────────────

@D stim_icms_feedback := "intracortical microstimulation for somatosensory feedback" :: therapy [ok recommended]
  moa = "Microstimulation in primary somatosensory cortex (S1) elicits localized tactile percepts; integrating these into a motor-BCI closed loop gives a user-perceptible 'sense of touch' from a prosthetic limb."
  landmark = "Flesher et al. (2016) demonstrated that ICMS in human S1 produces stable, localizable cutaneous percepts in a tetraplegic participant — first principled human demonstration of cortical somatosensory feedback."
  importance = "Without afferent feedback, dexterous prosthetic control is fragile; closed-loop sensorimotor BCI requires WRITE as well as READ."
  |> "[@x_flesher_2016]"

@D stim_dbs_neuromodulation := "deep brain stimulation (neuromodulation, distinct sibling)" :: therapy [ok]
  what = "Deep brain stimulation (DBS) of subthalamic nucleus / GPi (Parkinson's), VIM thalamus (essential tremor), and other targets is the most clinically mature 'WRITE' neural interface in humans (decades of use, FDA approval since the late 1990s)."
  status-vs-bci = "DBS is open-loop or simply triggered; it is NEUROMODULATION rather than intent decoding. It IS the benchmark for chronic stimulator safety/durability the BCI field implicitly references."
  honesty = "Listed for completeness and scope clarity — this tape does not duplicate the DBS literature; mentioned because BCI safety arguments often appeal to DBS-class experience."

@D stim_visual_prosthesis := "visual cortical / retinal prostheses" :: therapy [ok]
  what = "Stimulation devices intended to restore visual percepts: retinal implants (Argus II, historical; newer subretinal and suprachoroidal devices) and cortical visual prostheses (V1 stimulation arrays in trial)."
  state = "Argus II demonstrated feasibility of restoring phosphene-level vision in late retinitis pigmentosa; commercial program was discontinued by the manufacturer, illustrating the gap between technical feasibility and sustained clinical deployment. Cortical visual prostheses remain investigational."
  honesty = "Resolution and quality are far below natural sight; framing as 'cure for blindness' is overclaim. This is mobility/object-detection-grade percept, not photoreceptor restoration."

@D stim_closed_loop := "closed-loop BCI integration" :: therapy [ok]
  what = "Combining decode (READ) and stimulation (WRITE) within a control loop: e.g. brain-to-arm-with-touch (Collinger 2013 motor reach + Flesher 2016 ICMS feedback line), responsive neurostimulation for epilepsy (closed-loop detection + stimulation, distinct device class), and brain-state-triggered DBS."
  importance = "Closed-loop is where BCIs become PROSTHETIC SYSTEMS rather than pure recorders; it is also where joint safety analysis (stim parameters within tissue limits AND decoder errors not driving harmful stimulation) becomes paramount."

# ── §4b Modality comparison (qualitative, source-grounded) ───────────

@D cmp_axis := "comparison axis definition" :: comparison [ok]
  dimensions = "Each recording modality below is compared on: (1) invasiveness, (2) spatial resolution / signal type, (3) SNR / bandwidth, (4) dominant limiting factor, (5) signature failure mode."
  honesty = "Comparisons are QUALITATIVE (direction + relative ordering + cited landmark). Exact figures appear only where a single landmark study reported them and are paraphrased, not re-derived. There is NO single number ranking modalities; trade-offs are application-specific."

@D cmp_eeg := "scalp EEG" :: comparison [ok]
  invasiveness = "None."
  signal = "Summed cortical synaptic activity through skull/scalp; population-scale only, no single units."
  snr-bandwidth = "Lowest SNR among the modalities here; cm-scale spatial resolution; widely available."
  limiting-factor = "Skull attenuation and motion/muscle artefact ([@lim_snr_bandwidth])."
  failure-mode = "Low communication rate for BCI; slow signal-classification paradigms (P300, motor imagery)."

@D cmp_ecog := "ECoG / subdural & stereo-EEG" :: comparison [ok]
  invasiveness = "Craniotomy or burr-hole; typically tied to clinical epilepsy workup for human research."
  signal = "Surface (or depth) cortical population activity; broader bandwidth and higher SNR than EEG."
  snr-bandwidth = "Higher than EEG, lower than intracortical; mm-scale resolution."
  limiting-factor = "Surgical access and limited clinical implant duration; surface coverage limits depth access (mitigated by stereo-EEG)."
  failure-mode = "Demonstrated workhorse for speech-decoding research; not yet a routine standalone therapeutic device."
  |> "[@x_moses_2021]"

@D cmp_intracortical := "intracortical MEA (Utah / BrainGate)" :: comparison [ok]
  invasiveness = "Craniotomy + cortical penetration."
  signal = "Single-unit spikes + LFPs; the only modality giving routine single-cell access in humans at scale."
  snr-bandwidth = "Highest information-per-channel; the basis of every landmark human motor-BCI demonstration."
  limiting-factor = "Chronic-recording longevity (signal yield decays over months-to-years; [@lim_chronic_longevity]); session-to-session non-stationarity ([@lim_nonstationarity]); surgical risk ([@lim_surgical_risk])."
  failure-mode = "Glial encapsulation, tip degradation, sealing-failure infection risk; eventual explantation or signal loss."
  |> "[@x_hochberg_2006] · [@x_hochberg_2012]"

@D cmp_endovascular := "endovascular Stentrode" :: comparison [ok]
  invasiveness = "Endovascular catheter delivery — no craniotomy."
  signal = "Cortical activity recorded from inside a cortical vein; intermediate bandwidth/SNR."
  snr-bandwidth = "Between ECoG and EEG; basic switch-control demonstrated in early human implants."
  limiting-factor = "Bandwidth ceiling lower than ECoG; small participant numbers; vascular access constraints."
  failure-mode = "Field is early; long-horizon durability and dexterity ceilings are not yet established."
  |> "[@x_oxley_2021]"

@D cmp_synthesis := "comparison synthesis" :: comparison [ok]
  trade-off = "There is a real engineering trade-off: invasiveness buys SNR, bandwidth and single-unit access; non-invasiveness buys safety, reversibility and accessibility. No modality dominates the others on all axes — this is mechanistic complementarity, NOT a lattice product."
  no-universal-bci = "No single modality is 'the BCI'; clinically the right modality is set by application (motor restoration, communication, sensory feedback, epilepsy mapping, screening), patient profile, and acceptable risk. A 'general consumer brain interface' on intracortical-grade performance is not established."

# ── §5 Real-limits anchors (LATTICE_POLICY g1 — real-limits-first) ───

@D lim_chronic_longevity := "chronic-recording longevity / glial encapsulation" :: real-limit [ok required]
  wall = "HARD WALL (current materials / device science)"
  statement = "Penetrating microelectrodes provoke a chronic foreign-body / glial-scar response: microglial activation, astrocytic encapsulation, neuronal loss within tens of microns of the shank, and progressive impedance / signal-yield change over weeks-to-years. Materials and geometries that delay this exist; an indefinitely stable, full-yield human chronic recording is not currently a solved problem."
  consequence = "Reported high-performance human BCI demonstrations operate on a finite, drifting unit population; longitudinal performance depends on remaining yield + recalibration cadence ([@lim_nonstationarity]). Indefinite drop-in implant longevity should NOT be assumed."
  |> "[@x_polikov_2005]"

@D lim_snr_bandwidth := "SNR – bandwidth – channel-count trade-off" :: real-limit [ok required]
  wall = "PHYSICAL/INFORMATIONAL LIMIT"
  statement = "Information transmitted by a BCI is bounded by recorded signal SNR, bandwidth and the number of usable independent channels (a Shannon-bounded picture, modulated by neural-code redundancy). EEG is skull/scalp-limited; ECoG is surface-limited; intracortical is yield-limited; endovascular is geometry-limited. You cannot trade these freely."
  consequence = "Communication-rate claims must be cited per modality / per paradigm / per recalibration regime — there is no single 'BCI bandwidth' number."

@D lim_biocompatibility := "biocompatibility & infection risk (MEA failure modes)" :: real-limit [ok required]
  wall = "HARD WALL (chronic implant device class)"
  statement = "Chronic intracranial implants must maintain a hermetic seal against cerebrospinal fluid, avoid skin/dural breakdown at percutaneous connectors, and not promote infection over years of use. Documented MEA failure modes include connector failure, seal degradation, infection, and the chronic glial response."
  consequence = "Every additional year of intended implant life raises the integrated infection/explantation hazard; long-term reliability is a device-engineering frontier, not a solved spec."
  |> "[@x_polikov_2005]"

@D lim_surgical_risk := "surgical / hemorrhagic / infectious risk" :: real-limit [ok required]
  wall = "HARD WALL (procedural)"
  statement = "Implanting an intracortical array, ECoG grid, or DBS lead is open neurosurgery (or endovascular procedure for Stentrode): non-trivial peri-operative risk of intracranial hemorrhage, stroke, infection, seizure, and anesthesia-related morbidity. Endovascular delivery reduces but does not eliminate cerebrovascular procedural risk."
  consequence = "BCI must clear a risk/benefit bar set by the alternative (current standard of care for the patient's condition). 'Elective enhancement' framing collapses under this constraint; clinical first-in-human deployment has so far been in severely disabled participants for that reason."

@D lim_nonstationarity := "decoder generalization across sessions / users" :: real-limit [ok required]
  wall = "SOFT WALL"
  statement = "BCI signals are non-stationary across sessions (unit drift, plasticity, attentional state, electrode micromotion) and idiosyncratic across users (per-subject anatomy, implant placement). Decoders trained on a session typically degrade by the next without recalibration; cross-user transfer is harder still."
  consequence = "Reported peak accuracy / words-per-minute / bit-rates almost always reflect freshly-calibrated, single-subject, well-controlled settings; at-home, multi-week, multi-user generalization is the field's real test."

@D lim_neurodata_privacy := "neural-data privacy & autonomy / identity" :: real-limit [ok required]
  wall = "ETHICAL / SOCIETAL LIMIT (not a number)"
  statement = "Neural data plausibly reveals more than behavioural output (attention, intent, affect, possibly memory cues). Regulatory frameworks for 'neurorights' / mental privacy are emerging in some jurisdictions; consent, data retention, third-party access, and identity/agency questions in closed-loop stimulation are unresolved."
  consequence = "BCI deployment cannot be reduced to a clinical-efficacy metric — autonomy and informational self-determination are first-class constraints. This is a real limit on the form acceptable BCI products may take, not a 'soft' afterthought."
  |> "[@x_yuste_2017]"

@D lim_evidence_grade := "evidence-grade discipline" :: real-limit [ok required]
  wall = "EPISTEMIC LIMIT (claim-quality)"
  statement = "Several BCI claims circulate at company-press-release or preprint grade; peer-reviewed, multi-participant, longitudinal demonstrations are far rarer. Treating PR-grade claims as equivalent to peer-reviewed clinical evidence misrepresents the field."
  consequence = "This tape paraphrases peer-reviewed landmarks; press-release-only claims are explicitly NOT cited as evidence. See [@cmp_synthesis] no-universal-BCI."

# ── §6 n=6 lattice stance (HONEST — observation, not derivation) ─────

@F f_lattice_fit := "lattice-fit-on-bci-biology" :: governance [required deny:write]
  pattern = "Deriving BCI / neuroscience facts FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) — e.g. the deleted stub's '시각피질 V1~V6 = n=6', '운동피질 DOF=6=SE(3)', '청각피질 σ-φ=10 옥타브', '디코더 정확도 = σ-φ=10% 향상', '뇌질환 τ=4 보편성' etc."
  why = "Neuroscience and BCI engineering expose NO natural n=6 invariant. The deleted stub fabricated efficacy, channel counts, accuracies and 'universal' device claims by reading off lattice tokens — a direct hexa-bio AGENTS.tape g1/g2/g3/g8 + f1/f2/f3 violation. f1 forbids lattice-fit, f2 forbids in-silico→clinical/efficacy claim, f3 forbids shadowing sister-repo logic with fabricated wrappers."
  remedy = "Cite real neuroscience / BCI literature (this tape's @X entries). Lattice may only be a coincidental OBSERVATION (e.g. SE(3) really is 6-dimensional rigid-body motion — but the relevant fact is the kinematics, not its lattice-fit), never a derivation source for any BCI accuracy, channel-count, decoder-performance, longevity or 'universal-device' claim."

@N n6_honest_stance := "BCI / neuroscience has no natural n=6 invariant" :: note [required]
  text = "Stated plainly: brain-machine interface engineering and the underlying neuroscience expose NO natural n=6 invariant. Visual cortex is hierarchically organized (V1, V2, V3, V4, MT/V5, IT, …) — labels and counts depend on species and atlas, and 'V1–V6' is not a closed n=6 set. Cortical Brodmann areas number ~52, NOT 6. Cranial nerves number 12 (coincidentally matches σ(6), but this is OBSERVATION ONLY — cranial nerves are not derived from the lattice). Utah arrays are commonly 96-channel; high-density probes reach thousands of sites; channel counts are engineering choices, not lattice values. Motor SE(3) does have 6 DOF in rigid-body kinematics — but this is a fact of Euclidean geometry of rigid motion, not of an n=6 hexa lattice, and BCI decoders rarely operate cleanly in raw SE(3) anyway. Per LATTICE_POLICY g1/g2 + lattice-as-tool: the lattice is DECLINED here as a derivation tool. Coincidences may be observed; nothing here is derived from them. This honesty IS the corrective for the audited lattice-tautology stub this file replaced."

# ── §7 Verifiable predictions (real, falsifiable — NOT lattice) ──────

@D tp_1 := "TP-1 invasiveness ↔ information-per-channel gradient" :: prediction [ok]
  claim = "For a held-fixed motor BCI task (e.g. 2-D cursor control), achievable bit-rate / words-per-minute is monotonically higher for intracortical single-unit recording than for ECoG, and higher for ECoG than for scalp EEG, under matched user training."
  falsifier = "If matched-task, matched-training studies showed scalp-EEG bit-rates routinely meeting or exceeding intracortical single-unit performance, the SNR-bandwidth trade-off ([@lim_snr_bandwidth]) and the rationale for the entire invasive-BCI program would be wrong."
  source = "[@x_hochberg_2006] · [@x_pandarinath_2017]"

@D tp_2 := "TP-2 chronic decoder drift" :: prediction [ok]
  claim = "Intracortical-array BCI decoders trained on one session and applied to a session N days later (without recalibration) lose accuracy monotonically with N for typical N over weeks, in the absence of explicit drift-correction algorithms."
  falsifier = "If across-participant chronic studies showed indefinitely stable un-recalibrated decoders for months in the typical case, [@lim_nonstationarity] is wrong."
  source = "[@x_pandarinath_2017]"

@D tp_3 := "TP-3 ICMS-feedback improves dexterous control" :: prediction [ok]
  claim = "Adding intracortical microstimulation-based somatosensory feedback to a motor BCI improves performance on dexterous manipulation tasks vs the same BCI without feedback, in matched intracortical participants."
  falsifier = "If properly powered crossover studies showed no benefit (or harm) from adding ICMS feedback to motor BCI on dexterous tasks, the closed-loop premise ([@stim_icms_feedback] / [@stim_closed_loop]) would be wrong."
  source = "[@x_flesher_2016] · [@x_collinger_2013]"

# ── §8 External citations (real, landmark literature) ────────────────

@X x_hodgkin_huxley_1952 := "Hodgkin AL, Huxley AF 1952" :: literature [active]
  ref = "Hodgkin AL, Huxley AF. A quantitative description of membrane current and its application to conduction and excitation in nerve. J Physiol 1952;117:500–544. (foundational action-potential model; Nobel 1963)"

@X x_georgopoulos_1986 := "Georgopoulos AP et al 1986" :: literature [active]
  ref = "Georgopoulos AP, Schwartz AB, Kettner RE. Neuronal population coding of movement direction. Science 1986;233:1416–1419. (population vector in motor cortex)"

@X x_wessberg_2000 := "Wessberg J et al 2000" :: literature [active]
  ref = "Wessberg J et al. Real-time prediction of hand trajectory by ensembles of cortical neurons in primates. Nature 2000;408:361–365. (Nicolelis lab; cortical-ensemble motor decoding in monkeys)"

@X x_hochberg_2006 := "Hochberg LR et al 2006" :: literature [active]
  ref = "Hochberg LR et al. Neuronal ensemble control of prosthetic devices by a human with tetraplegia. Nature 2006;442:164–171. (BrainGate first human intracortical BCI report)"

@X x_hochberg_2012 := "Hochberg LR et al 2012" :: literature [active]
  ref = "Hochberg LR et al. Reach and grasp by people with tetraplegia using a neurally controlled robotic arm. Nature 2012;485:372–375. (BrainGate robotic-arm reach-and-grasp)"

@X x_collinger_2013 := "Collinger JL et al 2013" :: literature [active]
  ref = "Collinger JL et al. High-performance neuroprosthetic control by an individual with tetraplegia. Lancet 2013;381:557–564. (7-DOF robotic-arm control via intracortical BCI)"

@X x_flesher_2016 := "Flesher SN et al 2016" :: literature [active]
  ref = "Flesher SN et al. Intracortical microstimulation of human somatosensory cortex. Sci Transl Med 2016;8:361ra141. (cortical somatosensory feedback in a tetraplegic participant)"

@X x_pandarinath_2017 := "Pandarinath C et al 2017" :: literature [active]
  ref = "Pandarinath C et al. High performance communication by people with paralysis using an intracortical brain-computer interface. eLife 2017;6:e18554. (rapid intracortical communication BCI)"

@X x_willett_2021 := "Willett FR et al 2021" :: literature [active]
  ref = "Willett FR et al. High-performance brain-to-text communication via handwriting. Nature 2021;593:249–254. (attempted-handwriting decoded by RNN from motor-cortex intracortical arrays)"

@X x_willett_2023 := "Willett FR et al 2023" :: literature [active]
  ref = "Willett FR et al. A high-performance speech neuroprosthesis. Nature 2023. (intracortical speech-to-text decoding via motor-speech-cortex arrays; primary-author/era cited, exact volume/page paraphrased)"

@X x_moses_2021 := "Moses DA et al 2021" :: literature [active]
  ref = "Moses DA et al. Neuroprosthesis for decoding speech in a paralyzed person with anarthria. N Engl J Med 2021;385:217–227. (Chang lab; cortical speech decoding via ECoG)"

@X x_oxley_2021 := "Oxley TJ et al 2021" :: literature [active]
  ref = "Oxley TJ et al. Motor neuroprosthesis implanted with neurointerventional surgery improves capacity for activities of daily living tasks in severe paralysis: first in-human experience. J NeuroInterv Surg 2021. (Stentrode endovascular BCI first-in-human; primary-author/era — exact volume/page paraphrased)"

@X x_jun_neuropixels_2017 := "Jun JJ et al 2017 (Neuropixels)" :: literature [active]
  ref = "Jun JJ et al. Fully integrated silicon probes for high-density recording of neural activity. Nature 2017;551:232–236. (Neuropixels CMOS silicon probe)"

@X x_wu_black_2006 := "Wu W, Black MJ et al" :: literature [active]
  ref = "Wu W, Gao Y, Bienenstock E, Donoghue JP, Black MJ. Bayesian population decoding of motor cortical activity using a Kalman filter. (Kalman-filter decoder for intracortical motor BCI; primary-author/era cited, exact volume not asserted)"

@X x_polikov_2005 := "Polikov VS et al 2005" :: literature [active]
  ref = "Polikov VS, Tresco PA, Reichert WM. Response of brain tissue to chronically implanted neural electrodes. J Neurosci Methods 2005;148:1–18. (glial-scar / chronic foreign-body response review)"

@X x_lebedev_nicolelis_2006 := "Lebedev MA, Nicolelis MAL 2006" :: literature [active]
  ref = "Lebedev MA, Nicolelis MAL. Brain-machine interfaces: past, present and future. Trends Neurosci 2006;29:536–546. (foundational BMI review)"

@X x_yuste_2017 := "Yuste R et al 2017" :: literature [active]
  ref = "Yuste R et al. Four ethical priorities for neurotechnologies and AI. Nature 2017;551:159–163. (neurorights / neural-data privacy framing; primary-author/era cited)"
