@tool
extends CharacterBody2D
class_name Player

@export var _player_stats : PlayerStats:
	set(stats):
		_player_stats = stats
		if stats != null and $Icon != null:
			$Icon.texture = stats.texture

@export var _player_counter : CounterData

@export var test : int = 0 :
	set(value):
		test = value

@onready var camera = $Camera2D
@onready var health_component : HealthComponent = $HealthComponent

func _ready() -> void:
	if PlayerData.player_start_stats != null:
		var new_data = PlayerData.player_start_stats.duplicate()
		for i in range(PlayerData.player_start_stats.item_slots.size()):
			var slot = PlayerData.player_start_stats.item_slots[i].duplicate()
			new_data.item_slots[i] = slot
			
			
		_player_stats = new_data
	PlayerData.set_player_data(self)
	$MovementComponent.speed = _player_stats.speed
	pass


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func _on_health_component_on_death() -> void:
	queue_free()

func _on_health_component_on_damage(damage: int) -> void:
	pass
