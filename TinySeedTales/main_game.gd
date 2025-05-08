extends Node2D
# Called when the node enters the scene tree for the first time.
@onready var anim = $Stats_UI/ProgressBar/AnimatedSprite2D
@onready var Jahr = $Stats_UI/Jahr
func _ready() -> void:
	anim.play("0")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.shopSequence == 1:
		anim.play("1")
	if Global.shopSequence == 2:
		anim.play("2")
	if Global.shopSequence == 3:
		anim.play("3")
	if Global.shopSequence == 4:
		anim.play("4")
	if Global.shopSequence == 5:
		anim.play("5")
	Jahr.text = "Jahr: " + str(Global.shopSequence + 1)
	if Global.state == "shop":
		$Stats.disabled == true
		$Stats.visible = false
		$Board.position.y = 1000
		$shop.position.y = 0
		$Stats_UI.position.y = 0
	if Global.state == "Board":
		$Stats.disabled == false
		$Stats.visible = true
		$Board.position.y = 0
		$shop.position.y = 1000
		if Global.StatsHidden == 1 :
			$Stats_UI.position.y = 1000
		elif Global.StatsHidden == 2:
			$Stats_UI.position.y = 0
	
	$Stats_UI/Geld.text = var_to_str(Global.Money) + " $"

func _on_button_pressed() -> void:
	Global.state = "Board"
