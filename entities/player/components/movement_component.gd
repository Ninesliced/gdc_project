extends Node2D

var speed = 300.0
@export var acceleration = 300
@export var decceleration = 200
@export var rotation_speed = 2.5
@export var movement_mode : MovementMode = MovementMode.FourKeysDriven
@export var camera : Camera2D = null

@onready var parent = null
# Called when the node enters the scene tree for the first time.

enum MovementMode {
	RotationDriven,
	FourKeysDriven,
}


func _ready() -> void:
	if movement_mode == MovementMode.RotationDriven:
		pass
	if movement_mode == MovementMode.FourKeysDriven and camera != null:
		camera.ignore_rotation = true
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
	
	if movement_mode == MovementMode.FourKeysDriven:
		if Input.is_action_pressed("left"):
			direction.x = -1
		if Input.is_action_pressed("right"):
			direction.x = 1
		if direction != Vector2.ZERO:
			parent.rotation = rotate_toward(parent.rotation, direction.angle() + PI/2, rotation_speed * delta)

	if movement_mode == MovementMode.RotationDriven:
		if Input.is_action_pressed("left"):
			parent.rotate(-delta * rotation_speed)
		if Input.is_action_pressed("right"):	
			parent.rotate(delta * rotation_speed)
	
	PlayerData.player_rotation = parent.rotation
	
	if movement_mode == MovementMode.RotationDriven:
		direction = direction.rotated(parent.rotation)

	if movement_mode == MovementMode.FourKeysDriven and direction != Vector2.ZERO:
		direction = Vector2(cos(parent.rotation - PI/2), sin(parent.rotation - PI/2)).normalized()

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
