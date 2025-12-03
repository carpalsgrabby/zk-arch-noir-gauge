// app_extended.nr
// New extended gauge circuit for zk-arch-noir-gauge
//
// Adds a 4th axis: ux_speed
// Keeps the original 3 styles:
//   0 = Aztec-style privacy rollup
//   1 = Zama-style FHE compute stack
//   2 = Soundness-first protocol
//
// Returns the chosen style index as a public output.

fn main(
    privacy: pub u32,
    fhe: pub u32,
    soundness: pub u32,
    ux_speed: pub u32,
) -> pub u32 {
    // Validate inputs are within 0–100
    assert(privacy <= 100, "privacy out of range");
    assert(fhe <= 100, "fhe out of range");
    assert(soundness <= 100, "soundness out of range");
    assert(ux_speed <= 100, "ux_speed out of range");

    // Calculate extended scores
    let (aztec_score, zama_score, soundness_score) =
        compute_extended_scores(
            privacy,
            fhe,
            soundness,
            ux_speed
        );

    // Select best style with tie-breaking:
    // Aztec > Zama > Soundness
    let style =
        select_style_with_priority(
            aztec_score,
            zama_score,
            soundness_score
        );

    style
}

// ----------------------------------
// Score computation
// ----------------------------------

// Weighted scoring rules including UX axis.
//
// Aztec: privacy-pref + good soundness + some UX
// Zama:  FHE-pref + some privacy
// Soundness-first: strong soundness + small UX bonus
fn compute_extended_scores(
    privacy: u32,
    fhe: u32,
    soundness: u32,
    ux_speed: u32
) -> (u32, u32, u32) {

    let aztec_score: u32 =
        3u32 * privacy +
        2u32 * soundness +
        1u32 * ux_speed;

    let zama_score: u32 =
        2u32 * privacy +
        3u32 * fhe +
        0u32 * ux_speed;

    let soundness_score: u32 =
        4u32 * soundness +
        1u32 * privacy +
        1u32 * ux_speed;

    (aztec_score, zama_score, soundness_score)
}

// ----------------------------------
// Style selection with priority
// ----------------------------------
//
// Keeps determinism:
// - Aztec wins ties vs Zama + Soundness
// - Zama wins ties vs Soundness
fn select_style_with_priority(
    aztec_score: u32,
    zama_score: u32,
    soundness_score: u32
) -> u32 {

    let mut best_index: u32 = 0;
    let mut best_score: u32 = aztec_score;

    if zama_score > best_score {
        best_score = zama_score;
        best_index = 1;
    }

    if soundness_score > best_score {
        best_score = soundness_score;
        best_index = 2;
    }

    best_index
}
