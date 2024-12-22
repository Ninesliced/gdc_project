@tool
extends CharacterBody2D
class_name Player

@export var _player_stats : PlayerStats:
    set(stats):
        _player_stats = stats
        print(stats)
        if stats != null and $Icon != null:
            print(stats.texture, $Icon)
            $Icon.texture = stats.texture

@export var _player_counter : CounterData

@export var test : int = 0 :
    set(value):
        test = value

@onready var camera = $Camera2D
@onready var health_component : HealthComponent = $HealthComponent

func _ready() -> void:
    PlayerData.player = self
    PlayerData.load_equipment()
    print("printing: ",_player_stats.item_slots)
    pass


func _physics_process(delta: float) -> void:
    move_and_collide(velocity * delta)

func _on_health_component_on_death() -> void:
    queue_free()

func _on_health_component_on_damage(damage: int) -> void:
    pass
