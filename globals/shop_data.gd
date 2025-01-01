extends Node

var shop_scene : PackedScene = preload("res://ui/Shops/shop.tscn")

@export var items : Array = [
	load("res://entities/items/weapon_items/canon_base.tres"),
	load("res://entities/items/weapon_items/canon_base_2.tres"),
	load("res://entities/items/weapon_items/legendary/star_killer.tres"),
	load("res://entities/items/weapon_items/legendary/star_killer.tres"),
	load("res://entities/items/weapon_items/legendary/star_killer.tres"),
	load("res://entities/items/weapon_items/legendary/star_killer.tres"),
]
var items_weigthed : Array[Dictionary] = []
var weights_total : int = 0

var shop : Shop = null

func _ready() -> void:
	shop = shop_scene.instantiate() as Shop
	add_child(shop)
	shop.hide()
	set_weigthed_items(items)

func open_shop(items : Array) -> void:
	shop.open_shop()
	if items.size() > 0:
		shop.set_boxes(items)

func close_shop() -> void:
	shop.close_shop()

# Weigthed items functions

func set_weigthed_items(items : Array) -> void:
	weights_total = 0
	for item in items:
		weights_total += item.get_weight() * 100
		items_weigthed.append({ "weight" : weights_total, "item" : item })
	pass

func get_weigthed_item(weight : int) -> Item:
	if weight >= weights_total:
		return null
	for item in items_weigthed:
		if weight < item["weight"]:
			return item["item"].duplicate()
	return null

func get_random_items(amount : int) -> Array:
	var items : Array[Item] = []
	for i in range(amount):
		var weight = randi() % weights_total
		var new_item = get_weigthed_item(weight).duplicate()
		items.append(new_item)
	return items
	pass
