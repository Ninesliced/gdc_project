extends CharacterBody2D
class_name Player

const SPEED = 20000.0
const ACCELERATION = 400
const JUMP_VELOCITY = -400.0
const ROTATION_SPEED = 2
@onready var camera = $Camera2D

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _on_timer_timeout() -> void:
	pass # Replace with function body.
