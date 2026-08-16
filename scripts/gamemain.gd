extends Control

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
				print(grid_pos)
				grid_data[grid_pos.y][grid_pos.x] = player 
				player *= -1
				print(grid_data)
				

func new_game():
	player = 1
	grid_data = [
		[0, 0, 0],
		[0, 0, 0],
		[0, 0, 0]
		]
