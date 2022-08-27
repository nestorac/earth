# Geometry property container
template <class T> class GeomElemProps {
private:
  # Colours for vertices, edges and faces
  ElemProps<T> elem_props[3];

public:
  /// Get the element properties for an element type
  /**\param type from VERTS, EDGES, FACES.
   * \return The element properties. */
  const ElemProps<T> &operator[](int type) const;

  /// Get the element properties for an element type
  /**\param type from VERTS, EDGES, FACES.
   * \return The element properties. */
  ElemProps<T> &operator[](int type);

  /// Clear all properties for all elements
  void clear();

  /// Append a geometry property_container.
  /**\param geom_props geometry property holder to append.
   * \param v_size number of vertices in geometry associated with geom.
   * \param e_size number of edges in geometry associated with geom.
   * \param f_size number of faces in geometry associated with geomi. */
  void append(const GeomElemProps &geom_props, int v_size, int e_size,
			  int f_size);
}
