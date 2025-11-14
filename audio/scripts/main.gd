extends Control

@onready var menu_container: Control = $VBoxContainer/panel_content/Control_content
@onready var button_group: ButtonGroup = $VBoxContainer/ToolsBarBG/HBoxContainer/ToolsBarContainer/buildings.button_group

func _ready() -> void:
	_connect_group_buttons()
	_select_initial_menu()

func _connect_group_buttons() -> void:
	for btn in button_group.get_buttons():
		if not btn.pressed.is_connected(_on_button_pressed):
			btn.pressed.connect(_on_button_pressed.bind(btn))

func _select_initial_menu() -> void:
	var current := _get_checked_button()
	if current == null and button_group.get_buttons().size() > 0:
		var first: Button = button_group.get_buttons()[0]
		first.button_pressed = true
		current = first
	if current != null:
		_show_menu_for_button(current)

func _get_checked_button() -> Button:
	for btn in button_group.get_buttons():
		if btn.button_pressed:
			return btn
	return null

func _on_button_pressed(btn: Button) -> void:
	_show_menu_for_button(btn)

func _show_menu_for_button(btn: Button) -> void:
	var scene_path := ""
	if btn.has_meta("scene_path"):
		scene_path = str(btn.get_meta("scene_path"))
	else:
		scene_path = "res://Scenes/gui_menu/%s.tscn" % btn.name


	_clear_container(menu_container)
	var packed: PackedScene = load(scene_path)
	if packed == null:
		push_warning("Impossible de charger: %s" % scene_path)
		return

	var inst: Control = packed.instantiate()

	menu_container.add_child(inst)

func _clear_container(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/TitleScreen.tscn")
