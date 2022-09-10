extends Node

class_name MeshOfSquares

onready var square = get_node("Square")
var squares = []

func _ready():
	squares.append(square)
	squares[0].set_offset(0,0)
	squares[0].init()
	squares[0].play()
	
	squares.append(square)
	squares[1].set_offset(1,1)
	squares[1].init()
	squares[1].play()
	
	squares.append(square)
	squares[2].set_offset(2,2)
	squares[2].init()
	squares[2].play()
