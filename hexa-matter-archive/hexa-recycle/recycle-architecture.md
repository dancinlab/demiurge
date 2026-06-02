<!-- @authored: 2026-05-13 -->
<!-- @phase: C — recycle architectural overview -->

# recycle-architecture — mechanical vs chemical vs dissolution; entropy floor

> Architectural overview of recycle paths. Companion to `RECYCLING.md`
> and `HEXA-RECYCLE.md` (n=6 aux).

## §1 The recycle route hierarchy

```
                       Material End-of-Life
                              |
              +---------------+----------------+
              |                                |
        recycle pathway                   landfill / incineration
              |                                |
   +----------+----------+              (escape to environment:
   |          |          |               microplastics — POL cross-link)
 mechanical chemical  dissolution
 (sort →    (depoly-   (selective
  shred →    merize     solvent
  re-melt   to monomer  dissolution)
  → re-     → repoly-
  pellet)   merize)

   +-----------+
   |
 sorting tech
   |
   +------+-------+--------+--------+
   |      |       |        |        |
 NIR    density  FTIR    LIBS     manual
 spec   flotation imaging  spec     pick
        (per ρ)
```

## §2 Recycle by material class

### §2.1 Polymer recycle

| Method | Step | Polymer compatibility | Quality loss |
|--------|------|----------------------|--------------|
| Mechanical | sort → shred → wash → melt → pellet | each polymer class separately (PE, PP, PET, PS) | down-cycling typical |
| Chemical (glycolysis) | depolymerize PET with EG → BHET monomer | PET specifically | minimal — can re-make virgin-grade |
| Chemical (methanolysis) | PET with methanol → DMT monomer | PET, PA | minimal |
| Chemical (hydrolysis) | PET with H₂O → TPA + EG | PET, PLA, PHA | minimal |
| Chemical (pyrolysis) | thermal decomposition → liquid hydrocarbon | mixed PE/PP/PS | downstream sortable |
| Solvolysis (CreaSolv) | dissolve PS in solvent → precipitate | mixed PS (EPS, XPS) | high purity |
| Enzymatic (PETase) | cutinase enzyme breaks PET ester | PET | bio-based; Carbios pilot |

Vendors:
- Loop Industries (PET methanolysis)
- Eastman Chemical (polyester renewal)
- Carbios (enzymatic PET — pilot 50 tpa, Clermont-Ferrand, France)
- Loop Industries / Indorama Ventures
- Plastic Energy (pyrolysis)
- CreaSolv (BASF / Fraunhofer; PS solvolysis)

### §2.2 Metal recycle

| Material | Recycle rate (~) | Energy ratio (recycle / virgin) |
|----------|------------------|---------------------------------|
| Steel | ~85% (high) | ~25% energy of BF-BOF route |
| Aluminum | ~75% | ~5% energy of Hall-Héroult |
| Copper | ~65% | ~15% energy of pyrometallurgical |
| Gold (jewelry, electronics) | ~85% | mature, very high recovery rate |
| Lead (battery) | ~95% (highest) | mature |
| Platinum (catalyst converter) | ~50% | high-value recovery |
| Rare earths (NdFeB magnet) | < 5% | difficult; entropy of Re-mixed alloy high |

### §2.3 Glass recycle

- Cullet (broken glass) recycle: closed-loop in container glass (bottles)
- Quality loss: minor (color sort needed for clear/green/amber)
- Specialty glass (Pyrex, optical): closed-loop within vendor
- Cullet → batch furnace remelt at ~1100-1400 °C

### §2.4 Ceramic recycle

- Difficult: high-T sintered phases hard to disassemble
- Construction ceramic (brick, tile): aggregate for road base
- Engineering ceramic (Si₃N₄, SiC, Al₂O₃): typically NOT recycled; sometimes
  reprocessed via crushing + sintering with new powder

## §3 The Gibbs ΔS_mix floor (L12)

For a binary mix at composition x (mole fraction):

```
ΔG_mix = ΔH_mix - T·ΔS_mix
ΔS_mix = -R [x ln(x) + (1-x) ln(1-x)]
       = +R·ln(2) ≈ 5.76 J/(mol·K) at x = 0.5

To separate: must input at least T·ΔS_mix ≈ 1.73 kJ/mol at 300 K
             (per mole of mix at 50/50)
```

This is the HARD wall on physical separation of molecular-scale mixtures.
For polymer recycling:
- Bottle-scale sort (PE vs PP whole bottles): YES, NIR spectroscopy works
- Molecularly mixed PE/PP blend: NO, cannot mechanically separate
- Cross-linked thermoset (cured epoxy): NO mechanical recycle path; only
  chemical (e.g., epoxy depolymerization research at Stanford / Mac-Murray)

The `recycle_n6/` verb is the n=6 lattice arithmetic auxiliary verb. It
performs σ(6)=12, τ(6)=4, φ(6)=2, J₂=24 identity checks for in-software
consistency. **It does NOT predict any real recycling efficiency** — per
`LATTICE_POLICY §1.3`, the lattice is auxiliary.

## §4 The forward-vs-reverse asymmetry

Forward (synthesis) and reverse (recycle) processes are not symmetric due
to the Gibbs ΔS_mix floor:

| Process | Synthesis (forward) | Recycle (reverse) |
|---------|---------------------|-------------------|
| Polymerization | monomer + catalyst + heat → polymer | polymer + heat → mixed products (pyrolysis); or depolymerize back to monomer with specific catalyst |
| Alloying | metal + alloy element + heat → alloy | alloy + heat → mostly retains alloy (cannot reverse to pure constituents without large energy input) |
| Cement set | cement + H₂O → C-S-H + Ca(OH)₂ | concrete → crushed (aggregate use only); cannot recover cement |
| Glass melt | sand + soda + lime + heat → glass | broken glass → cullet → remelt (closed loop) |
| Dye uptake | dye + fiber + heat → dyed fabric | dyed fabric → cannot recover dye (dilution + bond) |

This asymmetry means recycling is fundamentally entropy-limited; "infinite
recycle" / cradle-to-cradle as marketed is UNPROVEN at thermodynamic limit.
The achievable closure is BOUNDED by L12.

## §5 Selftest hooks

- `selftest/recycling_yield_audit.py` (Phase B target): parse recycling.md
  for yield claims; cross-check vendor claims (Loop, Eastman) AS-IS without
- `selftest/lattice_arithmetic_regression.py` (Phase B): verify σ(6)=12,
  τ(6)=4, φ(6)=2, J₂=24, master identity σ·φ = n·τ — but does NOT
  cross-check these against recycling efficiency.

## §6 Cross-group interfaces

### §6.1 PRC-recycle ↔ POL

Chemical recycling of PET, PLA, PA targets POL chemistry. Mechanical sort
for PE/PP whole-form factor uses NIR (POL backbone IR signature).

### §6.2 PRC-recycle ↔ MET

Steel/Cu/Al scrap recycle is mature. Rare-earth-from-NdFeB recycle is
< 5% (entropy of dilute mix prohibits low-energy recovery).

### §6.3 PRC-recycle ↔ CER

Glass recycle (cullet) is closed-loop. Ceramic recycle is mostly
aggregate-grade down-cycle.

### §6.4 PRC-recycle ↔ environmental

Microplastics is the escape route when polymer recycle fails. NOAA / EPA /
5 Gyres data lives in `microplastics/`.

---

*Phase C recycle architecture overview, authored 2026-05-13.*
