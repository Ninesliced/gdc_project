extends UiBox
class_name ShopBox

#@onready var title: Label = $HBox/BoxContainer3/Title
@onready var title: NameValueUI = $HBox/BoxContainer3/MarginContainer/Title
@onready var price: Label = $HBox/BoxContainer2/Price
@onready var item_icon: Sprite2D = $HBox/BoxContainer/MarginContainer/Panel/Panel/Icon

@onready var stats: NinePatchRect = $Stats
@onready var stats_container: VBoxContainer = $Stats/StatsContainer
var stats_list : Array[NameValueUI] = []
var ressource = ""
@export var item : Item = null

var name_value_ui_scene = preload("res://name_value_ui.tscn")

func _ready():
	stats.hide()
	pass


func _process(delta):
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
	for stat_ui in stats_list:
		if is_instance_valid(stat_ui):
			stat_ui.queue_free()
	stats_list.clear()

	if item.resource is WeaponProperty:
		var weapon_property = item.resource as WeaponProperty
		var dps = 0
		if weapon_property.fire_rate > 0:
			dps = weapon_property.damage / weapon_property.fire_rate

		stats = {
			"dps" : dps,
			"damage" : weapon_property.get_damage(),
			"fire_rate" : weapon_property.fire_rate,
			"critical_chance" : str(weapon_property.get_critical_chance() * 100) + "%",
			"critical_damage" : str(weapon_property.get_critical_damage() * 100) + "%",
		}
	
	var new_stats : Array[NameValueUI] = UiGlobal.get_ui_stats_from_dict(stats)

	for stat in new_stats:
		stats_container.add_child(stat)
		stats_list.append(stat)

	

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
	stats.show()
	pass

func _on_mouse_exited() -> void:
	super._on_mouse_exited()
	stats.hide()
	pass

