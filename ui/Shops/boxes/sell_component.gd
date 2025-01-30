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
	var counter_data = CounterData.new()
	counter_data.base_coin = item.price
	if item:
		PlayerData.inventory.erase(item)
		PlayerData.player_stats.counter_data._add(counter_data)
		PlayerData.player_stats.counter_data.base_coin += item.get_resell_price()
		box_parent.play_sound("buy")
		box_parent.animation_player.play("delete")
		box_parent.stats_ui.hide()
		await box_parent.animation_player.animation_finished
		box_parent.queue_free()
	else:
		assert(false, "No item in box")
	pass
