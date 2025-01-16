extends Node
class_name ChunkManager
@export var chunk_size = 1000
signal chunk_loaded(position : Vector2, chunk_size: int)
var list_chunk_loaded = {
		Vector2(0,0) : true
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	load_chunk_around(Vector2(0,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass

func load_chunk_around(position : Vector2):
	for y in range(-1,2):
		for x in range(-1,2):
			load_chunk(Vector2(position.x + x*chunk_size, position.y + y*chunk_size))
	print(len(list_chunk_loaded))

func load_chunk(position):
	var x : int= int(position.x / chunk_size)
	var y : int = int(position.y / chunk_size)

	if not check_chunk_loaded(position):
		print("emitting")
		emit_signal("chunk_loaded",Vector2(x,y),chunk_size)
		list_chunk_loaded[Vector2(x,y)] = true

func check_chunk_loaded(position) -> bool:
	var x = int(position.x / chunk_size)
	var y = int(position.y / chunk_size)
	
	if Vector2(x,y) in list_chunk_loaded:
		return true
	return false
