# computational-practices-sound-image
Computational Practices: Sound and Image Processing
# Computational Practices: Sound & Image Processing — Weeks 1–9 (no Week 8)
> **Environment:** Processing 4.4.6 (Java mode).  
> **Audio:** install **Sound** → `Sketch → Import Library… → Add Library… → search "Sound"`.  
> **Run:** open each week’s `.pde` in Processing and press ▶︎.
## Repository layout
week01/ Getting started, pixels & colour

week02/ Pixel manipulation lab (threshold/stripes/checkerboard/half-invert)

week03/ Vector graphics (artist study + 2D transforms)

week04/ Noise + image filters + mouse mask

week05/ Dithering (Threshold / Bayer 4×4 / Floyd–Steinberg) + Convolution kernels

week06/ Oscillators & sound visualisation (Sound library)

week07/ Algorithmic music with samples (drum looper)

week09/ Vectors & motion: bouncing ball + mini game “Flower Glide”

Week 10/  Particle Systems (Developed further)

---

## Demo videos (10–30s each)

- Week 01 — Pixels & Colour:[Week01 Demo Video](https://drive.google.com/file/d/1pdMVE4aS6eaG0DH3wd53qp-OL5tthM6o/view?usp=drive_link)

- Week 02 — Manipulating Pixels:
[Two Color demo](https://drive.google.com/file/d/16WT5FlA_hYOAulYACj8VT3g2A6WuuabD/view?usp=drive_link)
[Stripe Makers demo](https://drive.google.com/file/d/15alJL7q-T3u-FD4IplZb5HLDEXnqwy15/view?usp=drive_link)
[Checkerboard demo](https://drive.google.com/file/d/1tKpHNVE9gvRu4eDJf3f6bIzikgwUxg6E/view?usp=drive_link)
[Half/Half demo](https://drive.google.com/file/d/1CV7xASMA1c8Ef2WyWDWiUW7bBHG_KRes/view?usp=drive_link)
  
- Week 03 — Vector Graphics:
[Transform practice](https://drive.google.com/file/d/1pDd43hJpbBhchmc5Vpo2pv4DTRKJMblE/view?usp=drive_link)
[Mondrian final](https://drive.google.com/file/d/180-HiWwZJNqSunNxato3AwdYV_G7FGbU/view?usp=drive_link)
- Week 04 — Noise, Filters & Masking:
[Noise demo](https://drive.google.com/file/d/11c193mEuzXtkT-FDn5NCwwnd-dEUnV-H/view?usp=drive_link)
[Masked filters demo](https://drive.google.com/file/d/1dG8Wq8siGciF8FD-CoMeaZaycwGh6Qpf/view?usp=drive_link)
- Week 05 — Dithering & Convolution:
  [Dithering demo](https://drive.google.com/file/d/1fQmi811ZHI3R3NM5ZmJy34ZCyGcjeAFM/view?usp=drive_link)
  [Convolution demo](https://drive.google.com/file/d/1XEZke8cYyrEsV0ZkUHjlaKznwDkH9zsJ/view?usp=drive_link)
  
- Week 06 — Oscillators & Visualiser:
[Sci-fi arrival sound](https://drive.google.com/file/d/1RxUtvn6JqNJvK8u5sfPKKNUfIG9FWtle/view?usp=drive_link)
[Sound-reactive visuals](https://drive.google.com/file/d/1qJM5hK8K19HqeFczP3Kndu5zPCFkjZZj/view?usp=drive_link)
- Week 07 — Algorithmic Music & Sampling (Drum Looper):
  [Week7-Algorithmic Drum Looper](https://drive.google.com/file/d/1QIkJP71RcDDFu0LSO1PkZyHbZt2fkrg3/view?usp=drive_link)
- Week 08 — Hackathon (no graded work)
- Week 09 — Vectors & Motion (Mini game):
[bouncing ball](https://drive.google.com/file/d/1TA9XYUTyzycrd-bF8HSZGUUV0vy34TSL/view?usp=drive_link)
[Flower Glide](https://drive.google.com/file/d/15zFr9l1IoAbpEMPxf8LfJRY8abSSTv71/view?usp=drive_link)
- **Week 10** — Particle Systems (Developed further): [Week10-Particle System](https://drive.google.com/file/d/1y5RIxiLCbWS1XE5dc4AHG7wW35vztVFk/view?usp=drive_link)

---

## Week 1 — Pixels & Colour
**What:** repo setup, Processing warm-ups, gradients/pixels basics.  
**Files:** `week01/week01_pixels.pde` 

**Notes:** if `saveFrame()` is used, exported images go to a folder like `week01/frames/`.

**Demo Video**：[Week01 Demo Video](./week01/week01.mp4)

**Google Drive**：[Week01 Demo Video](https://drive.google.com/file/d/1pdMVE4aS6eaG0DH3wd53qp-OL5tthM6o/view?usp=drive_link)

---

## Week 2 — Manipulating & Analysing Pixels
**What:** four pixel filters/constraints:

1. **Two-Color** (threshold)  
2. **Stripe Makers** (every other row brighter)  
3. **Checkerboard Creators** (modify alternating cells)  
4. **Half/Half** (half inverted)

**Files:** `week02/week02_twoColor.pde` ,`week02/week02_stripes.pde`,`week02/week02_checker.pde`,`week02/week02_halfhalf.pde`
**Controls:** `1` Threshold, `2` Stripes, `3` Checkerboard, `4` Half-invert.  
*(Optional)* `O` open image, `S` save output.

**Demo Videos**

- [Two Color demo](./week02/week2-two-color.mp4)
- [Stripe Makers demo](./week02/week2-stripes.mp4)
- [Checkerboard demo](./week02/week2-checker.mp4)
- [Half/Half demo](./week02/week2-halfhalf.mp4)
- 
Google Drive:
- [Two Color demo](https://drive.google.com/file/d/16WT5FlA_hYOAulYACj8VT3g2A6WuuabD/view?usp=drive_link)
- [Stripe Makers demo](https://drive.google.com/file/d/15alJL7q-T3u-FD4IplZb5HLDEXnqwy15/view?usp=drive_link)
- [Checkerboard demo](https://drive.google.com/file/d/1tKpHNVE9gvRu4eDJf3f6bIzikgwUxg6E/view?usp=drive_link)
- [Half/Half demo](https://drive.google.com/file/d/1CV7xASMA1c8Ef2WyWDWiUW7bBHG_KRes/view?usp=drive_link)
---

## Week 3 — Vector Graphics
**What:** vector primitives + `push/pop + translate/rotate/scale`; homage to modern artists (Kandinsky/Mondrian style).  
**Files:**

- `week03/week03_mondrian.pde` (grid, thick black strokes, primary colours)  
- `week03/week03_shapes_transform.pde` (polygons, petals, star/arms)

**Controls:** `S` save; `1/2/3` switch layouts (if provided).

**Demo Videos**

- [Transform practice](./week03/week3-practice.mp4)
- [Mondrian final](./week03/week3-final.mp4)

Google Drive:
- [Transform practice](https://drive.google.com/file/d/1pDd43hJpbBhchmc5Vpo2pv4DTRKJMblE/view?usp=drive_link)
- [Mondrian final](https://drive.google.com/file/d/180-HiWwZJNqSunNxato3AwdYV_G7FGbU/view?usp=drive_link)
---

## Week 4 — Filtering Images (+ Mask)
**What:**
- **Hr1:** Perlin Noise exploration.  
- **Hr2:** brightness/contrast/invert/duotone/threshold filters.  
- **Hr3:** **mouse circular mask** using `dist()` → different filters inside vs. outside.

**Files:**  
- `week04/week04_noise_filters.pde`  
- `week04/week04_masking.pde`

**Typical controls:** `1` Threshold, `2` Brightness, `3` Contrast, `4` Invert, `5` Duotone; mouse moves mask centre; `S` save.

**Demo Videos**

- [Noise demo](./week04/week4-noise.mp4)
- [Masked filters demo](./week04/week4-filters+masking.mp4)

Google Drive:
- [Noise demo](https://drive.google.com/file/d/11c193mEuzXtkT-FDn5NCwwnd-dEUnV-H/view?usp=drive_link)
- [Masked filters demo](https://drive.google.com/file/d/1dG8Wq8siGciF8FD-CoMeaZaycwGh6Qpf/view?usp=drive_link)
---

## Week 5 — Dithering & Convolution
**What:**
- Dithering: **Threshold / Bayer 4×4 / Floyd–Steinberg** (error diffusion).  
- Convolution: **Box / Gaussian / Sharpen / Edge / Emboss / Sobel** kernels.

**Files:**  
- `week05/week05_dithering.pde`  
- `week05/week05_convolution.pde`

**Controls:**  
- **Dither:** `1` Threshold, `2` Bayer 4×4, `3` Floyd–Steinberg; `L` reload, `S` save.  
- **Convolution:** `1` Box, `2` Gaussian, `3` Sharpen, `4` Edge, `5` Emboss, `6` Sobel; `R` reset, `S` save.

**Demo Videos**

- [Dithering demo](./week05/week5-Dithering.mp4)
- [Convolution demo](./week05/week5-Convolution.mp4)

Google Drive:
- [Dithering demo](https://drive.google.com/file/d/1fQmi811ZHI3R3NM5ZmJy34ZCyGcjeAFM/view?usp=drive_link)
- [Convolution demo](https://drive.google.com/file/d/1XEZke8cYyrEsV0ZkUHjlaKznwDkH9zsJ/view?usp=drive_link)
---

## Week 6 — Digital Sound & Oscillation
**What:** Sound library; **Sin/Tri/Saw** oscillators; map amplitude/frequency to **audio-reactive visuals**.  
**Files:**
- `week06/week06_osc_demo.pde` (multiple oscillators / envelopes / modulation)
- `week06/week06_visualiser.pde` (waveform, radial bars, etc.)

**Controls:** `1/2/3` waveform, `A/Z` frequency, `[`/`]` volume or envelope, `S` save.  
**Note:** install **Sound**; mind output volume.

**Demo Videos**

- [Sci-fi arrival sound](./week06/week6-Planet%20Landing%20sound.mp4)
- [Sound-reactive visuals](./week06/week6-Sound-ReactiveVisualization.mp4)

Google Drive:
- [Sci-fi arrival sound](https://drive.google.com/file/d/1RxUtvn6JqNJvK8u5sfPKKNUfIG9FWtle/view?usp=drive_link)
- [Sound-reactive visuals](https://drive.google.com/file/d/1qJM5hK8K19HqeFczP3Kndu5zPCFkjZZj/view?usp=drive_link)

---

## Week 7 — Algorithmic Music & Sampling
**What:** at least **4 samples** (kick/snare/hat/clap); **16-step drum looper**; A/B pattern evolution, probability fills, accents/ghost notes; optional synth bass (SinOsc + `Env`).  
**Files & data:**

- `week07/week07_drum_looper.pde`
- **Samples in `week07/data/`:** `kick.wav`, `snare.wav`, `hat.wav`, `clap.wav` (44.1k/16-bit recommended)

**Controls:** `SPACE` start/stop, `↑/↓` BPM, `R` roll/fill, `O` toggle bass, `V` visualiser, `S` save.

- [Week7-Algorithmic Drum Looper](./week07/Week7-Algorithmic%20Drum%20Looper.mp4)

Google Drive:
- [Week7-Algorithmic Drum Looper](https://drive.google.com/file/d/1QIkJP71RcDDFu0LSO1PkZyHbZt2fkrg3/view?usp=drive_link)
---

## Week 8 — Hackathon
Attended the Hackathon — **no separate weekly submission**.

---

## Week 9 — Vectors & Motion
### Hr2 — Bouncing Ball (vectors + forces + collision)
**File:** `week09/week09_bouncing_ball.pde`  
**Forces:** gravity + quadratic air drag; wall collisions with restitution.  
**Interaction:** click near the ball to add an impulse (“mouse bounce”).  
**Control:** `S` save.

### Hr3 — Mini Game: “Flower Glide”
**File:** `week09/week09_vector_game.pde`  
**Meets brief:**  

- **≥1 class:** `Player`, `Flower`  
- **≥2 forces:** gravity + drag (plus optional attractor/wind)  
- **≥1 interaction:** keyboard thrust + mouse gust  
  **Goal:** collect 10 flowers; falling out of bounds = fail.  
  **Controls:** `←/→` thrust, `SPACE` short boost, mouse click gust, `E` attractor toggle, `R` reset, `S` save.

**Demo Videos**

- [bouncing ball](./week09/week%209-Bouncing%20Ball.mp4)
- [Flower Glide](https://drive.google.com/file/d/15zFr9l1IoAbpEMPxf8LfJRY8abSSTv71/view?usp=drive_link)

Google Drive:
- [bouncing ball](https://drive.google.com/file/d/1TA9XYUTyzycrd-bF8HSZGUUV0vy34TSL/view?usp=drive_link)
- [Flower Glide](https://drive.google.com/file/d/15zFr9l1IoAbpEMPxf8LfJRY8abSSTv71/view?usp=drive_link)
---

# Week 10 — Particle Systems（Developed further）

**What this sketch shows**

- A reusable particle system built with **ArrayList** and **classes**.
- Each particle carries at least **three PVectors**: `position`, `velocity`, `acceleration`.
- **One user interaction**: mouse click produces a radial wind **gust** that pushes nearby particles; key `E` drops a new emitter at the mouse.
- **One randomized force**: time-varying **turbulent wind** driven by Perlin noise (changes every frame).
- Three aesthetics (press `1/2/3`): **petals / leaves / snow**.

**Controls**

- `1` Petals (pink, light drag)  
- `2` Leaves (orange/green, heavier drag)  
- `3` Snow (white, additive glow)  
- `E` Drop a new emitter at mouse  
- `G` Toggle gravity  
- `W` Toggle turbulent wind  
- Mouse **click**: radial gust from mouse  
- `R` Reset, `S` Save PNG

**Developed further**	

*Why selected:* it expands the base particle exercise into a reusable system with multiple emitters, a noise-driven wind field, rich user controls, and three distinct aesthetics — evidencing enquiry, iteration, and polish.

- **Multiple emitters** – press **E** to drop a new emitter at the mouse position.

  **Force controls** –

  - **G** to toggle gravity on/off.
  - **W** to toggle turbulent wind on/off.
  - **Mouse click** to create a gust of wind near the cursor.

  **Three visual modes** – press **1** for petals, **2** for leaves, **3** for snow.

  **System management** –

  - **R** to reset the whole system.
  - **S** to save a screenshot.

**Demo Video：**- [Week10-Particle System](./week10/Week10-Particle%20System.mp4)

Google Drive: [Week10-Particle System](https://drive.google.com/file/d/1y5RIxiLCbWS1XE5dc4AHG7wW35vztVFk/view?usp=drive_link)

# References & Licences
## Core docs & tutorials
- Processing Pixels Tutorial: https://processing.org/tutorials/pixels
- Processing Tutorial on 2D Transformations: https://processing.org/tutorials/transform2d
- Rotate / Push / Pop example: https://processing.org/examples/rotatepushpop.html
- Contrast formula (DF Studios): https://www.dfstudios.co.uk/articles/programming/image-programming-algorithms/image-processing-algorithms-part-5-contrast-adjustment/
- Sepia matrix (GeeksForGeeks): https://www.geeksforgeeks.org/java/image-processing-in-java-colored-image-to-sepia-image-conversion/
- Perlin Noise explanation (Daniel Shiffman): https://www.youtube.com/watch?v=YcdldZ1E9gU
- Lucas Pope on Obra Dinn dithering: https://www.youtube.com/watch?v=ILolesm8kFY
- TIGSource thread (Pope notes): https://forums.tigsource.com/index.php?topic=40832.msg1363742#msg1363742
- Surma — Ditherpunk: https://surma.dev/things/ditherpunk/
- Tanner Helland — Dithering algorithms + source: https://tannerhelland.com/2012/12/28/dithering-eleven-algorithms-source-code.html
- Processing Sound library (API & classes): https://processing.org/reference/libraries/sound/index.html
- Article on audio filters (concepts & use cases): https://www.edmprod.com/audio-filters/
- Processing **SoundFile** docs — https://processing.org/reference/libraries/sound/SoundFile.html
- Processing **AudioSample** docs (low-latency RAM-loaded samples; optional alternative) — https://processing.org/reference/libraries/sound/AudioSample.html
- Free samples — https://freesound.org/
- Essential hip-hop drum patterns (timing ideas) — https://midimighty.com/blogs/resources/hip-hop-drum-patterns-essential-hiphop
- Nature of Code (vectors): https://natureofcode.com/vectors/
- Processing `PVector` reference: https://processing.org/reference/PVector.html

### Video demos
- All demo videos are screen-captures of my own sketches.
