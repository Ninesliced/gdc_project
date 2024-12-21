extends Panel
class_name SlotUI
@onready var sprite: Sprite2D = $Sprite
var upgrade_parent : Upgrade = null

var index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_slot(item: Item) -> void:
	if item:
		sprite.texture = item.icon
		sprite.visible = true
	else:
		sprite.visible = false
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item: Item = data
	if item:
		sprite.texture = item.icon
		sprite.visible = true
	else:
		sprite.visible = false
	pass
	PlayerData.replace_item(item, index)
	if upgrade_parent:
		upgrade_parent.update_player_stats()