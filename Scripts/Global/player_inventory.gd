extends Node

#signals
signal play_car_leaving
signal disable_doors

#Data
enum {IDLE, ASKED, DIDNT_ASK}
var has_phone : bool = false
var market_lights_disabled : bool = false
var state
var street : bool = false
var has_paper : bool = false
var dialogue

#Refrences
@onready var player : CharacterBody3D
@onready var cashier_dialogue : DialogueComponent
@onready var asking_for_cigarette_dialogue : DialogueComponent
@onready var market_lights : Array[Node]
@onready var man : Node3D
@onready var man_didnt_ask : CharacterBody3D
@onready var man_cashier_dialogue : DialogueComponent
@onready var didnt_ask_nodes : Array[Node]
@onready var did_ask_nodes : Array[Node]

func _ready() -> void:
	state = IDLE

func disable_player(dialogue_pass):
	player.disable_movement()
	dialogue = dialogue_pass

func _process(_delta: float) -> void:
	if street:
		if not player:
			player = get_tree().get_first_node_in_group("Player")
		if not cashier_dialogue:
			cashier_dialogue = get_tree().get_first_node_in_group("CashierDialogue")
		if not asking_for_cigarette_dialogue:
			asking_for_cigarette_dialogue = get_tree().get_first_node_in_group("AskingDialogue")
		if not market_lights:
			market_lights = get_tree().get_nodes_in_group("MarketLight")
		if not man:
			man = get_tree().get_first_node_in_group("Man")
		if not man_didnt_ask:
			man_didnt_ask = get_tree().get_first_node_in_group("ManDidntAsk")
		if not man_cashier_dialogue:
			man_cashier_dialogue = get_tree().get_first_node_in_group("ManCashierDialogue")
		if not man_cashier_dialogue and man_didnt_ask:
			man_didnt_ask.animator.play("animation")
		if not didnt_ask_nodes:
			didnt_ask_nodes = get_tree().get_nodes_in_group("DidntAsk")
		if not did_ask_nodes:
			did_ask_nodes = get_tree().get_nodes_in_group("DidAsk")
	
	if not dialogue and player:
		player.enable_movement()
	
	if state == DIDNT_ASK and player:
		play_no_asking()
		if did_ask_nodes:
			for node in did_ask_nodes:
				if is_instance_valid(node):
					node.queue_free()
	
	if state == ASKED and player:
		if didnt_ask_nodes:
			for node in didnt_ask_nodes:
				if is_instance_valid(node):
					node.queue_free()

func play_no_asking():
	if not cashier_dialogue and state != ASKED and not market_lights_disabled:
		disable_market_lights()

func disable_market_lights():
	for light in market_lights:
		light.visible = false
	AudioManager.play_reverb(AudioManager.SWITCH)
	market_lights_disabled = true
	man.queue_free()
	disable_market_doors()
	get_tree().create_timer(2.0).timeout.connect(car_leaving)

func disable_market_doors():
	disable_doors.emit()

func car_leaving():
	play_car_leaving.emit()
