extends Node3D

#Refrences
##Audio to play on search.
@export var audio : AudioStreamPlayer
##The interaction component to search trash.
@onready var interaction_component : InteractionComponent = $InteractionComponent
##The collision shape to disable.
@onready var collision_bag : CollisionShape3D = $InteractionComponent/CollisionShape3D
##The trigger that has to happen to search trash.
@export var trigger_component : TriggerComponent

func _ready() -> void:
	interaction_component.interacted.connect(taken)

func _process(_delta: float) -> void:
	if not trigger_component and collision_bag != null:
		collision_bag.disabled = false

func taken():
	audio.play()
	PlayerInventory.has_paper = true
	$Label.visible = true
	get_tree().create_timer(2.0).timeout.connect(label_update)

func label_update():
	$Label.visible = false
