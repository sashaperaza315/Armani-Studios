extends Node
## Autoload — Sprint 0.5 win/lose loop for The Forgotten Orchard.
## Updated per Armani's Creative Decision Session #003 (post-Sprint-0
## playtest): three win paths (survive the timer, find 3 Hollow secrets,
## or defeat The Watcher) and a 3-hit health bar instead of instant loss.

signal state_changed(new_state: String)
signal time_updated(seconds_left: float)
signal health_changed(current: int, max_health: int)
signal objective_updated(found: int, total: int)

enum RunState { PLAYING, WON, LOST }

const SURVIVAL_TIME := 120.0
const MAX_HEALTH := 3
const SECRETS_REQUIRED := 3

var run_state: RunState = RunState.PLAYING
var time_left := SURVIVAL_TIME
var lose_reason := ""
var win_reason := ""
var player_health := MAX_HEALTH
var secrets_found := 0


func _ready() -> void:
	_reset()


func _process(delta: float) -> void:
	if run_state != RunState.PLAYING:
		return
	time_left = max(time_left - delta, 0.0)
	time_updated.emit(time_left)
	if time_left <= 0.0:
		_win("You survived The Watcher.")


func player_hit(amount: int, reason: String) -> void:
	if run_state != RunState.PLAYING:
		return
	player_health = max(player_health - amount, 0)
	health_changed.emit(player_health, MAX_HEALTH)
	if player_health <= 0:
		lose_reason = reason
		run_state = RunState.LOST
		state_changed.emit("lost")


func secret_found() -> void:
	if run_state != RunState.PLAYING:
		return
	secrets_found += 1
	objective_updated.emit(secrets_found, SECRETS_REQUIRED)
	if secrets_found >= SECRETS_REQUIRED:
		_win("You uncovered the Hollow's secrets and escaped.")


func watcher_defeated() -> void:
	_win("You defeated The Watcher.")


func _win(reason: String) -> void:
	if run_state != RunState.PLAYING:
		return
	run_state = RunState.WON
	win_reason = reason
	state_changed.emit("won")


func restart() -> void:
	_reset()
	get_tree().reload_current_scene()


func _reset() -> void:
	run_state = RunState.PLAYING
	time_left = SURVIVAL_TIME
	lose_reason = ""
	win_reason = ""
	player_health = MAX_HEALTH
	secrets_found = 0
