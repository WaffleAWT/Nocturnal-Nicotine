extends Label

#Data
var player : bool = false

#Refrences
@export var collision : CollisionShape3D
@export var trigger_cashier_killed : TriggerComponent

func _ready() -> void:
	visible = false
	collision.disabled = true

func _process(_delta: float) -> void:
	if not trigger_cashier_killed:
		collision.disabled = false

func _on_can_call_body_entered(_body: Node3D) -> void:
	if not trigger_cashier_killed and PlayerInventory.has_phone:
		player = true
		visible = true

func _on_can_call_body_exited(_body: Node3D) -> void:
	player = false
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("action") and visible and PlayerInventory.has_phone:
			get_tree().change_scene_to_file("res://Scenes/Levels/police.tscn")
