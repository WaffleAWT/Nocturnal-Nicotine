extends AudioStreamPlayer3D
class_name AudioPlayerComponent3D

##The trigger component to play audio on trigger.
@export var trigger_component : TriggerComponent
##The interaction component to play audio on interaction.
@export var interaction_component : InteractionComponent

func _ready() -> void:
	if interaction_component and not trigger_component:
		interaction_component.interacted.connect(play_audio)
	elif trigger_component and not interaction_component:
		trigger_component.triggered.connect(play_audio)
	elif interaction_component and trigger_component:
		push_error("You can't have the cutscene show both on interaction and trigger, remove one of the components in order to function!")
	else:
		push_error("This component does play audio on interaction or trigger, you have to refrence one in order to function.")
	finished.connect(queue_free)

func play_audio() -> void:
	play()
