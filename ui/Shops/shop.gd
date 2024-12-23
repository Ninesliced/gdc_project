extends CanvasLayer
class_name Shop

enum ShopType { 
	BUY,
	SELL,
	UPGRADE,
	QUIT,
}

var currentShopType : ShopType = ShopType.BUY

@onready var buy_ui : VBoxContainer = $Shop/HBoxContainer/Buy
@onready var upgrade_ui : Upgrade = $Shop/HBoxContainer/Upgrade
@onready var sell_ui : SellUI =  $Shop/HBoxContainer/Sell
@onready var animation_player : AnimationPlayer = $AnimationPlayer
var dict_type : Dictionary = {}

var box_card : PackedScene = preload("res://ui/Shops/boxes/buy_box.tscn")
@onready var item_containter : HBoxContainer = $Shop/HBoxContainer/Buy/ItemContainer
var buy_cards : Array = []
var item: Item = load("res://entities/items/weapon_items/canon_base.tres")
var item2 : Item = load("res://entities/items/weapon_items/canon_base_2.tres")
# var shield : Item = load("res://entities/items/shield_items/basic_shield_item.tres")

func _ready() -> void:
	dict_type = {
		ShopType.BUY : buy_ui,
		ShopType.SELL : sell_ui,
		ShopType.UPGRADE : upgrade_ui,
	}
	set_buy_cards([item, item2, item, item2])
	pass

func _process(delta: float) -> void:
	pass



func set_buy_cards(cards : Array) -> void:
	for card in cards:
		var instantiated = box_card.instantiate()
		instantiated.set_item(card)
		item_containter.add_child(instantiated)
		buy_cards.append(instantiated)
	pass




# no need to look

func show_type(shop_type : ShopType, animate:bool = false) -> void:
	if animate:
		animation_player.play("Fall")

		await animation_player.animation_finished
	for type in dict_type.keys():
		dict_type[type].hide()
	
	dict_type[shop_type].show()

	if animate:
		animation_player.play("rise")

func _on_buy_button_pressed():
	show_type(ShopType.BUY)
	pass

func _on_sell_button_pressed():
	show_type(ShopType.SELL)
	sell_ui.update()
	pass

func _on_upgrade_button_pressed():
	show_type(ShopType.UPGRADE)
	upgrade_ui.update_player_stats()
	pass

func _on_quit_button_pressed():
	close_shop()
	pass

func open_shop() -> void:
	show_type(ShopType.BUY, false)
	show()
	get_tree().paused = true
	pass

func close_shop() -> void:
	hide()
	get_tree().paused = false
	pass
