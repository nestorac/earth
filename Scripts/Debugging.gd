extends Control

onready var debugging_day = $debugging_day

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TurnTimer_timeout():
	debugging_day.text = str(GlobalVars.day)
	pass # Replace with function body.
