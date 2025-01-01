extends Node
var box_parent : ShopBox = null
var bought = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var box = get_parent()

	if box is ShopBox:
		box_parent = box
	else:
		assert(false, "Box parent is not a UiBox")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shop_box_pressed() -> void:
	var item: Item = box_parent.item

	if not bought and item:
		if PlayerData.money >= item.price:
			PlayerData.money -= item.price
			PlayerData.inventory.append(item)

			bought = true
			box_parent.price.text = "bought"

		box_parent.animation_player.play("delete")
		box_parent.play_sound("buy")
		box_parent.stats.hide()
		await box_parent.animation_player.animation_finished
		destroy()
	pass # Replace with function body.

func destroy() -> void:
	var item: Item = box_parent.item
	var id = ShopData.shop.item_boxes.find(box_parent)
	ShopData.shop.items.erase(item)
	box_parent.queue_free()
	pass