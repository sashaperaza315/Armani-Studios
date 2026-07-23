# Hollowhunt™ — Game Design Document

**Status:** Living document — v0.1 (Sprint 0 baseline)
**Creative Founder:** Armani
**Producer:** parent/builder
**Last updated:** 2026-07-23

> This document is the single source of truth for what Hollowhunt *is*. Every system, creature, and location built should trace back to a section here. When something changes in development, update this document in the same work session — don't let code and design drift apart.

---

## 1. Vision

**One-line pitch:** A spooky horror-adventure where you hunt bizarre, impossible creatures nobody has ever seen before, using courage, strategy, and a lantern that shows you the truth.

**What Hollowhunt is not:** generic jump-scare horror, a reskin of Poppy Playtime/Granny/Skibidi Toilet, or a game that relies on gore or realistic violence. Fear comes from *weirdness and mystery*, not gore.

**What makes it Hollowhunt:**
- Creatures that feel like something a kid imagined and it became real — illogical anatomy, uncanny behavior, a strange internal logic once you learn it.
- Every creature has *rules* — the player's job is to learn them, not just run.
- Environments are quiet, foggy, and full of small details worth noticing.
- Moments are built to be memorable and shareable ("wait, it can't fire lasers up close?? RUN").

**Design pillars (every decision should serve at least one):**
1. **Weird over generic** — if a creature or location could exist in any other horror game, redesign it.
2. **Learnable, not random** — creatures follow discoverable rules; horror comes from tension and timing, not cheap unpredictability.
3. **Curiosity rewarded** — exploring and noticing pays off (secrets, lore, easier creature counters).
4. **Armani's approval gate** — no creature, location, or major mechanic ships without the Creative Founder's sign-off that it still feels like *Hollowhunt*.

---

## 2. World

### 2.1 Premise
[TO EXPAND — placeholder from current brief] The world contains "Hollow" places — locations that have become detached from normal reality, where impossible creatures ("Hollow Entities") take root. A Warden's job is to enter these places, understand the entities inside, and either banish, calm, or outlast them.

### 2.2 Tone & atmosphere
Fog, decay, quiet dread, occasional dark humor from how absurd the creatures look. Scary because it's *impossible*, not because it's graphic.

### 2.3 Locations (planned)
| Location | Status | Notes |
|---|---|---|
| The Forgotten Orchard | **In production (Sprint 0)** | Abandoned orchard, first Hollow location, home to The Watcher |
| *(future locations TBD)* | Not started | To be defined after Sprint 0 playtesting |

---

## 3. Player Character

**Working name:** The Young Warden

