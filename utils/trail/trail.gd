class_name Trail extends Line2D
@export var point_number : int = 10
var parent : Node2D
var queue : Array = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	if parent == null:
		queue_free()
	pass # Replace with function body.

func _process(delta: float) -> void:
	var pos = parent.global_position
	queue.push_front(pos)
	if queue.size() > point_number:
		queue.pop_back()
	
	clear_points()
	for point in queue:
		add_point(point)
	pass
