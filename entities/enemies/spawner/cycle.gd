extends Resource

class_name Cycle

@export var enemies: Array[EnemyChance] = []

@export var spawn_interval := 1.0
@export var spawn_count := 3
@export var spawn_distance_min := 500
@export var spawn_distance_max := 2000

@export var is_boss := false
