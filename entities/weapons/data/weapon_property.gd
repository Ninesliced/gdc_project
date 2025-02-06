extends Resource

class_name WeaponProperty

@export var level: int = 1
@export var rotation_speed: float = 0.1

@export var bullet: PackedScene = load("res://entities/weapons/bullet.tscn")
@export var texture: Texture2D = load("res://assets/space_breaker_asset/Weapons/Small/Cannon/turret_01_mk1.png")
@export var damage := 5.0
@export var attack_range := 500
@export var fire_rate := 0.2
@export var bullet_speed := 300
@export var critical_chance := 0.0
@export var critical_damage := 0.0

@export var target_enemy := true
@export var aimbot := true

@export var enable_audio := false

var level_damage_multiplier := 1.2
var level_cc_multiplier := 0.05
var level_cd_multiplier := 0.05

func get_damage(multiplier = 1) -> int:
	return floor(damage + (level * level_damage_multiplier) * multiplier)

func get_critical_chance(add = 0) -> float:
	return critical_chance + level * level_cc_multiplier + add
func get_critical_damage(add = 0) -> float:
	return critical_damage + level * level_cd_multiplier + add

func level_up() -> void:
	level += 1
	
func set_level(new_level: int) -> void:
	if new_level < 1:
		new_level = 1
	level = new_level

func get_dps():
	return get_damage() / fire_rate

func randomize_properties(delta_percentage_range : float):
	var dpr = delta_percentage_range
	var damage_delta = randf_range(-dpr, dpr)
	damage += damage * damage_delta
	var speed_delta = randf_range(-dpr, dpr)
	fire_rate += fire_rate * speed_delta
	var crit_chance_delta = randf_range(-dpr, dpr)
	critical_chance += critical_chance * crit_chance_delta
	
	var crit_damage_delta = randf_range(-dpr, dpr)
	critical_damage += critical_damage * crit_damage_delta
	