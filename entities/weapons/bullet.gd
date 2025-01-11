extends CharacterBody2D

class_name Bullet

@export var direction: Vector2 = Vector2(1, 0):
	set(value):
		direction = value
		update_velocity()

@export var speed: float = 200.0:
	set(value):
		speed = value
		update_velocity()

@export var damage := 5.0
@export var is_critical_hit := false

var target_enemy := true
var target: Node2D = null

func update_velocity() -> void:
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed

func _ready() -> void:
	update_velocity()

func _physics_process(_delta: float) -> void:
	if target != null and is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
		global_rotation = direction.angle()
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy and target_enemy:
		var enemy: Enemy = body as Enemy
		enemy.health_component.damage(damage, is_critical_hit)
		queue_free()
	
	if body is Player and not target_enemy:
		var player: Player = body as Player
		player.health_component.damage(damage, is_critical_hit)
		queue_free()
	
	if body is Shield:
		var shield: Shield = body as Shield
		if shield.get_parent() is Player and not target_enemy or shield.get_parent() is Enemy and target_enemy:
			shield.health_component.damage(damage, is_critical_hit)
			queue_free()

func _on_timer_timeout() -> void:
	queue_free()
