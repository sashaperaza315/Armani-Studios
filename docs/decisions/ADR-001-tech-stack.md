# ADR-001: Engine & Technology Stack — Hollowhunt

**Studio:** Armani Studios™
**Project:** Hollowhunt™ — Prototype: *The Forgotten Orchard*
**Status:** Recommended
**Decision owner:** Builder/Producer, with Creative Founder sign-off

## Context

We need to pick a stack for a small-scope 3D horror-adventure prototype, built by a two-person team (a parent producer/developer plus AI-assisted development), with a 12-year-old creative director. The stack has to support:

- Third-person exploration in a small outdoor/enclosed environment (orchard, fog, foliage)
- A flashlight-style "Spirit Lantern" mechanic with real-time lighting and reveal effects
- A single scripted creature (The Watcher) with simple state-based AI
- Fast iteration so Armani can see ideas turn into something playable quickly
- A realistic path to console/PC release later without a full rewrite
- Low/no licensing cost while the studio is pre-revenue

## Options Considered

| Engine | Pros | Cons |
|---|---|---|
| **Godot 4** | Free, MIT license, no royalties ever; lightweight; excellent for small teams; GDScript is very approachable (good long-term, since Armani will eventually want to touch it); strong 2D/3D lighting and fog volumes in Godot 4; fast iteration/reload times; small install footprint | Smaller asset marketplace; fewer AAA horror-specific plugins; less built-in cinematic tooling than Unreal |
| **Unity** | Huge asset store; wide horror-genre precedent (Poppy Playtime-adjacent titles use Unity); strong console export support; large hiring pool later | Runtime fee/licensing history has been volatile and trust-damaging; C# has a steeper learning curve than GDScript; heavier editor; more setup overhead for a first prototype |
| **Unreal Engine 5** | Best-in-class visuals, Lumen/Nanite make atmospheric horror easy to make "AAA-looking" with little art effort; strong for a "cinematic, YouTube-worthy" horror look | Steep learning curve; heavy hardware requirements; overkill for a first playable prototype; 5% royalty after $1M revenue (fine long-term, irrelevant now, but adds complexity); slower iteration for a two-person team |

## Decision

**Use Godot 4.x (latest stable) for the Hollowhunt prototype and Sprint 0.**

Reasoning:
1. **Speed to playable matters most right now.** The immediate goal is Armani seeing The Watcher and the Spirit Lantern working in-engine, not chasing visual fidelity. Godot's iteration loop is the fastest of the three for a solo/duo team.
2. **Zero cost, zero royalty risk.** Important for a pre-revenue studio — no surprise licensing changes later.
3. **3D lighting/fog is good enough for this brief.** Godot 4's WorldEnvironment, volumetric fog, and shadow-casting spotlights can absolutely deliver "fog, spotlight lantern reveals hidden things" — the core sensory hook of the prototype — without Unreal-level overhead.
4. **Room to grow, not a dead end.** If Hollowhunt scales into a multi-location, console-bound title, Godot 4 can still ship on PC, mobile, and (via community/official pipelines) consoles. If a future decision is made to move to Unreal for visual fidelity once the studio has more resources, the Game Design Document and content (models, design, narrative) all transfer — only engine-side implementation would be redone.
5. **Legibility for Armani.** GDScript's Python-like syntax is one of the most approachable "look inside the game" languages if/when Armani wants to peek at how his creatures come to life. This matters for the studio's stated goal of preserving and growing his creative ownership over time.

## Supporting Tools

| Purpose | Tool |
|---|---|
| Engine | Godot 4.x (stable) |
| Version control | Git + GitHub (private repo) |
| Art (concept/2D) | Any raster tool (Procreate/Photoshop/Krita) for Armani's creature sketches → reference for 3D artists |
| 3D modeling (creatures/props) | Blender (free, exports cleanly to Godot via glTF) |
| Audio | Free/CC0 horror ambience libraries for prototype; original score later |
| Project management | This repository's `/docs` folder + a simple Kanban board (Trello/Notion/GitHub Projects) |
| Build distribution (prototype) | itch.io private/unlisted page for internal playtesting |

## Consequences

- All folder architecture, build scripts, and Sprint 0 tasks in this repo assume Godot 4 project structure (`project.godot`, `scenes/`, `scripts/` as GDScript `.gd` files).
- If a future ADR revisits the engine choice (e.g., after Sprint 0 playtesting reveals a hard limitation), that decision should be logged as ADR-002, not silently overwritten here.
