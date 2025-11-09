extends Node

@onready var player := AudioStreamPlayer.new()
var click_sound: AudioStream = preload("res://audio/sfx/pop_sfx.mp3")

func _ready() -> void:
	add_child(player)
	await get_tree().process_frame
	_connect_existing_buttons()
	get_tree().connect("node_added", Callable(self, "_on_node_added"))

func _connect_existing_buttons() -> void:
	for node in get_tree().get_nodes_in_group("buttons"):
		if node is Button:
			_connect_button(node)

func _on_node_added(node: Node) -> void:
	if node is Button and node.is_in_group("buttons"):
		_connect_button(node)

func _connect_button(btn: Button) -> void:
	if not btn.is_connected("pressed", Callable(self, "_on_button_pressed")):
		btn.connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed() -> void:
	player.stream = click_sound
	player.stop()
	player.play(0.0)
