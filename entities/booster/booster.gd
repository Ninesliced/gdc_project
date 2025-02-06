extends Node2D

@export var booster_property: BoosterProperty = null

func load_resource(resource : Resource) -> void:
	if resource is BoosterProperty:
		booster_property = resource
		
		if get_parent() is Player:
			var player := get_parent() as Player
			player.player_stats.bonus_speed = booster_property.speed_boost
	else:
		assert(false, "Invalid resource type")


func _ready() -> void:
	if not booster_property:
		return

	load_resource(booster_property)
