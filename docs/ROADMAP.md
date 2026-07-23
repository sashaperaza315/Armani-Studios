# Hollowhunt™ — Development Roadmap

This roadmap is intentionally scope-controlled: each phase has a single clear goal and a small set of deliverables. Do not start the next phase until the current one's exit criteria are met — controlling scope is what lets a two-person team actually ship.

## Phase 0 — Foundation (this week)
**Goal:** repository, docs, and decisions exist before any code.
- [x] Tech stack decision (ADR-001)
- [x] Repository folder architecture
- [x] Game Design Document v0.1
- [x] Sprint 0 defined
- [x] Git repo initialized locally (see repo health note below — pushed to GitHub still pending, needs a token or the GitHub connector authorized)
- [x] Godot 4 project scaffolded and should open cleanly in `project/` (needs a local Godot install to confirm — not yet verified in-editor)

**Exit criteria:** empty Godot project runs, repo is under version control, GDD/Roadmap/Sprint 0 exist. **Status: code-complete, not yet verified in-editor or pushed to GitHub.**

## Phase 1 — Sprint 0: First Playable Prototype
**Goal:** *The Forgotten Orchard* is playable start-to-finish, even if ugly.
See `docs/design/SPRINT_0.md` for full detail. Summary:
- Player movement + camera
- One small orchard environment block-out with fog
- Spirit Lantern: on/off, reveal hidden object, detect The Watcher
- The Watcher: block-out model, laser (long range) + kick (close range) behavior, one clear weakness
- One win condition, one lose condition

**Exit criteria:** Armani can play it start to finish on a controller/keyboard, and confirms it *feels* like Hollowhunt (weird, tense, learnable).

## Phase 2 — Vertical Slice
**Goal:** take the roughest edges off Sprint 0 and prove the loop is fun repeated, not just fun once.
- Replace block-out art with first-pass real models/textures for the orchard and The Watcher
- Real (even if simple) lighting pass — this is where the "fog + lantern" atmosphere should start looking intentional
- Add basic audio: ambience, lantern SFX, Watcher laser telegraph
- Add a second small encounter variation with The Watcher (e.g., a harder room layout) to test if the rule-learning loop holds up
- Basic UI: title screen, restart/pause

**Exit criteria:** a stranger (not the dev, not Armani) can pick it up with zero explanation and understand the lantern + Watcher rules within 2–3 tries.

## Phase 3 — Second Creature + Expanded Loop
**Goal:** prove the *format* (design template → concept approval → block-out → vertical slice) works for more than one creature.
- Design and approve Creature #2 with Armani using the Creature Design Template in the GDD
- Build a second small location or expand the orchard
- Introduce lightweight progression (e.g., lantern upgrade, or a simple map/objective system)
- First pass on the Warden's actual visual design (deferred from Sprint 0)

**Exit criteria:** two creatures, two distinct rule sets, no design or code drift from the GDD.

## Phase 4 — Production Planning for a Full Release Candidate
**Goal:** turn "this looks real" into an actual production plan.
- Decide target platform(s) (PC first is likely; consoles later)
- Scope the full creature roster and location list with Armani
- Budget/timeline plan for art, audio, and any outside help needed
- Marketing/community groundwork (devlogs, early screenshots) — "YouTube-worthy moments" pillar starts paying off here

**Exit criteria:** a scoped, funded (even if self-funded), timelined plan for a shippable version 1.0.

## Phase 5+ — Full Production → Launch
To be planned in detail once Phase 4 scoping is complete. Do not pre-plan this in depth now — premature long-range planning burns effort on assumptions that Sprint 0/vertical slice will likely invalidate.

---

## Guiding rule for all phases
No phase adds a system "because it'll be needed eventually." Every system enters scope because the *current* phase's exit criteria require it. This keeps the project buildable by a small team without stalling in pre-production forever.
