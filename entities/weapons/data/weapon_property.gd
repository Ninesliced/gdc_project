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
	return floor(damage * (level ** level_damage_multiplier) * multiplier)

func get_critical_chance(add = 0) -> float:
	return critical_chance + level * level_cc_multiplier + add
func get_critical_damage(add = 0) -> float:
	return critical_damage + level * level_cd_multiplier + add

func level_up() -> void:
	level += 1
	
