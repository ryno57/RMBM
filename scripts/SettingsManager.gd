extends Node


func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		_apply_main_volume(config.get_value("audio", "master_volume", 100))
		_apply_music_volume(config.get_value("audio", "music_volume", 100))
		_apply_sfx_volume(config.get_value("audio", "sfx_volume", 100))
		
		_apply_fullscreen(config.get_value("display", "fullscreen", false))
		_apply_vsync(config.get_value("display", "VSYNC", false))
		_apply_dalto(config.get_value("display", "DALTO", 0))


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
	
func _apply_dalto(value: int) -> void:
	if value == 0:
		ColorBlindFilter.set_mode(0)
	elif value == 1:
		ColorBlindFilter.set_mode(1)
	elif value == 2:
		ColorBlindFilter.set_mode(2)
	elif value == 3:
		ColorBlindFilter.set_mode(3)
	
