extends CharacterBody3D
## The Young Warden — Sprint 0 first-person controller.
## Camera perspective is LOCKED to first-person (Armani, Creative Decision #1).
## Scope: walk/run, look, collide with orchard geometry, single interact
## input that toggles the Spirit Lantern (or triggers a nearby interactable).

const SPEED := 4.2
const SPRINT_SPEED := 6.4
const MOUSE_SENSITIVITY := 0.0025
const GRAVITY := 9.8
const INTERACT_RANGE := 2.5

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interact_ray: RayCast3D = $Head/Camera3D/InteractRay
@onready var lantern = $Head/Camera3D/SpiritLantern

var lantern_on := false


func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	lantern.set_on(false)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		head.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-80), deg_to_rad(80))
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0.0

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var speed := SPRINT_SPEED if Input.is_action_pressed("sprint") else SPEED
	var direction := (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	if direction.length() > 0.0:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed)
		velocity.z = move_toward(velocity.z, 0.0, speed)

	move_and_slide()

	if Input.is_action_just_pressed("interact"):
		_handle_interact()


func _handle_interact() -> void:
	if interact_ray.is_colliding():
		var hit := interact_ray.get_collider()
		if hit and hit.has_method("interact") and hit.is_in_group("interactable"):
			hit.interact()
			return
	lantern_on = not lantern_on
	lantern.set_on(lantern_on)
