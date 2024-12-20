extends Control

enum ShopType { 
	BUY,
	SELL,
	UPGRADE,
	QUIT,
}

var currentShopType : ShopType = ShopType.BUY

@onready var buy_ui : VBoxContainer = $HBoxContainer/Buy
@onready var upgrade_ui : VBoxContainer = $HBoxContainer/Upgrade
@onready var sell : VBoxContainer =  $HBoxContainer/Sell

var dict_type : Dictionary = {}

var box_card : PackedScene = preload("res://ui/Shops/shop_box.tscn")
@onready var item_containter : HBoxContainer = $HBoxContainer/Buy/ItemContainer
var buy_cards : Array = []

func _ready() -> void:
	dict_type = {
		ShopType.BUY : buy_ui,
		ShopType.SELL : sell,
		ShopType.UPGRADE : upgrade_ui,
	}
	print(item_containter)
	set_buy_cards(["card1", "card2", "card3"])
	pass

func _process(delta: float) -> void:
	pass



func set_buy_cards(cards : Array) -> void:
	for card in cards:
		var instantiated = box_card.instantiate()
		# instantiated.set_card(card)
		item_containter.add_child(instantiated)
		buy_cards.append(instantiated)
	pass




# no need to look

func show_type(shop_type : ShopType) -> void:
	for type in dict_type.keys():
		dict_type[type].hide()
	
	dict_type[shop_type].show()

func _on_buy_button_pressed():
	show_type(ShopType.BUY)
	pass

func _on_sell_button_pressed():
	show_type(ShopType.SELL)
	pass

func _on_upgrade_button_pressed():
	show_type(ShopType.UPGRADE)
	pass

func _on_quit_button_pressed():
	pass
