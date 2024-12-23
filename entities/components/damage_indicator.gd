extends Node2D
class_name DamageIndicator

var damage: float = 0.0
@export var damage_indicator_duration = 0.5

@export var damage_color_list : Array[Color] = []
@export var damage_number_list : Array[int] = []

@onready var animation_player : AnimationPlayer = $AnimationPlayer
var damage_indicator_timer : Timer = Timer.new()

func _ready() -> void:
	animation_player.play("crit")
	await animation_player.animation_finished
	queue_free()
	pass # Replace with function body.

func set_damage(new_damage: float) -> void:
	$Node2D/Label.text = str(new_damage)
	var index_color = 0

	for i in range(damage_number_list.size() - 1):
		if new_damage < damage_number_list[i + 1]:
			break
		index_color += 1
	print(new_damage, " ", index_color)
	$Node2D/Label.modulate = damage_color_list[index_color]
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
