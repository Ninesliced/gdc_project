extends CharacterBody2D
class_name Player

@onready var camera = $Camera2D
@onready var health_component : HealthComponent = $HealthComponent

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

func _on_health_component_on_death() -> void:
	print("dead")
	queue_free()

func _on_health_component_on_damage(damage: int) -> void:
	print("Took", damage, "damage")
