extends Control

@export var circle_scene : PackedScene
@export var x_scene : PackedScene
var testArray = [
	"test1",
	"test2"
]
var grid_data : Array
var player : int
var cell_size : int
var grid_pos : Vector2i
var board_size : int
var board_size2 = 700
#divide board size by 3 for size of individual cells



func _ready():
	pass
	board_size = $Board.texture.get_width()
	print(board_size)
	cell_size = board_size2 / 3
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
					player *= -1
					print(grid_data)
				else :
					print("Piece already there")
				

func new_game():
	player = 1
	grid_data = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
		]

func create_marker(player, position) : 
	#create a marker node and add it as a child 
	if player == 1:
		var circle = circle_scene.instantiate()
		circle.position = position
		add_child(circle)
	else: 
		var cross = x_scene.instantiate()
		cross.position = position
		add_child(cross)
