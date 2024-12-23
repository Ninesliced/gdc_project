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
@export var show_damage_indicator = false :
	set(value):
		if $DamageIndicator:
			$DamageIndicator.visible = value
			show_damage_indicator = value
@export var damage_indicator_duration = 0.5
@export var damage_indicator_color = Color(1, 1, 1, 1) :
	set(value):
		if $DamageIndicator:
			$DamageIndicator.modulate = value
			damage_indicator_color = value
@onready var animation_player : AnimationPlayer = $AnimationPlayer
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

	init_damage_indicator()

func _process(delta):
	global_rotation = 0
	

func damage(n):
	if invincible:
		return
	hp -= n
	emit_signal("on_damage", n)
	indicate_damage(n)
	if hp <= 0:
		hp = 0
		emit_signal("on_death")
	progress_bar.value = hp
	print(hp)
	pass 

func heal(n):
	if hp < max_hp and n > 0:
		emit_signal("on_heal")
	hp += n
	if hp >= max_hp:
		hp = max_hp
	
# Damage indicator

func indicate_damage(n):
	if show_damage_indicator:
		$DamageIndicator.visible = true
		damage_indicator_timer.start()
		$DamageIndicator.text = str(n)
		animation_player.play("crit")

func init_damage_indicator():
	if show_damage_indicator:
		damage_indicator_timer = Timer.new()
		damage_indicator_timer.one_shot = true
		damage_indicator_timer.wait_time = damage_indicator_duration
		add_child(damage_indicator_timer)
		damage_indicator_timer.timeout.connect(_on_DamageIndicator_timeout)

		$DamageIndicator.text = ""


func _on_DamageIndicator_timeout():
	$DamageIndicator.visible = false