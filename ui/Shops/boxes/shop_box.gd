extends UiBox
class_name ShopBox

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
	title.modulate = rarity_colors[new_item.rarity]
	if new_item.resource is WeaponProperty:
		var weapon = new_item.resource as WeaponProperty
		title.text += " v" + str(weapon.level)
	price.text = str(new_item.price) + "$"
	item_icon.texture = new_item.icon
	ressource = new_item.resource
	item = new_item
	pass

func get_save_data() -> Dictionary:
	return {
		"item" : item,
	}

func play_sound(sound: String) -> void:
	if sound == "buy":
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
		$AudioStreamPlayer2D.play()
	pass