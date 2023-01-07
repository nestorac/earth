extends MeshInstance

class_name Square

var escaque_label = Label3D.new()

var tmpMesh = Mesh.new()
var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
var color = Color(0, 0, 0)
var st = SurfaceTool.new()

export var temperature_celsius = 10.0 # between -100 and +100

#var layer = NONE

var water_depth = 0 # between 0 and 100
var land_elevation = 50 # between 0 and 100
var ice_depth = 0.0 # between 0 and 1
var grass = false

var up
var down
var left
var right

var coord_x
var coord_y

var escaque = Vector2(0,0)


func _process(delta):
	if Input.is_action_just_pressed("test2"):
		draw_square()


func compute_temp_celsius():
	temperature_celsius = -land_elevation + water_depth


func set_temperature_celsius(temp):
	if temp >= -100.0 and temp <= 100.0:
		temperature_celsius = temp
	else:
		print ("Temperature ()" + temp + "ºC) is out of range (-100..100ºC)")

func set_neighbors(_up, _down, _left, _right):
	if (_up != null):
		up = _up 
	if (_down != null):
		down = _down
	if (_left != null):
		left = _left
	if (_right != null):
		right = _right


func remove_land(land):
	land_elevation -= land
	draw_square()


func add_terrain_water(water):
	water_depth += water
	if water_depth > 100:
		water_depth = 100
	draw_square()



func draw_square_water():
	var material = get_surface_material(0)
	
	color = Color(water_depth/100.0*0.1, water_depth/100.0*0.1, water_depth/100.0*1.0)
	material.albedo_color = color


func draw_square_land():
	var material = get_surface_material(0)
	
	color = Color(land_elevation/100.0, land_elevation/100.0*0.66, 0)
	material.albedo_color = color


func draw_square_ice():
	var material = get_surface_material(0)
	
	color = Color(ice_depth*0.15, ice_depth*1, ice_depth*1)
	material.albedo_color = color


func get_square_temp_color(temp_c):
	return Color((temperature_celsius+100)/200.0, 0, 1.0-(temperature_celsius+100)/200.0)


#func draw_square_temp():
#	var material = get_surface_material(0)
#
#	color = Color((temperature_celsius+100)/200.0, 0, 1.0-(temperature_celsius+100)/200.0)
##	color = get_square_temp_color(temperature_celsius)
#
#	material.albedo_color = color
	
func draw_square_temp(_min, _max):
	var material = get_surface_material(0)
	var value = 0.0
#
#	if _max > 20:
#		_max = 20.0
#
#	if _max == _min:
#		value = _min - temperature_celsius
#	else:
#		value = abs( ( float(_min - temperature_celsius) ) / (float ( (_max - _min) ) ) )
#		print (abs(value)) 
	
#	color = GlobalVars.color_min.linear_interpolate(GlobalVars.color_max, value)
	
	
	value = abs( ( float(_min - temperature_celsius) ) / (float ( (_max - _min) ) ) )

#	color = GlobalVars.log_color(Color(0.0,0.0,1.0,1.0), Color(1.0,0.0,0.0,1.0), value)

	color = GlobalVars.color_min.linear_interpolate(GlobalVars.color_max, log(value))
	
	print ("Value: ", value)
	
	material.albedo_color = color

func draw_square():
	var material = get_surface_material(0)
	var mesh_of_squares = get_parent()
	
	if mesh_of_squares.layer == GlobalVars.layer.NONE:
		if ice_depth > 0:
			color = Color(ice_depth*0.15, ice_depth, ice_depth)
		elif water_depth > 0:
			color = Color(water_depth/100.0*0.1, water_depth/100.0*0.1, water_depth/100.0)
			if land_elevation > 0:
				color = color + Color(land_elevation/100.0, land_elevation/100.0*0.66, 0)
		elif land_elevation > 0:
			color = Color(land_elevation/100.0, land_elevation/100.0*0.66, 0)
		if grass:
			color = Color(0.1, 0.7, 0.1)
	elif mesh_of_squares.layer == GlobalVars.layer.WATER:
		draw_square_water()
	elif mesh_of_squares.layer == GlobalVars.layer.LAND:
		draw_square_land()
	elif mesh_of_squares.layer == GlobalVars.layer.ICE:
		draw_square_ice()
	elif mesh_of_squares.layer == GlobalVars.layer.TEMP:
		draw_square_temp(-100,100)
#	elif mesh_of_squares.layer == GlobalVars.layer.GRASS:
#		draw_square_grass()
	material.albedo_color = color


func choose_random(array:Array):
	array.shuffle()
	return array.front()


func load_fig():
	vertices.push_back(Vector3(1, 0, 0))
	vertices.push_back(Vector3(1, 0, 1))
	vertices.push_back(Vector3(0, 0, 1))
	vertices.push_back(Vector3(0, 0, 0))

	UVs.push_back(Vector2(0, 0))
	UVs.push_back(Vector2(0, 1))
	UVs.push_back(Vector2(1, 1))
	UVs.push_back(Vector2(1, 0))


func init():
	mat.albedo_color = color

	st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
#	st.set_material(mat)

#	set_terrain(global_terrain)

	for v in vertices.size(): 
		st.add_color(color)
		st.add_uv(UVs[v])
		st.add_vertex(vertices[v])

	st.commit(tmpMesh)


func play():
	$".".mesh = tmpMesh


func escaquear():
	escaque_label.scale = Vector3(3,3,3)
	escaque_label.rotation_degrees = Vector3(-90,0,0)
	escaque_label.transform.origin = Vector3(0,0.2,0)
	add_child(escaque_label)


func _ready():
	var _material = SpatialMaterial.new()
	
	load_fig()
	init()
	play()
	escaquear() # Draw coordinates on every square. Debugging purposes.
	
	set_surface_material(0, _material)
	
	draw_square()
