extends Area2D

@export var follower : Node2D 
var follow : Node2D = null
var speed : float = 200
var multiplier : float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if follower == null:
		follower = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_instance_valid(follow):
		var direction = follow.global_position - global_position
		direction = direction.normalized()
		follower.global_position += direction * speed * delta * multiplier
		multiplier += 1 * delta
	pass


func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		follow = body
	pass # Replace with function body.
