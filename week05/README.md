# Week 5 — Dithering and Convolution

## What I did
- **Dithering (Hr1):** Implemented three dithering pipelines:
  1) **Threshold** (baseline, no error diffusion)
  2) **Bayer ordered dithering** (4×4 matrix)
  3) **Floyd–Steinberg error diffusion** (1-bit palette)
- **Convolution (Hr2):** Wrote a generic 3×3/5×5 kernel engine and added presets:
  - Box blur, Gaussian(approx), Sharpen, Edge(3×3), Emboss, and **Sobel** (|Gx|+|Gy|).

## Files
- `week05_dithering.pde`  
  - Keys: `1` Threshold, `2` Ordered (Bayer), `3` Floyd–Steinberg, `C` toggle clip-to-bounds, `S` save PNG, `L` load/reset original.
- `week05_convolution.pde`  
  - Keys: `1` Box blur, `2` Gaussian, `3` Sharpen, `4` Edge, `5` Emboss, `6` Sobel, `R` reset, `S` save.

## Demo Videos
- [Dithering demo](./week5-Dithering.mp4)
- [Convolution demo](./week5-Convolution.mp4)

## Resources used (as requested)
- Lucas Pope on Obra Dinn dithering: https://www.youtube.com/watch?v=ILolesm8kFY
- TIGSource thread (Pope notes): https://forums.tigsource.com/index.php?topic=40832.msg1363742#msg1363742
- Surma — Ditherpunk: https://surma.dev/things/ditherpunk/
- Tanner Helland — Dithering algorithms + source: https://tannerhelland.com/2012/12/28/dithering-eleven-algorithms-source-code.html
