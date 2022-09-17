extends MeshInstance

class_name Square

enum {WATER, LAND, ICE, GRASS}


var tmpMesh = Mesh.new()
var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
var color = Color(0.5, 0, 0)
export var terrain = WATER

var up = 0
var down = 0
var left = 0
var right = 0

func set_neighbors(_up, _down, _left, _right):
	if (_up != 0):
		up = _up 
	if (_down != 0):
		down = _down
	if (_left != 0):
		left = _left
	if (_right != 0):
		right = _right

func set_terrain(terrain):
	
	terrain = randi()%4
	
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

	set_terrain(WATER)

	for v in vertices.size(): 
		st.add_color(color)
		st.add_uv(UVs[v])
		st.add_vertex(vertices[v])

	st.commit(tmpMesh)


func play():
	$".".mesh = tmpMesh


func _ready():
	
	load_fig()
	init()
	play()
