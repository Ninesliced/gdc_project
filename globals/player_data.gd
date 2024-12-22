extends Node
var player = null
var player_rotation = 0
var money = 400
var inventory : Array[Item] = []
var equipments : Array[Node2D] = []

enum ItemType {
	WEAPON = 0,
	SHIELD = 1,
	BOOSTER = 2,
	ALL = 3
}

func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_player() -> Player:
	return player

func get_player_stats() -> PlayerStats:
	if player == null:
		print("warning: player not found")
		return null
	return player._player_stats

func replace_item(item: Item, index: int) -> void:
	if player == null:
		assert(false, "warning: player not found")
		return
	if player._player_stats == null:
		assert(false, "player stats not found")
		return
	if player._player_stats.item_slots.size() <= index:
		assert(false, "index out of range")
		return

	if item and !check_type(item, player._player_stats.item_slots[index]):
		return

	var temp_item = player._player_stats.item_slots[index].item
	player._player_stats.item_slots[index].item = item

	if temp_item:
		inventory.append(temp_item)

	inventory.erase(item)
	load_equipment()

func check_type(item: Item, slot: Slot) -> bool:
	if item.type == ItemType.ALL:
		return true
	if ItemType.ALL in slot.slot_types:
		return true
	if item.type in slot.slot_types:
		return true
	return false

func load_equipment() -> void:
	for equipment in equipments:
		if is_instance_valid(equipment):
			equipment.queue_free()
	equipments = []
	if player == null:
		print("warning: player not found")
		return
	if player._player_stats == null:
		assert(false,"player stats not found")
		return

	var slots : Array[Slot] = player._player_stats.item_slots
	for i in range(slots.size()):
		var item = slots[i].item
		if item == null:
			continue

		var instance = item.item_scene.instantiate()
		instance.rotation = slots[i].rotation
		equipments.append(instance)
		player.add_child(instance)
		instance.position = slots[i].position

		if instance.has_method("load_resource"):
			instance.load_resource(item.resource)
	pass
