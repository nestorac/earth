extends Spatial

onready var cell = get_node("Cell")

export(PackedScene) var unit_scene
export(NodePath) onready var units_node = get_node(units_node) as Spatial


func _process(delta):
	if Input.is_action_pressed("spawn_cells"):
		for i in range(20):
			spawn_unit()

func spawn_unit():
	var unit_instance = unit_scene.instance()
	
	units_node.add_child(unit_instance)
	unit_instance.global_transform.origin = Vector3(randf()/4.0,randf()/4.0,randf()/4.0)
	print("Spawn child.")
