extends StaticBody3D
class_name RoadLight

#Refrences
##The light you wanna put off.
@onready var light : OmniLight3D = $OmniLight3D
##The emissive material.
@onready var emission : StandardMaterial3D = $Mesh.get_active_material(0)

func disable_road_lights():
	light.visible = false
	emission.emission_enabled = false

func enable_road_lights():
	light.visible = true
	emission.emission_enabled = true
