extends CharacterBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent

func _physics_process(delta: float) -> void:
	move_and_slide()

func _kill() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
		
	pass # Replace with function body.
