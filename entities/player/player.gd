@tool
extends CharacterBody2D
class_name Player

@export var _player_stats : PlayerStats:
	set(stats):
		_player_stats = stats
		if stats != null and $Icon != null:
			$Icon.texture = stats.texture

var _player_counter : CounterData

@export var chunk_manager : ChunkManager = null
var chunk_check_frame_rate = 0.2
var chunk_frame = 0

@onready var camera = $Camera2D
@onready var health_component : HealthComponent = $HealthComponent

func _ready() -> void:
	if PlayerData.player_start_stats != null:
		var new_data = PlayerData.player_start_stats.duplicate()
		for i in range(PlayerData.player_start_stats.item_slots.size()):
			var slot = PlayerData.player_start_stats.item_slots[i].duplicate()
			new_data.item_slots[i] = slot
		new_data.counter_data = PlayerData.player_start_stats.counter_data.duplicate()			
		_player_stats = new_data
		_player_counter = _player_stats.counter_data
	else:
		print("WARNING: Player stats not set")
		_player_counter = _player_stats.counter_data
	PlayerData.set_player_data(self)
	UiGlobal.in_game_ui_node.set_player(self)
	$MovementComponent.speed = _player_stats.speed
	pass

func _process(delta: float) -> void:
	if chunk_manager == null:
		return
	if chunk_frame > chunk_check_frame_rate:
		chunk_manager.load_chunk_around(global_position)
		chunk_frame = 0
	chunk_frame += delta

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func _on_health_component_on_death() -> void:
	UiGlobal.retry_node.show_retry()
	get_tree().paused = true

func _on_health_component_on_damage(damage: int) -> void:
	pass
