extends Node3D

var main_manu = preload("res://Scenes/Levels/main_menu.tscn")

func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_packed(main_manu)
