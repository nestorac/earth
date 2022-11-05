extends MultiMeshInstance

var square = preload("res://Scenes/Square.tscn")
export var width = 50
export var height = 50

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
		child.set_terrain(WATER, 1.0)

func random_land(terrain):
	var array = get_children()
	array.shuffle()
	var random_land = array.front()
	random_land.set_terrain(terrain, 1.0)
	

func get_random_coordinates():
	randomize()
	var x = randi() % (width - 1)
	var y = randi() % (height - 1)
	
	return [x,y]

func impact(x, y, radius, terrain):
	var square = get_square(x,y)
	# square.set_terrain(terrain, 1.0)
	
	for i in range(radius):
		var aliasing = 1.0
		var distance = round ( radius - round( (i*i) / (PI*PI*2) ) )
#		print ("i: " + str(i) + ", radius: " + str(radius))
		for j in range( distance ):
			if (j == (distance - 1) ):
				aliasing = fmod((i*i) / (PI*PI*2), 1.0)
				print (aliasing)
			else:
				aliasing = 1.0
			
			square = get_square(x+i, y+j)
			if square:
				square.add_terrain_water(aliasing)
			square = get_square(x+i, y-j)
			if square:
				square.add_terrain_water(aliasing)
			square = get_square(x-i,y+j)
			if square:
				square.add_terrain_water(aliasing)
			square = get_square(x-i,y-j)
			if square:
				square.add_terrain_water(aliasing)


func get_square(x, y):
	if (x <= width) and (y <= height):
		return get_node("test_" + str(x) + "_" + str(y))
	else:
		print ("Coordinates must be lower than " + str(width) + " width and " + str(height) + " height.")
		

func update_terrains_random():
	for child in get_children():
		child.set_terrain(child.choose_random([WATER, LAND, ICE, GRASS]))


func _process(delta):
	if Input.is_action_pressed("test1"):
		var xy = get_random_coordinates()
		impact(xy[0],xy[1],randi()%20,WATER)
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
			
