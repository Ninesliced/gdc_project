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
	print("update player stats")
	handle_ship()
	handle_slots()
	handle_items()

func handle_items():
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


func handle_slots():
	for slot in slots:
		slot.queue_free()
	slots = []

	for i in range(player_stats.item_slots.size()):
		var slot_data : Slot = player_stats.item_slots[i]
		var slot : SlotUI = slot_scene.instantiate()
	
		ship_sprite.add_child(slot)
		slots.append(slot)
		slot.index = i
		slot.set_slot(slot_data)
		slot.upgrade_parent = self
		slot.position = slot.position + slot_data.position
		pass


func play_sound(sound: String) -> void:
	if sound == "load":
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
		$AudioStreamPlayer2D.play()
