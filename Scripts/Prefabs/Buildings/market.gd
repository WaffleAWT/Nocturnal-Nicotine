extends Node3D

#Data
var is_open : bool = false
var toggle_distance : float = 2.0
var can_open : bool = true

#Refrences
##The market door animation player.
@export var animator : AnimationPlayer
##Actors that can use the door.
@export var actors : Array[CharacterBody3D]
##Used to mark the center of the two doors.
@export var marker : Marker3D
##The man didn't ask refrence.
@export var man_didnt_ask : CharacterBody3D

func _ready() -> void:
	PlayerInventory.disable_doors.connect(disable_doors)

func _process(_delta: float) -> void:
	for actor in actors:
		if is_instance_valid(actor):
			if marker.global_position.distance_squared_to(actor.global_position) <= toggle_distance and not is_open and can_open:
				open()
				is_open = true

func open():
	animator.play("open_door")
	get_tree().create_timer(1.0).timeout.connect(set_opened)

func set_opened():
	get_tree().create_timer(2.0).timeout.connect(close)

func close():
	animator.play("close_door")
	get_tree().create_timer(1.0).timeout.connect(set_closed)

func set_closed():
	is_open = false

func disable_doors():
	can_open = false
	get_tree().create_timer(20.0).timeout.connect(enable_doors)

func enable_doors():
	can_open = true
	man_didnt_ask.animator.play("walk_inside")
