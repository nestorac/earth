extends MultiMeshInstance

var square = preload("res://Scenes/Square.tscn")
export var width = 10
export var height = 5

var squares = [width]

func _ready():
	var square_instance
	
	var up = 0
	var down = 0
	var right = 0
	var left = 0
	
	for i in range(width):
		for j in range(height):
			square_instance = square.instance()
			squares[i].append(square.instance())
			add_child(square_instance)
			square_instance.transform.origin = Vector3(i,0,j)
	
	
	for i in range(width):
		for j in range(height):
			if (i > 0):
				up = squares[i-1][j]
			else:
				up = 0
			if (i < height - 1):
				down = squares[i+1][j]
			else:
				down = 0
			if (j > 0):
				left = squares[i][j-1]
			else:
				left = 0
			if (j < width -1):
				right = squares[i][j+1]
			else:
				right = 0
			square_instance.set_neighbors(up, down, left, right)
