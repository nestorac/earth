extends MeshInstance

class_name Square

var tmpMesh = Mesh.new()
var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
export var color = Color(0.9, 0.1, 0.1)


func set_offset(offset_x, offset_z):
	vertices.push_back(Vector3(offset_x + 1, 0, offset_z + 0))
	vertices.push_back(Vector3(offset_x + 1, 0, offset_z + 1))
	vertices.push_back(Vector3(offset_x + 0, 0, offset_z + 1))
	vertices.push_back(Vector3(offset_x + 0, 0, offset_z + 0))

	UVs.push_back(Vector2(offset_x + 0, offset_z + 0))
	UVs.push_back(Vector2(offset_x + 0, offset_z + 1))
	UVs.push_back(Vector2(offset_x + 1, offset_z + 1))
	UVs.push_back(Vector2(offset_x + 1, offset_z + 0))


func play():
	mat.albedo_color = color

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	st.set_material(mat)

	for v in vertices.size(): 
		st.add_color(color)
		st.add_uv(UVs[v])
		st.add_vertex(vertices[v])

	st.commit(tmpMesh)
	
	$".".mesh = tmpMesh


func _ready():
	pass
