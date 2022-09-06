extends Spatial

var tmpMesh = Mesh.new()
var vertices = PoolVector3Array()
var UVs = PoolVector2Array()
var mat = SpatialMaterial.new()
export var color = Color(0.9, 0.1, 0.1)


func _ready():
#	vertices.push_back(Vector3(-0.5,0,1))
#	vertices.push_back(Vector3(-1.5,0,0))
#	vertices.push_back(Vector3(-0.5,0,-1))
#	vertices.push_back(Vector3(0.5,0,-1))
#	vertices.push_back(Vector3(1.5,0,0))
#	vertices.push_back(Vector3(0.5,0,1))

	vertices.push_back(Vector3(5.8,0,0))
	vertices.push_back(Vector3(17.33,0,0))
	vertices.push_back(Vector3(23.13,0,10))
	vertices.push_back(Vector3(17.34,0,20))
	vertices.push_back(Vector3(5.8,0,20))
	vertices.push_back(Vector3(0,0,10))
#
	UVs.push_back(Vector2(0,10))
	UVs.push_back(Vector2(5,20))
	UVs.push_back(Vector2(17.34,20))
	UVs.push_back(Vector2(23.13,10))
	UVs.push_back(Vector2(17.33,0))
	UVs.push_back(Vector2(5.8,0))

##	vertices.push_back(Vector3(0,0,0))
##	vertices.push_back(Vector3(0,0,1))
##	vertices.push_back(Vector3(1,0,0))
##
##	UVs.push_back(Vector2(0,0))
##	UVs.push_back(Vector2(0,1))
###	UVs.push_back(Vector2(1,0))
#	vertices.push_back(Vector3(1,0,0))
#	vertices.push_back(Vector3(0,0,1))
#	vertices.push_back(Vector3(0,0,0))
##	vertices.push_back(Vector3(0,0,1))
##	vertices.push_back(Vector3(1,0,0))
##	vertices.push_back(Vector3(1,0,1))
##	vertices.push_back(Vector3(0,0,1))
##	vertices.push_back(Vector3(0,0,0))
#
#	UVs.push_back(Vector2(0,0))
#	UVs.push_back(Vector2(0,1))
##	UVs.push_back(Vector2(1,1))
#	UVs.push_back(Vector2(1,0))
	
	mat.albedo_color = color

	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLE_FAN)
	st.set_material(mat)

	for v in vertices.size(): 
		st.add_color(color)
		st.add_uv(UVs[v])
		st.add_vertex(vertices[v])

	st.commit(tmpMesh)
	$"../MeshInstance3".mesh = tmpMesh
