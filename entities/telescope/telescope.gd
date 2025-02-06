extends Node2D

@export var telescope_property: TelescopeProperty = null

func load_resource(resource : Resource) -> void:
	if resource is ShieldProperty:
		telescope_property = resource
		
		if get_parent() is Player:
			var player := get_parent() as Player
			player.player_stats.bonus_view_distance = telescope_property.additionalView
	else:
		assert(false, "Invalid resource type")


func _ready() -> void:
	if not telescope_property:
		return

	load_resource(telescope_property)
