extends Button
class_name UiBox
@onready var title: Label = $HBox/BoxContainer3/Title
@onready var price: Label = $HBox/BoxContainer2/Price
@onready var item_icon: Sprite2D = $HBox/BoxContainer/Panel2/Icon

var ressource = ""
var item : Item = null

func _ready():
	pass


func _process(delta):
	pass


func set_item(new_item: Item) -> void: # SCOTCH UTILISER LES RESSOURCES
	await ready
	title.text = new_item.name
	price.text = str(new_item.price)
	item_icon.texture = new_item.icon
	ressource = new_item.resource
	item = new_item
	pass

func get_save_data() -> Dictionary:
	return {
		"item" : item,
	}