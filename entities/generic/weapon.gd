extends Node2D

@export var direction: Vector2 = Vector2(1, 0)
@export var rotation_speed: float = 0.1

@export var bullet: PackedScene = load("res://entities/generic/bullet.tscn")
@export var damage := 5.0

func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	direction = (mouse_pos - global_position).normalized()
	global_rotation = direction.angle()


func _on_timer_timeout() -> void:
	if bullet == null:
		return
	
	var instance: Bullet = bullet.instantiate() as Bullet
	instance.global_position = global_position
	instance.rotation = rotation
	instance.direction = direction
	instance.damage = damage
	get_tree().current_scene.add_child(instance)
