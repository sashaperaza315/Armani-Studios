extends CanvasLayer
## Sprint 0 HUD — visible on-screen survival timer (producer's-discretion
## call from SPRINT_0.md's open decision; revisit with Armani if an
## atmospheric-only countdown feels better once it's playable) plus the
## minimal win/lose text called for in SPRINT_0.md section 5.

@onready var timer_label: Label = $TimerLabel
@onready var message_label: Label = $MessageLabel


func _ready() -> void:
	GameManager.time_updated.connect(_on_time_updated)
	GameManager.state_changed.connect(_on_state_changed)
	message_label.visible = false
	_on_time_updated(GameManager.time_left)


func _on_time_updated(seconds_left: float) -> void:
	var s := int(max(seconds_left, 0.0))
	timer_label.text = "%02d:%02d" % [s / 60, s % 60]


func _on_state_changed(new_state: String) -> void:
	message_label.visible = true
	if new_state == "won":
		message_label.text = "You survived.\nPress R to play again."
	else:
		message_label.text = "%s\nPress R to play again." % GameManager.lose_reason


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		GameManager.restart()
