extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func hide_squares(layer):
	var mmi = $"../MultiMeshInstance"
	for square in mmi.get_children():
		pass # TODO


func _on_BtWater_button_up():
	pass
