extends CharacterBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent

@export var damage := 5.0

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player : Player = body
		player.health_component.damage(damage)
		queue_free()


func _on_health_component_on_death() -> void:
	queue_free()
	pass # Replace with function body.
