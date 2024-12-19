extends Node2D

@export var speed = 300.0
@export var acceleration = 300
@export var decceleration = 200
@export var rotation_speed := 2.5
@onready var parent = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	var velocity = parent.velocity

	if Input.is_action_pressed("down"):
		direction.y = 1
	if Input.is_action_pressed("up"):
		direction.y = -1
	if Input.is_action_pressed("left"):
		parent.rotate(-delta * rotation_speed)
	if Input.is_action_pressed("right"):	
		parent.rotate(delta * rotation_speed)
	
	direction = direction.rotated(parent.rotation)
	velocity = handle_acceleration(direction,velocity, delta)
	velocity = handle_decceleration(direction, velocity, delta)
	parent.velocity = velocity
	pass

func handle_acceleration(direction,velocity, delta):
	if direction.x > 0:
		velocity.x = velocity.move_toward(direction * speed, acceleration * delta).x
	if direction.x < 0:
		velocity.x = velocity.move_toward(direction * speed, acceleration * delta).x
	if direction.y > 0:
		velocity.y = velocity.move_toward(direction * speed, acceleration * delta).y
	if direction.y < 0:
		velocity.y = velocity.move_toward(direction * speed, acceleration * delta).y
	
	return velocity

func handle_decceleration(direction, velocity, delta):
	if direction.x == 0:
		velocity.x = velocity.move_toward(Vector2.ZERO,decceleration * delta).x
	if direction.y == 0:
		velocity.y = velocity.move_toward(Vector2.ZERO,decceleration * delta).y
	return velocity
