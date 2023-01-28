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
	mmi.next_day()

