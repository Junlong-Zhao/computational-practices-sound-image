# Notes — Oscillators, Envelopes, and Visualization

- **Oscillators** (Sin, Saw, Tri) produce periodic waveforms with different harmonic spectra. We combine them to get a richer sound: bassy rumble (Sin), bright sweep (Saw), and a mid-range lead (Tri).
- **Envelope (ADSR-ish)** is approximated using `Env.play(osc, attack, sustainTime, sustainLevel, release)`. It shapes the loudness over time to create “hit → sustain → fade”.
- **Frequency modulation (FM-like)** here is done by gradually changing `osc.freq()` over time and adding an LFO vibrato:  
  `freq = base + sweep(t) + depth * sin(2π * lfoRate * t)`.
- **Visualization mapping**: oscillator *amplitude* and *frequency* are mapped to circle radius, colour hue, and radial spikes. This follows the brief: “use the output of an oscillator as a parameter for the sketch”.
- **Filters**: From EDM article — LPF/HPF/BPF shape timbre. I kept the core sketch focused on oscillators (meets “≥3 oscillators and/or filters”) for portability and to avoid driver issues across machines. Filters like `LowPass`, `HighPass`, `Reverb`, `Delay` can be added later if professors want (the Sound library exposes them).
