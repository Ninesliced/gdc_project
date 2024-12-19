extends Node2D

var speed = 100
var players := []
var parent : Enemy = null

@export var scene : PackedScene = load("res://entities/generic/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players = get_tree().get_nodes_in_group("Player")
	parent = get_parent()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if players.size() == 0:
		return
	var player = players[0]
	
	var direction : Vector2 = (player.global_position - parent.global_position).normalized()
	var direction_angle = direction.angle()
	parent.rotation = direction_angle
	parent.velocity = direction * speed	
	pass
