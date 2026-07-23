extends Node
## Autoload — Sprint 0 win/lose loop for The Forgotten Orchard.
## Win condition (Armani, Creative Decision #6): survive a set timer, no exit point.
## Lose condition: caught by The Watcher's laser or kick.

signal state_changed(new_state: String)
signal time_updated(seconds_left: float)

enum RunState { PLAYING, WON, LOST }

const SURVIVAL_TIME := 120.0  # 2 minutes, per GDD section 5 / SPRINT_0 win condition. Tune by feel.

var run_state: RunState = RunState.PLAYING
var time_left := SURVIVAL_TIME
var lose_reason := ""


func _ready() -> void:
	_reset()


func _process(delta: float) -> void:
	if run_state != RunState.PLAYING:
		return
	time_left = max(time_left - delta, 0.0)
	time_updated.emit(time_left)
	if time_left <= 0.0:
		_win()


func player_caught(reason: String) -> void:
	if run_state != RunState.PLAYING:
		return
	lose_reason = reason
	run_state = RunState.LOST
	state_changed.emit("lost")


func _win() -> void:
	if run_state != RunState.PLAYING:
		return
	run_state = RunState.WON
	state_changed.emit("won")


func restart() -> void:
	_reset()
	get_tree().reload_current_scene()


func _reset() -> void:
	run_state = RunState.PLAYING
	time_left = SURVIVAL_TIME
	lose_reason = ""
