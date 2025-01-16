extends Node

var planet_scene = preload("res://entities/planets/planet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_planet(position : Vector2, chunk_size = 1):
	var planet_instance = planet_scene.instantiate()
	planet_instance.global_position = position * chunk_size
	add_child(planet_instance)
	pass


func _on_chunk_manager_chunk_loaded(position: Vector2, chunk_size: int) -> void:
	generate_planet(position, chunk_size)
	pass # Replace with function body.
