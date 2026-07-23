# Hollowhunt™ — Armani Studios™

Hollowhunt is a spooky horror-adventure monster-hunting game. Players explore abandoned, fog-choked locations, discover impossible creatures, learn their rules, and use tools and courage to overcome them. Every monster should feel like something a kid dreamed up that became real.

This repository is the working home for the game's design, prototype code, and assets.

**Creative Founder:** Armani (original creator — monster ideas, gameplay imagination, creative approval)
**Builder/Producer:** parent (organization, infrastructure, execution)

## Start here

1. [`docs/decisions/ADR-001-tech-stack.md`](docs/decisions/ADR-001-tech-stack.md) — why we're building in Godot 4
2. [`docs/design/GDD.md`](docs/design/GDD.md) — the Game Design Document (living doc)
3. [`docs/ROADMAP.md`](docs/ROADMAP.md) — phased development plan
4. [`docs/design/SPRINT_0.md`](docs/design/SPRINT_0.md) — what we're building right now

## Repository structure

```
hollowhunt-repo/
├── docs/                        # Everything non-code: design, narrative, art direction, decisions
│   ├── design/                  # GDD, sprint plans, systems specs
│   ├── narrative/               # Lore, creature bios, world backstory
│   ├── art/                     # Art direction, mood boards, style references
│   └── decisions/               # ADRs — one file per major decision, never overwritten
│
├── project/                     # The actual Godot 4 project
│   ├── scenes/                  # .tscn scene files, mirrors gameplay systems
│   │   ├── player/
│   │   ├── creatures/watcher/   # one subfolder per creature
│   │   ├── environments/forgotten_orchard/
│   │   ├── items/               # Spirit Lantern and other tools
│   │   └── ui/
│   ├── scripts/                 # .gd scripts, mirrors scenes/ structure
│   │   ├── player/
│   │   ├── creatures/
│   │   ├── items/
│   │   ├── systems/             # save/load, game state, audio manager, etc.
│   │   └── ui/
│   ├── assets/
│   │   ├── models/              # .glb/.gltf from Blender
│   │   ├── textures/
│   │   ├── materials/
│   │   ├── audio/{sfx,music,ambience}/
│   │   ├── fonts/
│   │   └── shaders/
│   └── addons/                  # third-party Godot plugins, if any
│
├── tools/                       # Small utility scripts (asset import helpers, build scripts)
├── builds/                      # Exported playable builds (gitignored except structure)
└── .github/workflows/           # CI, if/when we automate exports
```

**Rule of thumb:** every creature, tool, or location gets a matching folder in both `scenes/` and `scripts/`, and (once it exists) a design entry in `docs/design/GDD.md` and/or `docs/narrative/`. Code should never be the only place a creature's rules live — if it's not written down in `docs/`, a future contributor (including future-you) has no way to check the implementation against the intended design.

## Engine

Godot 4.x (stable). See ADR-001 for the full reasoning.

## Current status

**Phase:** Sprint 0 — first playable prototype, *The Forgotten Orchard*.
See `docs/design/SPRINT_0.md` for exact scope and `docs/ROADMAP.md` for what comes after.
