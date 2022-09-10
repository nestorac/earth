extends MultiMeshInstance

var square = preload("res://Scenes/Square.tscn")
export var width = 10
export var height = 5

func _ready():
	var square_instance
	
	for i in width:
		for j in height:
			square_instance = square.instance()
			add_child(square_instance)
			square_instance.transform.origin = Vector3(i,0,j)
