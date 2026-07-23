extends Node3D
## The Spirit Lantern — Sprint 0 scope: pure on/off, no battery/charge system
## (SPRINT_0.md decision log: "default to no, pure on/off" for this sprint).
## Reveals objects in group "lantern_reveal" and triggers a reaction on
## anything in group "watcher" when the beam passes over it.

@export var range_meters := 8.5
@export var cone_degrees := 30.0

@onready var light: SpotLight3D = $SpotLight3D

var is_on := false


func set_on(value: bool) -> void:
	is_on = value
	light.visible = value


func _physics_process(_delta: float) -> void:
	if not is_on:
		return
	for obj in get_tree().get_nodes_in_group("lantern_reveal"):
		if _in_beam(obj):
			obj.on_lit()
	for watcher in get_tree().get_nodes_in_group("watcher"):
		if _in_beam(watcher):
			watcher.on_lantern_hit()


func _in_beam(node: Node3D) -> bool:
	var to_obj := node.global_position - global_position
	var dist := to_obj.length()
	if dist > range_meters or dist < 0.001:
		return false
	var forward := -global_transform.basis.z
	var angle := rad_to_deg(forward.angle_to(to_obj.normalized()))
	return angle <= cone_degrees
