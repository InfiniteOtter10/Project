extends Node2D
var scale_factor = 8
var scaled_size
var currentTeil = 0

var dirt_texture = preload("res://Dirt.png")
var white = preload("res://White16x16.png")
var Rot = preload("res://Rot16x16.png")
var curent_texture = dirt_texture

var canvas_size = Vector2(800, 800)
var cell_size = canvas_size.x / 6
var lastCurrentTeil = 1

# Größe des großen Feldes
const FIELD_SIZE = Vector2(800, 800)
# Offsets
const OFFSET = Vector2(100, 50)
# Größe der einzelnen Zellen in der 6x6 Matrix
const CELL_SIZE = Vector2(FIELD_SIZE.x / 6, FIELD_SIZE.y / 6)
var matrix = _matrix()
var matrixCopie = _matrix()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if lastCurrentTeil != currentTeil:
		currentTeil = Global.Teile[0]
		lastCurrentTeil = currentTeil
	scaled_size = Vector2(dirt_texture.get_width() * scale_factor, dirt_texture.get_height() * scale_factor)

func _matrix():
	var matrix = []
	for i in range(6):
		var row = []
		for j in range(6):
			row.append(0)  # Hier kannst du den Anfangswert anpassen
		matrix.append(row)
	return matrix

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	matrixCopie = _matrix()
	if _testTeil() == true:
		for row in range(6):
			for col in range(6):
				if matrix[row][col] == 0:
					var rm = (row - _lokalBoardMouse()[0] + 2)
					var cm = (col - _lokalBoardMouse()[1] + 2)
					if rm <= 4 && rm >= -1 && cm <= 4 && cm >= -1:
						if currentTeil[rm][cm] != 0:
							matrixCopie[row][col] = 1

	if _testTeil() == false:
		for row in range(6):
			for col in range(6):
					var rm = (row - _lokalBoardMouse()[0] + 2)
					var cm = (col - _lokalBoardMouse()[1] + 2)
					if rm <= 4 && rm >= -1 && cm <= 4 && cm >= -1:
						if currentTeil[rm][cm] != 0:
							matrixCopie[row][col] = 2

	selectCurrentTeil()
	queue_redraw()
	pass

func _lokalBoardMouse():
		# Hole die globale Mausposition
	var global_mouse_pos = get_viewport().get_mouse_position()
	# Wandle die globale Position in die lokale Koordinate des Nodes um
	var local_mouse_pos = to_local(global_mouse_pos)
	
	# Berechne die Position im Feld, indem die Offsets subtrahiert werden
	var relative_pos = local_mouse_pos - OFFSET
	var col = int(relative_pos.x / CELL_SIZE.x)
	var row = int(relative_pos.y / CELL_SIZE.y)
	
	if row  < 6 && col < 6 && row > -1 && col > -1 :
		return [row, col]
	else:
		return [-1, -1]

func _input(event):
	if Global.state == "Board":
		if Global.Teile[0] != [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]:
			if event is InputEventMouseButton:
				if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
					if _testTeil() == true:
						for row in range(6):
							for col in range(6):
								if matrix[row][col] == 0:
									if _lokalBoardMouse()[0] != -1:
										var rm = (row - _lokalBoardMouse()[0] + 2)
										var cm = (col - _lokalBoardMouse()[1] + 2)
										if rm <= 4 && rm >= -1 && cm <= 4 && cm >= -1:
											if currentTeil[rm][cm] != 0:
												matrix[row][col] = 1
									if row == 5 && col == 5:
										Global.Teile.pop_front()

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			rotate_matrix()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			rotate_matrix()

func rotate_matrix():
	var new_matrix = []
	for i in range(5):
		new_matrix.append([])
		for j in range(5):
			new_matrix[i].append(currentTeil[5 - j - 1][i])
	Global.Teile[0] = new_matrix

func _testTeil() :
	var Teilgröße = 0
	for row in range(5):
		for col in range(5):
			if currentTeil[row][col] != 0 :
				Teilgröße = Teilgröße + 1

	for row in range(6):
		for col in range(6):
			if matrix[row][col] == 0:
				if _lokalBoardMouse()[0] != -1:
					var rm = (row - _lokalBoardMouse()[0] + 2)
					var cm = (col - _lokalBoardMouse()[1] + 2)
					if rm <= 4 && rm >= -1 && cm <= 4 && cm >= -1:
						if currentTeil[rm][cm] != 0:
							Teilgröße = Teilgröße - 1
							
	if Teilgröße == 0:
		return true
	else:
		return false

func _draw() -> void:
	for row in range(6):
		for col in range(6):
			if matrix[row][col] == 0:
				var position = Vector2(col * cell_size - 700, row * cell_size - 400)
				var rect = Rect2(position, scaled_size)
				draw_texture_rect(white, rect, false, Color(1,1,1))
			else : if matrix[row][col] == 1:
				var position = Vector2(col * cell_size - 700, row * cell_size - 400)
				var rect = Rect2(position, scaled_size)
				draw_texture_rect(dirt_texture, rect, false, Color(1,1,1))

	for row in range(6):
		for col in range(6):
			if matrixCopie[row][col] == 1:
				var position = Vector2(col * cell_size - 700, row * cell_size - 400)
				var rect = Rect2(position, scaled_size)
				draw_texture_rect(dirt_texture, rect, false, Color(1,1,1))
			if matrixCopie[row][col] == 2:
				var position = Vector2(col * cell_size - 700, row * cell_size - 400)
				var rect = Rect2(position, scaled_size)
				draw_texture_rect(Rot, rect, false, Color(1,1,1))

func selectCurrentTeil():
	if lastCurrentTeil != Global.Teile[0]:
		currentTeil = Global.Teile[0]
		lastCurrentTeil = currentTeil
