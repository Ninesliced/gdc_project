extends Node2D

signal on_collectible_collected(player: Player)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		emit_signal("on_collectible_collected", body as Player)
		queue_free()
