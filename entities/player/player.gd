@tool
extends CharacterBody2D
class_name Player

@export var _player_stats : PlayerStats:
	set(stats):
		_player_stats = stats
		if stats != null and $Icon != null:
			$Icon.texture = stats.texture

var _player_counter : CounterData

@export var test : int = 0 :
	set(value):
		test = value

@onready var camera = $Camera2D
@onready var health_component : HealthComponent = $HealthComponent

func _ready() -> void:
	# if _player_counter == null and _player_stats.counter_data != null:
	# 	print("Counter data is null")
	# 	print(_player_stats.counter_data.score)
	# 	_player_counter = _player_stats.counter_data.duplicate()
	if PlayerData.player_start_stats != null:
		var new_data = PlayerData.player_start_stats.duplicate()
		for i in range(PlayerData.player_start_stats.item_slots.size()):
			var slot = PlayerData.player_start_stats.item_slots[i].duplicate()
			new_data.item_slots[i] = slot
		new_data.counter_data = PlayerData.player_start_stats.counter_data.duplicate()			
		_player_stats = new_data
		_player_counter = _player_stats.counter_data

	PlayerData.set_player_data(self)
	UiGlobal.in_game_ui_node.set_player(self)
	$MovementComponent.speed = _player_stats.speed
	pass


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func _on_health_component_on_death() -> void:
	queue_free()

func _on_health_component_on_damage(damage: int) -> void:
	pass
