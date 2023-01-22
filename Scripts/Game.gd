extends Spatial

onready var mmi = $World
onready var ui = $UI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_DebuggingPause_pressed():
	pause_days()

func pause_days():
	if $TurnTimer.paused:
		$TurnTimer.paused = false
		$UI/Debugging/DebuggingPause.text = "Pause"
	else:
		$TurnTimer.paused = true
		$UI/Debugging/DebuggingPause.text = "Continue"

func _on_TurnTimer_timeout():
	GlobalVars.day += 1
	var ui_min_temp = $UI/min_temp
	var ui_max_temp = $UI/max_temp
	var world = $World
	world.refresh_min_max_temp()
	var world_max_temp = world.max_temp_c
	var world_min_temp = world.min_temp_c
	
#	var _colors = [PoolColorArray()]
#	_colors[0].push_back(Color(1.0, 0, 0, 1))
#	_colors[0].push_back(Color(0, 1.0, 0, 1))

	
#	var gradient = $UI/Gradient
#	gradient.set_colors(_colors)
	
	ui_max_temp.set_text(str("max: ", world_max_temp, "ºC"))
	ui_min_temp.set_text(str("min: ", world_min_temp, "ºC"))
	
	print ("max: ", world_max_temp, "ºC")
	print ("min: ", world_min_temp, "ºC")
	
	mmi.next_day()

