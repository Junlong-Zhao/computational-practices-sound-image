# Week 10 — Particle Systems

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

**References used**
- Shiffman, *Nature of Code* — particles chapter (concepts and API habits).  
- Processing Reference: `PVector`, `mouseClicked()`, `keyPressed()`.  
- Reeves, W. T. *Particle Systems — A Technique for Modeling a Class of Fuzzy Objects* (historical background). :contentReference[oaicite:1]{index=1}
