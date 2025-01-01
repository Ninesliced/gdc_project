extends Node

var list_available_characters : Array[PlayerStats] = [
	preload("res://entities/player/player_stats/player_base.tres"),
	preload("res://entities/player/player_stats/player_debug.tres")
]

var rarity_colors : Dictionary = {
	"health": Color.html("#3dff6e"),
	"damage_multiplier" : Color.html("#d41e3c"),
	"critical_chance" : Color.html("#ed7b39"),
	"critical_damage" : Color.html("#d61a88"),
	"speed" : Color.html("#488bd4"),
}


func _ready() -> void:
	pass