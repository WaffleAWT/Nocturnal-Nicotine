extends Node
class_name DestroyComponent

#Data
##Used to do something on destroy.
@export var pickable : bool = false

#Refrences
##The node to destroy
@export var destroyable : Node
##Use to destroy something on interaction.
@export var interaction_component : InteractionComponent
##Use to destroy something on trigger.
@export var trigger_component : TriggerComponent

func _ready() -> void:
	if interaction_component and not trigger_component:
		interaction_component.interacted.connect(destroy)
	elif trigger_component and not interaction_component:
		trigger_component.triggered.connect(destroy)
	elif interaction_component and trigger_component:
		push_error("You can't have something destroyed both on interaction and trigger, remove one of the components in order to function!")
	else:
		push_error("You have to refrence either InteractionComponent or TriggerComponent to destroy.")

func destroy():
	if destroyable:
		destroyable.queue_free()
	if pickable:
		pick()
	queue_free()

func pick():
	match destroyable.name:
		"Phone":
			PlayerInventory.has_phone = true
			AudioManager.play_sound(AudioManager.PICKUP)
