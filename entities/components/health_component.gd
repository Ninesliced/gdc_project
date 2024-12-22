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

var hp = 0

@onready var progress_bar : TextureProgressBar = $ProgressBar

signal on_damage(damage: int)
signal on_death
signal on_heal(heal: int)

func _ready():
	hp = initial_hp
	progress_bar.visible = show_hp
	progress_bar.max_value = max_hp
	progress_bar.value = hp
	if progress_bar.visible:
		set_process(true)

func _process(delta):
	if progress_bar.visible:
		global_rotation = 0

func damage(n):
	if invincible:
		return
	hp -= n
	emit_signal("on_damage", n)
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
	
