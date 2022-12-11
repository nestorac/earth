extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var gradient = $Gradient

# Called when the node enters the scene tree for the first time.
func _ready():
	set_gradient_colors(GlobalVars.color_min, GlobalVars.color_max)

func set_gradient_colors(color_min:Color, color_max:Color):
	gradient.material.set("shader_param/first_color", color_min)
	gradient.material.set("shader_param/second_color", color_max)

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
		square.draw_square_temp(mmi.min_temp_c, mmi.max_temp_c)


func _on_BtNormal_button_up():
	var mmi = $"../World"
	mmi.set_layer(GlobalVars.layer.NONE)
	for square in mmi.get_children():
		square.draw_square()
