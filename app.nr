// app.nr
// Chooses between three styles based on 0–100 preference sliders:
//
//   0u8 => Aztec-style zk privacy rollup
//   1u8 => Zama-style FHE compute stack
//   2u8 => Soundness-first protocol
//
// Inputs (public):
//   privacy   : how important privacy is       (0–100)
//   fhe       : how important FHE support is   (0–100)
//   soundness : how important formal soundness is (0–100)
//
// Output (public):
//   style_idx : 0 / 1 / 2 as described above (declared as pub u8)

fn main(privacy: u8, fhe: u8, soundness: u8) -> pub u8 {
    let p: u8 = if privacy > 100u8 { 100u8 } else { privacy };
    let f: u8 = if fhe > 100u8 { 100u8 } else { fhe };
    let s: u8 = if soundness > 100u8 { 100u8 } else { soundness };

    let p16: u16 = p as u16;
    let f16: u16 = f as u16;
    let s16: u16 = s as u16;

    let aztec_score: u16 = p16 * 3u16 + s16 * 2u16;
    let zama_score: u16 = p16 * 2u16 + f16 * 3u16;
    let snd_score: u16 = s16 * 4u16 + p16;

    let mut best_idx: u8 = 0u8;
    let mut best_score: u16 = aztec_score;

    if zama_score > best_score {
        best_idx = 1u8;
        best_score = zama_score;
    }

    if snd_score > best_score {
        best_idx = 2u8;
        best_score = snd_score;
    }

    best_idx
}
