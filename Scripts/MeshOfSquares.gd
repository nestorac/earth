extends MultiMeshInstance

var square = preload("res://Scenes/Square.tscn")
export var width = 30
export var height = 20

enum {WATER, LAND, ICE, GRASS}
export var islands = 5

var squares = []

#func update_terrains():
#
#	for i in range(width):
#		for j in range(height):
##			squares[i][j].set_terrain(WATER)


func create_sea():
	for child in get_children():
		child.set_terrain(WATER)

func random_land(terrain):
	var array = get_children()
	array.shuffle()
	var random_land = array.front()
	random_land.set_terrain(terrain)
	


func update_terrains_random():
	for child in get_children():
		child.set_terrain(child.choose_random([WATER, LAND, ICE, GRASS]))


func _process(delta):
	if Input.is_action_pressed("update_terrains"):
		create_sea()
		for i in islands:
			random_land(LAND)

func _ready():
	var square_instance
	
	var up
	var down
	var right
	var left
	
	for i in range(width):
		squares.append([])
		for j in range(height):
			square_instance = square.instance()
			squares[i].append(square.instance())
			add_child(square_instance)
			square_instance.escaque = Vector2(i, j)
			square_instance.escaque_label.text = str(i) + " " + str(j)
			square_instance.transform.origin = Vector3(i,0,j)
			square_instance.set_name("test_" + str(i) + "_" + str(j))
	
	
	for i in range(width):
		for j in range(height):
			if (i > 0):
				up = squares[i-1][j]
			else:
				up = null
			if (i < width - 1):
				down = squares[i+1][j]
			else:
				down = null
			if (j > 0):
				left = squares[i][j-1]
			else:
				left = null
			if (j < height -1):
				right = squares[i][j+1]
			else:
				right = null
			square_instance.set_neighbors(up, down, left, right)
			
