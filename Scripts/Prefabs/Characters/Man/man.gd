extends Node3D

#Data
const ANIMATION_BLEND : float = 7.0

var dialogue : bool = false

#Refrences
##The man's animation tree node.
@export var animator : AnimationTree
@export var interaction_component : InteractionComponent

func _physics_process(_delta: float) -> void:
	if not interaction_component:
		asked()

func idle():
	animator.set("parameters/iw_blend/blend_amount", lerp(animator.get("parameters/iw_blend/blend_amount"), 0.0, ANIMATION_BLEND))

func walk():
	animator.set("parameters/iw_blend/blend_amount", lerp(animator.get("parameters/iw_blend/blend_amount"), 1.0, ANIMATION_BLEND))

func smoke():
	animator.set("parameters/smoking_os/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	get_tree().create_timer(18.0).timeout.connect(set_dialogue)

func set_dialogue():
	dialogue = true

func asked():
	if not interaction_component:
		PlayerInventory.state = PlayerInventory.ASKED
