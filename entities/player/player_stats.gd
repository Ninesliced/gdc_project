@tool
extends Resource
class_name PlayerStats

@export var texture : Texture2D = load("res://assets/space_breaker_asset/Ships/Medium/body_02.png")
@export var item_slots : Array[Slot] = []
@export var reduction_delay_boost : float = 0.0
@export var damage_multiplier : float = 2.0
@export var speed : float = 100.0
@export var health : float = 100.0

signal on_player_stats_changed(stats: PlayerStats)