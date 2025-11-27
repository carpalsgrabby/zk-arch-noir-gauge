# zk-arch-noir-gauge

A minimal Noir (Aztec) example that implements a simple “architecture style gauge” for Web3 systems.

The circuit selects one of three abstract Web3 architectural styles:

0 — Aztec-style zk privacy rollup  
1 — Zama-style FHE compute stack  
2 — Soundness-first protocol (formal-verification driven)

All logic runs inside a provable Noir circuit that can be embedded into Aztec (ZK L2 on Ethereum) or similar ZK tooling.


## Repository Structure

This repository contains exactly two files:

1. app.nr  
   The Noir circuit that computes the style index.

2. README.md  
   This file. Contains setup, usage, explanation, and notes.


## Concept

The gauge models three high-level Web3 design axes:

- **privacy**  
  How important encrypted state / private execution is (e.g., Aztec-style rollups).

- **FHE compute**  
  How important fully homomorphic encrypted computation is (e.g., Zama-style systems).

- **soundness**  
  How important formal verification and strict correctness guarantees are (soundness-first protocols).

All inputs are integers from **0 to 100**.  
The circuit computes weighted scores for each style and returns the index of the strongest match.


## Installation

1. Install the Noir toolchain (Rust + nargo).  
2. Create a new Noir project using nargo.  
3. Replace the generated `src/main.nr` (or add a new module) with the contents of `app.nr`.  
4. Build or prove the circuit using Noir tooling as usual.

Exact setup steps depend on the current Noir / Aztec toolchain documentation.


## Usage

1. Create or open your Noir project.  
2. Copy `app.nr` into `src/main.nr` or import it as a module.  
3. Run the circuit with three public arguments:

   - privacy (0–100)  
   - fhe (0–100)  
   - soundness (0–100)

The circuit will return a single public value:

- **0** → Aztec-style zk privacy rollup  
- **1** → Zama-style FHE compute stack  
- **2** → Soundness-first protocol


## Output Explanation

The circuit computes three weighted sums:

- Aztec score = 3 × privacy + 2 × soundness  
- Zama score  = 2 × privacy + 3 × FHE  
- Soundness   = 4 × soundness + 1 × privacy

The style with the highest score wins.

Tie-breaking rule:

- Aztec wins ties vs Zama and Soundness.
- Zama wins ties vs Soundness.


## Background and Motivation

- **Aztec**  
  Noir is the native circuit language for Aztec.  
  Style 0 represents architectures prioritizing privacy-preserving execution.

- **Zama**  
  Style 1 emphasizes heavy FHE usage and encrypted compute pipelines.

- **Soundness-first**  
  Style 2 models conservative, correctness-driven protocol designs, often used in research and high-assurance systems.


## Notes

- All weights and formulas are illustrative and can be changed.  
- The model is intentionally simple to demonstrate ZK-friendly logic.  
- The output can be embedded in larger circuits or combined with other Aztec / Noir tooling.  
- This repository is intended as a minimal template for Noir-based Web3 sketches.
