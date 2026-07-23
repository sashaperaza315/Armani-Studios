extends Node3D
## Attach to any prop that should be invisible until lit by the Spirit
## Lantern. Sprint 0: 2-3 of these placed in The Forgotten Orchard.

@export var stays_revealed := true

var revealed := false


func _ready() -> void:
	add_to_group("lantern_reveal")
	visible = false


func on_lit() -> void:
	if revealed and stays_revealed:
		return
	revealed = true
	visible = true
