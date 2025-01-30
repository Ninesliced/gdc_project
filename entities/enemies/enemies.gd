extends CharacterBody2D
class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent
@export var enemy_data : EnemyData = null

func load_resource(resource: Resource) -> void:
	if resource is EnemyData:
		enemy_data = resource
		

func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		var player : Player = body
		player.health_component.damage(enemy_data.damage)
		queue_free()
	
	if body is Shield:
		var shield: Shield = body
		shield.health_component.damage(enemy_data.damage)
		queue_free()


func _on_health_component_on_death() -> void:
	if enemy_data.drop != null:
		var instance : Node2D = enemy_data.drop.instantiate()
		instance.global_position = global_position
		get_tree().current_scene.add_child(instance)
	
	queue_free()

func set_hp(hp: int) -> void:
	if !health_component:
		await ready
	health_component.hp = hp

func add_hp(hp: int) -> void:
	if !health_component:
		await ready
	health_component.hp += hp

func _on_health_component_on_damage(damage:int) -> void:
	$HitPlayer.stop()
	$HitPlayer.play("hit")
	pass # Replace with function body.
