extends Node

var player : Player = null
var player_start_stats = null
var player_stats : PlayerStats = null
var player_rotation := 0
var inventory : Array[Item] = []
var equipments : Array[Node2D] = []
var nodes_positioner : Array[Node2D] = []

enum ItemType {
	ALL = 0,
	ITEM = 1,
	WEAPON = 2,
	SHIELD = 3,
	BOOSTER = 4,
	TELESCOPE = 5,
}

func _ready():
	pass

func set_player_data(player_data: Player):
	player = player_data
	player_stats = player.player_stats
	inventory = player_stats.inventory
	equipments = player_stats.equipments
	nodes_positioner = player_stats.nodes_positioner
	load_equipment()
 
func get_player() -> Player:
	var players := get_tree().get_nodes_in_group("Player")
	if players.size() == 0:
		return null
	return players[0]

func get_player_stats() -> PlayerStats:
	if player == null:
		push_warning("player not found")
		return null
	return player.player_stats



# equipment manager

func replace_item(item: Item, index: int) -> bool:
	if player == null:
		assert(false, "warning: player not found")
		return false
	if player.player_stats == null:
		assert(false, "player stats not found")
		return false
	if player.player_stats.item_slots.size() <= index:
		assert(false, "index out of range")
		return false

	if item and !check_type(item, player.player_stats.item_slots[index]):
		return false

	var temp_item: Item = player.player_stats.item_slots[index].item
	player.player_stats.item_slots[index].item = item

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
	
	player_stats.bonus_view_distance = 0
	player_stats.bonus_damage = 0
	player_stats.bonus_speed = 0
	
	if player == null:
		push_warning("warning: player not found")
		return
	if player.player_stats == null:
		assert(false,"player stats not found")
		return

	var slots : Array[Slot] = player.player_stats.item_slots
	for i in range(slots.size()):
		var item: Item = slots[i].item
		if item == null:
			continue

		var instance: Node = item.item_scene.instantiate()
		instance.rotation = slots[i].rotation
		equipments.append(instance)
		player.add_child(instance)
		instance.position = slots[i].position

		
		# FOR floaty item
		var nodes: Array[Node] = instance.get_children()

		var node2D = Node2D.new()
		node2D.position = slots[i].position
		player.add_child(node2D)
		nodes_positioner.append(node2D)

		for node in nodes:
			if node is FloatComponent:
				node.set_floaty(slots[i].floaty, slots[i].position, slots[i].float_distance, node2D)
				if instance is Weapon:
					instance.floaty_weapon = slots[i].floaty
		# END FOR
		
		if instance.has_method("load_resource"):
			instance.load_resource(item.resource)

		if instance is Weapon:
			var weapon: Weapon = instance as Weapon
			weapon.set_delay(float(i) / slots.size())
	update_zoom()
	update_speed()


func update_zoom() -> void:
	if player == null:
		push_warning("warning: player not found")
		return
	if player.player_stats == null:
		push_warning("warning: player stats not found")
		return
		
	var zoom := player_stats.view_distance * (1 + player_stats.bonus_view_distance)
	player.camera.zoom = Vector2(zoom, zoom)


func update_speed() -> void:
	if player == null:
		push_warning("warning: player not found")
		return
	if player.player_stats == null:
		push_warning("warning: player stats not found")
		return
		
	player.movement_component.speed = player.player_stats.speed * (1 + player.player_stats.bonus_speed)
