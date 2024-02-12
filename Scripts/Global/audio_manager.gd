extends Node

#Loads
#Music
const MUSIC_1 : AudioStreamMP3 = preload("res://Assets/Audio/Music/Music.mp3")

#Sounds
const AIR_CONDITIONER : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Air Condition.wav")
const CREEPY_AMBIENCE : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Creepy Ambience.wav")
const FOOTSTEPS : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Footsteps.wav")
const FROGS : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Frogs.wav")
const GASP : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Gasp.wav")
const GLASS_TAP : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Glass Random Tapping.wav")
const GUNFIRE : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Gunfire.wav")
const SWITCH : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Switch.wav")
const TAP : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Tap.wav")
const VAN_DOOR_CLOSE : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Van Door Close.wav")
const VAN_DOOR_OPEN : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Van Door Open.wav")
const WOMAN_SCREAM : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Woman Scream.wav")
const WALK_1 : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Walk1.wav")
const WALK_2 : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Walk2.wav")
const PICKUP : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Pickup.wav")
const GO_OUT : AudioStreamWAV = preload("res://Assets/Audio/Sounds/Go Out.wav")

#Refrences
@onready var music_players : Array[Node] = $Music.get_children()
@onready var sound_players : Array[Node] = $Sounds.get_children()
@onready var reverb_players : Array[Node] = $Reverb.get_children()

func _ready() -> void:
	play_music(MUSIC_1)

func play_music(music : AudioStreamMP3):
	for player in music_players:
		if not player.playing:
			player.stream = music
			player.play()
			break

func play_sound(sound : AudioStreamWAV):
	for player in sound_players:
		if not player.playing:
			player.stream = sound
			player.play()
			break

func play_reverb(sound : AudioStreamWAV):
	for player in reverb_players:
		if not player.playing:
			player.stream = sound
			player.play()
			break
