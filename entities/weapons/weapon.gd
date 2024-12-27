extends Node2D
class_name Weapon
var direction: Vector2 = Vector2(1, 0)

@export var weapon_property: WeaponProperty = null
@export var play_shoot_audio: bool = false
@onready var sprite = $Sprite
var target: Node2D = null
var parent : Node2D = null

var current_damage: float = 0.0

signal shoot

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
	parent = get_parent()
	if weapon_property == null:
		weapon_property = WeaponProperty.new()
	current_damage = weapon_property.damage
	$Timer.wait_time = weapon_property.shoot_interval
	$Sprite.texture = weapon_property.texture
	var parent = get_parent()
	if parent is Player:
		var player: Player = parent as Player
		player._player_stats.connect("on_player_stats_changed", update_stats)
		weapon_property.critical_chance += player._player_stats.critical_chance
		weapon_property.critical_damage += player._player_stats.critical_damage
		update_stats()

func update_stats():
	var player_stat : PlayerStats = parent._player_stats
	$Timer.wait_time = weapon_property.shoot_interval - (weapon_property.shoot_interval * player_stat.reduction_delay_boost)
	current_damage = weapon_property.damage * player_stat.damage_multiplier

func _process(delta: float) -> void:
	if (target == null or !is_instance_valid(target)):
		target = select_target()
	
	if target != null and is_instance_valid(target):
		direction = (target.global_position - global_position).normalized()
		global_rotation = direction.angle()


func _on_timer_timeout() -> void:
	if weapon_property.bullet == null or target == null:
		return
	
	var bullet_instance : Bullet = init_bullet(weapon_property.bullet)
	if weapon_property.aimbot:
		bullet_instance.target = target

	get_tree().current_scene.add_child(bullet_instance)
	emit_signal("shoot")
	target = select_target()


func init_bullet(bullet: PackedScene) -> Bullet:
	var instance : Bullet = bullet.instantiate() as Bullet
	instance.global_position = global_position
	instance.global_rotation = direction.angle()
	instance.direction = direction
	instance.target_enemy = weapon_property.target_enemy
	instance.speed = weapon_property.bullet_speed

	if randf() < weapon_property.critical_chance:
		instance.is_critical_hit = true
		instance.damage = current_damage * weapon_property.critical_damage
	else:
		instance.damage = current_damage

	return instance


func _on_shoot() -> void:
	if weapon_property.enable_audio:
		$ShootAudio.play()
	pass # Replace with function body.
