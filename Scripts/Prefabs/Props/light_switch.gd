extends Node3D

#Data
var material : StandardMaterial3D = preload("res://Assets/Materials/Bulb Off.tres")

#Refrences
##The interaction component to trigger lights on and off.
@export var interaction_component : InteractionComponent
##The light to switch on and off.
@export var light : OmniLight3D
##The bulb emission to switch on and off.
@export var bulb : MeshInstance3D
##The light switch audio.
@export var audio : AudioStreamPlayer

func _ready() -> void:
	interaction_component.interacted.connect(switch)

func switch():
	light.visible = false
	bulb.material_override = material
	audio.play()
