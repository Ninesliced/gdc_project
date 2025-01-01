extends UiBox

class_name ClassBox
var selected : bool = false
var player_stats : PlayerStats = null
signal on_class_selected(box : ClassBox)

@onready var class_icon = $HBox/TextureRect/Icon
@onready var character_name: Label = $HBox/Name
@onready var description: Label = $HBox/Description

func _ready() -> void:
	if player_stats == null:
		return
	class_icon.texture = player_stats.texture
	character_name.text = player_stats.name
	character_name.modulate = rarity_colors[player_stats.rarity]
	description.text = player_stats.description
	pass


func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	emit_signal("on_class_selected", self)
	pass # Replace with function body.

func _on_mouse_entered() -> void:
	if selected:
		return
	play_animation_selected()
	pass # Replace with function body.

func _on_mouse_exited() -> void:
	if selected:
		return
	play_animation_selected(true)
	pass # Replace with function body.

func select() -> void:
	selected = true
	$AnimationPlayer.play("select_3")

func deselect() -> void:
	selected = false
	$AnimationPlayer.play_backwards("select_3")
