extends Control

@onready var slider = $Panel/Settings_bg/Audio_Container/MainV_Container/HBoxContainer/HSlider
@onready var label = $Panel/Settings_bg/Audio_Container/MainV_Container/HBoxContainer/Label
@onready var fullscreen_checkbox = $Panel/Settings_bg/Display_Container/CheckBox
@onready var VSYNC_checkbox = $Panel/Settings_bg/Display_Container/CheckBox2

func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var volume = config.get_value("audio", "master_volume", 100)
		slider.value = volume
		label.text = str(int(volume)) + " %"

		var fullscreen = config.get_value("display", "fullscreen", false)
		fullscreen_checkbox.button_pressed = fullscreen

		var VSYNC = config.get_value("display", "VSYNC", false)
		VSYNC_checkbox.button_pressed = VSYNC
	else:
		slider.value = 100
		label.text = "100 %"
		fullscreen_checkbox.button_pressed = false
		VSYNC_checkbox.button_pressed = false


func _on_h_slider_value_changed(value: int) -> void:
	label.text = str(int(value)) + " %"
	SettingsManager._apply_volume(value)
	_save_settings()


func _on_check_box_toggled(button_pressed: bool) -> void:
	SettingsManager._apply_fullscreen(button_pressed)
	_save_settings()


func _on_check_box_2_toggled(button_pressed: bool) -> void:
	SettingsManager._apply_vsync(button_pressed)
	_save_settings()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://TitleScreen.tscn")


func _save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "master_volume", slider.value)
	config.set_value("display", "fullscreen", fullscreen_checkbox.button_pressed)
	config.set_value("display", "VSYNC", VSYNC_checkbox.button_pressed)
	config.save("user://settings.cfg")
