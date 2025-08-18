# Notes — Week 5: Dithering & Convolution

## Dithering
Goal: fake more tones with fewer colors by spatial patterns.
- **Threshold**: map luminance to {0,1} by a fixed cutoff — banding artifacts.
- **Ordered (Bayer 4×4)**: compare normalized luminance to a tiled threshold matrix. Pros: fast, stable patterns; Cons: visible periodicity.
- **Floyd–Steinberg (error diffusion)**: quantize the current pixel to nearest palette color, distribute the quantization error to future neighbors (7/16, 3/16, 5/16, 1/16). Pros: high quality; Cons: sequential & slower.
- Palette: 1-bit (black/white), can be extended to 4/8 colors (Lucas Pope’s Obra Dinn pipeline discusses curated palettes and tone mapping).

## Convolution
- Output pixel = sum(kernel[i,j] * input[x+i, y+j]).
- Implemented clamp-at-borders sampling; kernels normalized when needed.
- Presets:
  - **Box/Gaussian blur** smooth noise.
  - **Sharpen** enhances edges.
  - **Edge** high-pass outline (3×3).
  - **Emboss** adds relief shading.
  - **Sobel** computes gradient magnitude √(Gx²+Gy²) ~ (|Gx|+|Gy|) approx for speed.

**Indexing**: `idx = x + y*width`.  
**Luminance**: `0.299*R + 0.587*G + 0.114*B`.

I compared subjective quality: FS > Bayer > Threshold (banding). Performance: Threshold > Bayer > FS.
