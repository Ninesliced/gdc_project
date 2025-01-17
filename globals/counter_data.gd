extends Resource

class_name CounterData

@export var base_coin := 0.0
@export var weapon_coin := 0.0
@export var booster_coin := 0.0
@export var accelerator_coin := 0.0
@export var shield_coin := 0.0
@export var view_coin := 0.0
@export var score := 0

signal on_counter_data_changed

func _add(data: CounterData) -> void:
	base_coin += data.base_coin
	weapon_coin += data.weapon_coin
	booster_coin += data.booster_coin
	accelerator_coin += data.accelerator_coin
	shield_coin += data.shield_coin
	view_coin += data.view_coin
	score += data.score
	emit_signal("on_counter_data_changed")

func get_stats():
	return {
		"coin": base_coin,
		"score": score
	}