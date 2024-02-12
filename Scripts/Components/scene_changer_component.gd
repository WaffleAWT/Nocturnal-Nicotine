extends Node
class_name SceneChangerComponent

#Signals
signal scene_changed

#Refrences
##The scene you want to change to.
@export var scene : PackedScene
##Used to change scene on interaction.
@export var interaction_component : InteractionComponent
##Used to change scene on trigger.
@export var trigger_component : TriggerComponent

func _ready() -> void:
	if interaction_component and not trigger_component:
		interaction_component.interacted.connect(change_scene)
	elif trigger_component and not interaction_component:
		trigger_component.triggered.connect(change_scene)
	elif interaction_component and trigger_component:
		push_error("You can't change scene both on interaction and trigger, remove one of the components in order to function!")
	else:
		push_error("You have to refrence either InteractionComponent or TriggerComponent to change scene.")

func change_scene():
	PlayerInventory.street = true
	get_tree().change_scene_to_packed(scene)
