extends Node
var box_parent : UiBox = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var box = get_parent()

	if box is UiBox:
		box_parent = box
	else:
		assert(false, "Box parent is not a UiBox")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_box_pressed() -> void:
	var item: Item = box_parent.item
	if item:
		print("sell: ", item)
		print(PlayerData.inventory)
		PlayerData.inventory.erase(item)
		print(PlayerData.inventory)
		PlayerData.money += item.price
		box_parent.queue_free()
	else:
		assert(false, "No item in box")
	pass