extends Camera3D
class_name CutsceneComponent

#Signals
signal disable_player_movement
signal enable_player_movement

#Data
@export_group("Data")
##Plays the cutscene as soon as it's ready in the scene tree.
@export var play_on_start : bool = false

#Refrences
@export_group("Refrences")
##The cutscene animation player, the animation name should be animation
@export var animation_player : AnimationPlayer
##Used to disable the player camera and movement while in cutscene.
@export var player : CharacterBody3D
##Used to play the cutscene on interaction with an InteractionComponent object. "doesn't work while trigger_component is refrenced"
@export var interaction_component : InteractionComponent
##Used to play the cutscene on trigger with an TriggerComponent object. "doesn't work while interaction_component is refrenced"
@export var trigger_component : TriggerComponent

func _ready() -> void:
	if interaction_component and not trigger_component:
		interaction_component.interacted.connect(play_cutscene)
	elif trigger_component and not interaction_component:
		trigger_component.triggered.connect(play_cutscene)
	elif interaction_component and trigger_component:
		push_error("You can't have the cutscene show both on interaction and trigger, remove one of the components in order to function!")
	
	if play_on_start:
		play_cutscene()

func play_cutscene():
	current = true
	disable_player_movement.connect(player.disable_movement)
	disable_player_movement.emit()
	animation_player.animation_finished.connect(cutscene_finished.unbind(1))
	animation_player.play("animation")

func cutscene_finished():
	player.camera.current = true
	enable_player_movement.connect(player.enable_movement)
	enable_player_movement.emit()
	queue_free()
