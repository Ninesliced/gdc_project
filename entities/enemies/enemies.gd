extends CharacterBody2D
class_name Enemy

func _physics_process(delta: float) -> void:
	move_and_slide()

func _kill() -> void:
	queue_free()
