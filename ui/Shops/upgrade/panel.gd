extends Panel

var upgrade_parent : Upgrade = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var box: UiBox = data
	var item = box.item
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is UiBox