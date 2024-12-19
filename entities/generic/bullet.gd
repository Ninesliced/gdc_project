extends CharacterBody2D


@export var direction: float = 0.0:
	set(value):
		direction = value
		update_velocity()

@export var speed: float = 200.0:
	set(value):
		speed = value
		update_velocity()

func update_velocity() -> void:
	velocity.x = cos(direction) * speed
	velocity.y = sin(direction) * speed

func _ready() -> void:
	update_velocity()

func _physics_process(_delta: float) -> void:
	move_and_slide()
