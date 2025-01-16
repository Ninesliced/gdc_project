@tool
extends Node2D
class_name HealthComponent

@export var max_hp := 100
@export var initial_hp := 100
@export var invincible := false
@export var show_hp = false :
	set(value):
		$ProgressBar.visible = value
		$ProgressBar.value = hp
		show_hp = value

## show damage when hit
@export_group("Damage Indicator")
var damage_indicator : PackedScene = preload("res://entities/components/damage_indicator.tscn")
@export var show_damage_indicator = false
@onready var animation_player : AnimationPlayer = $DamageIndicator/AnimationPlayer
var damage_indicator_timer : Timer = Timer.new()

var hp = 0

@onready var progress_bar : TextureProgressBar = $ProgressBar

signal on_damage(damage: int)
signal on_death
signal on_heal(heal: int)

func _ready():
	hp = initial_hp
	if show_hp:
		progress_bar.visible = show_hp
		progress_bar.max_value = max_hp
		progress_bar.value = hp

func _process(delta):
	global_position = get_parent().global_position
	

func damage(n, is_critical_hit = false):
	if invincible:
		return
	hp -= n
	emit_signal("on_damage", n)
	indicate_damage(n, is_critical_hit)
	if hp <= 0:
		hp = 0
		emit_signal("on_death")
	progress_bar.value = hp
	pass 

func heal(n):
	if hp < max_hp and n > 0:
		emit_signal("on_heal")
	hp += n
	if hp >= max_hp:
		hp = max_hp
	
# Damage indicator

var damage_indicator_instance : Node2D

func indicate_damage(n, is_critical_hit):
	if show_damage_indicator:
		damage_indicator_instance = damage_indicator.instantiate()
		damage_indicator_instance.global_position = global_position + Vector2(randi_range(-10, 10), randi_range(-10, 10))
		get_tree().current_scene.add_child(damage_indicator_instance)

		damage_indicator_instance.set_damage(n, is_critical_hit)


func _on_DamageIndicator_timeout():
	$DamageIndicator.visible = false
