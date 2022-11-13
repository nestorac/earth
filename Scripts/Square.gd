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
var land_elevation = 0 # between 0 -100 and 100
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
#	if Input.is_action_just_pressed("set_layer"):
#		if layer == NONE:
#			layer = WATER
#		elif layer == WATER:
#			layer = LAND
#		elif layer == LAND:
#			layer = ICE
#		elif layer == ICE:
#			layer = GRASS
#		elif layer == GRASS:
#			layer = NONE
#		draw_square()
#		print (str(layer))

func set_neighbors(_up, _down, _left, _right):
	if (_up != null):
		up = _up 
	if (_down != null):
		down = _down
	if (_left != null):
		left = _left
	if (_right != null):
		right = _right


#func update_terrain():
##	randomize()
##	if (not left):
##		terrain = randi()%4
##	else:
##		terrain = left.terrain
##		print (left.terrain)
#
#	terrain = WATER
#
##	terrain = randi() % 4
#
#	match terrain:
#		WATER:
#			color = Color(0.1, 0.1, 1)
#			self.modulate = Color(0.1, 0.1, 1)
#		LAND:
#			color = Color(1, 0.66, 0)
#			self.modulate = Color(1, 0.66, 0)
#		ICE:
#			color = Color(0.15, 1, 1)
#			self.modulate = Color(0.15, 1, 1)
#		GRASS:
#			color = Color(0.1, 0.7, 0.1)
#			self.modulate = Color(0.1, 0.7, 0.1)
#
##	mat.albedo_color = color
##
##	st.set_material(mat)

func remove_land(land):
	land_elevation -= land
	draw_square()


func add_terrain_water(water):
	water_depth += water
	if water_depth > 1.0:
		water_depth = 1.0
	draw_square()

func draw_square():
	var material = get_surface_material(0)
	
#	if layer == NONE:
	if ice_depth > 0:
		color = Color(ice_depth*0.15, ice_depth, ice_depth)
	elif water_depth > 0:
		color = Color(water_depth*0.1, water_depth*0.1, water_depth)
		if land_elevation > 0:
			color = color + Color(land_elevation, land_elevation*0.66, land_elevation*0)
	elif (land_elevation > 0):
		color = Color(land_elevation, land_elevation*0.66, land_elevation*0)
	if grass:
		color = Color(0.1, 0.7, 0.1)
	material.albedo_color = color
#	elif layer == WATER:
#		color = Color(water_depth*0.1, water_depth*0.1, water_depth*1)
#		material.albedo_color = color
#	elif layer == LAND:
#		color = color + Color(land_depth*1, land_depth*0.66, land_depth*0)
#		material.albedo_color = color
#	elif layer == ICE:
#		color = Color(ice_depth*0.15, ice_depth*1, ice_depth*1)
#		material.albedo_color = color
#	elif layer == GRASS:
#		if grass:
#			color = Color(0.1, 0.7, 0.1)
#		else:
#			color = Color(0, 0, 0)
#		material.albedo_color = color


#func set_terrain(_terrain, depth):



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
