extends Node2D
class_name Manager

@export var max_slots := 3

var slots = []
func _ready() -> void:
	for i in range(max_slots):
		slots.append(null)
	pass

func _process(delta: float) -> void:
	pass

func replace_item(item, i):
	if i >= slots.size():
		return null
	var replaced_item = slots[i]
	slots[i] = item
	return replaced_item

func add_slots():
	slots.append(null)
	

	
