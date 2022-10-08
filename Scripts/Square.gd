extends MeshInstance

class_name Square

enum {WATER, LAND, ICE, GRASS}

var escaque_label = Label3D.new()

var tmpMesh = Mesh.new()
var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
var color = Color(0.5, 0, 0)
export var terrain = WATER

var up
var down
var left
var right

var escaque = Vector2(0,0)

func set_neighbors(_up, _down, _left, _right):
	if (_up != null):
		up = _up 
	if (_down != null):
		down = _down
	if (_left != null):
		left = _left
	if (_right != null):
		right = _right


func update_terrain():
#	randomize()
#	if (not left):
#		terrain = randi()%4
#	else:
#		terrain = left.terrain
#		print (left.terrain)
		
	terrain = WATER

#	terrain = randi() % 4

	match terrain:
		WATER:
			color = Color(0.1, 0.1, 1)
		LAND:
			color = Color(1, 0.66, 0)
		ICE:
			color = Color(0.15, 1, 1)
		GRASS:
			color = Color(0.1, 0.7, 0.1)

	mat.albedo_color = color


func set_terrain(_terrain):
	
	terrain = _terrain
	
	match _terrain:
		WATER:
			color = Color(0.1, 0.1, 1)
		LAND:
			color = Color(1, 0.66, 0)
		ICE:
			color = Color(0.15, 1, 1)
		GRASS:
			color = Color(0.1, 0.7, 0.1)

	mat.albedo_color = color


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

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	st.set_material(mat)

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
	
	load_fig()
	init()
	play()
	escaquear()
