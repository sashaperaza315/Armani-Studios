# Sprint 0 — Hollowhunt: The Forgotten Orchard

**Goal:** the smallest possible playable version of Hollowhunt. Not pretty. Not final. *Playable, start to finish, and it has to feel like Hollowhunt.*

**Definition of done:** Armani plays it on a keyboard/controller from start to finish without the producer explaining anything mid-play, and says it feels right.

**Suggested timebox:** 1–2 weeks of part-time work. If it's taking much longer, cut scope further rather than extending the timeline — see "Cut list" below.

---

## Scope (build exactly this, nothing more)

### 1. Player — The Young Warden (placeholder art OK)
- [x] **First-person** camera and controller (locked in — Armani, Creative Decision #1). No third-person model needed for Sprint 0.
- [x] WASD movement, mouse look (controller/left-stick support not yet wired — keyboard/mouse only for this pass)
- [x] Basic collision so the player can't walk through orchard geometry
- [x] Single "interact" input (E) — toggles the lantern; framework in place for object interaction but nothing besides the lantern uses it yet in Sprint 0

### 2. Location — The Forgotten Orchard (grey-box/blockout)
- [x] Small enclosed outdoor area — 6 trees + 1 shed (blockout cylinders/boxes)
- [x] Boundaries: fog-shrouded fence perimeter (collision walls, fog handles the "you can't see past this" read rather than an obvious visible wall)
- [x] Godot WorldEnvironment fog + low ambient moonlight set up
- [x] 3 hidden objects placed, only visible via the Spirit Lantern
- [x] **Opening moment (locked in — Armani, Creative Decision #3):** the game cold-opens directly on the foggy orchard path — dead trees, quiet, path ahead. No UI splash, no lantern close-up, no early Watcher tease before the player can move.

### 3. Tool — Spirit Lantern
- [x] Toggle on/off
- [x] Cone/radius of light with a defined range (8.5m, 30°, tune by feel)
- [x] Reveals the 3 hidden objects placed in the orchard when lit
- [x] Detectable reaction (blockout flicker) when pointed near The Watcher — swap for real material flash + audio cue once art/audio lands

### 4. Creature — The Watcher (blockout model: sphere "eye" + two leg cylinders)
- [x] Idle/patrol state — wanders a randomized home radius, varies timing so it's not predictable on repeat attempts
- [x] Long-range TRACK state: tracks player, telegraphs (blinking beam), fires a red laser (visual beam + line-of-sight hit check)
- [x] Close-range KICK state: laser disabled, kicks instead
- [x] Explicit SAFE-zone state between kick range and laser-disable range — implements the documented "gap between too-far and danger-of-kick" as its own state, not just an inferred gap
- [x] Distance thresholds implemented as named constants in watcher.gd (kick 2.0m / safe up to 4.5m / laser up to 12m) — starting values only, **not yet tuned by playtest**
- [x] Win/lose hookup: laser or kick contact calls GameManager.player_caught()

### 5. Win/Lose Loop (encounter goal locked in — Armani, Creative Decision #2: **Discover and Escape**, not capture or rescue)
- [x] **Win condition (locked in — Armani, Creative Decision #6): survive a set timer** (120s) without being caught. No exit point — orchard uses trees/shed/fence as hiding spots and sightline-breaking cover.
- [x] Countdown decided (producer's call, see decision log): on-screen timer, top-left HUD.
- [x] One clear lose condition, with an instant restart (R key reloads the scene, no reload screen)
- [x] Minimal on-screen feedback for both ("You survived." / lose reason text, both with a restart prompt)
- [x] The Watcher's patrol behavior uses randomized wait times and wander points so it's not predictable on repeat attempts — **not yet playtested for whether the variation is enough to stay tense for the full 2 minutes**

### Explicitly cut from Sprint 0
Do not build any of these yet, even if it's tempting:
- Inventory system
- Save/load
- Multiple creatures
- Dialogue/story delivery beyond maybe one or two environmental text/lore props
- Menus beyond start/restart
- Real (non-blockout) art and audio — placeholder/CC0 assets are correct for this sprint
- Lantern battery/resource management

---

## Suggested build order
1. Godot project setup, folder structure already scaffolded (see repo root `project/`)
2. Player controller + camera + collision in a flat test scene
3. Orchard grey-box + fog/lighting pass (this is where atmosphere starts proving itself)
4. Spirit Lantern toggle + hidden-object reveal (test with placeholder objects before touching The Watcher)
5. The Watcher state machine, tuned in isolation (empty room, just player + Watcher) before dropping it into the orchard
6. Combine: Watcher in the orchard + win/lose conditions
7. Playtest with Armani. Note anything that doesn't feel right — tune distances, light radius, pacing.
8. Only after it "feels like Hollowhunt": clean up for a stable internal build.

## Decision Log (resolve before/during build, update here)
| Decision | Resolution | Date |
|---|---|---|
| Camera perspective (1st vs 3rd person) | **First-person** — Armani, Creative Decision Session #001 | 2026-07-23 |
| Encounter goal | **Discover and Escape** — Armani, Creative Decision Session #001 | 2026-07-23 |
| Opening moment | **Cold open on the foggy orchard path** — Armani, Creative Decision Session #001 | 2026-07-23 |
| Win condition specifics (exact trigger) | **Survive a set timer (no exit point)** — Armani, Creative Decision Session #002 | 2026-07-23 |
| Countdown display (on-screen vs. atmospheric) | **On-screen timer (top-left HUD)** — producer's discretion for first build, so playtesting can isolate "does the loop work" from "does the atmospheric version feel better." Revisit with Armani after first playtest. | 2026-07-23 |
| Does lantern have any limitation in Sprint 0? | **No — pure on/off**, per the doc's own default. | 2026-07-23 |

## Playtest checklist (run this with Armani when Sprint 0 is "done")
- [ ] Did you understand the lantern's purpose without being told?
- [ ] Did you figure out The Watcher's laser/kick rule through play, or did it feel random?
- [ ] Was there a moment that felt tense or exciting?
- [ ] Was there a moment that felt unfair or confusing?
- [ ] Does The Watcher still feel "creepy, bizarre, memorable, funny-strange" per the GDD tone target?
- [ ] Armani's verdict: does this feel like Hollowhunt? (go/no-go to Phase 2)
