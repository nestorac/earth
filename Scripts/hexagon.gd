extends Spatial

# State machine
enum{SEA, LAND, FOREST}

func set_type(type):
	var material = $"Circle".get_surface_material(0)
	
	if type == SEA:
		material.albedo_color = Color(0, 0, 0.64)
	elif type == LAND:
		material.albedo_color = Color(1, 0.75, 0.31)
	elif type == FOREST:
		material.albedo_color = Color(0, 0.64, 0.05)
	else:
		return
	$"Circle".set_surface_material(0, material)

func _process(delta):
	if Input.is_action_pressed("set_sea"):
		set_type(SEA)
	if Input.is_action_pressed("set_land"):
		set_type(LAND)
	if Input.is_action_pressed("set_forest"):
		set_type(FOREST)
