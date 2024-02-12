extends Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	reset_game()

func _on_start_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/house.tscn")

func _on_options_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/credits.tscn")

func _on_quit_button_button_up() -> void:
	get_tree().quit()

func reset_game():
	PlayerInventory.has_phone = false
	PlayerInventory.market_lights_disabled = false
	PlayerInventory.state = PlayerInventory.IDLE
	PlayerInventory.street = false
	PlayerInventory.has_paper = false
	PlayerInventory.dialogue = null
	PlayerInventory.player = null
	PlayerInventory.cashier_dialogue = null
	PlayerInventory.asking_for_cigarette_dialogue = null
	PlayerInventory.market_lights = []
	PlayerInventory.man = null
	PlayerInventory.man_didnt_ask = null
	PlayerInventory.man_cashier_dialogue = null
	PlayerInventory.didnt_ask_nodes = []
	PlayerInventory.did_ask_nodes = []
	PlayerInventory.state = PlayerInventory.IDLE
