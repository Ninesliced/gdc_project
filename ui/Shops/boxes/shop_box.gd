extends UiBox
class_name ShopBox

#@onready var title: Label = $HBox/BoxContainer3/Title
@onready var title: NameValueUI = $HBox/BoxContainer3/MarginContainer/Title
@onready var price: Label = $HBox/BoxContainer2/Price
@onready var item_icon: Sprite2D = $HBox/BoxContainer/MarginContainer/Panel/Panel/Icon

@onready var stats_ui : StatsUI = $Stats
@onready var stats_container: VBoxContainer = $Stats/MarginContainer/StatsContainer
var stats_list : Array[NameValueUI] = []
var ressource = ""
@export var item : Item = null

var name_value_ui_scene = preload("res://name_value_ui.tscn")

func _ready():
	stats_ui.hide()
	pass

var counter = 1
func _process(delta):
	if counter % 5 != 0:
		counter += 1
		return
	counter = 1
	var windows_width = get_viewport_rect().size.x
	if global_position.x < windows_width/2:
		stats_ui.position.x = 134
	else:
		stats_ui.position.x = -134
	pass


func set_item(new_item: Item) -> void: # SCOTCH UTILISER LES RESSOURCES
	await ready
	# title.text = new_item.name
	title.set_name_value(new_item.name, "")
	title.set_text_color(rarity_colors[new_item.rarity])
	# title.modulate = rarity_colors[new_item.rarity]
	# if new_item.resource is WeaponProperty:
	# 	var weapon = new_item.resource as WeaponProperty
		# title.text += " v" + str(weapon.level)
	price.text = str(new_item.price) + "$"
	item_icon.texture = new_item.icon
	ressource = new_item.resource
	item = new_item
	set_stats()
	pass

func set_stats() -> void:
	var stats = {}
	if item.resource is WeaponProperty:
		var weapon_property = item.resource as WeaponProperty
		stats_ui.set_stats_by_resource(weapon_property)
	
	

func get_save_data() -> Dictionary:
	return {
		"item" : item,
	}

func play_sound(sound: String) -> void:
	if sound == "buy":
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1)
		$AudioStreamPlayer2D.play()
	pass

func _on_mouse_entered() -> void:
	super._on_mouse_entered()
	stats_ui.show()
	pass

func _on_mouse_exited() -> void:
	super._on_mouse_exited()
	stats_ui.hide()
	pass
