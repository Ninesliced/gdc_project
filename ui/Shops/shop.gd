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
@onready var item_containter : HBoxContainer = $Shop/HBoxContainer/Buy/Panel/ItemContainer
@export var random_items : bool = false

var dict_type : Dictionary = {}
var box_card : PackedScene = preload("res://ui/Shops/boxes/buy_box.tscn")
var item_boxes : Array = []
var items: Array = []
# TODO: changer

# var shield : Item = load("res://entities/items/shield_items/basic_shield_item.tres")

func _ready() -> void:
	dict_type = {
		ShopType.BUY : buy_ui,
		ShopType.SELL : sell_ui,
		ShopType.UPGRADE : upgrade_ui,
	}
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and PauseGlobal.current_pause_type == PauseGlobal.PauseType.SHOP:
		close_shop()
	pass



func set_boxes(cards : Array) -> void:
	for card in item_boxes:
		if is_instance_valid(card):
			card.queue_free()
	item_boxes.clear()
	for card in cards:
		var instantiated = box_card.instantiate()
		instantiated.set_item(card)
		item_containter.add_child(instantiated)
		item_boxes.append(instantiated)
	items = cards
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
	animation_player.speed_scale = 2
	animation_player.play("rise")
	PauseGlobal.current_pause_type = PauseGlobal.PauseType.SHOP
	show_type(ShopType.BUY, false)
	show()
	get_tree().paused = true
	pass

func close_shop() -> void:
	animation_player.speed_scale = 4
	animation_player.play_backwards("rise")
	await animation_player.animation_finished
	PauseGlobal.current_pause_type = PauseGlobal.PauseType.NONE
	hide()
	get_tree().paused = false
	pass
