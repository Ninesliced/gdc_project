class_name Trail extends Line2D
@export var point_number : int = 10
@export var time : float = 0.1
var parent : Node2D
var timer: Timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if parent == null:
		parent = get_parent()
	timer.set_wait_time(time)
	timer.autostart = true
	timer.timeout.connect(update_points)
	add_child(timer)
	
	pass # Replace with function body.

func update_points() -> void:
	if points.size() > 0:
		points.remove_at(0)
		print(points)
	# points.append(parent.global_position)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
