extends Node3D

#Refrences
##Used to disable phone if the player took it.
@export var phone : MeshInstance3D
##Used to animate the shooting.
@export var end_animation : AnimationPlayer
##Used to shoot after dialogue.
@export var last_dialogue : DialogueComponent

func _ready() -> void:
	if not PlayerInventory.has_phone:
		phone.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	if not last_dialogue:
		end_animation.play("shoot")

func change_scene():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")
