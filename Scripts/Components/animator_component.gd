extends Node
class_name AnimatorComponent

#Data
var animation_name : String = "animation"

#Refrences
##The animation player you want to play something on.
@export var animator : AnimationPlayer
##The interaction component to animate on interaction.
@export var interaction_component : InteractionComponent
##The trigger component to animate on trigger.
@export var trigger_component : TriggerComponent

func _ready() -> void:
	if interaction_component and not trigger_component:
		interaction_component.interacted.connect(animate)
	elif trigger_component and not interaction_component:
		trigger_component.triggered.connect(animate)
	elif interaction_component and trigger_component:
		push_error("You can't have the animation play both on interaction and trigger, remove one of the components in order to function!")
	else:
		push_error("You must have at least am InteractionComponent or TriggerComponent to play animation.")

func animate() -> void:
	animator.play(animation_name)
