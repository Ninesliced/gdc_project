extends Node

var shop_scene : PackedScene = preload("res://ui/Shops/shop.tscn")

@export var items : Array = [
	preload("res://entities/items/weapon_items/common/canon_base.tres"),
	preload("res://entities/items/weapon_items/common/canon_base_2.tres"),
	preload("res://entities/items/weapon_items/uncommon/canon_uncommon.tres"),
	preload("res://entities/items/weapon_items/rare/canon_rare.tres"),
	preload("res://entities/items/weapon_items/epic/canon_epic.tres"),
	preload("res://entities/items/weapon_items/legendary/star_killer.tres"),
]
var items_weigthed : Array[Dictionary] = []
var weights_total : int = 0

var items_by_rarity : Dictionary = {
}

var shop : Shop = null

func _ready() -> void:
	for i in range(GameData.Rarity.size()):
		items_by_rarity[i] = []
		pass
	shop = shop_scene.instantiate() as Shop
	add_child(shop)
	shop.hide()
	filter_items()
	# set_weigthed_items(items)

func open_shop(items : Array) -> void:
	shop.open_shop()
	if items.size() > 0:
		shop.set_boxes(items)

func close_shop() -> void:
	shop.close_shop()

# Weigthed items functions

func filter_items() -> void:
	for item in items:
		items_by_rarity[item.rarity].append(item)
	pass

func get_rarity(number : int, planet_level = 0) -> GameData.Rarity:
	var sum_rarity = 0
	for i in range(GameData.Rarity.size()):
		sum_rarity += GameData.get_weight_rarity(planet_level - 1)[i] * 100
		print(GameData.get_weight_rarity(planet_level))
		if number < sum_rarity:
			return i
	return GameData.Rarity.COMMON

func get_random_items(amount : int, level = 1) -> Array:
	var new_items : Array[Item] = []

	for i in range(amount):
		var random_rarity = randi() % 100
		var rarity = get_rarity(random_rarity, level)
		var size_items = items_by_rarity[rarity].size()

		if size_items > 0:
			var random_item = randi() % size_items
			var item = items_by_rarity[rarity][random_item].duplicate()
			item.resource = item.resource.duplicate()
			if item.resource and item.resource.has_method("randomize_properties"):
				item.resource.randomize_properties(0.1)
			# 	item.resource.set_level(level)
			new_items.append(item)
	return new_items
