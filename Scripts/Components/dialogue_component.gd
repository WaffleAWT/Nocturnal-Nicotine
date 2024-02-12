extends CanvasLayer
class_name DialogueComponent

#Signals
signal enable_player_movement

#Data
var counter : int = 0
var additional_dialogue_counter : int = 0

@export_group("Data")
##The lower the faster dialogue text shows.
@export var text_speed : float = 0.05
##Used to play dialogue as soon as it's ready in the scene tree, useful for continious dialogue.
@export var play_on_start : bool = false
##Used to control how much to wait before closing the dialogue, useful with CutsceneComponenets.
@export var wait_time : float = 1.0
##You have to check this to true if this dialogue is a CutsceneComponent dialogue.
@export var cutscene : bool = false
##Used to start dialogue by animation players.
@export var start : bool = false :
	set(_value):
		show_dialogue()

#Refrences
@export_group("Refrences")
##The DialogueData resource refrence to play main dialogue.
@export var dialogue_data : DialogueData
##Character name label.
@export var name_label : Label
##Dialogue text label.
@export var dialogue_label : Label
##Timer to control the characters showing in the dialogue in order to animate them.
@export var timer : Timer
##The dialogue background
@export var dialogue_background : ColorRect
##The VboxContainer containing the dialogue labels.
@export var container : VBoxContainer
##Used to disable player movement on dialogue, don't refrence if you don't want to disable movement when dialogue plays.
@export var player : CharacterBody3D
##Used to play dialogue sound effect
@export var audio_player : AudioStreamPlayer

#Components
@export_group("Components")
##Used to play dialogue on interaction with an InteractionComponent object. "doesn't work while trigger_component is refrenced"
@export var interaction_component : InteractionComponent
##Used to play dialogue on trigger with a TriggerComponent object. "doesn't work while interaction_component is refrenced"
@export var trigger_component : TriggerComponent
##Used to spawn another dialogue on exit.
@export var next_dialogue : DialogueComponent

func _ready() -> void:
	name_label.text = dialogue_data.character_name
	dialogue_label.text = dialogue_data.dialogue_text
	dialogue_label.visible_characters = 0
	timer.wait_time = text_speed
	
	if play_on_start:
		show_dialogue()
	elif play_on_start and interaction_component or play_on_start and trigger_component:
		push_error("You can't have play on start with interaction or trigger.")
	else:
		if interaction_component and not trigger_component:
			interaction_component.interacted.connect(show_dialogue)
		elif trigger_component and not interaction_component:
			trigger_component.triggered.connect(show_dialogue)
		elif interaction_component and trigger_component:
			push_error("You can't have dialogue show both on interaction and trigger, remove one of the components in order to function!")
	
	if player:
		enable_player_movement.connect(player.enable_movement)

func show_dialogue():
	dialogue_background.visible = true
	container.visible = true
	timer.start()
	audio_player.play()

func _on_timer_timeout() -> void:
	dialogue_label.visible_characters += 1
	update_dialogue()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("action") and player and not cutscene:
			if dialogue_label.visible_characters < len(dialogue_label.text):
				dialogue_label.visible_characters = len(dialogue_label.text)
				timer.stop()
			else:
				wait_time = 0.0
				handle_exit()

func update_dialogue():
	if dialogue_label.visible_characters == len(dialogue_label.text):
		handle_exit()
	else:
		timer.start()

func handle_exit():
	audio_player.stop()
	if player and next_dialogue:
		next_dialogue.player = player
	get_tree().create_timer(wait_time).timeout.connect(exit_dialogue)

func exit_dialogue():
	if player and not next_dialogue:
		enable_player_movement.emit()
	if next_dialogue:
		next_dialogue.start = true
	queue_free()
