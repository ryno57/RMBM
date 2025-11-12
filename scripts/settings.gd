extends Control

@onready var slider_main = $Panel/Settings_bg/Audio_Container/Audio_label/VBoxContainer/MainV_Container/HBoxContainer/HSlider_main
@onready var slider_music = $Panel/Settings_bg/Audio_Container/Audio_label/VBoxContainer/MusicV_Container/HBoxContainer/HSlider_music
@onready var slider_sfx = $Panel/Settings_bg/Audio_Container/Audio_label/VBoxContainer/SFXV_Container/HBoxContainer/HSlider_sfx
@onready var label_main = $Panel/Settings_bg/Audio_Container/Audio_label/VBoxContainer/MainV_Container/HBoxContainer/Label
@onready var label_music = $Panel/Settings_bg/Audio_Container/Audio_label/VBoxContainer/MusicV_Container/HBoxContainer/Label
@onready var label_sfx = $Panel/Settings_bg/Audio_Container/Audio_label/VBoxContainer/SFXV_Container/HBoxContainer/Label
@onready var fullscreen_checkbox = $Panel/Settings_bg/Display_Container/Display_label/VBoxContainer/CheckBox
@onready var VSYNC_checkbox = $Panel/Settings_bg/Display_Container/Display_label/VBoxContainer/CheckBox2
@onready var None_dalto = $Panel/Settings_bg/Display_Container/Display_label/VBoxContainer/Dalto/VBoxContainer/HBoxContainer/None
@onready var Prota_dalot = $Panel/Settings_bg/Display_Container/Display_label/VBoxContainer/Dalto/VBoxContainer/HBoxContainer/Protanopia
@onready var Deute_dalto = $Panel/Settings_bg/Display_Container/Display_label/VBoxContainer/Dalto/VBoxContainer/HBoxContainer2/Deuteranopia
@onready var Trita_dalto = $Panel/Settings_bg/Display_Container/Display_label/VBoxContainer/Dalto/VBoxContainer/HBoxContainer2/Tritanopia

@onready var dalto = 0

func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var main_volume = config.get_value("audio", "master_volume")
		slider_main.value = main_volume
		label_main.text = str(int(main_volume)) + " %"
		
		var music_volume = config.get_value("audio", "music_volume")
		slider_music.value = music_volume
		label_music.text = str(int(music_volume)) + " %"
		
		var sfx_volume = config.get_value("audio", "sfx_volume")
		slider_sfx.value = sfx_volume
		label_sfx.text = str(int(sfx_volume)) + " %"

		var fullscreen = config.get_value("display", "fullscreen")
		fullscreen_checkbox.button_pressed = fullscreen

		var VSYNC = config.get_value("display", "VSYNC")
		VSYNC_checkbox.button_pressed = VSYNC
		
		var dalton = config.get_value("display", "DALTO")
		if dalton == 0:
			None_dalto.button_pressed = true
		elif dalton == 1:
			Prota_dalot.button_pressed = true
		elif dalton == 2:
			Deute_dalto.button_pressed = true
		elif dalton == 3:
			Trita_dalto.button_pressed = true
			
	else:
		slider_main.value = 100; label_main.text = "100 %"
		slider_music.value = 100; label_music.text = "100 %"
		slider_sfx.value = 100; label_sfx.text = "100 %"
		fullscreen_checkbox.button_pressed = false
		VSYNC_checkbox.button_pressed = false
		None_dalto.button_pressed = true ; Prota_dalot.button_pressed = false; Deute_dalto.button_pressed = false; Trita_dalto.button_pressed = false


func _on_h_slider_main_value_changed(value: int) -> void:
	label_main.text = str(int(value)) + " %"
	SettingsManager._apply_main_volume(value)
	_save_settings()

func _on_h_slider_music_value_changed(value: int) -> void:
	label_music.text = str(int(value)) + " %"
	SettingsManager._apply_music_volume(value)
	_save_settings()

func _on_h_slider_sfx_value_changed(value: int) -> void:
	label_sfx.text = str(int(value)) + " %"
	SettingsManager._apply_sfx_volume(value)
	_save_settings()

func _on_check_box_toggled(button_pressed: bool) -> void:
	SettingsManager._apply_fullscreen(button_pressed)
	_save_settings()

func _on_check_box_2_toggled(button_pressed: bool) -> void:
	SettingsManager._apply_vsync(button_pressed)
	_save_settings()


func _on_none_toggled(toggled_on: bool) -> void:
	if toggled_on:
		dalto = 0
		SettingsManager._apply_dalto(dalto)
		_save_settings()

func _on_protanopia_toggled(toggled_on: bool) -> void:
	if toggled_on:
		dalto = 1
		SettingsManager._apply_dalto(dalto)
		_save_settings()

func _on_deuteranopia_toggled(toggled_on: bool) -> void:
	if toggled_on:
		dalto = 2
		SettingsManager._apply_dalto(dalto)
		_save_settings()

func _on_tritanopia_toggled(toggled_on: bool) -> void:
	if toggled_on:
		dalto = 3
		SettingsManager._apply_dalto(dalto)
		_save_settings()



func _on_back_1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")

func _save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "master_volume", slider_main.value)
	config.set_value("audio", "music_volume", slider_music.value)
	config.set_value("audio", "sfx_volume", slider_sfx.value)
	config.set_value("display", "fullscreen", fullscreen_checkbox.button_pressed)
	config.set_value("display", "VSYNC", VSYNC_checkbox.button_pressed)
	config.set_value("display", "DALTO", dalto)
	print(dalto)
	config.save("user://settings.cfg")
