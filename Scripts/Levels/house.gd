extends Node3D

var menu : PackedScene = preload("res://Scenes/Levels/main_menu.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("ESC"):
			get_tree().change_scene_to_packed(menu)
