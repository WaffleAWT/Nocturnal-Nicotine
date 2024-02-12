extends RayCast3D
class_name Player

#Data
var target

#Refrences
##The player's interaction lable.
@export var interaction_label : Label

func _physics_process(_delta: float) -> void:
	if is_colliding():
		target = get_collider()
		if target is InteractionComponent:
			target.interact(self)
			interaction_label.text = target.interaction_text
			if not target.interaction_component:
				interaction_label.visible = true
			if Input.is_action_just_pressed("action") and not target.interaction_component:
				target.interacted.emit()
	else:
		target = null
		interaction_label.visible = false
