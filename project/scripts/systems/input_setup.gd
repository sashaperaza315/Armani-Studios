extends Node
## Autoload — defines the input map in code so the project works
## identically on any machine without hand-edited project.godot input blocks.
## Must be the FIRST autoload listed in project.godot so actions exist before
## any scene (Player, HUD) reads them in _ready().

func _ready() -> void:
	_bind_key("move_forward", KEY_W)
	_bind_key("move_back", KEY_S)
	_bind_key("move_left", KEY_A)
	_bind_key("move_right", KEY_D)
	_bind_key("sprint", KEY_SHIFT)
	_bind_key("interact", KEY_E)
	_bind_key("restart", KEY_R)
	_bind_key("toggle_camera", KEY_C)
	_bind_mouse_button("attack", MOUSE_BUTTON_LEFT)


func _bind_key(action: String, keycode: Key) -> void:
	if InputMap.has_action(action):
		return
	InputMap.add_action(action)
	var event := InputEventKey.new()
	event.physical_keycode = keycode
	InputMap.action_add_event(action, event)


func _bind_mouse_button(action: String, button: MouseButton) -> void:
	if InputMap.has_action(action):
		return
	InputMap.add_action(action)
	var event := InputEventMouseButton.new()
	event.button_index = button
	InputMap.action_add_event(action, event)
