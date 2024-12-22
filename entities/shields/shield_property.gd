extends Resource

class_name ShieldProperty

@export var generatorTexture: Texture2D = load("res://assets/space_breaker_asset/Bonus/turret_01c_mk3.png")
@export var shieldTexture: Texture2D = load("res://assets/shield/shield.png")

@export var max_health := 25.0
@export var regeneration_rate_s := 1.0
@export var regeneration := 2.0

@export var regeneration_delay := 15.0
@export var shield_scale := 1.0
