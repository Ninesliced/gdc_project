extends Button
class_name UiBox

var rarity_colors : Dictionary = {
	0: Color(1, 1, 1, 1),
	1 : Color.html("#488bd4"),
	2 : Color.html("#3dff6e"),
	3 : Color.html("#d61a88"),
	4 : Color.html("#ffb84a"),
}

@onready var title: Label = $HBox/BoxContainer3/Title
@onready var price: Label = $HBox/BoxContainer2/Price
@onready var item_icon: Sprite2D = $HBox/BoxContainer/Panel2/Icon

@onready var animation_player : AnimationPlayer = $AnimationPlayer
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



func _on_mouse_entered() -> void:
	if animation_player.is_playing() and animation_player.current_animation != "select_2":
		await animation_player.animation_finished
	$AnimationPlayer.play("select_2")
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	if animation_player.is_playing() and animation_player.current_animation != "select_2":
		await animation_player.animation_finished
	$AnimationPlayer.play_backwards("select_2")
	pass # Replace with function body.
