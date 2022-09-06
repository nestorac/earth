extends Node

class_name MeshOfSquares

var square = Square.new()
var square2 = Square.new()

func _ready():
	square.set_offset(0,0)
	square.play()
	print ("Ok.")
