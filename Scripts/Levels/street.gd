extends Node3D

var street_lights : Array[RoadLight]
var menu : PackedScene = preload("res://Scenes/Levels/main_menu.tscn")

#Refrences
@onready var road_lights_node : Node3D = $World/RoadLights
@onready var peaking_1 : Node = $Components/AnimatorComponents/ManPeaking
@onready var peaking_2 : Node = $Components/AnimatorComponents/ManPeaking2
@onready var peaking_3 : Node = $Components/AnimatorComponents/ManPeaking3
@onready var peaking_4 : Node = $Components/AnimatorComponents/ManPeaking4
@onready var man_peaking : TriggerComponent = $Components/TriggerComponents/ManPeaking
@onready var man_peaking_2 : TriggerComponent = $Components/TriggerComponents/ManPeaking2
@onready var man_peaking_3 : TriggerComponent = $Components/TriggerComponents/ManPeaking3
@onready var man_peaking_4 : TriggerComponent = $Components/TriggerComponents/ManPeaking4
@export var animator_peak1 : AnimationPlayer
@export var animator_peak2 : AnimationPlayer
@export var animator_peak3 : AnimationPlayer
@export var animator_peak4 : AnimationPlayer
@export var player : CharacterBody3D

func turn_off_lights() -> void:
	for child in road_lights_node.get_children():
		if child is RoadLight:
			child.disable_road_lights()
	AudioManager.play_reverb(AudioManager.SWITCH)

func turn_on_lights() -> void:
	for child in road_lights_node.get_children():
		if child is RoadLight:
			child.enable_road_lights()

func _ready() -> void:
	man_peaking.triggered.connect(peak1)
	man_peaking_2.triggered.connect(peak2)
	man_peaking_3.triggered.connect(peak3)
	man_peaking_4.triggered.connect(peak4)
	turn_on_lights()

func peak1():
	if is_instance_valid(peaking_2):
		peaking_2.queue_free()
	if is_instance_valid(peaking_3):
		peaking_3.queue_free()
	if is_instance_valid(peaking_4):
		peaking_4.queue_free()
	if is_instance_valid(animator_peak1):
		animator_peak1.play("animation")

func peak2():
	if is_instance_valid(peaking_1):
		peaking_1.queue_free()
	if is_instance_valid(peaking_3):
		peaking_3.queue_free()
	if is_instance_valid(peaking_4):
		peaking_4.queue_free()
	if is_instance_valid(animator_peak2):
		animator_peak2.play("animation")

func peak3():
	if is_instance_valid(peaking_1):
		peaking_1.queue_free()
	if is_instance_valid(peaking_2):
		peaking_2.queue_free()
	if is_instance_valid(peaking_4):
		peaking_4.queue_free()
	if is_instance_valid(animator_peak3):
		animator_peak3.play("animation")

func peak4():
	if is_instance_valid(peaking_1):
		peaking_1.queue_free()
	if is_instance_valid(peaking_2):
		peaking_2.queue_free()
	if is_instance_valid(peaking_3):
		peaking_3.queue_free()
	if is_instance_valid(animator_peak4):
		animator_peak4.play("animation")

func kidnap():
	$Kidnap.visible = true
	get_tree().create_timer(1.5).timeout.connect(change_to_kidnap)

func change_to_kidnap():
	get_tree().change_scene_to_file("res://Scenes/Levels/kidnapped.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("ESC"):
			get_tree().change_scene_to_packed(menu)
