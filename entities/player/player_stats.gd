@tool
extends Resource
class_name PlayerStats

@export var locked : bool = false
@export var name : String = "unnamed soldier"
@export var description : String = "A soldier with no name"
@export var rarity : GameData.Rarity = GameData.Rarity.COMMON
@export var texture : Texture2D = load("res://assets/space_breaker_asset/Ships/Medium/body_02.png")
@export var item_slots : Array[Slot] = []
@export_group("Trail")
@export var has_trail : bool = false
@export var trail_color : Color = Color(1, 1, 1, 1)

@export_group("Stats")
@export var reduction_delay_boost : float = 0.0
@export var damage_multiplier : float = 2.0
@export var speed : float = 100.0
@export var health : float = 100.0
@export var critical_chance : float = 0.2
@export var critical_damage : float = 2
@export var counter_data : CounterData = CounterData.new()
@export var view_distance : float = 0.8

var bonus_speed : float = 0.0
var bonus_damage : float = 0.0
var bonus_view_distance : float = 0.0

var inventory : Array[Item] = []
var equipments : Array[Node2D] = []
var nodes_positioner : Array[Node2D] = []

signal on_player_stats_changed(stats: PlayerStats)

func is_critical_hit() -> bool:
	return randf() < critical_chance
