extends Node2D
var gamestate = "Game"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gamestate == "menue" :
		$mainGame.visible = false
		$menue.visible = true
	if gamestate == "Game" :
		$mainGame.visible = true
		$menue.visible = false
	if Global.StatsHidden > 2:
		Global.StatsHidden = 1
	#handle game states


func _on_button_pressed() -> void:
	gamestate = "Game"

func _on_stats_pressed():
	Global.StatsHidden += 1
	
func _on_skip_pressed():
	Global.state = "shop"
	Global.shopSequence += 1
