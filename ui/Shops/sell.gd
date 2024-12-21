extends VBoxContainer
class_name SellUI
var items : Array[Item] = []
var box_card : PackedScene = preload("res://ui/Shops/boxes/sell_box.tscn")
var list_box_scene : Array = []
@onready var grid_container : GridContainer = $NinePatchRect/ScrollContainer/GridContainer

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update() -> void: #SKOTCH DOUBLE DANS L'AUTRE
	items = PlayerData.inventory
	for item in list_box_scene:
		if is_instance_valid(item):
			item.queue_free()
	
	list_box_scene = []

	for item in items:
		var instantiated = box_card.instantiate()
		instantiated.set_item(item)
		grid_container.add_child(instantiated)
		list_box_scene.append(instantiated)
	pass
