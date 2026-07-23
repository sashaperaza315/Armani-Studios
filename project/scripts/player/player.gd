extends CharacterBody3D
## The Young Warden — Sprint 0.5 controller.
## Camera is now TOGGLABLE between first-person (original Creative
## Decision #1) and third-person (Armani's playtest request — see
## Creative Decision Session #003 in ARMANI_CREATIVE_DECISIONS.md).
## Also adds the Lantern Ember Bolt weapon from that same session.

const SPEED := 4.2
const SPRINT_SPEED := 6.4
const MOUSE_SENSITIVITY := 0.0025
const GRAVITY := 9.8
const INTERACT_RANGE := 2.5
const ATTACK_COOLDOWN := 1.0

@onready var head: Node3D = $Head
@onready var fps_camera: Camera3D = $Head/Camera3D
@onready var third_person_camera: Camera3D = $Head/ThirdPersonRig/Camera3D
@onready var warden_body: MeshInstance3D = $WardenBody
@onready var interact_ray: RayCast3D = $Head/Camera3D/InteractRay
@onready var attack_ray: RayCast3D = $Head/Camera3D/AttackRay
@onready var lantern = $Head/Camera3D/SpiritLantern

var lantern_on := false
var third_person := false
var attack_timer := 0.0


func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	lantern.set_on(false)
	_apply_camera_mode()


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
	if event.is_action_pressed("toggle_camera"):
		third_person = not third_person
		_apply_camera_mode()


func _apply_camera_mode() -> void:
	fps_camera.current = not third_person
	third_person_camera.current = third_person
	# Decision #1's "no seeing your own body" only applies in first-person;
	# the Warden model exists solely for the third-person mode added in
	# Creative Decision Session #003.
	warden_body.visible = third_person


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

	if attack_timer > 0.0:
		attack_timer -= delta

	if Input.is_action_just_pressed("interact"):
		_handle_interact()
	if Input.is_action_just_pressed("attack") and attack_timer <= 0.0:
		_handle_attack()


func _handle_interact() -> void:
	if interact_ray.is_colliding():
		var hit := interact_ray.get_collider()
		if hit and hit.has_method("interact") and hit.is_in_group("interactable"):
			hit.interact()
			return
	lantern_on = not lantern_on
	lantern.set_on(lantern_on)


func _handle_attack() -> void:
	# Lantern Ember Bolt — Creative Decision Session #003, Decision 8.
	# Provisional per that decision's own note: evaluate at next playtest
	# before treating this as locked canon the way Decisions 1-7 are.
	attack_timer = ATTACK_COOLDOWN
	attack_ray.force_raycast_update()
	if attack_ray.is_colliding():
		var hit := attack_ray.get_collider()
		if hit and hit.is_in_group("watcher") and hit.has_method("take_damage"):
			hit.take_damage(1)
