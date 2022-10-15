extends MultiMeshInstance

var square = preload("res://Scenes/Square.tscn")
export var width = 10
export var height = 5

enum {WATER, LAND, ICE, GRASS}

var squares = []

#func update_terrains():
#
#	for i in range(width):
#		for j in range(height):
##			squares[i][j].set_terrain(WATER)

func update_terrains():
	for child in get_children():
		child.set_terrain(ICE)
		print(child)

func _process(delta):
	if Input.is_action_pressed("update_terrains"):
		update_terrains()

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
	
	
#	print (squares)
	
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
				print (j)
			else:
				right = null
			square_instance.set_neighbors(up, down, left, right)
			
