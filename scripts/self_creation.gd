extends Control

@onready var line_edits = [
	$HBoxContainer/Game_Panel/VBoxContainer/holder/LineEdit,
	$HBoxContainer/Self_Panel/VBoxContainer/holder/LineEdit,
	$HBoxContainer/Self_Panel/VBoxContainer/holder2/LineEdit
]

@onready var radio_groups = [
	[
		$HBoxContainer/Game_Panel/VBoxContainer/holder2/HBoxContainer/easy,
		$HBoxContainer/Game_Panel/VBoxContainer/holder2/HBoxContainer/normal,
		$HBoxContainer/Game_Panel/VBoxContainer/holder2/HBoxContainer/hard
	],
	[
		$"HBoxContainer/Game_Panel/VBoxContainer/holder3/HBoxContainer/0_75x",
		$"HBoxContainer/Game_Panel/VBoxContainer/holder3/HBoxContainer/1x",
		$"HBoxContainer/Game_Panel/VBoxContainer/holder3/HBoxContainer/1_5x"
	],
	[
		$"HBoxContainer/Self_Panel/VBoxContainer/holder3/HBoxContainer/1900",
		$"HBoxContainer/Self_Panel/VBoxContainer/holder3/HBoxContainer/1950",
		$"HBoxContainer/Self_Panel/VBoxContainer/holder3/HBoxContainer/2000"
	]
]

@onready var continue_button = $Button2

func _ready():
	for le in line_edits:
		le.text_changed.connect(_on_input_changed)
	
	for group in radio_groups:
		for rb in group:
			rb.pressed.connect(_on_input_changed)
	
	_update_button_state()

func _on_input_changed(_value = ""):
	_update_button_state()

func _update_button_state():
	var all_filled := line_edits.all(func(le): return le.text.strip_edges() != "")
	var all_groups_selected := radio_groups.all(func(group):
		return group.any(func(rb): return rb.is_pressed())
	)
	continue_button.disabled = not (all_filled and all_groups_selected)

func _on_back_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	GameLogic.is_active = true
