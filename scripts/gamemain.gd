extends Control

@export var circle_scene : PackedScene
@export var x_scene : PackedScene

var grid_data : Array
var player : int
var winner : int
var temp_marker
var player_panel_pos: Vector2i
var cell_size : int
var grid_pos : Vector2i
var board_size : int
var board_size2 = 700
var column_sum : int
var diagonal1_sum : int
var diagonal2_sum : int
var row_sum : int
#divide board size by 3 for size of individual cells



func _ready():
	pass
	board_size = $Board.texture.get_width()
	print(board_size)
	cell_size = board_size2 / 3
	player_panel_pos = $PlayerPanel.get_position()
	print(cell_size)
	new_game()
	
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#check if mouse is on game board 
			if event.position.x < board_size2:
				#convert mouse pos into a grid location
				grid_pos = Vector2i(event.position / cell_size)
				if grid_data[grid_pos.y][grid_pos.x] == 0 :
					print(grid_pos)
					grid_data[grid_pos.y][grid_pos.x] = player 
					#place the players marker
					create_marker(player, grid_pos * cell_size + Vector2i(cell_size / 2, cell_size /2))
					if check_win()!= 0:
						print("Game over")
						get_tree().paused = true
						$GameOverMenu.show()
						
					
					player *= -1
					#update panel marker
					temp_marker.queue_free()
					create_marker(player, player_panel_pos + Vector2i(cell_size / 2, cell_size / 2), true)
					print(grid_data)
				else :
					print("Piece already there")
				

func new_game():
	#start player as 1 which is the cross and will be placed in the grid
	player = 1
	winner = 0
	#instantiate grid array to place markers
	grid_data = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
		]
	var column_sum = 0
	var diagonal1_sum = 0
	var diagonal2_sum = 0
	var row_sum = 0
	#clear exisitng markers
	get_tree().call_group("Circles", "queue_free")
	get_tree().call_group("Crosses", "queue_free")
	#create a marker to show starting player
	create_marker(player, player_panel_pos + Vector2i(cell_size / 2, cell_size / 2), true)
	$GameOverMenu.hide()
	get_tree().paused = false

func create_marker(player, position, temp=false) : 
	#create a marker node and add it as a child 
	if player == 1:
		var circle = circle_scene.instantiate()
		circle.position = position
		add_child(circle)
		if temp: temp_marker = circle
	else: 
		var cross = x_scene.instantiate()
		cross.position = position
		add_child(cross)
		if temp: temp_marker = cross
		
func check_win() : 
	# add up the markers in each row and diagonal to find winner, winner is 3
	for i in len(grid_data):
		row_sum = grid_data[i][0] + grid_data[i][1] + grid_data[i][2]
		column_sum = grid_data[0][i] + grid_data[1][i] + grid_data[2][i]
		diagonal1_sum = grid_data[0][i] + grid_data[1][1] + grid_data[2][2]
		diagonal2_sum = grid_data[0][2] + grid_data[1][1] + grid_data[2][0]
		#check if =3
		if row_sum == 3 or column_sum == 3 or diagonal1_sum == 3 or diagonal2_sum == 3:
			winner = 1
		elif row_sum == -3 or column_sum == -3 or diagonal1_sum == -3 or diagonal2_sum == -3:
			winner = -1
	return winner


func _on_game_over_menu_restart() :
	new_game()
