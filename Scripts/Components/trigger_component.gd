extends Area3D
class_name TriggerComponent

#Signals
signal triggered
signal disable_player

#Data
##Destroy component on trigger.
@export var oneshot : bool = false
##Used to disable player's movement on trigger.
@export var disable_player_movement : bool = false
##Pass when you have disable player true
@export var dialogue : DialogueComponent
##Used to make a trigger dependant on another.
@export var trigger_component : TriggerComponent
##Used to make a trigger dependant on an interaction.
@export var interaction_component : InteractionComponent

func _ready() -> void:
	if disable_player_movement and dialogue:
		disable_player.connect(PlayerInventory.disable_player.bind(dialogue))

func _on_body_entered(_body: Node3D) -> void:
	if not trigger_component and not interaction_component:
		triggered.emit()
		if disable_player_movement:
			disable_player.emit()
		if oneshot:
			queue_free()
