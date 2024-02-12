extends Node3D

#Refrences
##The animation node.
@export var animator : AnimationPlayer
##The phone node.
@export var phone : MeshInstance3D
##The last dialogue.
@export var last_dialogue : DialogueComponent

func _ready() -> void:
	if not PlayerInventory.has_phone:
		phone.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	if not last_dialogue:
		animator.play("animate")

func change_scene():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")
