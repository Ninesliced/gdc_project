extends Panel
class_name SlotUI
@onready var sprite: Sprite2D = $Sprite
var upgrade_parent : Upgrade = null

var index = 0
var mouse_over = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.position = Vector2(abs(sprite.position.x), abs(sprite.position.y))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right_click") and mouse_over:
		if (PlayerData.replace_item(null, index)):
			upgrade_parent.update_player_stats()
	pass

func _input(event: InputEvent) -> void:
	pass

func set_slot(slot_data: Slot) -> void:
	if slot_data.item:
		sprite.texture = slot_data.item.icon
		sprite.visible = true
		sprite.rotation = slot_data.rotation + PI/2
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
	# will try to replace the item in the slot
	if (PlayerData.replace_item(item, index)):
		upgrade_parent.play_sound("load")
		if upgrade_parent:
			upgrade_parent.update_player_stats()

func _on_mouse_entered() -> void:
	mouse_over = true

	pass # Replace with function body.


func _on_mouse_exited() -> void:
	mouse_over = false
	pass # Replace with function body.
