extends Node2D

var direction: Vector2 = Vector2(1, 0)

@export var weapon_property: WeaponProperty = null
@onready var sprite = $Sprite
var target: Node2D = null


func load_resource(resource : Resource) -> void:
	if resource is WeaponProperty:
		weapon_property = resource
		$Sprite.texture = weapon_property.texture
	else:
		assert(false, "Invalid resource type")

func select_target() -> Node2D:
	var enemies: Array[Node] = get_tree().get_nodes_in_group("Enemy" if weapon_property.target_enemy else "Player")
	var enemies_in_range: Array[Variant] = []
	for enemy in enemies:
		var distance: float = global_position.distance_to(enemy.global_position)
		if distance < weapon_property.attack_range:
			enemies_in_range.append(enemy)
	
	if enemies_in_range.size() > 0:
		return enemies_in_range[randi() % enemies_in_range.size()]
	return null

func _ready() -> void:
	if weapon_property == null:
		weapon_property = WeaponProperty.new()
	
	$Timer.wait_time = weapon_property.shoot_interval
	$Sprite.texture = weapon_property.texture

func _process(delta: float) -> void:
	if (target == null or !is_instance_valid(target)):
		target = select_target()
	
	if target != null and is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
		global_rotation = direction.angle()


func _on_timer_timeout() -> void:
	if weapon_property.bullet == null or target == null:
		return
	
	var instance: Bullet = weapon_property.bullet.instantiate() as Bullet
	instance.global_position = global_position
	instance.rotation = rotation
	instance.direction = direction
	instance.target_enemy = weapon_property.target_enemy
	if weapon_property.aimbot:
		instance.target = target
	instance.damage = weapon_property.damage
	get_tree().current_scene.add_child(instance)

	target = select_target()
	if target != null and is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
		global_rotation = direction.angle()
