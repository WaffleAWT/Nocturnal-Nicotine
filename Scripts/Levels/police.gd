extends Node3D

#Refrences
@export var background : ColorRect
@export var label : Label

func _on_timer_timeout() -> void:
	background.visible = true
	get_tree().create_timer(0.5).timeout.connect(label_show)

func label_show():
	label.visible = true
	get_tree().create_timer(3.0).timeout.connect(change_scene)

func change_scene():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_menu.tscn")
