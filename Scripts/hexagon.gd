extends Spatial

func _ready():
	var material = $hexagon.get_surface_material(0)
	material.albedo_color = Color(1, 0, 0)
	$hexagon.set_surface_material(0, material)
