extends Node2D
var Slot1 = Global.Slot1
var Slot2 = Global.Slot2
var Slot3 = Global.Slot3
var cell_size = 16*1.2
var scaled_size
var dirt_texture = preload("res://Dirt.png")
var white = preload("res://White16x16.png")
var Rot = preload("res://Rot16x16.png")
var scale_factor = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scaled_size = Vector2(dirt_texture.get_width() * scale_factor, dirt_texture.get_height() * scale_factor)
	pass # Replace with function body.
	

func _draw() -> void:
	drawSlot(Slot1, 0)
	drawSlot(Slot2, 270)
	drawSlot(Slot3, 540)

func drawSlot(x, y):
	var Slot = x
	var Offset = y
	if typeof(Slot.Teil1) == TYPE_ARRAY:
		for row in range(5):
			for col in range(5):
				if Slot.Teil1[row][col] == 1:
					var position = Vector2(col * cell_size - 615 + Offset, row * cell_size - 235)
					var rect = Rect2(position, scaled_size)
					draw_texture_rect(dirt_texture, rect, false, Color(1,1,1))
			

	if typeof(Slot.Teil2) == TYPE_ARRAY:
		for row in range(5):
			for col in range(5):
				if Slot.Teil2[row][col] == 1:
					var position = Vector2(col * cell_size - 615 + Offset, row * cell_size - 120)
					var rect = Rect2(position, scaled_size)
					draw_texture_rect(dirt_texture, rect, false, Color(1,1,1))

	if typeof(Slot.Teil3) == TYPE_ARRAY:
		for row in range(5):
			for col in range(5):
				if Slot.Teil3[row][col] == 1:
					var position = Vector2(col * cell_size - 615 + Offset, row * cell_size)
					var rect = Rect2(position, scaled_size)
					draw_texture_rect(dirt_texture, rect, false, Color(1,1,1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	Slot1 = Global.Slot1
	Slot2 = Global.Slot2
	Slot3 = Global.Slot3
