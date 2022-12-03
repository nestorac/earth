extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func hide_squares(layer):
	var mmi = $"../World"
	for square in mmi.get_children():
		pass # TODO


func _on_BtWater_button_up():
	var mmi = $"../World"
	mmi.set_layer(GlobalVars.layer.WATER)
	for square in mmi.get_children():
		square.draw_square_water()


func _on_BtLand_button_up():
	var mmi = $"../World"
	mmi.set_layer(GlobalVars.layer.LAND)
	for square in mmi.get_children():
		square.draw_square_land()


func _on_BtIce_button_up():
	var mmi = $"../World"
	mmi.set_layer(GlobalVars.layer.ICE)
	for square in mmi.get_children():
		square.draw_square_ice()


func _on_BtTemp_button_up():
	var mmi = $"../World"
	mmi.set_layer(GlobalVars.layer.TEMP)
	for square in mmi.get_children():
		square.draw_square_temp(0,50)


func _on_BtNormal_button_up():
	var mmi = $"../World"
	mmi.set_layer(GlobalVars.layer.NONE)
	for square in mmi.get_children():
		square.draw_square()
