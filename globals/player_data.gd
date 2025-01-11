extends Node
var player = null
var player_start_stats = null
var player_stats = null
var player_rotation = 0
var inventory : Array[Item] = []
var equipments : Array[Node2D] = []
var nodes_positioner : Array[Node2D] = []
enum ItemType {
	ALL = 0,
	WEAPON = 1,
	SHIELD = 2,
	BOOSTER = 3,
	ITEM = 4,
	
}

func _ready():
	pass

func set_player_data(player_data: Player):
	player = player_data
	player_stats = player._player_stats
	inventory = player_stats.inventory
	equipments = player_stats.equipments
	nodes_positioner = player_stats.nodes_positioner
	load_equipment()
 
func get_player() -> Player:
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() == 0:
		return null
	return players[0]

func get_player_stats() -> PlayerStats:
	if player == null:
		push_warning("player not found")
		return null
	return player._player_stats



# equipment manager

func replace_item(item: Item, index: int) -> bool:
	if player == null:
		assert(false, "warning: player not found")
		return false
	if player._player_stats == null:
		assert(false, "player stats not found")
		return false
	if player._player_stats.item_slots.size() <= index:
		assert(false, "index out of range")
		return false

	if item and !check_type(item, player._player_stats.item_slots[index]):
		return false

	var temp_item = player._player_stats.item_slots[index].item
	player._player_stats.item_slots[index].item = item

	if temp_item:
		inventory.append(temp_item)

	inventory.erase(item)
	load_equipment()
	return true

func check_type(item: Item, slot: Slot) -> bool:
	if item.type == ItemType.ALL:
		return true
	if ItemType.ALL in slot.slot_types:
		return true
	if item.type in slot.slot_types:
		return true
	return false

func load_equipment() -> void:
	for node in nodes_positioner:
		if is_instance_valid(node):
			node.queue_free()
		nodes_positioner = []

	for equipment in equipments:
		if is_instance_valid(equipment):
			equipment.queue_free()

	equipments.clear()
	if player == null:
		push_warning("warning: player not found")
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

		
		# FOR floaty item
		var nodes = instance.get_children()

		var node2D = Node2D.new()
		node2D.position = slots[i].position
		player.add_child(node2D)
		nodes_positioner.append(node2D)

		for node in nodes:
			if node is FloatComponent:
				node.set_floaty(slots[i].floaty, slots[i].position, slots[i].float_distance, node2D)
		# END FOR
		
		if instance.has_method("load_resource"):
			instance.load_resource(item.resource)

		if instance is Weapon:
			var weapon = instance as Weapon
			weapon.set_delay(float(i) / slots.size())
	pass
