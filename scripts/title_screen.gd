extends Control

func ready():
	GameLogic.is_active = false
	GameLogic.reset()

func _on_button_4_pressed():
	OS.shell_open("https://github.com/ryno57/RMBM")

func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")

func _on_button_5_pressed() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/self_creation.tscn")
	
