extends Node

var planet_scene = preload("res://entities/planets/planet.tscn")
@export var enemy_spawner : EnemySpawner = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_planet(position : Vector2, chunk_size = 1):
	var x_delta_random = randi_range(0, chunk_size)
	var y_delta_random = randi_range(0, chunk_size)
	var planet_instance : Planet = planet_scene.instantiate()
	planet_instance.planet_level = enemy_spawner.total_cycle
	planet_instance.global_position = position * chunk_size + Vector2(x_delta_random, y_delta_random)
	add_child(planet_instance)
	pass


func _on_chunk_manager_chunk_loaded(position: Vector2, chunk_size: int) -> void:
	var chance = randf()
	if chance < 0.3:
		generate_planet(position, chunk_size)
	pass # Replace with function body.
