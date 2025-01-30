extends Node2D
class_name Planet

@onready var ui = $ui
var can_interact = false
@export var buy_cards : Array[Item] = []
var random_items_set = false
var planet_level = 1
func _ready() -> void:	
	pass # Replace with function body.

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body is Player:
		ui.show()
		can_interact = true
	pass


func _on_area_2d_body_exited(body:Node2D) -> void:
	if body is Player:
		ui.hide()
		can_interact = false
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and \
		can_interact:
		handle_items()
		ShopData.open_shop(buy_cards)

func handle_items():
	if not random_items_set:
		buy_cards = ShopData.get_random_items(3, planet_level)
		random_items_set = true
