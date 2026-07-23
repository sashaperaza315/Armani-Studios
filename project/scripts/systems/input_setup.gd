extends Node
## Autoload — defines the Sprint 0 input map in code so the project works
## identically on any machine without hand-edited project.godot input blocks.
## Must be the FIRST autoload listed in project.godot so actions exist before
## any scene (Player, HUD) reads them in _ready().

func _ready() -> void:
	_bind("move_forward", KEY_W)
	_bind("move_back", KEY_S)
	_bind("move_left", KEY_A)
	_bind("move_right", KEY_D)
	_bind("sprint", KEY_SHIFT)
	_bind("interact", KEY_E)
	_bind("restart", KEY_R)


func _bind(action: String, keycode: Key) -> void:
	if InputMap.has_action(action):
		return
	InputMap.add_action(action)
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	InputMap.action_add_event(action, event)
