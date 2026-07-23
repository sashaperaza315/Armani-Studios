extends CanvasLayer
## Sprint 0.5 HUD — timer, health, objective progress, win/lose message,
## and a controls hint (added because Session #003 doubled the control
## scheme: camera toggle + attack are new).

@onready var timer_label: Label = $TimerLabel
@onready var health_label: Label = $HealthLabel
@onready var objective_label: Label = $ObjectiveLabel
@onready var message_label: Label = $MessageLabel


func _ready() -> void:
	GameManager.time_updated.connect(_on_time_updated)
	GameManager.state_changed.connect(_on_state_changed)
	GameManager.health_changed.connect(_on_health_changed)
	GameManager.objective_updated.connect(_on_objective_updated)
	message_label.visible = false
	_on_time_updated(GameManager.time_left)
	_on_health_changed(GameManager.player_health, GameManager.MAX_HEALTH)
	_on_objective_updated(GameManager.secrets_found, GameManager.SECRETS_REQUIRED)


func _on_time_updated(seconds_left: float) -> void:
	var s := int(max(seconds_left, 0.0))
	timer_label.text = "%02d:%02d" % [s / 60, s % 60]


func _on_health_changed(current: int, max_health: int) -> void:
	health_label.text = "Health: " + "*".repeat(current) + ".".repeat(max_health - current)


func _on_objective_updated(found: int, total: int) -> void:
	objective_label.text = "Hollow Secrets: %d / %d" % [found, total]


func _on_state_changed(new_state: String) -> void:
	message_label.visible = true
	if new_state == "won":
		message_label.text = "%s\nPress R to play again." % GameManager.win_reason
	else:
		message_label.text = "%s\nPress R to play again." % GameManager.lose_reason


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		GameManager.restart()
