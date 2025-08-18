# Week 4 — Filtering Images

## What I did
- **Hr1 (Noise):** Implemented a Perlin Noise animation to understand “usable / natural randomness” and how `noise()` differs from `random()`.
- **Hr2 (Filters):** Wrote image filters by manipulating pixel values: threshold, brightness, contrast, invert, duotone, sepia.
- **Hr3 (Masking):** Extended the filter code to add a circular mask around the mouse. One filter is applied to the whole image and a different filter is applied inside the mask (hint: `dist()`).

## Files
- `week04_noise.pde` — Perlin Noise demo (`[` and `]` change scale, `A` toggle animation, `S` save frame).
- `week04_masked_filters.pde` — Filters + masking (number keys choose **base** filter, letter keys choose **inner** filter; `UP/DOWN` change mask radius; `R` reset; `S` save).

## Demo Videos
- Noise demo: <PUT_LINK_HERE>
- Masked filters demo: <PUT_LINK_HERE>

## Resources used
- Contrast formula (DF Studios): https://www.dfstudios.co.uk/articles/programming/image-programming-algorithms/image-processing-algorithms-part-5-contrast-adjustment/
- Sepia matrix (GeeksForGeeks): https://www.geeksforgeeks.org/java/image-processing-in-java-colored-image-to-sepia-image-conversion/
- Perlin Noise explanation (Daniel Shiffman): https://www.youtube.com/watch?v=YcdldZ1E9gU
