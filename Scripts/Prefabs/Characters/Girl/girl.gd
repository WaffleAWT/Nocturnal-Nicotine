extends Node3D

##The 3D audio player to play the scream audio.
@export var audio : AudioStreamPlayer3D

func _ready() -> void:
	position = Vector3(-101.251, 0.046, -32)

func play_scream():
	audio.play()

func play_gunfire():
	AudioManager.play_reverb(AudioManager.GUNFIRE)
