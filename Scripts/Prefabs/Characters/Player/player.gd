extends CharacterBody3D

#Data
@export_group("Movement Data")
##The player's movement speed.
@export var speed : float = 2.5
##The player's jump power.
@export var jump_strength : float = 4.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var velocity_y : float = 0.0
var can_move : bool = true

@export_group("Settings")
##Mouse sensitivity to control the first person view.
@export var look_sensitivity : float = 0.003

#Refrences
@export_group("Refrences")
##The player's camera.
@export var camera : Camera3D
##The player's animation player for headbob.
@export var animator : AnimationPlayer
##The player's interaction label.
@export var interaction_label : Label

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if can_move:
		velocity = get_horizontal_velocity().x * global_transform.basis.x + get_horizontal_velocity().y * global_transform.basis.z
	
	apply_gravity(delta)
	velocity.y = velocity_y
	
	if get_input_vector() and can_move:
		animator.play("walking", -1, 1.5)
	else:
		animator.pause()
	
	move_and_slide()

func _input(event):
	#Mouse Yaw and Pitch movement
	if event is InputEventMouseMotion and can_move:
		rotate_y(-event.relative.x * look_sensitivity)
		camera.rotate_x(-event.relative.y * look_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func get_input_vector() -> Vector2:
	var input_vector : Vector2 = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_forwards", "move_backwards")
	input_vector = input_vector.normalized()
	return input_vector

func get_horizontal_velocity() -> Vector2:
	var horizontal_velocity = get_input_vector() * speed
	return horizontal_velocity

func apply_gravity(delta):
	if is_on_floor():
		velocity_y = 0
	else:
		velocity_y -= gravity * delta

func disable_movement():
	if velocity != Vector3.ZERO:
		velocity = Vector3.ZERO
	can_move = false

func enable_movement():
	can_move = true
