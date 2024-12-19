extends CharacterBody2D


@export var direction: Vector2 = Vector2(1, 0):
	set(value):
		direction = value
		update_velocity()

@export var speed: float = 200.0:
	set(value):
		speed = value
		update_velocity()

func update_velocity() -> void:
	velocity.x = direction.x * speed
	velocity.y = direction.y * speed

func _ready() -> void:
	update_velocity()

func _physics_process(_delta: float) -> void:
	move_and_slide()
