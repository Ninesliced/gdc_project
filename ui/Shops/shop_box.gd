extends Button

@onready var title: Label = $HBox/BoxContainer3/Title
@onready var price: Label = $HBox/BoxContainer2/Price
@onready var item_icon: Sprite2D = $HBox/BoxContainer/Panel2/Icon

var ressource = ""
var shop_card : Dictionary = {}
var buyed = false

func _ready():
	shop_card["price"] = 0
	shop_card["ressource"] = ""
	print("price: ", price)
	pass


func _process(delta):
	pass


func set_card(card : Dictionary) -> void: # SCOTCH UTILISER LES RESSOURCES
	title.text = card["title"]
	price.text = str(card["price"])
	item_icon.texture = card["icon"]
	ressource = card["ressource"]
	shop_card = card
	pass

func get_save_data() -> Dictionary:
	return {
		"buyed" : buyed,
		"ressource" : ressource
	}


func _on_pressed():
	if not buyed:
		if PlayerData.money >= shop_card["price"]:
			PlayerData.money -= shop_card["price"]
			PlayerData.inventory.append(shop_card["ressource"])
			buyed = true
			price.text = "Buyed"
	pass
