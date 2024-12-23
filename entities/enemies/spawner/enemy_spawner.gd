extends Node

@export var spawn_interval := 1.0:
	set(value):
		$SpawnDelay.wait_time = value
@export var spawn_count := 3
@export var spawn_distance_min := 500
@export var spawn_distance_max := 2000

@export var cycle := 0
@export var cycle_interval := 120.0
@export var cycle_multiplier := 1.75

@export var enemies : Array[PackedScene]= [load("res://entities/enemies/impl/basic_enemy.tscn")]

func calculate_cycle_value(val: float) -> float:
	return val + (val * cycle * cycle_multiplier)

func spawn_around_player(player: Player) -> void:
	for i in range(int(calculate_cycle_value(spawn_count))):
		var angle: float = rad_to_deg(randf() * 360)
		var distance: float = randf() * (spawn_distance_max - spawn_distance_min) + spawn_distance_min
		var position: Vector2 = player.global_position + Vector2(cos(angle), sin(angle)) * distance
		
		var enemy: Enemy = enemies[randi() % enemies.size()].instantiate()
		enemy.global_position = position
		get_tree().current_scene.add_child(enemy)


func _on_spawn_delay_timeout() -> void:
	var players := get_tree().get_nodes_in_group("Player")
	
	for player in players:
		spawn_around_player(player as Player)


func _on_cycle_delay_timeout() -> void:
	cycle += 1
