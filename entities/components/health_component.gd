extends Node2D
class_name HealthComponent

@export var max_hp := 100
@export var initial_hp := 100
@export var invincible := false
var hp = 0

signal on_damage(damage: int)
signal on_death
signal on_heal(heal: int)

func _ready():
	hp = initial_hp

func damage(n):
	if invincible:
		return
	hp -= n
	print("damaged")
	emit_signal("on_damage", n)
	if hp <= 0:
		hp = 0
		emit_signal("on_death")
	pass 

func heal(n):
	if hp < max_hp and n > 0:
		emit_signal("on_heal")
	hp += n
	if hp >= max_hp:
		hp = max_hp
	
