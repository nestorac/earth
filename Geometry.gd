class_name Geometry

var vert_elems

func verts():
	return vert_elems

var verts = verts()

# function verts, v_idx: int
func verts(v_idx):
	return vert_elems[v_idx]


func add_vert(vert, col): #vert: type Vector3, col: type Color
  idx = verts().size()
  raw_verts().push_back(vert)
  if col.is_set():
	colors(VERTS).set(idx, col)
  return idx;

func add_verts(vrts):  #vrts: type const Vector3
  for v in vrts:
	add_vert(v)
  return verts().size() - 1
