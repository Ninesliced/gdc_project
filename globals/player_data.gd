extends Node
var player = null
var player_rotation = 0
var money = 0
var inventory = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# var players = get_tree().get_nodes_in_group("player")
	# if players.size() > 0:
	# 	player = players[0]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_player() -> Player:
	return player

func get_player_stats() -> PlayerStats:
	if player == null:
		print("warning: player not found")
		return null
	print(player._player_stats)
	return player._player_stats