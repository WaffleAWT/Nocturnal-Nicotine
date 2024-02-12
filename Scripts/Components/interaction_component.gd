extends Area3D
class_name InteractionComponent

#Signals
signal interacted
signal disable_player

#Data
var player = null
@export_group("Data")
##The intaeraction text to show on screen.
@export_multiline var interaction_text : String

#Refrences
@export_group("Refrences")
##Used to disable the interaction until another interaction happens.
@export var interaction_component : InteractionComponent
##Used to disable player movement on dialogue.
@export var dialogue_component : DialogueComponent

func _ready() -> void:
	if dialogue_component:
		disable_player.connect(PlayerInventory.disable_player.bind(dialogue_component))

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("action") and player and not interaction_component and player.target == self:
			interacted.emit()
			if dialogue_component:
				disable_player.emit()
			queue_free()

func interact(player_hand : Player):
	player = player_hand
