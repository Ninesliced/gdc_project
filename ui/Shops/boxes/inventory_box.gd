extends ShopBox
class_name InventoryBox
var parent_box : Upgrade = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _get_drag_data(at_position: Vector2) -> Variant:
	var preview = TextureRect.new()
	preview.texture = item_icon.texture

	var preview_control = Control.new()
	preview_control.add_child(preview)
	set_drag_preview(preview_control)
	parent_box.update_player_stats()
	return item

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is UiBox

func _drop_data(at_position: Vector2, data: Variant) -> void:
	PlayerData.inventory.append(data)
