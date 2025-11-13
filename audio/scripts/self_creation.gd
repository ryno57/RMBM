extends Control

func _on_back_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
