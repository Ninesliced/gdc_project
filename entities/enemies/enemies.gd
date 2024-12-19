extends CharacterBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player : Player = body
	
	pass # Replace with function body.


func _on_health_component_on_death() -> void:
	queue_free()
	pass # Replace with function body.