- Age/vibe: young, brave, in over their head but resourceful — a relatable audience-insert for players around Armani's age and older.
- Core capabilities (Sprint 0 scope): walk/run, look around (camera control), interact with objects, carry and use the Spirit Lantern.
- Not in Sprint 0 scope: combat, inventory beyond the lantern, dialogue system, saving/loading.
- **Camera perspective: first-person** (Armani's Creative Decision #1 — see `ARMANI_CREATIVE_DECISIONS.md`). The player sees only what the Warden sees; no third-person view of the character's body.

*(Full backstory, appearance design, and progression to be developed with Armani after the first prototype is playable — seeing the character move in-engine will make this conversation more concrete.)*

---

## 4. Core Tool: The Spirit Lantern

**Function:** the player's primary means of interacting with the Hollow.

| Function | Description | Sprint 0 scope? |
|---|---|---|
| Reveal hidden objects | Objects/secrets only visible when lit by the lantern | Yes |
| Detect Hollow Entities | Lantern reacts (flicker/glow/sound) near The Watcher | Yes |
| Create tension | Limited light radius, and using it can attract attention | Yes (basic version) |
| Battery/charge management | Resource management layer | Later — not Sprint 0 |
| Upgrades | New lantern abilities as progression | Later — not Sprint 0 |

**Design intent:** the lantern should feel like it gives the player power *and* puts them at risk — light reveals truth, but truth can be dangerous to look directly at.

---

## 5. Creature Bestiary

Each creature gets its own entry here **and** its own folder under `project/scenes/creatures/` and `project/scripts/creatures/`. A creature is not "done" until both exist and match.

### 5.1 The Watcher
**Creator:** Armani
**Status:** First creature — in production for Sprint 0

**Visual design:** A giant human eye with two enormous human feet. No other limbs. It stands and walks on the feet; the eye itself is the "head/body."

**Abilities:**
- Fires red laser beams from its pupil at range.
- Kicks the player if they get too close.
- **Cannot fire lasers at close range** (its core exploitable rule).

**What makes it scary (Armani, Creative Decision #4):** not that it stares at you — it's that it's *just an eye and feet*. No arms, barely a face beyond the one giant eye, and it still moves and hurts you. Animation/rigging priority should sell the wrongness of that motion, not generic creepy-crawly behavior.

**Why nothing else looks like it (Armani, Creative Decision #5):** confirmed directly by the Creative Founder as the test every future creature must pass — "nothing else looks like it." See Design Pillar #1.

**Behavior rules (for the player to learn):**
1. At long range: The Watcher tracks and fires lasers. Player must break line of sight or use cover.
2. At close range: laser attack is disabled; instead it attempts a kick. Player must avoid the kick (dodge/sidestep) rather than the laser.
3. The "safe zone" is the gap between "too far" (laser range) and "danger of getting kicked" — the player must learn to read distance, not just react.

**Why it works (design notes):** the core exploit — get close to stop the lasers, but not too close — creates a real risk/reward decision loop from one simple asymmetric rule. This is the template for future creatures: **one bizarre visual idea + one clear behavioral rule + one exploitable weakness.**

**Tone target:** creepy, bizarre, memorable, a little funny in how strange it is, scary because its logic is alien — not scary because it's gory.

### 5.2 Future creatures
Use the Creature Design Template below for every new entity. Bring concepts to Armani for approval before moving to 3D production.

### 5.3 Creature Design Template
```
Name:
Creator/idea source:
Visual design (plain description):
Core gimmick (the ONE weird rule that defines it):
Attack(s):
Weakness/exploit:
Tone check — does it feel like Hollowhunt? (weird/learnable/curious/approved by Armani):
Sprint targeted:
```

---

## 6. Gameplay Systems (Sprint 0 baseline)

| System | Sprint 0 scope |
|---|---|
| Movement & camera | **First-person** (locked in — Armani's Creative Decision #1), walk/run, look |
| Interaction | Basic "interact with object" prompt system |
| Lantern mechanic | On/off, limited cone/radius, reveals hidden objects, reacts near The Watcher |
| Creature AI | Simple state machine for The Watcher: Idle → Track/Laser → Kick → (repeat) |
| Win/lose condition | Minimal — e.g., reach a goal point without being caught, or survive N encounters. Finalize in Sprint 0 planning. |
| Fog/atmosphere | Environmental fog, limited visibility, ambient horror audio |

Systems explicitly **out of scope** for Sprint 0: inventory, save/load, multiple creatures, dialogue, progression/upgrades, menus beyond a minimal start/restart.

---

## 7. Art Direction

- Muted, desaturated color palette for environments (grays, dead greens, orchard browns) so lantern light and creature color (e.g., The Watcher's red laser) pop.
- Creatures should read clearly in silhouette — a design test: if you can't tell what it is from a dark shape alone, redesign it.
- Environmental storytelling over cutscenes: props, decay, and small details imply history without dialogue.

*(Full style guide to be developed in `docs/art/` once concept art begins.)*

---

## 8. Audio Direction

- Sparse ambient horror soundscape (wind, creaks, distant sounds) rather than constant music.
- Distinct, recognizable audio cue for lantern-reveals and for The Watcher's laser charge-up (telegraphing the attack fairly).
- Silence used deliberately as a tension tool.

---

## 9. Open Questions (track and resolve here, don't let them float in chat)

- [x] ~~First-person or third-person camera for the Warden?~~ **Resolved: first-person** (Armani, Creative Decision Session #001)
- [x] ~~Precise win condition for The Forgotten Orchard prototype?~~ **Resolved: survive a set timer (no exit point)** (Armani, Creative Decision Session #002)
- [x] ~~Should the survival countdown be a visible on-screen timer, or communicated atmospherically?~~ **Resolved for first build: on-screen timer** (producer's discretion, see SPRINT_0.md decision log — revisit with Armani after first playtest if atmospheric-only feels better)
- [x] ~~Does the lantern have any limitation (battery, cooldown) even in Sprint 0?~~ **Resolved: no, pure on/off** (later-phase system per GDD section 4)
- [ ] Warden's visual design — defer to a dedicated session with Armani?
- [x] ~~What's the first thing the player sees on load?~~ **Resolved: cold open on the foggy orchard path** (Armani, Creative Decision #3)

---

## 10. Change Log
| Date | Change |
|---|---|
| 2026-07-23 | Initial GDD created from founding creative brief. The Watcher and Spirit Lantern documented. Sprint 0 scope defined. |
| 2026-07-23 | Creative Decision Session #001 with Armani: camera locked to first-person, encounter goal confirmed as Discover and Escape, opening moment set to the foggy orchard path, Watcher's core scare and uniqueness test defined in his own words. See `ARMANI_CREATIVE_DECISIONS.md`. |
| 2026-07-23 | Creative Decision Session #002 with Armani: Sprint 0 win condition locked to "survive a set timer" (no exit point). New open question raised on whether the countdown is shown on-screen. |
| 2026-07-23 | First playable Sprint 0 prototype built in Godot 4: first-person Warden controller, The Forgotten Orchard grey-box with fog, Spirit Lantern reveal + Watcher-detection, The Watcher's full three-zone state machine (laser/safe/kick), on-screen survival timer, win/lose loop with instant restart. Not yet playtested by Armani — see SPRINT_0.md playtest checklist. |
