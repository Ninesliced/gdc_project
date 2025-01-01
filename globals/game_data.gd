extends Node

var list_available_characters : Array[PlayerStats] = [
	preload("res://entities/player/player_stats/player_base.tres"),
	preload("res://entities/player/player_stats/player_debug.tres")
]

func _ready() -> void:
	pass