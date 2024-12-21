extends Node
var player = null
var player_rotation = 0
var money = 400
var inventory : Array[Item] = []
var equipments : Array[Node2D] = []

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
		print("warning: player not found")
		return
	if player._player_stats == null:
		assert(false,"player stats not found")
		return
	if player._player_stats.item_slots.size() <= index:
		assert(false,"index out of range")
		return

	var temp_item = player._player_stats.item_slots[index]

	player._player_stats.item_slots[index] = item
	if temp_item:
		print(inventory)
		inventory.erase(item)
		print(inventory)
		inventory.append(temp_item)
		print("replaced item by: ", temp_item)
		print("inventory size: ", inventory.size())
	else:
		inventory.erase(item)
	load_equipment()

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

	var items :Array[Item] = player._player_stats.item_slots

	for equipment : Item in items:
		var instance = equipment.item_scene.instantiate()
		equipments.append(instance)
		player.add_child(instance)
		if instance.has_method("load_resource"):
			print(equipment.resource)
			instance.load_resource(equipment.resource)
	pass