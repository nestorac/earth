extends Spatial

func _ready():
	var material = $"Circle".get_surface_material(0)
	material.albedo_color = Color(1, 0, 0)
	$"Circle".set_surface_material(0, material)
