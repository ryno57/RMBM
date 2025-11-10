extends Node

func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		_apply_main_volume(config.get_value("audio", "main_volume", 100))
		_apply_music_volume(config.get_value("audio", "music_volume", 100))
		_apply_sfx_volume(config.get_value("audio", "sfx_volume", 100))
		
		_apply_fullscreen(config.get_value("display", "fullscreen", false))
		_apply_vsync(config.get_value("display", "VSYNC", false))
	else:
		_apply_main_volume(100)
		_apply_music_volume(100)
		_apply_sfx_volume(100)

func _apply_main_volume(value: float) -> void:
	var linear_value = value / 100
	var db = -80.0 if linear_value <= 0.0 else linear_to_db(linear_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), db)

func _apply_music_volume(value: float) -> void:
	var linear_value = value / 100
	var db = -80.0 if linear_value <= 0.0 else linear_to_db(linear_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)
	
func _apply_sfx_volume(value: float) -> void:
	var linear_value = value / 100
	var db = -80.0 if linear_value <= 0.0 else linear_to_db(linear_value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), db)

func _apply_fullscreen(enable: bool) -> void:
	var target_mode = DisplayServer.WINDOW_MODE_FULLSCREEN if enable else DisplayServer.WINDOW_MODE_WINDOWED
	var current_mode = DisplayServer.window_get_mode()
	if current_mode != target_mode:
		DisplayServer.window_set_mode(target_mode)

func _apply_vsync(enable: bool) -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if enable else DisplayServer.VSYNC_DISABLED)
