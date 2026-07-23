extends CharacterBody3D
## The Watcher — Sprint 0's only creature. GDD section 5.1 / Armani's
## Creative Decision #4-5. Health/defeat added in Creative Decision
## Session #003 (post-Sprint-0 playtest, provisional pending next test).
##
## Three-zone rule (GDD 5.1 "Behavior rules"):
##   1. IDLE   — outside laser range, unaware, patrols its home area.
##   2. TRACK  — inside laser range but outside the safe zone: tracks,
##               telegraphs, fires a laser.
##   3. SAFE   — inside laser-disable range but outside kick range: the
##               core exploit. Laser is off, kick can't reach yet.
##   4. KICK   — inside kick range: kicks instead of firing.
##
## ACTIVATION_DELAY is a bugfix, not a design pivot: Armani's Decision #3
## asked for a few quiet seconds before any Watcher tension starts, and
## the original Sprint 0 build broke that on a map this small relative to
## LASER_RANGE. This restores the intended pacing.

enum State { IDLE, TRACK, SAFE, KICK }

const ACTIVATION_DELAY := 8.0
const KICK_RANGE := 2.0
const LASER_DISABLE_RANGE := 4.5  # upper bound of the safe zone
const LASER_RANGE := 12.0
const MOVE_SPEED := 1.8
const LASER_TELEGRAPH_TIME := 0.8
const LASER_COOLDOWN := 2.2
const KICK_COOLDOWN := 1.4
const PATROL_WAIT_MIN := 2.0
const PATROL_WAIT_MAX := 4.5
const PATROL_RADIUS := 7.0
const MAX_HEALTH := 3

@onready var los_ray: RayCast3D = $LineOfSightRay
@onready var laser_beam: MeshInstance3D = $LaserBeam
@onready var eye: MeshInstance3D = $EyeBody

var state: State = State.IDLE
var player: Node3D = null
var home_position: Vector3
var patrol_target: Vector3
var patrol_timer := 0.0
var laser_timer := 0.0
var kick_timer := 0.0
var telegraphing := false
var telegraph_timer := 0.0
var flash_timer := 0.0
var activation_timer := ACTIVATION_DELAY
var health := MAX_HEALTH
var defeated := false


func _ready() -> void:
	add_to_group("watcher")
	home_position = global_position
	patrol_target = home_position
	laser_beam.visible = false
	_pick_new_patrol_point()
	call_deferred("_find_player")


func _find_player() -> void:
	var players := get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]


func on_lantern_hit() -> void:
	flash_timer = 0.35


func take_damage(amount: int) -> void:
	if defeated:
		return
	health -= amount
	flash_timer = 0.3
	if health <= 0:
		_defeat()


func _defeat() -> void:
	defeated = true
	telegraphing = false
	laser_beam.visible = false
	set_physics_process(false)
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector3(0.05, 0.05, 0.05), 0.6)
	GameManager.watcher_defeated()


func _physics_process(delta: float) -> void:
	if player == null:
		_find_player()
		return

	if flash_timer > 0.0:
		flash_timer -= delta
		eye.scale = Vector3.ONE * (1.0 + 0.06 * sin(flash_timer * 40.0))
	else:
		eye.scale = Vector3.ONE

	if activation_timer > 0.0:
		activation_timer -= delta
		_process_idle(delta)
		move_and_slide()
		return

	var distance := global_position.distance_to(player.global_position)
	var can_see := _has_line_of_sight()

	if distance <= KICK_RANGE:
		_set_state(State.KICK)
	elif distance <= LASER_DISABLE_RANGE:
		_set_state(State.SAFE)
	elif distance <= LASER_RANGE and can_see:
		_set_state(State.TRACK)
	else:
		_set_state(State.IDLE)

	match state:
		State.IDLE:
			_process_idle(delta)
		State.SAFE:
			_process_safe()
		State.TRACK:
			_process_track(delta, can_see)
		State.KICK:
			_process_kick(delta)

	move_and_slide()


func _set_state(new_state: State) -> void:
	if new_state == state:
		return
	state = new_state
	if state != State.TRACK:
		telegraphing = false
		laser_beam.visible = false


func _has_line_of_sight() -> bool:
	var target := player.global_position + Vector3.UP * 0.9
	if global_position.distance_to(target) < 0.05:
		return true
	los_ray.look_at(target, Vector3.UP)
	los_ray.force_raycast_update()
	if not los_ray.is_colliding():
		return true
	return los_ray.get_collider() == player


func _face_player() -> void:
	var look_target := player.global_position
	look_target.y = global_position.y
	if global_position.distance_to(look_target) > 0.01:
		look_at(look_target, Vector3.UP)


func _process_idle(delta: float) -> void:
	patrol_timer -= delta
	var to_target := patrol_target - global_position
	to_target.y = 0.0
	if to_target.length() < 0.5 or patrol_timer <= 0.0:
		_pick_new_patrol_point()
		velocity.x = 0.0
		velocity.z = 0.0
		return
	var dir := to_target.normalized()
	look_at(global_position + dir, Vector3.UP)
	velocity.x = dir.x * MOVE_SPEED
	velocity.z = dir.z * MOVE_SPEED


func _pick_new_patrol_point() -> void:
	var offset := Vector3(randf_range(-PATROL_RADIUS, PATROL_RADIUS), 0.0, randf_range(-PATROL_RADIUS, PATROL_RADIUS))
	patrol_target = home_position + offset
	patrol_timer = randf_range(PATROL_WAIT_MIN, PATROL_WAIT_MAX)


func _process_safe() -> void:
	velocity.x = 0.0
	velocity.z = 0.0
	_face_player()


func _process_track(delta: float, can_see: bool) -> void:
	velocity.x = 0.0
	velocity.z = 0.0
	_face_player()

	if not can_see:
		laser_timer = max(laser_timer, 0.5)
		return

	laser_timer -= delta
	if telegraphing:
		telegraph_timer -= delta
		laser_beam.visible = int(telegraph_timer * 8.0) % 2 == 0
		_aim_laser_beam()
		if telegraph_timer <= 0.0:
			_fire_laser()
	elif laser_timer <= 0.0:
		telegraphing = true
		telegraph_timer = LASER_TELEGRAPH_TIME


func _fire_laser() -> void:
	telegraphing = false
	laser_timer = LASER_COOLDOWN
	laser_beam.visible = true
	_aim_laser_beam()
	var hit := _has_line_of_sight()
	get_tree().create_timer(0.15).timeout.connect(func():
		if is_instance_valid(laser_beam):
			laser_beam.visible = false
	)
	if hit and global_position.distance_to(player.global_position) <= LASER_RANGE:
		GameManager.player_hit(1, "The Watcher's laser found you.")


func _aim_laser_beam() -> void:
	var from := eye.global_position
	var to := player.global_position + Vector3.UP * 0.9
	var dist := from.distance_to(to)
	if dist < 0.05:
		return
	laser_beam.global_position = (from + to) * 0.5
	laser_beam.look_at(to, Vector3.UP)
	laser_beam.rotate_object_local(Vector3.RIGHT, deg_to_rad(90))
	laser_beam.scale = Vector3(1.0, dist, 1.0)


func _process_kick(delta: float) -> void:
	velocity.x = 0.0
	velocity.z = 0.0
	_face_player()
	kick_timer -= delta
	if kick_timer <= 0.0:
		kick_timer = KICK_COOLDOWN
		GameManager.player_hit(1, "The Watcher kicked you.")
