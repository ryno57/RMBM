extends Node

func _ready():
	connect("finished", Callable(self, "_on_video_finished"))

func _on_video_finished():
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
