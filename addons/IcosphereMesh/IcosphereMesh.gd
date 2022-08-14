# Based on
# https://schneide.blog/2016/07/15/generating-an-icosphere-in-c/

tool
extends ArrayMesh
class_name IcosphereMesh

export var subdivisions : int = 2 setget set_subdivisions
func set_subdivisions(value):
	value = clamp(value, 0,6)
	if not value == subdivisions:
		subdivisions = value
		update_mesh()

export var diameter := 1.0 setget set_diameter
func set_diameter(value):
	if not diameter ==  value:
		diameter = value
		update_mesh()

var X := 0.525731112119133606 
var Z := 0.850650808352039932
var N := 0.0

var vertices : PoolVector3Array = []
var core_vertices : PoolVector3Array = [
		Vector3(-X,N,Z), Vector3(X,N,Z), Vector3(-X,N,-Z), Vector3(X,N,-Z),
		Vector3(N,Z,X), Vector3(N,Z,-X), Vector3(N,-Z,X), Vector3(N,-Z,-X),
		Vector3(Z,X,N), Vector3(-Z,X, N), Vector3(Z,-X,N), Vector3(-Z,-X, N),
		]

var triangles : PoolVector3Array = []
var core_triangles : PoolVector3Array = [
		Vector3(0,4,1), Vector3(0,9,4), Vector3(9,5,4), Vector3(4,5,8), Vector3(4,8,1),
		Vector3(8,10,1), Vector3(8,3,10), Vector3(5,3,8), Vector3(5,2,3), Vector3(2,7,3),
		Vector3(7,10,3), Vector3(7,6,10), Vector3(7,11,6), Vector3(11,0,6), Vector3(0,1,6),
		Vector3(6,1,10), Vector3(9,0,11), Vector3(9,11,2), Vector3(9,2,5), Vector3(7,2,11),
		]

func _init():
	update_mesh()

func update_mesh():
	triangles = core_triangles
	vertices = core_vertices
	
	for i in subdivisions:
		triangles = subdivide()
## scale vertices
	for i in vertices.size():
		vertices[i] = vertices[i] * diameter
## convert tiangles to PoolIntArray
	var triangles_pi : PoolIntArray = []
	for triangle in triangles:
		triangles_pi.append(triangle[0])
		triangles_pi.append(triangle[1])
		triangles_pi.append(triangle[2])
## Initialize the ArrayMesh.
	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = vertices
	arrays[ArrayMesh.ARRAY_INDEX] = triangles_pi
## Create the Mesh.
	clear_surfaces()
	self.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	emit_changed()

var lookup := {}
func vertex_for_edge(first:int, second:int) -> int:
	var key = [first, second]
	if first > second:
		key = [second, first]
	
	if not lookup.has(key):
		lookup[key] = vertices.size()
	
	if lookup[key]:
		var edge0 = vertices[first]
		var edge1 = vertices[second]
		var point : Vector3 = (edge0 + edge1).normalized()
		vertices.push_back(point)
	
	return lookup[key]

func subdivide():
	lookup = {}
	var new_triangles : PoolVector3Array = []
	var mid := [null, null, null]
	
	for original_triangle in triangles:
		for edge in 3:
			mid[edge] = vertex_for_edge(original_triangle[edge], original_triangle[(edge+1)%3])
		
		new_triangles.push_back(Vector3(original_triangle[0], mid[0], mid[2]))
		new_triangles.push_back(Vector3(original_triangle[1], mid[1], mid[0]))
		new_triangles.push_back(Vector3(original_triangle[2], mid[2], mid[1]))
		new_triangles.push_back(Vector3(mid[0], mid[1], mid[2]))
	return new_triangles


