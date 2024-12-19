extends Node2D

@export var direction: Vector2 = Vector2(1, 0)
@export var rotation_speed: float = 0.1

@export var bullet: PackedScene = load("res://entities/generic/bullet.tscn")
@export var damage := 5.0
@export var attack_range := 500

@export var target_enemy := true
var target: Node2D = null

func select_target() -> Node2D:
	var enemies: Array[Node]             = get_tree().get_nodes_in_group("Enemy" if target_enemy else "Player")
	var enemies_in_range: Array[Variant] = []
	for enemy in enemies:
		if not enemy is Enemy:
			continue
		var distance: float = global_position.distance_to(enemy.global_position)
		if distance < attack_range:
			enemies_in_range.append(enemy)
	
	if enemies_in_range.size() > 0:
		return enemies_in_range[randi() % enemies_in_range.size()]
	
	return null

func _process(delta: float) -> void:
	if target == null or global_position.distance_to(target.global_position) > attack_range:
		target = select_target()
	
	if target != null:
		direction = (target.global_position - global_position).normalized()
		global_rotation = direction.angle()


func _on_timer_timeout() -> void:
	if bullet == null or target == null:
		return
	
	var instance: Bullet = bullet.instantiate() as Bullet
	instance.global_position = global_position
	instance.rotation = rotation
	instance.direction = direction
	instance.target_enemy = target_enemy
	instance.target = target
	instance.damage = damage
	get_tree().current_scene.add_child(instance)
