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

var target_enemy := true

func update_velocity() -> void:
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed

func _ready() -> void:
	update_velocity()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy and target_enemy:
		var enemy: Enemy = body as Enemy
		enemy.health_component.damage(damage)
		queue_free()
	
	if body is Player and not target_enemy:
		var player: Player = body as Player
		# player.health_component.damage(damage)
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
