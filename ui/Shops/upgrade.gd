extends HBoxContainer
class_name Upgrade

var player_stats : PlayerStats = null
@onready var ship_sprite : Sprite2D = $Bench/Panel/Center/Ship

var slots : Array = []
var slot_scene : PackedScene = preload("res://ui/Shops/upgrade/equipment_slot.tscn")

@onready var item_list_ui : VBoxContainer = $Items/ScrollContainer/VBoxContainer

var items : Array[Item] = []
var list_box_scene : Array[UiBox] = []
var box_card : PackedScene = preload("res://ui/Shops/boxes/inventory_box.tscn")

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_player_stats() -> void:
	handle_ship()

	items = PlayerData.inventory
	for item in list_box_scene:
		if is_instance_valid(item):
			item.queue_free()

	for item in items:
		var instantiated : InventoryBox = box_card.instantiate()
		instantiated.set_item(item)
		instantiated.parent_box = self
		item_list_ui.add_child(instantiated)
		list_box_scene.append(instantiated)

func handle_ship():
	var new_stats = PlayerData.get_player_stats()
	if new_stats == null:
		return
	player_stats = new_stats
	if player_stats.texture:
		ship_sprite.texture = player_stats.texture
	pass

	for slot in slots:
		slot.queue_free()
	
	slots = []

	for i in range(player_stats.slots_position.size()):
		var slot : SlotUI = slot_scene.instantiate()
		ship_sprite.add_child(slot)
		slots.append(slot)
		slot.index = i
		slot.set_slot(player_stats.item_slots[i])
		slot.upgrade_parent = self
		slot.position = slot.position + player_stats.slots_position[i]
		pass
