extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.is_debug_build():
		$Label.text = "DEBUG"
	else:
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
