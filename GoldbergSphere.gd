tool
extends ArrayMesh

class_name Geodesic


func make_geo(geo): # geo: type Geometry
  gverts = geo.raw_verts()

  gverts = base.verts();
  geo.colors(VERTS) = base.colors(VERTS);

  if (method == 's')
	project_onto_sphere(geo, centre);

  int num_verts =
	  base.faces().size() * (F * F * (m * m + m * n + n * n) - F * 3 + 2) / 2 +
	  base.edges().size() * (F - 1) + base.verts().size();
  // fprintf(stderr, "num_verts = %d\n", num_verts);
  // fprintf(stderr, "num_verts = %d, fs=%d, es=%d, vs=%d, F=%d, m=%d, n=%d,
  // freq=%d\n", num_verts, faces.size(), edges.size(), verts.size(), F, m, n,
  // freq);

  gverts.resize(num_verts);

  vector<vector<int>> orig_edges;
  for (unsigned int i = 0; i < base.faces().size(); i++) {
	vector<int> indx = make_face_indexes(i, base.faces(i));
	grid_to_points(indx, gverts);
	vector<vector<int>> new_face_tris;
	grid_to_tris(indx, new_face_tris, orig_edges);
	vector<vector<int>> &gfaces = geo.raw_faces();
	gfaces.insert(gfaces.end(), new_face_tris.begin(), new_face_tris.end());
	Color f_col = base.colors(FACES).get(int(i));
	for (unsigned int f = gfaces.size() - new_face_tris.size();
		 f < gfaces.size(); f++)
	  geo.colors(FACES).set(int(f), f_col);
