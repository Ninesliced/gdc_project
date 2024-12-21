extends VBoxContainer
class_name Upgrade
var player_stats : PlayerStats = null
@onready var ship_texture : TextureRect = $NinePatchRect/Panel/Ship

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_player_stats() -> void:
	var new_stats = PlayerData.get_player_stats()
	if new_stats == null:
		return
	player_stats = new_stats
	ship_texture.texture = player_stats.texture
	pass