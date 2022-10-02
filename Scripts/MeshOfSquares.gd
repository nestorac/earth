extends MultiMeshInstance

var square = preload("res://Scenes/Square.tscn")
export var width = 10
export var height = 5

var squares = []

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
	
	
#	print (squares)
	
	for i in range
	
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
			square_instance.update_terrain()
