extends Node
class_name EnemySpawner
@export var cycle := 0
@export var cycle_interval := 120.0

@export var enemies: Array[EnemyDef] = []

@export var cycles : Array[Cycle] = [
	Cycle.new(),
]

signal cycle_changed(cycle: int)

func _ready() -> void:
	set_cycle(cycle)
	var first_cycle: Cycle = cycles[0]
	$SpawnDelay.wait_time = first_cycle.spawn_interval
	$CycleDelay.wait_time = cycle_interval
	$SpawnDelay.start()
	$CycleDelay.start()
	
func get_enemy_by_id(id: String) -> EnemyDef:
	for enemy in enemies:
		if enemy.id == id:
			return enemy
	return null

func get_random_enemy() -> EnemyDef:
	var cycle := cycles[cycle]
	var enemyChances := cycle.enemies
	var totalChance := 0
	
	for enemy in enemyChances:
		totalChance += enemy.chance
	
	var random := randf() * totalChance
	var current := 0
	
	for enemy in enemyChances:
		current += enemy.chance
		if random < current:
			return get_enemy_by_id(enemy.enemyId)
	return null

func spawn_around_player(player: Player) -> void:
	if cycles.size() <= cycle:
		return
		
	var cycle: Cycle = cycles[cycle]
	
	for i in range(int(cycle.spawn_count)):
		var angle: float = rad_to_deg(randf() * 360)
		var distance: float = randf() * (cycle.spawn_distance_max - cycle.spawn_distance_min) + cycle.spawn_distance_min
		var position: Vector2 = player.global_position + Vector2(cos(angle), sin(angle)) * distance
		
		var enemy: Enemy = get_random_enemy().scene.instantiate() as Enemy
		enemy.global_position = position
		get_tree().current_scene.add_child(enemy)


func _on_spawn_delay_timeout() -> void:
	var players := get_tree().get_nodes_in_group("Player")
	
	for player in players:
		spawn_around_player(player as Player)


func _on_cycle_delay_timeout() -> void:
	set_cycle(cycle + 1)
	
	if cycles.size() <= cycle:
		# TODO: End game
		set_cycle(0)
	
	var cycle: Cycle = cycles[cycle]
	$SpawnDelay.wait_time = cycle.spawn_interval
	$SpawnDelay.start()


func set_cycle(new_cycle: int) -> void:
	cycle = new_cycle
	emit_signal("cycle_changed", cycle)
	
	