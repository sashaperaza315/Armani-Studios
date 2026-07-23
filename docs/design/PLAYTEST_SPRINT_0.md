# Sprint 0 Playtest Package — Armani's First Playthrough

**Status:** Ready to run
**Build under test:** Sprint 0, *The Forgotten Orchard* (first commit on `master`)
**Purpose:** Find out if the core loop is *fun*, before a single hour goes into real art or audio. Nothing below asks about visuals — the blockout is supposed to look rough right now. This tests the game underneath it.

> Rule for this session: if Armani's answer to "does this feel like Hollowhunt" is anything other than a clear yes, that's not a failure — that's Sprint 0 doing its job. Log it, don't argue with it.

---

## 1. Playtest Instructions (read this to Armani before he plays)

1. Producer opens the project in Godot and presses Play (or launches an exported build, if one's been made).
2. **Don't explain anything before he plays.** No "here's what to do," no "watch out for the laser." The GDD's own definition of done is that he can play it without the producer explaining anything mid-play — if you have to explain, that's a finding, not a rule violation.
3. Controls card (only hand this over if he asks, not before):
   - **WASD** — move
   - **Mouse** — look around
   - **Shift** — run
   - **E** — turn lantern on/off
   - **R** — restart after a win or loss
4. Let him play **one full attempt** start to finish (win or lose) without interruption.
5. After the first attempt, ask the Section 2 questions below — out loud, casually, not like a survey.
6. Then let him play **2-3 more attempts.** The first attempt tests "can he figure it out." The repeat attempts test "is it still fun once he knows the rule" — that's what actually predicts whether Phase 2 is worth building.
7. Write his answers down in his own words in the Decision Log at the bottom of `SPRINT_0.md` (or a new session log) the same day. Don't paraphrase into producer-speak — his exact words are the source of truth, same as the Creative Decisions sessions.

---

## 2. Feedback Questions (organized around what we're actually testing)

### Does the player understand The Watcher's behavior?
- Before you were told anything — did you figure out on your own that getting close stops the laser?
- What made you realize that, if you did? A near-miss, a guess, watching it react?
- Did it ever feel random, like you got hit and didn't know why?

### Does the laser attack create tension?
- When you saw it about to fire, what did you do?
- Did you have enough warning to react, or did it feel like it just happened to you?
- Was there a moment the laser felt scary, or just annoying?

### Does the close-range safe zone create interesting decisions?
- Did you ever deliberately walk closer to stop the laser?
- Did that feel clever, or did it feel like you'd found a bug?
- Once you were in that safe-but-close spot, what were you thinking? Bored, tense, planning your next move?

### Does the kick attack feel fair?
- When you got kicked, did you understand why, or did it feel cheap?
- Did you feel like you had a way to avoid it, or was it unavoidable once you were close?

### Does surviving the timer feel exciting?
- Did you know how much time was left? Did that matter to you?
- Did the last 10-15 seconds feel different from the first 30?
- When you survived, did it feel like a win, or just like time ran out?

### Does the lantern make exploration interesting?
- Did you use the lantern on purpose to look for things, or mostly forget it existed?
- Did finding a hidden object feel rewarding?
- Did you ever use the lantern *near* The Watcher on purpose, to see what it'd do?

### Closing question (the one that actually gates Phase 2)
- Does this feel like Hollowhunt — weird, tense, learnable — or does it feel like a generic hide-and-seek game with a placeholder monster?

---

## 3. Bugs to Watch For

Things that are implementation risk, not design risk — if any of these happen, it's a bug report, not a tuning conversation:

- **Mouse look stops working** or the cursor becomes visible/interactive mid-game unexpectedly (Escape toggles capture — pressing it by accident will do this; that's expected, but confirm it's recoverable).
- **Getting stuck on geometry** — trees, the shed, or the fence perimeter trapping the player with no way out.
- **The Watcher clipping through or getting stuck on a tree** while patrolling or tracking (patrol targets are randomized within a radius and don't currently path around obstacles).
- **Laser fires with no visible telegraph** — the beam should blink before firing; if it fires instantly with no warning, that's broken, not just poorly tuned.
- **Getting hit by the laser with a tree clearly between you and The Watcher** — line-of-sight should block it.
- **Kicked from farther away than feels close-range** — note the exact moment/distance if this happens.
- **Restart (R) not working**, or working but leaving the old Watcher/timer state partially active.
- **Timer visually stuck** (not counting down) even though the game is clearly still running.
- **Lantern revealing an object from an unreasonable distance or angle** (should be a ~30° cone, ~8.5m range).
- **Frame stutters/freezes** — note when (on Watcher state changes, on restart, etc.) since that'll point at a specific system.

---

## 4. Tuning Variables We May Adjust After Feedback

These are named constants in the code already — nothing here requires new engineering, just number changes, so there's no reason to guess right the first time. Current Sprint 0 starting values:

| System | Variable | Current value | What it controls |
|---|---|---|---|
| The Watcher | `KICK_RANGE` | 2.0m | Distance at which it switches to kick attacks |
| The Watcher | `LASER_DISABLE_RANGE` | 4.5m | Upper edge of the safe zone (laser can't fire inside this) |
| The Watcher | `LASER_RANGE` | 12.0m | Max distance it can see/fire the laser from |
| The Watcher | `LASER_TELEGRAPH_TIME` | 0.8s | Warning time (blinking beam) before the laser actually fires |
| The Watcher | `LASER_COOLDOWN` | 2.2s | Time between laser shots |
| The Watcher | `KICK_COOLDOWN` | 1.4s | Time between kick attempts |
| The Watcher | `MOVE_SPEED` (patrol) | 1.8 m/s | How fast it wanders when unaware |
| The Watcher | `PATROL_RADIUS` / wait timers | 7.0m / 2-4.5s | How far and how often it wanders — this is what's supposed to keep repeat attempts unpredictable |
| Spirit Lantern | `range_meters` | 8.5m | How far the lantern reveals things |
| Spirit Lantern | `cone_degrees` | 30° | How wide the lantern's reveal cone is |
| Win condition | `SURVIVAL_TIME` | 120s | Length of the survival timer |
| Player | `SPEED` / `SPRINT_SPEED` | 4.2 / 6.4 m/s | Walk/run speed |

**Likely candidates for a first tuning pass based on common Sprint-0 findings** (confirm or discard after Armani's actual answers — don't pre-adjust these before he plays):
- If the safe zone feels boring rather than tense: shrink the gap between `KICK_RANGE` and `LASER_DISABLE_RANGE`, or give The Watcher a slow creep toward the player while in that state.
- If the laser telegraph feels too generous or too stingy: `LASER_TELEGRAPH_TIME` is the first knob, not hit-detection logic.
- If 2 minutes feels too long/short to stay tense: `SURVIVAL_TIME` is a one-line change.
- If the countdown-on-HUD vs. atmospheric-only question resurfaces after he actually plays it: that's still an open item from `SPRINT_0.md`'s decision log — his live reaction to the visible timer is the actual data point we were waiting for.

---

## 5. What Happens After This Session

Do not start Phase 2 (art, audio, second encounter) until:
1. Armani's answers are logged (his words, not summarized).
2. Any bugs from Section 3 are fixed or explicitly deferred with a reason.
3. Any tuning changes from Section 4 are made and **replayed** — a tuning change without a replay is a guess, not a fix.
4. Armani gives a clear go/no-go per the `SPRINT_0.md` playtest checklist's closing line: "does this feel like Hollowhunt?"

If the answer is "no, but I know what's wrong" — fix and replay before touching art.
If the answer is "no, and I'm not sure why" — that's worth a follow-up conversation with Armani before any code changes, not a guess-and-check tuning pass.
