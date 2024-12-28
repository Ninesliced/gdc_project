extends CharacterBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent

@export var damage := 5.0
@export var drop: PackedScene = load("res://entities/enemies/drops/basic_drop.tscn")

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player : Player = body
		player.health_component.damage(damage)
		queue_free()
	
	if body is Shield:
		var shield: Shield = body
		shield.health_component.damage(damage)
		queue_free()


func _on_health_component_on_death() -> void:
	if drop != null:
		var instance : Node2D = drop.instantiate()
		instance.global_position = global_position
		get_tree().current_scene.add_child(instance)
	
	queue_free()


func _on_health_component_on_damage(damage:int) -> void:
	$HitPlayer.stop()
	$HitPlayer.play("hit")
	pass # Replace with function body.
