extends MeshInstance

class_name Square

var escaque_label = Label3D.new()

var tmpMesh = Mesh.new()
var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
var color = Color(0, 0, 0)
var st = SurfaceTool.new()

#enum {NONE, WATER, LAND, ICE, GRASS}
#var layer = NONE

var water_depth = 0 # between 0 and 200
var land_elevation = 50 # between 0 and 100
var ice_depth = 0.0 # between 0 and 1
var grass = false

var up
var down
var left
var right

var escaque = Vector2(0,0)


func _process(delta):
	if Input.is_action_just_pressed("test2"):
		draw_square()

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
	if water_depth > 1.0:
		water_depth = 1.0
	draw_square()



func draw_square_water():
	var material = get_surface_material(0)
	
	color = Color(water_depth*0.1, water_depth*0.1, water_depth*1)
	material.albedo_color = color


func draw_square_land():
	var material = get_surface_material(0)
	
	color = color + Color(land_elevation*1, land_elevation*0.66, land_elevation*0)
	material.albedo_color = color


func draw_square_ice():
	var material = get_surface_material(0)
	
	color = Color(ice_depth*0.15, ice_depth*1, ice_depth*1)
	material.albedo_color = color

func draw_square():
	var material = get_surface_material(0)
	
	if ice_depth > 0:
		color = Color(ice_depth*0.15, ice_depth, ice_depth)
	elif water_depth > 0:
		color = Color(water_depth*0.1, water_depth*0.1, water_depth)
		if land_elevation > 0:
			color = color + Color(land_elevation/100, (land_elevation/100)*0.66, 0)
	elif land_elevation > 0:
		color = Color(land_elevation/100, land_elevation/100*0.66, 0)
	if grass:
		color = Color(0.1, 0.7, 0.1)
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
#	escaquear() # Draw coordinates on every square. Debugging purposes.
	
	set_surface_material(0, _material)
	
	draw_square()
