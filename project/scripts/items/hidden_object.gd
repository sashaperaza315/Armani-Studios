extends Node3D
## Attach to any prop that should be invisible until lit by the Spirit
## Lantern. Feeds GameManager's "find 3 Hollow secrets" escape objective
## (Creative Decision Session #003).

var revealed := false


func _ready() -> void:
	add_to_group("lantern_reveal")
	visible = false


func on_lit() -> void:
	if revealed:
		return
	revealed = true
	visible = true
	GameManager.secret_found()
