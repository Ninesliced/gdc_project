extends Panel
class_name SlotUI
@onready var sprite: Sprite2D = $Sprite
var has_stats = false
@onready var stats_ui : StatsUI = $Stats

var upgrade_parent : Upgrade = null
var index = 0
var mouse_over = false
var item : Item = null

var test_drop = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.position = Vector2(abs(sprite.position.x), abs(sprite.position.y))
	stats_ui.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("right_click") and mouse_over:
		if (PlayerData.replace_item(null, index)):
			upgrade_parent.update_player_stats()
	if has_stats:
		print("true")
	if test_drop:
		print("process: test drop is true")
		test_drop = false
	# if item:
	# 	stats_ui.set_stats_by_resource(item.resource)

func _input(event: InputEvent) -> void:
	pass

func set_slot(slot_data: Slot) -> void:
	if slot_data.item:
		if sprite == null:
			assert(false, "Sprite is null")
		set_sprite(slot_data)
		item = slot_data.item
		stats_ui.set_stats_by_resource(item.resource)
		if mouse_over:
			stats_ui.show()
	else:
		sprite.visible = false
		stats_ui.clear_stats()
		stats_ui.hide()
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item

func _drop_data(at_position: Vector2, data: Variant) -> void:
	test_drop = true
	var item: Item = data
	if item:
		sprite.texture = item.icon
		sprite.visible = true
	else:
		sprite.visible = false

	# will try to replace the item in the slot
	if (PlayerData.replace_item(item, index)):
		upgrade_parent.play_sound("load")
		if upgrade_parent:
			#will then call set_slots
			upgrade_parent.update_player_stats()

func _on_mouse_entered() -> void:
	mouse_over = true
	if stats_ui.is_empty():
		stats_ui.hide()
	else:
		stats_ui.show()
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	mouse_over = false
	stats_ui.hide()
	pass # Replace with function body.


func set_sprite(slot_data: Slot) -> void:
	sprite.texture = slot_data.item.icon
	sprite.visible = true
	sprite.rotation = slot_data.rotation + PI/2