extends AudioStreamPlayer

var playlist: Array = [
	preload("res://audio/music/track1.ogg"),
	preload("res://audio/music/track2.ogg"),
	preload("res://audio/music/track3.ogg"),
	preload("res://audio/music/track4.ogg"),
	preload("res://audio/music/track5.ogg"),
	preload("res://audio/music/track6.ogg"),
]

func _ready() -> void:
	randomize()
	_play_random_track()

func _play_random_track() -> void:
	if playlist.is_empty():
		return
	stream = playlist[randi() % playlist.size()]
	play()

func _process(_delta: float) -> void:
	if not playing:
		_play_random_track()
