extends Node3D

#Data
var player

#Refrences
##The collision shape to come back home.
@export var collision : CollisionShape3D
##The trigger to enable going back home on.
@export var trigger_component : TriggerComponent
##The audio to play on enter.
@export var audio : AudioStreamPlayer

func _ready() -> void:
	visible = false
	$CanvasLayer/Label.visible = false

func _process(_delta: float) -> void:
	if PlayerInventory.state == PlayerInventory.DIDNT_ASK:
		collision.disabled = false
		visible = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("action") and player and PlayerInventory.state != PlayerInventory.IDLE:
			AudioManager.play_sound(AudioManager.GO_OUT)
			if PlayerInventory.state == PlayerInventory.DIDNT_ASK:
				if PlayerInventory.has_paper:
					get_tree().change_scene_to_file("res://Scenes/Levels/house_with_paper.tscn")
				else:
					get_tree().change_scene_to_file("res://Scenes/Levels/house_no_paper.tscn")

func _on_area_3d_body_entered(body: Node3D) -> void:
	player = body
	if PlayerInventory.state == PlayerInventory.DIDNT_ASK:
		$CanvasLayer/Label.visible = true

func _on_area_3d_body_exited(_body: Node3D) -> void:
	player.interaction_label.visible = false
	player = null
	if PlayerInventory.state == PlayerInventory.DIDNT_ASK:
		$CanvasLayer/Label.visible = false
