extends Node2D
class_name Weapon
var direction: Vector2 = Vector2(1, 0)

@export var weapon_property: WeaponProperty = null
@export var play_shoot_audio: bool = false
@onready var sprite = $Sprite
var target: Node2D = null
var parent : Node2D = null

@export var floaty_weapon : bool = true

var _player_stats : PlayerStats = null

signal shoot

func load_resource(resource : Resource) -> void:
	if resource is WeaponProperty:
		weapon_property = resource
		$Sprite.texture = weapon_property.texture
		$Timer.wait_time = weapon_property.fire_rate
	else:
		assert(false, "Invalid resource type")

func set_delay(percents: float) -> void:
	$Timer.stop()
	var delayTimer : Timer = Timer.new()
	delayTimer.wait_time = weapon_property.fire_rate * percents
	delayTimer.one_shot = true
	delayTimer.timeout.connect(start_shooting)
	add_child(delayTimer)
	delayTimer.start()

func start_shooting() -> void:
	print($Timer.wait_time)
	$Timer.start()

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
	$Timer.wait_time = weapon_property.fire_rate
	$Sprite.texture = weapon_property.texture

	if parent is Player:
		var player: Player = parent as Player
		_player_stats = player._player_stats

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
	var additional_cc = 0 if _player_stats == null else _player_stats.critical_chance
	var additional_cd = 0 if _player_stats == null else _player_stats.critical_damage

	instance.global_position = global_position
	instance.global_rotation = direction.angle()
	instance.direction = direction
	instance.target_enemy = weapon_property.target_enemy
	instance.speed = weapon_property.bullet_speed

	if randf() < (weapon_property.critical_chance + additional_cc):
		instance.is_critical_hit = true
		instance.damage = weapon_property.get_damage() * \
		(weapon_property.critical_damage + additional_cd)
	else:
		instance.damage = weapon_property.get_damage()

	return instance


func _on_shoot() -> void:
	if weapon_property.enable_audio:
		$ShootAudio.play()
	pass # Replace with function body.
