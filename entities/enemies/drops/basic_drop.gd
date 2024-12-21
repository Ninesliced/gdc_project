extends Node2D

@export var data: CounterData

func _on_collectible_collected(player: Player) -> void:
	player._player_counter._add(data)
	
	print("collected: " + str(player._player_counter.score) + " score")
	queue_free()
