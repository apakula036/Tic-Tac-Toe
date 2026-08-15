extends Control


func _on_startgamebutton_pressed() -> void:
	print("start button pressed")
	get_tree().change_scene_to_file("res://scenes/gamemain.tscn")


func _on_optionsbutton_pressed() -> void:
	print("options button pressed")


func _on_quitgamebutton_pressed() -> void:
	print("quit button pressed")
	get_tree().quit()
