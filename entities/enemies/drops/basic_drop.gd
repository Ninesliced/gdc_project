extends Node2D

@export var data: CounterData
@onready var audio_pick = $AudioStreamPlayer2D
@onready var sprite = $Galaxy

func _on_collectible_collected(player: Player) -> void:
	player._player_counter._add(data)
	audio_pick.play()
	sprite.queue_free()
	await audio_pick.finished
	queue_free()
