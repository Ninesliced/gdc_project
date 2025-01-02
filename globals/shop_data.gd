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
var items_weigthed : Array[Dictionary] = [] # REWORK
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

# func set_weigthed_items(items : Array) -> void: # DEPRECATED
# 	weights_total = 0
# 	for item in items:
# 		weights_total += item.get_weight() * 100
# 		items_weigthed.append({ "weight" : weights_total, "item" : item })
# 	pass

# func get_weigthed_item(weight : int) -> Item: # DEPRECATED
# 	if weight >= weights_total:
# 		return null
# 	for item in items_weigthed:
# 		if weight < item["weight"]:
# 			return item["item"].duplicate()
# 	return null

func get_rarity(number : int) -> GameData.Rarity:
	var sum_rarity = 0
	for i in range(GameData.Rarity.size()):
		sum_rarity += GameData.weight_rarity[i] * 100
		if number < sum_rarity:
			return i
	return GameData.Rarity.COMMON

func get_random_items(amount : int) -> Array:
	var new_items : Array[Item] = []

	for i in range(amount):
		var random_rarity = randi() % 100
		var rarity = get_rarity(random_rarity)
		var size_items = items_by_rarity[rarity].size()

		if size_items > 0:
			var random_item = randi() % size_items
			new_items.append(items_by_rarity[rarity][random_item].duplicate())
	return new_items
