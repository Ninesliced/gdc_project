extends Resource

class_name WeaponProperty

@export var rotation_speed: float = 0.1

@export var bullet: PackedScene = load("res://entities/weapons/bullet.tscn")
@export var texture: Texture2D = load("res://assets/space_breaker_asset/Weapons/Small/Cannon/turret_01_mk1.png")
@export var damage := 5.0
@export var attack_range := 500
@export var shoot_interval := 0.2
@export var bullet_speed := 300

@export var target_enemy := true
@export var aimbot := true

@export var enable_audio := false