extends Node

var list_available_characters : Array[PlayerStats] = [
	preload("res://entities/player/player_stats/player_base.tres"),
	preload("res://entities/player/player_stats/player_debug.tres")
]

var name_colors : Dictionary = {
	"health": Color.html("#3dff6e"),
	"damage_multiplier" : Color.html("#d41e3c"),
	"damage" : Color.html("#d41e3c"),
	"critical_chance" : Color.html("#ed7b39"),
	"critical_damage" : Color.html("#d61a88"),
	"fire_rate" : Color.html("#488bd4"),
	"speed" : Color.html("#488bd4"),
}

var weight_rarity : Dictionary = {
    Item.Rarity.COMMON : 0.57,
    Item.Rarity.UNCOMMON : 0.25,
    Item.Rarity.RARE : 0.12,
    Item.Rarity.EPIC : 0.05,
    Item.Rarity.LEGENDARY : 0.01,
}

@export var crt_shader_scene : PackedScene = preload("res://shaders/crt.tscn")
var instance_crt : CanvasLayer = null

func _ready() -> void:
	instance_crt = crt_shader_scene.instantiate()
	add_child(instance_crt)
	print("Game data ready")
	pass