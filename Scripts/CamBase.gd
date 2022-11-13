extends Spatial

const MOVE_MARGIN = 20
const MOVE_SPEED = 30
const RAY_LENGHT = 1000

# Rotación
export var rot_speed = 30
var last_mouse_position = Vector2()
#var is_rotating = false

# Variables del zoom
export (int) var max_zoom = 10
export (int) var min_zoom = 0
export (float) var zoom_speed = 50
export (float) var horizontal_displacement = 1
export (float) var vertical_displacement = 1

var zoom_direction = 0
onready var camera = $Camera

# Variables de la selecciṕón
var selected_units = []
var start_selection_position = Vector2()

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
#	calc_move(delta, mouse_position)
#	mouse_rotate(delta)
	zoom(delta)

func _unhandled_input(event):
#	# See if we are rotating the camera.
#	if event.is_action_pressed("center_click"):
#		is_rotating = true
#		last_mouse_position = get_viewport().get_mouse_position()
#	if event.is_action_released("center_click"):
#		is_rotating = false
	if event.is_action_pressed("zoom_in"):
		zoom_direction = -1
	if event.is_action_pressed("zoom_out"):
		zoom_direction = 1

func zoom(delta):
	# Calcular nuevo zoom
	var new_zoom = clamp(camera.translation.y + zoom_speed * zoom_direction * delta, min_zoom, max_zoom)
	camera.translation.y = new_zoom
	
	# Delimitar los valores del zoom
	# Dejar de mover el zoom cuando no haga nada el jugador
	zoom_direction = 0

#func mouse_rotate(delta):
#	if not is_rotating:
#		return
#
#	# Calcular el desplazamiento del ratón
#	var displacement = get_mouse_displ()
#
#	# Usar el desplazamiento para rotar la cḿámara
#	rotate_horizontal(delta, displacement.x)

func get_mouse_displ():
	var current_mouse_position = get_viewport().get_mouse_position()
	var displacement = current_mouse_position - last_mouse_position
	
	last_mouse_position = current_mouse_position
	return displacement

#func rotate_horizontal(delta, displacement_x):
#	rotation_degrees.y += displacement_x * delta * rot_speed
#
#
#func rotate_horizontal_right(delta):
#	rotation_degrees.y += horizontal_displacement * delta * rot_speed
#
#
#func rotate_horizontal_left(delta):
#	rotation_degrees.y -= horizontal_displacement * delta * rot_speed
#
#
#func rotate_vertical_up(delta):
#	rotation_degrees.x += vertical_displacement * delta * rot_speed
#
#
#func rotate_vertical_down(delta):
#	rotation_degrees.x -= vertical_displacement * delta * rot_speed
	

#func calc_move(delta, m_pos):
##	if is_rotating:
##		return
#
#	var viewport_size = get_viewport().size
#	var move_vector = Vector3()
#	if m_pos.x < MOVE_MARGIN:
#		rotate_horizontal_left(delta)
#	if m_pos.y < MOVE_MARGIN:
#		rotate_vertical_down(delta)
#	if m_pos.x > ( viewport_size.x - MOVE_MARGIN ):
#		rotate_horizontal_right(delta)
#	if m_pos.y > ( viewport_size.y - MOVE_MARGIN ):
#		rotate_vertical_up(delta)
#
#	global_translate(move_vector * MOVE_SPEED * delta)

