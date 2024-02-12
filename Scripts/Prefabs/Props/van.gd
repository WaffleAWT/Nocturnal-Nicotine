extends StaticBody3D

#Refrences
@onready var animator : AnimationPlayer

func _process(_delta: float) -> void:
	var current_scene := get_tree().get_current_scene()
	
	if current_scene.name == "Street":
		animator = $Animator

func _ready() -> void:
	PlayerInventory.play_car_leaving.connect(animate)

func animate():
	animator.play("animation")
