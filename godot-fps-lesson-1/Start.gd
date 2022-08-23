extends Control



func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	get_tree().change_scene("res://Options.tscn")
