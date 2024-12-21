extends Node

var shop_scene : PackedScene = preload("res://ui/Shops/shop.tscn")

var shop : Shop = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shop = shop_scene.instantiate() as Shop
	add_child(shop)
	shop.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func open_shop() -> void:
	shop.open_shop()
	pass

func close_shop() -> void:
	shop.close_shop()
	pass
