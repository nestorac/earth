extends MultiMeshInstance


var square = preload("res://Scenes/Square.tscn")
export var width = 50
export var height = 40

export var land_to_be_removed = 25

export var water_impact = 50.0

var max_temp_c = 0.0
var min_temp_c = 0.0

const TEMP_IMPACT = 3000.0

export var islands = 5
export var layer = GlobalVars.layer.NONE
export var world_temperature_celsius = 21.0

var squares = []

#func update_terrains():
#
#	for i in range(width):
#		for j in range(height):
##			squares[i][j].set_terrain(WATER)


func refresh_min_max_temp():
	var squares = get_children()
	
	max_temp_c = squares[0].temperature_celsius
	min_temp_c = squares[0].temperature_celsius
	
	for square in squares:
		if max_temp_c < square.temperature_celsius:
			max_temp_c = square.temperature_celsius
		
		if min_temp_c > square.temperature_celsius:
			min_temp_c = square.temperature_celsius


func init_temp_c():
	var equator = round(height / 2.0)
	
	var squares = get_children()
	
	max_temp_c = squares[0].temperature_celsius
	min_temp_c = squares[0].temperature_celsius
	
	for square in squares:
		var coord_y = square.coord_y
		var distance = abs( coord_y )
		if distance > equator:
			distance = height - distance
		
		square.temperature_celsius = distance
		
		if max_temp_c < square.temperature_celsius:
			max_temp_c = square.temperature_celsius
		
		if min_temp_c > square.temperature_celsius:
			min_temp_c = square.temperature_celsius
	
	for square in squares:
		square.draw_square_temp(min_temp_c,max_temp_c)
		square.escaque_label.text = str(square.temperature_celsius)
#		print ("temp: ", square.temperature_celsius, ", min: ", min_temp_c, ", max: ", max_temp_c)
		
		

# iterate: perform the necessary steps to advance time by 1 day
func next_day():
	# Process all the events for a day.
	GlobalVars.day += 1
	var ui_min_temp = $"../UI/min_temp"
	var ui_max_temp = $"../UI/max_temp"
	refresh_min_max_temp()
	var world_max_temp = max_temp_c
	var world_min_temp = min_temp_c
	
#	var _colors = [PoolColorArray()]
#	_colors[0].push_back(Color(1.0, 0, 0, 1))
#	_colors[0].push_back(Color(0, 1.0, 0, 1))

	
#	var gradient = $UI/Gradient
#	gradient.set_colors(_colors)
	var day = $"../UI/Debugging/debugging_day"
	
	day.text = str(GlobalVars.day)
	
	ui_max_temp.set_text(str("max: ", world_max_temp, "ºC"))
	ui_min_temp.set_text(str("min: ", world_min_temp, "ºC"))
	
#	print ("max: ", world_max_temp, "ºC")
#	print ("min: ", world_min_temp, "ºC")
	print (GlobalVars.day)


func set_layer(_layer):
	layer = _layer


func create_sea():
	for child in get_children():
		child.set_terrain(GlobalVars.layer.WATER, 1.0)

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
	var array_coordinates_water = []
	var square = get_square(x,y)
	# The radius now will only be one, for debugging purposes.
	radius = 1
	
	for i in range(radius):
		var aliasing = water_impact
		var distance = round ( radius - round( (i*i) / (PI*PI*2) ) )
		
		for j in range( distance ):
			if (j == (distance - 1) ):
				aliasing = water_impact * fmod((i*i) / (PI*PI*2.0), 1.0) / 2.0
			
			if (i == 0) and (j == 0):
				square = get_square(x, y)
				square.temperature_celsius = TEMP_IMPACT
				if square:
					array_coordinates_water.append([x,y])
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
			
			if (i == 0) and (j != 0):
				square = get_square(x, y+j)
				if square:
					array_coordinates_water.append([x,y+j])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
				square = get_square(x, y-j)
				if square:
					array_coordinates_water.append([x,y+j])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
			if (j == 0) and (i != 0):
				square = get_square(x+i, y)
				if square:
					array_coordinates_water.append([x+i,y])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
				square = get_square(x-i, y)
				if square:
					array_coordinates_water.append([x+i,y])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
			if (i != 0 and j != 0):
				square = get_square(x+i, y+j)
				if square:
					array_coordinates_water.append([x+i,y+j])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
				square = get_square(x+i, y-j)
				if square:
					array_coordinates_water.append([x-i,y+j])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
				square = get_square(x-i,y+j)
				if square:
					array_coordinates_water.append([x-i,y+j])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
				square = get_square(x-i,y-j)
				if square:
					array_coordinates_water.append([x-i,y-j])
					square.temperature_celsius = TEMP_IMPACT * 0.9
					square.add_terrain_water(aliasing)
					square.remove_land(land_to_be_removed*aliasing/100.0)
#	flow(array_coordinates_water)


func flow(impact_coordinates:Array):
	var water_depth_center = get_square(impact_coordinates[0][0], impact_coordinates[0][1]).water_depth
#	print ("up: " + str(get_square(impact_coordinates[0][0], impact_coordinates[0][1]).up))
	var neighbours = [[impact_coordinates[0][0], impact_coordinates[0][1]+1],
					  [impact_coordinates[0][0]+1, impact_coordinates[0][1]],
					  [impact_coordinates[0][0], impact_coordinates[0][1]-1],
					  [impact_coordinates[0][0]-1, impact_coordinates[0][1]-1]]
	
	var water_depth_new = water_depth_center / ( neighbours.size() + 1 )

	print ("water depth new: " + str(water_depth_new) )
	print ("water depth center: " + str(water_depth_center) )

	for element in neighbours:
		get_square(element[0], element[1]).water_depth = water_depth_new
		print (element)

	get_square(impact_coordinates[0][0], impact_coordinates[0][1]).water_depth = water_depth_new

#	print (neighbours)
#
#	print (impact_coordinates)
#	print (get_square(impact_coordinates[0][0], impact_coordinates[0][1]).water_depth)


func get_square(x, y):
	if x < width and y < height and x >= 0 and y >= 0:
		var node = get_node("test_" + str(x) + "_" + str(y))
		if node:
			return node
#	else:
#		print ("Coordinates must be lower than " + str(width) + " width and " + str(height) + " height.")
		

func update_terrains_random():
	for child in get_children():
		child.set_terrain(child.choose_random([GlobalVars.layer.WATER,
						GlobalVars.layer.LAND, GlobalVars.layer.ICE,
						GlobalVars.layer.GRASS]))


func _process(delta):
	if Input.is_action_just_pressed("test1"):
		var xy = get_random_coordinates()
		impact(xy[0],xy[1],randi()%20,GlobalVars.layer.WATER)
	if Input.is_action_just_pressed("update_terrains"):
		create_sea()
		for i in islands:
			random_land(GlobalVars.layer.LAND)

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
			square_instance.escaque_label.text = str(square_instance.temperature_celsius)
			square_instance.transform.origin = Vector3(i,0,j)
			square_instance.set_name("test_" + str(i) + "_" + str(j))
			square_instance.coord_x = i
			square_instance.coord_y = j
	
	
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
			
	init_temp_c()


func _on_DebuggingNextDay_pressed():
	next_day()
	pass # Replace with function body.
