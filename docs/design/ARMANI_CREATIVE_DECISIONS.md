# Armani's Creative Decisions — Session #001

**Status:** OFFICIAL CANON — these answers are binding creative direction for Hollowhunt.
**Creative Director:** Armani
**Session date:** 2026-07-23
**Recorded by:** Builder/Producer, verbatim from Armani's choices — not altered or overridden.

> Rule for the team: nothing in this file gets changed without going back to Armani. If a technical or scheduling constraint makes one of these hard to build exactly as chosen, that's a conversation to have *with* him, not a reason to quietly build it differently.

---

## Decision 1 — Camera Perspective

**Question:** First-person scary exploration, or third-person character adventure?

**Armani's answer: FIRST-PERSON.**

> You see through the Warden's own eyes. No seeing your own body — just what's in front of you. This is the more intense, scary-jumpy option, and Armani chose it deliberately over the "see your whole hero" third-person option.

**Implication for the GDD/Sprint 0:** the open question on camera perspective is now resolved. Sprint 0 should build a first-person controller. This also means The Watcher's design needs to read clearly even though the player will mostly see it head-on/in front of them rather than from a wide third-person view — worth double-checking silhouette and scale in-engine once it's blocked out.

---

## Decision 2 — The Watcher Encounter Goal

**Question:** When the player meets The Watcher, is it Capture & Bond, Discover & Escape, or Rescue & Transform?

**Armani's answer: DISCOVER AND ESCAPE.**

> You figure out The Watcher's rules — laser far away, kick up close — and get away without being caught. Pure monster-hunting tension, not a taming or rescue story.

**Implication for the GDD/Sprint 0:** this confirms and locks in the design already drafted in Sprint 0 (learn the rule, use the safe zone, reach an exit / survive). No design change needed here — Armani's answer validates the existing plan. Future creatures should default to this same "discover and escape" framing unless Armani specifically asks for a different kind of encounter for a specific creature.

---

## Decision 3 — First Thing the Player Sees

**Question:** What's the very first thing on screen when the game loads?

**Armani's answer: THE FOGGY ORCHARD PATH.**

> The player opens their eyes already standing in the misty orchard — dead trees, quiet, a path ahead. Not a lantern close-up, not a Watcher tease — straight into the atmosphere.

**Implication for Sprint 0:** the opening moment is a cold open into the environment itself — no UI splash, no cutscene, no early Watcher reveal. First few seconds of gameplay should be pure mood: fog, quiet, the path. Any lantern or Watcher introduction happens after the player has had a moment to feel the space.

---

## Decision 4 — The Scariest Thing About The Watcher

**Question:** What's the scariest part of The Watcher to you?

**Armani's answer: IT'S JUST AN EYE AND FEET.**

> No arms, no face except one giant eye — it doesn't look like it should be able to move or hurt you, but it can.

**Implication for design/art:** the scare isn't "it's staring at you" or "it's a mystery" — it's the *wrongness of its body*. The design and animation priority should be selling how unnatural it looks in motion: an eye that shouldn't walk, walking. Animation and rigging work on The Watcher should lean hard into that impossible, off-balance, "this should not be able to move like this" quality rather than generic creepy-crawly movement.

---

## Decision 5 — What Makes The Watcher Unique

**Question:** What makes The Watcher different from every other monster out there?

**Armani's answer: NOTHING ELSE LOOKS LIKE IT.**

> A giant eyeball with feet is just not a shape anyone's used before — totally original.

**Implication for future creature design:** this confirms the studio's core creative bar (see GDD Design Pillar #1, "Weird over generic") in Armani's own words. Every future creature pitch should pass this same test before moving to production: *does anything else look like this?* If a new creature idea resembles an existing horror-game monster archetype, it needs to be reworked before art production starts.

---

## Summary — What Changes Now

| Area | Before this session | Now (canon) |
|---|---|---|
| Camera | Open question | **First-person**, locked in |
| Watcher encounter type | Assumed in Sprint 0 draft | **Confirmed: Discover and Escape** |
| Opening moment | Undecided | **Cold open on the foggy orchard path** — no lantern/Watcher tease first |
| Watcher's core scare | General "creepy/bizarre" | **Specifically: the wrongness of an eye-and-feet body moving at all** — drive animation/rigging priorities |
| Creature design bar | Stated by producer in GDD | **Confirmed directly by Armani: "nothing else looks like it" is the test every creature must pass** |

Next step: update `docs/design/GDD.md` open questions and `docs/design/SPRINT_0.md` decision log to reflect Decisions 1 and 3 as resolved.

---

# Session #002 — Sprint 0 Win Condition

**Session date:** 2026-07-23

## Decision 6 — How the Player Wins The Forgotten Orchard

**Question:** Discover and Escape is the goal — but exactly how does the player win the Sprint 0 level? Reach a marked exit, or survive a set amount of time?

**Armani's answer: SURVIVE THE TIME.**

> No exit point to find — the player just needs to outlast The Watcher for a set amount of time (e.g., 2 minutes) while staying hidden/uncaught. This is the tenser, hide-and-seek-survival option over a goal-driven "run to the exit" structure.

**Implication for Sprint 0:** the win condition is a survival timer, not a navigation goal. This changes what needs to be built:
- A visible or subtly-communicated timer/countdown (needs a follow-up decision on whether the player sees a literal timer on screen, or feels it more atmospherically — flag this as a new open question rather than assuming).
- Level layout can be smaller/more contained since there's no exit point to place and path players toward — more focus on hiding spots and sightline-breaking cover for outlasting The Watcher.
- The Watcher's patrol/search behavior needs to feel varied enough to sustain tension for the full timer without becoming predictable or boring on repeat attempts.

## Summary Update

| Area | Before this session | Now (canon) |
|---|---|---|
| Win trigger | Open (exit point vs. timer) | **Survive the time** — a set survival timer, no exit point |

New open question raised by this decision: **should the countdown timer be visible on-screen, or communicated some other way (audio cue, environmental change)?** Flag for a future quick decision or producer's discretion during Sprint 0 build, revisit with Armani if it changes the feel.
